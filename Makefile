.PHONY: setup env sync auth jupyter test validate deploy clean help

VENV_PROMPT := genai-mlflow
PROFILE     := DEFAULT

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-12s %s\n", $$1, $$2}'

setup: env sync auth ## Full local setup (env + sync + auth)
	@echo "✅ Setup complete. Run 'make jupyter' to start."

env: ## Create .env from template if missing
	@test -f .env || (cp env_template .env && echo "Created .env from template — edit values before running notebooks")
	@test -f .env && echo ".env exists"

sync: ## Install dependencies (creates venv if missing)
	@test -d .venv || uv venv --prompt $(VENV_PROMPT)
	uv sync

auth: ## Refresh Databricks OAuth token
	databricks auth login --profile $(PROFILE)

jupyter: ## Start Jupyter notebook server
	uv run jupyter notebook --notebook-dir=src/notebooks

lab: ## Start JupyterLab server
	uv run jupyter lab --notebook-dir=src/notebooks

test: ## Run AI Gateway endpoint smoke test
	uv run python test/test_ai_gateway_endpoints.py

test-client: ## Test LangChain client connectivity
	uv run python src/utils/clnt_utils.py

validate: ## Validate Databricks bundle
	databricks bundle validate

deploy: ## Deploy bundle to dev target
	databricks bundle deploy --target dev

clean: ## Remove venv and Python caches
	rm -rf .venv
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name '*.pyc' -delete 2>/dev/null || true
