# Vector Space Model

## My understanding
- This is one of the three main statistical retrieval models.

- It provides a framework in which term weighting, ranking of retrieved documents, and determining the relevance of feedback are possible.

- Each document is represented by an n-dimensional vector of values (using individual terms as dimensions).

### Features
- These are a subset of the terms that are deemed the most relevant to an [IR](./INFORMATION_RETRIEVAL.md) in a set of documents.

- The process of selecting these features  and their properties as a limited list out of the available terms is independent of the model specification.

- The query is also specified as a terms vector.
    - And is compared to the document vectors for similarity or relevance assessment.

## Why it matters
This model establishes a way to compare pieces of [unstructured information](./INFORMATION_RETRIEVAL.md#why-it-matters).

## Example
```sql
-- Search query: What is a Heisenbug?
-- Top 3 most similar chunks

SELECT
    chunk_id,
    SUBSTR(chunk_text, 1, 100) AS preview,
    ROUND(VECTOR_DISTANCE(chunk_vector, TO_VECTOR(TO_CLOB('[0.05735243, 0.02846243, -0.07571563, 0.07665976, -0.02165867,') || ' -0.01396088, -0.00733835, -0.00908888, 0.00702541, -0.02913135]', 5, FLOAT32), COSINE), 4) AS similarity_score
FROM doc_chunks
ORDER BY similarity_score ASC
FETCH FIRST 3 ROWS ONLY;
```

## Resources
- [Elmasri, R. and Navathe, S. (7th Edition) (2016) *Fundamentals of Database Systems.* Pearson.](https://repository.gctu.edu.gh/files/original/40d4b26d17431add03c83ca3a8ea0125.pdf)