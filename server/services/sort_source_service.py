from typing import List
from sentence_transformers import SentenceTransformer
import numpy as np

class SortSourceService:
    def __init__(self):
        self.embedding_model = SentenceTransformer("all-MiniLM-L6-v2")

    def sort_sources(self, query: str, search_results: List[dict]):
        if not search_results:
            return []

        query_embedding = self.embedding_model.encode(query)
        doc_embeddings = self.embedding_model.encode([r["content"] for r in search_results])

        similarities = doc_embeddings @ query_embedding / (
            np.linalg.norm(query_embedding) * np.linalg.norm(query_embedding)
        )

        relevant_docs = []

        for res, similarity in zip(search_results, similarities):
            res["relevance_score"] = float(similarity)

            if(similarity > 0.3):
                relevant_docs.append(res)
            
        return sorted(relevant_docs, key = lambda x: x['relevance_score'], reverse = True)