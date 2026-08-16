# SKILLS.md — Claude Code Slash Commands

Skills are slash commands for [Claude Code](https://claude.ai/claude-code) that activate specialized agents for MLflow and GenAI tasks. Each skill reads your code and environment automatically — no need to explain context.

```
/skill-name
```

Prerequisites: `make setup` completed (see [RUNBOOK.md](RUNBOOK.md)).

---

## Catalog

### Getting Started

| Skill | Purpose |
|-------|---------|
| `/mlflow-onboarding` | First-time MLflow setup and experiment configuration |
| `/searching-mlflow-docs` | Look up any MLflow feature or API (fetches live docs) |

### Observability & Tracing

| Skill | Purpose |
|-------|---------|
| `/instrumenting-with-mlflow-tracing` | Add tracing to an agent or LLM app |
| `/retrieving-mlflow-traces` | Fetch or filter traces by ID, status, or metadata |
| `/analyze-mlflow-trace` | Debug a single trace — root-cause diagnosis |
| `/analyze-mlflow-chat-session` | Debug a multi-turn conversation session |
| `/querying-mlflow-metrics` | Aggregated token usage, latency, and costs |

### Evaluation

| Skill | Purpose |
|-------|---------|
| `/agent-evaluation` | Measure and improve agent quality with MLflow evaluation |

### Code Quality

| Skill | Purpose |
|-------|---------|
| `/simplify` | Review changed code for redundancy and efficiency |

---

## Skill Details

### `/mlflow-onboarding`

Guided setup of MLflow tracking, tracing, or experiment configuration. Detects your use case (GenAI vs traditional ML) and configures environment variables.

**Relevant notebooks:** 01, 02

---

### `/searching-mlflow-docs`

Fetches live documentation from `mlflow.org` with targeted answers and code examples. Covers all integrations: LangChain, LangGraph, OpenAI, DSPy, CrewAI, AutoGen.

---

### `/instrumenting-with-mlflow-tracing`

Adds `mlflow.<framework>.autolog()` calls, `@mlflow.trace` decorators, and session tracking to your code. Verifies tracing works end-to-end.

**Relevant notebooks:** 03, 04, 10, 11, 12

---

### `/retrieving-mlflow-traces`

Gets traces by ID, filters by status/tags/metadata, queries traces slower than a threshold or failed traces only.

---

### `/analyze-mlflow-trace`

Fetches a full trace, analyzes LLM prompts, tool calls, span timings, and errors. Provides root-cause diagnosis and actionable recommendations.

---

### `/analyze-mlflow-chat-session`

Analyzes a sequence of traces forming a conversation session. Identifies which turn introduced errors or quality degradation (context loss, hallucination drift, tool misuse).

---

### `/querying-mlflow-metrics`

Fetches token usage, latency distributions, trace counts, cost trends, and quality evaluation summaries. Supports querying by experiment, time window, or model.

**Relevant notebook:** 02

---

### `/agent-evaluation`

4-step workflow:
1. **Understand** — Runs agent with sample inputs, inspects traces
2. **Define Scorers** — Selects built-in judges or helps write custom scorers
3. **Prepare Dataset** — Discovers existing datasets or helps create new ones
4. **Run Evaluation** — Executes `mlflow.genai.evaluate()`, produces results report

**Relevant notebooks:** 07, 08, 09, 10, 11, 12

---

### `/simplify`

Reviews changed code against existing repo patterns. Identifies over-engineering, duplication, or unnecessary complexity. Applies targeted fixes only.

---

## Skills by Demo Stage

| Demo Stage | Recommended Skill |
|------------|-------------------|
| First time setup (01–02) | `/mlflow-onboarding` |
| Adding tracing (03–04) | `/instrumenting-with-mlflow-tracing` |
| Debugging a trace (any) | `/analyze-mlflow-trace` |
| Debugging a chat session (04+) | `/analyze-mlflow-chat-session` |
| Looking up docs (any) | `/searching-mlflow-docs` |
| Evaluating responses (07–09) | `/agent-evaluation` |
| Multi-agent patterns (10–12) | `/instrumenting-with-mlflow-tracing`, `/agent-evaluation` |
| Checking usage/costs (02, 09) | `/querying-mlflow-metrics` |
| After writing new code (any) | `/simplify` |

---

## Tips

- **Skills read your files automatically** — no need to explain the project.
- **Skills work best when tracing is active** — evaluation and trace analysis skills need MLflow traces.
- **Chain skills** — e.g., `/instrumenting-with-mlflow-tracing` then `/agent-evaluation` on the resulting traces.
- **For API questions**, use `/searching-mlflow-docs` — it fetches live docs rather than relying on training data.
