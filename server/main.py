from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from fastapi.concurrency import iterate_in_threadpool

from pydantic_models.chat_body import ChatBody
from services.search_service import SearchService
from services.sort_source_service import SortSourceService
from services.llm_service import LLMService

import asyncio
import logging

logger = logging.getLogger("perplexed")

# instantiate FastAPI in project
app = FastAPI() 

search_service = SearchService()
sort_source_service = SortSourceService()
llm_service = LLMService()

# search + rank in worker thread so other users aren't blocked
async def find_sources(query: str):
    results = await asyncio.to_thread(search_service.web_search, query)
    return await asyncio.to_thread(sort_source_service.sort_sources, query, results)

# just share title + url to client; full page text not needed
def public(sources):
    return [{"title": s["title"], "url": s["url"]} for s in sources]

ALLOWED_ORIGINS = {"https://perplexed.onrender.com", "http://localhost:5000"}

# websocket
@app.websocket("/ws/chat")
async def websocket_chat_endpoint(websocket: WebSocket):
    if websocket.headers.get("origin") not in ALLOWED_ORIGINS:
        await websocket.close(code=1008) # 1008 = policy violation
        return
    # accept connection request
    await websocket.accept()

    try: 
        # one socket, multiple queries
        while True: 
            data = await websocket.receive_json()
            query = (data.get("query") or "").strip()

            if not query:
                await websocket.send_json({"type":"error", "data":"Empty query"})

                continue

            try:
                sources = await find_sources(query)
                await websocket.send_json({"type": "search_result", "data": public(sources)})

                # stream AI response from worker thread
                async for chunk in iterate_in_threadpool(
                    llm_service.generate_response(query, sources)
                ):
                    await websocket.send_json({"type": "content", "data": chunk})
                
                await websocket.send_json({"type": "done"})

            except WebSocketDisconnect:
                raise 
            except Exception:
                # log the real error
                logger.exception("chat failed for query=%r", query)
                await websocket.send_json(
                    {"type": "error", "data": "Something went wrong. Please try again."}
                )
    except WebSocketDisconnect:
        pass

# chat
@app.post("/chat")
async def chat_endpoint(body: ChatBody):
    sources = await find_sources(body.query)

    answer = await asyncio.to_thread(
        lambda: "".join(llm_service.generate_response(body.query, sources))
    )

    return {"sources": public(sources), "answer": answer}

# for deployment host's health check
@app.get("/health")
def health():
    return {"ok": True}