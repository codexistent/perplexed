from fastapi import FastAPI
from pydantic_models.chat_body import ChatBody
from services.search_service import SearchService

# instantiate FastAPI in project
app = FastAPI() 

search_service = SearchService()

# chat
@app.post("/chat")
def chat_endpoint(body: ChatBody):
    # 1. search web and find appropriate sources
    search_results = search_service.web_search(body.query);
    print(search_results)

    # 2. sort sources based on relevancy 

    # 3. generate response using llm

    return body.query