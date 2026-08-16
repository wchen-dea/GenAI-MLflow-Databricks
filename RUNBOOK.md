# RUNBOOK.md — Operations & Setup

Single source of truth for installing, configuring, running, deploying, and troubleshooting this project.

## Prerequisites

- macOS / Linux
- Python 3.11+
- [UV](https://docs.astral.sh/uv/) package manager
- [Databricks CLI](https://docs.databricks.com/dev-tools/cli/databricks-cli.html) v0.200+
- A Databricks workspace with serving endpoints configured

## Setup

```bash
git clone <repo-url> && cd GenAI-with-MLflow-on-Databricks
make setup
```

`make setup` runs three steps:
- **`make env`** — creates `.env` from `env_template` (edit values before proceeding)
- **`make sync`** — creates the `genai-mlflow` virtualenv and installs all dependencies
- **`make auth`** — refreshes Databricks OAuth token for the DEFAULT profile

## Environment Variables

Edit `.env` with your workspace values (see `env_template` for the full list):

```dotenv
DATABRICKS_HOST=https://dbc-xxxx.cloud.databricks.com
DATABRICKS_PROFILE=DEFAULT
MLFLOW_TRACKING_URI=databricks
USE_DATABRICKS_AI_GATEWAY=True
AI_GATEWAY_BASE_URL=https://dbc-xxxx.cloud.databricks.com/serving-endpoints
AI_GATEWAY_MODELS=<chat-endpoint>,<embedding-endpoint>
AI_GATEWAY_EMBED_MODEL=<embedding-endpoint>
OPENAI_API_KEY=<optional-fallback>
```

MLflow tracks to the Databricks workspace directly — no local server needed. Auth uses the DEFAULT profile in `~/.databrickscfg` (OAuth via `databricks-cli`).

## Verify Connectivity

```bash
make test          # Smoke-test AI Gateway endpoints
make test-client   # Test LangChain client wiring
make validate      # Validate Databricks bundle config
```

## Running Notebooks

```bash
make jupyter       # Notebook server (src/notebooks/)
make lab           # JupyterLab alternative
```

Work through notebooks in order — each builds on the previous.

## Makefile Reference

| Command | Purpose |
|---------|---------|
| `make setup` | Full local setup (env + sync + auth) |
| `make env` | Create `.env` from template |
| `make sync` | Install/update dependencies |
| `make auth` | Refresh Databricks OAuth token |
| `make jupyter` | Start Jupyter notebook server |
| `make lab` | Start JupyterLab server |
| `make test` | Run AI Gateway endpoint smoke test |
| `make test-client` | Test LangChain client connectivity |
| `make validate` | Validate Databricks bundle |
| `make deploy` | Deploy bundle to dev target |
| `make clean` | Remove venv and Python caches |

## Deployment (Optional)

Deploy all bundle resources (experiments + jobs) to the workspace:

```bash
make deploy
```

Run an individual demo as a Databricks job:

```bash
databricks bundle run run_03_tracing
```

## Project Structure

```
├── databricks.yml              # Bundle config (targets, variables)
├── resources/                  # Bundle resource definitions
│   ├── experiments.yml         # 12 MLflow experiments
│   └── *_job.yml               # One job per notebook
├── src/
│   ├── notebooks/              # Demo notebooks (01–12)
│   └── utils/                  # Shared Python utilities
│       ├── clnt_utils.py       # Client factory (OpenAI / Databricks Gateway)
│       ├── fema_data.py        # FEMA disaster data for demos 10, 12
│       └── policy_docs.py      # Policy documents for demos 10, 12
├── test/                       # Endpoint smoke tests
├── pyproject.toml              # Dependencies (UV)
├── Makefile                    # Dev workflow commands
├── env_template                # .env template
└── .env                        # Local config (not committed)
```

## Troubleshooting

| Problem | Fix |
|---------|-----|
| `databricks auth` token expired | `make auth` |
| `ModuleNotFoundError` in notebook | Restart kernel after `make sync` |
| `Correctness` scorer fails | Ensure dataset has `expected_facts` in `expectations` |
| RAG scorers return empty | Use `predict_fn` with tracing enabled — scorers read from the trace |
| Wrong MLflow API | Use `mlflow.genai.evaluate()` (3.x), not `mlflow.evaluate()` (2.x) |
| Judge model format for LiteLLM | `"databricks/model-name"`, `"anthropic/claude-..."`, not raw names |

## Cleanup

```bash
make clean         # Remove venv and __pycache__
```
