import google.generativeai as genai
from config import Settings

settings = Settings()

class LLMService:
    def __init__(self):
        genai.configure(api_key=settings.GEMINI_API_KEY )

        # instantiate model
        self.model = genai.GenerativeModel("gemini-3.8-flash")

    def generate_response(self, query: str, search_results: list[dict]):
        # build system prompt
        # format:
        #  Source 1: <url>
        #   <content>
        #  Source 2: <url>
        #   <content>
        #  Query:
        context_text = "\n\n".join(
            [
                f"Source {i+1} ({result['url']}):\n{result['content']}"
                for i, result in enumerate(search_results)
            ]
        )

        full_prompt = f"""
        Context from web search:
            {context_text}
        
        Query: {query}

        Please provide a comprehensive, detailed, well-cited, and accurate response using the above context. Think and reason deeply. Ensure it answers the query the user is asking. Do not use your knowledge until it is absolutely neccesary.
        """

        response = self.model.generate_content(full_prompt)

        return response.text