# MLflow GenAI Demo Series

A twelve-notebook series teaching MLflow's GenAI platform — from first traced run through multi-agent orchestration. Built on **MLflow 3.14.0** with Databricks workspace integration.

## What You'll Learn

- Experiment tracking and cost monitoring for LLM applications
- Auto-tracing and manual instrumentation with MLflow Tracing
- Prompt versioning via the Prompt Registry
- Evaluation with built-in scorers, custom scorers, and DeepEval
- Prompt optimization using the GEPA algorithm
- End-to-end RAG with RAGAS evaluation
- Multi-agent patterns: LangGraph supervisor, deep agents, CrewAI crews

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

See [RUNBOOK.md](RUNBOOK.md) for detailed setup, deployment, and troubleshooting.

## Resources

- [MLflow Documentation](https://mlflow.org/docs/latest/)
- [MLflow GenAI Guide](https://mlflow.org/docs/latest/genai/)
- [MLflow GitHub](https://github.com/mlflow/mlflow)
