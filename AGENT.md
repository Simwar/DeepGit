---
description: "Fork of zamalali/DeepGit — intelligent GitHub repository discovery using semantic search, BM25, cross-encoder reranking, and multi-factor ranking."
tags: [github, repository-search, semantic-search, langgraph, rag, open-source-discovery]
authors:
  - name: Simon Guerrier
    account: simwar
capabilities:
  - "Search GitHub repositories by natural language query"
  - "Semantic retrieval with FAISS + sentence-transformers (all-mpnet-base-v2)"
  - "Cross-encoder reranking for precision (ms-marco-MiniLM-L-6-v2)"
  - "Multi-factor ranking: activity, code quality, dependency analysis"
  - "Hardware-constraint filtering (CPU-only, low RAM, mobile)"
  - "Surfaces powerful but under-the-radar open-source tools"
repository: github:Simwar/DeepGit
integrations:
  - groq
  - openai
---

# DeepGit

DeepGit is an intelligent GitHub repository discovery agent. Give it a natural language query and it will search GitHub, semantically rank results, rerank with a cross-encoder, and apply multi-factor scoring (activity, code quality, dependency health) to surface the most relevant repositories — including hidden gems that keyword search misses. This is a fork of the original [DeepGit](https://github.com/zamalali/DeepGit) by zamalali.

## How it works

1. **Query conversion** — Translates your natural language query into optimal GitHub search terms
2. **GitHub ingestion** — Fetches repository metadata and README content via the GitHub API
3. **Dense retrieval** — Ranks candidates using FAISS + sentence-transformers
4. **Cross-encoder reranking** — Applies a cross-encoder for higher precision
5. **Multi-factor ranking** — Scores by activity, code quality, and dependency analysis
6. **Hardware filtering** — Optional: filter by CPU-only, low RAM, or mobile constraints

## Example queries

- "lightweight Python HTTP client with async support"
- "transformer model that runs on CPU with low memory"
- "open-source alternative to Pinecone for vector search"

## Required inputs

| Input | Description |
|-------|-------------|
| `GITHUB_API_KEY` | GitHub personal access token ([create one](https://github.com/settings/tokens)) |
| `GROQ_API_KEY` | Always required — the evaluation pipeline uses Groq directly. Free tier at [console.groq.com](https://console.groq.com) |
| `MINIMAX_API_KEY` | Optional — only needed if `LLM_PROVIDER=minimax` |

## Limitations

- GitHub API rate limits apply even with authentication (5,000 requests/hour)
- Results quality depends on repository README coverage
- Hardware filtering is heuristic-based, not guaranteed
