# GenAI with MLflow on Databricks

A twelve-notebook demo series covering MLflow's GenAI platform end-to-end — from first traced LLM call through multi-agent orchestration. Deployed as a [Databricks Asset Bundle](https://docs.databricks.com/dev-tools/bundles/index.html) for declarative, version-controlled automation of experiments and jobs.

## Tech Stack

| Layer | Technology |
|-------|------------|
| LLM Ops | MLflow 3.14.0 (tracing, evaluation, prompt registry) |
| Orchestration | LangChain, LangGraph, CrewAI, OpenAI Agents SDK |
| Evaluation | MLflow GenAI Scorers, DeepEval, RAGAS |
| Optimization | GEPA (prompt optimization) |
| RAG | LlamaIndex, LangChain retrievers |
| Infrastructure | Databricks Asset Bundles, AI Gateway |
| Package Management | UV, Python 3.11+ |


## Notebooks

| # | Notebook | Focus |
|---|----------|-------|
| 01 | Setup and Introduction | MLflow architecture, first tracked run |
| 02 | Experiment Tracking | Autologging, cost tracking, parent-child runs |
| 03 | Introduction to Tracing | Auto-tracing OpenAI & LangChain |
| 04 | Manual Tracing | `@mlflow.trace`, custom spans, agentic workflows |
| 05 | Prompt Management | Prompt Registry, versioning, Jinja2 templates |
| 06 | Framework Integrations | LangChain, LlamaIndex, LangGraph side-by-side |
| 07 | Evaluating Agents | Built-in scorers, custom `@scorer`, DeepEval |
| 08 | Prompt Optimization | GEPA algorithm, baseline vs optimized comparison |
| 09 | Complete RAG Application | End-to-end RAG pipeline with RAGAS evaluation |
| 10 | Multi-Agent Supervisor | LangGraph routing to Genie + Knowledge agents |
| 11 | Deep Agents (LangGraph) | Planning, file tools, sub-agent delegation |
| 12 | CrewAI Multi-Agent | Role-based agents, hierarchical crew orchestration |

## Quick Start

Requires Python 3.11+, [UV](https://docs.astral.sh/uv/), and a Databricks workspace.

```bash
make setup      # Creates .env, installs deps, refreshes auth
make jupyter    # Start notebook server
```

See [docs/operations.md](docs/operations.md) for detailed setup, deployment, and troubleshooting.

## Resources

- [MLflow Documentation](https://mlflow.org/docs/latest/)
- [MLflow GenAI Guide](https://mlflow.org/docs/latest/genai/)
- [MLflow GitHub](https://github.com/mlflow/mlflow)
