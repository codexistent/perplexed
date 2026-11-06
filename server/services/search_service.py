from config import Settings
from tavily import TavilyClient
import trafilatura

settings = Settings()
tavily_client = TavilyClient(api_key = settings.TAVILY_API_KEY)

# inputs user query, returns results from web
class SearchService:
    def web_search(self, query: str):
        results = []

        # search web
        response = tavily_client.search(query, max_results = 10)
        search_results = response.get("results", [])

        # scrapes returned websites for data/content
        for result in search_results:
            downloaded = trafilatura.fetch_url(result.get("url"))
            content = trafilatura.extract(downloaded, include_comments = False) or result.get("content")
            if not content: 
                continue

            results.append({
                "title": result.get("title", ""),
                "url": result.get("url"),
                "content": content
            })

        return results