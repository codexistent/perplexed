from fastapi import FastAPI, WebSocket 
from pydantic_models.chat_body import ChatBody
from services.search_service import SearchService
from services.sort_source_service import SortSourceService
from services.llm_service import LLMService
import asyncio

# instantiate FastAPI in project
app = FastAPI() 

search_service = SearchService()
sort_source_service = SortSourceService()
llm_service = LLMService()

# websocket
@app.websocket("/ws/chat")
async def websocket_chat_endpoint(websocket: WebSocket):
    # accept connection request
    await websocket.accept()

    try: 
        await asyncio.sleep(0.1)
        data = await websocket.receive_json()
        query = data.get("query")

        # 1. search web and find appropriate sources
        search_results = search_service.web_search(query);

        # 2. sort sources based on relevancy 
        sorted_results = sort_source_service.sort_sources(query, search_results)
        await asyncio.sleep(0.1)

        # 3. inform user web search and sort is done
        await websocket.send_json({
            "type": "search_result",
            "data": sorted_results
        })

        # 4. stream llm response in chunks over websocket connection
        for chunk in llm_service.generate_response(query, sorted_results):
            await asyncio.sleep(0.1)
            await websocket.send_json({
                'type': 'content',
                'data': chunk
            })
    except:
        print("Unexpected error occurred")
    finally:
        await websocket.close()

# chat
@app.post("/chat")
def chat_endpoint(body: ChatBody):
    # 1. search web and find appropriate sources
    search_results = search_service.web_search(body.query);

    # 2. sort sources based on relevancy 
    sorted_results = sort_source_service.sort_sources(body.query, search_results)

    # 3. generate response using llm
    response = llm_service.generate_response(body.query, sorted_results)

    return response