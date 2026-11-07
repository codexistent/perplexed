from config import Settings
from tavily import TavilyClient

settings = Settings()
tavily_client = TavilyClient(api_key = settings.TAVILY_API_KEY)

MAX_CHARS = 8000

# inputs user query, returns results from web
class SearchService:
    def web_search(self, query: str):
        results = []

        # search web + get content of webpages
        response = tavily_client.search(query, max_results=10, include_raw_content=True)

        for r in response.get("results", []):
            content = r.get("raw_content") or r.get("content")
            if content:
                results.append({
                    "title": r.get("title", ""),
                    "url": r.get("url"),
                    "content": content[:MAX_CHARS],
                })

        return results