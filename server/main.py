from fastapi import FastAPI
from pydantic_models.chat_body import ChatBody
from services.search_service import SearchService
from services.sort_source_service import SortSourceService
from services.llm_service import LLMService

# instantiate FastAPI in project
app = FastAPI() 

search_service = SearchService()
sort_source_service = SortSourceService()
llm_service = LLMService()

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