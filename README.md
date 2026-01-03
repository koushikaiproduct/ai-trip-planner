# AI-LD-Planner  
v0.1 · Technical Preview

AI-LD-Planner is an agent-orchestrated Learning & Development planner built as an interview-grade portfolio artifact for AI Product Manager and AI Strategist roles.

This repository represents an early but real system: a working multi-agent architecture with live LLM calls, clear separation of concerns, and a foundation designed for evaluation, iteration, and productization.

It is intentionally scoped.
It is intentionally honest.
It is designed to demonstrate how an AI PM would actually build an agentic system.

--------------------------------------------------

Positioning & Intent

What this is
- A capability-shaping system that converts a learning goal into a structured execution plan
- A concrete example of agent orchestration, reasoning boundaries, and synthesis
- A technical artifact suitable for deep product and systems discussions

What this is not (yet)
- Not a full L&D platform
- Not a production personalization engine
- Not a polished public SaaS demo

This distinction is deliberate.

--------------------------------------------------

What Works Today (v0.1)

The following capabilities are fully implemented and verifiable:
- FastAPI backend exposing a planning workflow
- Minimal frontend UI to collect inputs and render outputs
- Multi-agent orchestration using LangGraph
- Live LLM calls via OpenRouter (provider-agnostic routing)
- End-to-end flow from user input → agent execution → synthesized plan

Explicitly out of scope for v0.1:
- Retrieval-augmented generation (RAG)
- Persistent memory or user state
- Automated evaluation or scoring
- Iterative refinement loops

v0.1 optimizes for architectural clarity, not completeness.

--------------------------------------------------

High-Level Architecture

┌─────────────────────────────────────────────────────────────────┐
│                         User Request                             │
│           (learning goal, time horizon, weekly effort)           │
└────────────────────────────────┬────────────────────────────────┘
                                 │
                    ┌────────────▼────────────┐
                    │   FastAPI Endpoint       │
                    │   /plan-trip             │
                    └────────────┬────────────┘
                                 │
                    ┌────────────▼────────────┐
                    │   LangGraph Workflow     │
                    │   (Parallel Agents)      │
                    └────────────┬────────────┘
                                 │
        ┌────────────────────────┼────────────────────────┐
        │                        │                        │
┌───────▼────────┐     ┌─────────▼────────┐     ┌────────▼─────────┐
│ Skill Mapping  │     │ Constraints       │     │ Personalization   │
│ Agent          │     │ Agent             │     │ Agent             │
│ (What to learn)│     │ (Effort & scope)  │     │ (User context)    │
└───────┬────────┘     └─────────┬────────┘     └────────┬─────────┘
        │                        │                        │
        └────────────────────────┼────────────────────────┘
                                 │
                    ┌────────────▼────────────┐
                    │ Plan Synthesis Agent     │
                    │ (Sequencing & narrative) │
                    └────────────┬────────────┘
                                 │
                    ┌────────────▼────────────┐
                    │   Final Learning Plan   │
                    └─────────────────────────┘

All orchestration logic lives in backend/main.py.

--------------------------------------------------

Agent Architecture

The system is decomposed into four agents, each responsible for a distinct reasoning boundary.

1. Skill Mapping Agent

Purpose:
Identify domains, concepts, and skill areas relevant to the target learning goal.

Outputs:
- High-level skill domains
- Conceptual framing for the plan

Why this exists:
Skill decomposition is a distinct cognitive task. Isolating it allows future improvements without contaminating constraint handling or synthesis logic.

--------------------------------------------------

2. Constraints Agent (Effort & Scope)

Purpose:
Interpret time availability and effort constraints.

Outputs:
- Realistic scope boundaries
- Pacing assumptions for the plan

Why this exists:
Constraint reasoning is orthogonal to content quality. Separating it ensures feasibility and extensibility.

--------------------------------------------------

3. Personalization Agent (User Context)

Purpose:
Adapt the plan to the learner’s background, strengths, and prior experience.

Outputs:
- Context-aware emphasis
- Personalized framing

Why this exists:
Personalization is a separate concern from goal definition or effort modeling.

--------------------------------------------------

4. Plan Synthesis Agent

Purpose:
Combine all prior agent outputs into a coherent, actionable learning plan.

Outputs:
- Skill Gap Analysis
- Cornerstone Project
- Phased Learning Plan
- Week-by-Week Execution Plan

Why this exists:
Synthesis is fundamentally different from analysis. This agent optimizes for coherence, sequencing, and clarity.

--------------------------------------------------

End-to-End Flow

1. User submits:
   - Learning goal or target role
   - Time horizon
   - Weekly hours available
   - Background and strengths

2. FastAPI validates input and invokes LangGraph

3. Agents execute:
   - Skill Mapping → Constraints → Personalization → Plan Synthesis

4. Final learning plan is returned and rendered

There are no hidden steps or speculative components beyond this flow.

--------------------------------------------------

Local Setup

Prerequisites:
- Python 3.10+
- OpenRouter API key

Clone repository:
git clone https://github.com/koushikaiproduct/ai-ld-planner.git
cd ai-ld-planner

Backend setup:
cd backend
pip install -r requirements.txt

Create .env file:
OPENROUTER_API_KEY=your_key_here

Run backend:
python -m uvicorn main:app --reload

Frontend setup:
cd frontend
npm install
npm run dev

--------------------------------------------------

Quick Verification

Health check:
curl http://127.0.0.1:8000/health

Plan generation:
curl -X POST http://127.0.0.1:8000/plan-trip \
-H "Content-Type: application/json" \
-d '{"destination":"AI Product Manager","duration":"4 weeks","budget":"6-8 hrs/week","interests":"Product, analytics, strategy"}'

--------------------------------------------------

Configuration & Model Routing

- All LLM calls are routed via OpenRouter
- Model selection is abstracted and swappable
- No hard dependency on OpenAI billing or credits

This keeps experimentation flexible and low-cost.

--------------------------------------------------

Known Limitations (v0.1)

- No quantitative skill scoring
- No automated evaluation harness
- No memory across sessions
- No feedback-driven refinement
- Output quality depends on prompt and model behavior

v0.1 optimizes for architectural clarity, not completeness
--------------------------------------------------

Roadmap (Planned, Not Implemented)

Evaluation & Quality:
- Rubric-based plan scoring
- Regression tests for plan stability
- Human-in-the-loop review hooks

Persona-Specific Tuning:
- Engineers transitioning into AI
- PMs becoming AI PMs
- First-time managers (L5 → L6 equivalent)

Skill Quantification:
- Explicit skill matrices
- Confidence and progress scoring
- Plan comparisons over time

Resource Retrieval:
- RAG over curated learning resources
- Source attribution

UX & Demo:
- Improved visualization
- Exportable formats
- Guard-railed public demo

--------------------------------------------------

Versioning

v0.1 – Agent-orchestrated learning planner (technical preview)