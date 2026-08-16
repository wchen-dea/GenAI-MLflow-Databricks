# CLAUDE.md

Guidance for AI coding assistants working in this repository.

## Project Overview

Twelve sequential Jupyter notebooks teaching MLflow's GenAI platform (tracing, experiment tracking, prompt management, evaluation, RAG, multi-agent orchestration). MLflow version: **3.14.0** (pinned in `pyproject.toml`). Uses the **MLflow 3.x API** exclusively.

For setup, environment config, and operations see [RUNBOOK.md](RUNBOOK.md).
For Claude Code slash commands see [SKILLS.md](SKILLS.md).

## Build & Test Commands

```bash
uv sync                                    # Install dependencies
uv run python test/test_ai_gateway_endpoints.py   # Smoke-test endpoints
uv run python src/utils/clnt_utils.py      # Test client connectivity
databricks bundle validate                 # Validate bundle config
```

## Architecture

### Notebook Sequence

| # | Focus |
|---|-------|
| 01 | MLflow setup, first tracked run |
| 02 | Experiment tracking, cost tracking, parent-child runs |
| 03 | Auto-tracing with `mlflow.openai.autolog()` |
| 04 | Manual tracing: `@mlflow.trace`, `mlflow.start_span()` |
| 05 | Prompt Registry: create, version, link to experiments |
| 06 | Framework integrations: OpenAI, LangChain, LlamaIndex |
| 07 | Evaluation: built-in scorers, custom `@scorer`, DeepEval |
| 08 | Prompt optimization with GEPA algorithm |
| 09 | Complete RAG app with RAGAS evaluation |
| 10 | Multi-agent supervisor (LangGraph): Genie + Knowledge Assistant |
| 11 | LangGraph Deep Agents: planning, file tools, sub-agent delegation |
| 12 | CrewAI multi-agent: role-based agents, hierarchical crews |

### `src/utils/clnt_utils.py`

Shared client factory used across all notebooks. Provider controlled by env vars:
- **OpenAI** — `USE_DATABRICKS_CLIENT=False`, `USE_DATABRICKS_AI_GATEWAY=False`
- **Databricks workspace** — `USE_DATABRICKS_CLIENT=True`
- **Databricks AI Gateway** — `USE_DATABRICKS_AI_GATEWAY=True` (default)

## Key MLflow 3.x Patterns

**Tracing:**
```python
mlflow.openai.autolog()              # Auto-trace OpenAI calls
mlflow.langchain.autolog()           # Auto-trace LangChain/LangGraph
mlflow.crewai.autolog()              # Auto-trace CrewAI
@mlflow.trace                        # Trace a function
with mlflow.start_span("name"):      # Manual span
```

**Evaluation (3.x API):**
```python
from mlflow.genai.scorers import Correctness, RelevanceToQuery, Safety, Guidelines
results = mlflow.genai.evaluate(data=dataset, scorers=[...])
results = mlflow.genai.evaluate(data=dataset, predict_fn=my_fn, scorers=[...])
```

**Agent-as-a-Judge:**
```python
from mlflow.genai.judges import make_judge
judge = make_judge(name="...", instructions="...{{ trace }}...", model="databricks/...")
feedback = judge(trace=mlflow.get_trace(trace_id))
```

## Common Pitfalls

- **`Correctness` scorer requires `expected_facts`** in dataset `expectations` field
- **RAG judges** (`RetrievalGroundedness`, `RetrievalRelevance`) require `predict_fn` with tracing enabled — they read from the trace, not from `outputs`
- **Old vs new API**: Use `mlflow.genai.evaluate()` (MLflow 3.x), not `mlflow.evaluate()` with `model_type="databricks-agent"` (MLflow 2.x)
- **Judge model format for LiteLLM**: `"databricks/model-name"`, `"anthropic/claude-..."`, `"azure:/gpt-4o"` — not raw model names
