# Resume and Presentation Design

## Context

Preparing resume and technical presentation materials for job hunting targeting staff-level AI engineering / infrastructure / applied AI roles. Primary interview target is OpenAI L5 (Staff) Software Engineer.

## Resume

### Approach: Focused 2024-2025 (Option A, Primary)

Structure the Instacart section with 5 bullets covering Commerce Platform work:

1. **Item pricing migration** (Ruby to Go): 50x P90 latency improvement, real-time bulk pricing for 3,000+ SKUs
2. **Authoritative product data API replacement**: 800k req/min, 695M/day, ~50% latency reduction, zero-downtime cutover via shadow diffing
3. **Order delivery state transition framework**: Lock-first RPC design, eliminated race conditions in ~8M daily fulfillment events
4. **Cross-org interface standardization**: Protobuf contracts, 8+ design docs, 7+ teams aligned on unified fulfillment architecture
5. **Payment integration hardening** (if space permits): Financial loophole fix, Temporal workflow migration, pluggable partner connectors

### Approach: Thematic (Option C, Commented-out Alternative)

Organize by capability theme:
- Platform & API Design
- Performance & Migration
- Cross-Org Execution
- Mentorship & Leadership

### Guidelines

- No internal project codenames (Photon, OOF, PRS, etc.)
- Use "Protobuf" not "gRPC" (in-house RPC framework)
- Follow action → scope → measurable result pattern for each bullet
- Keep narrative aligned with Positioning Strategy (staff backend/platform engineer transitioning to AI engineering)

### Skills Update

- Languages: **Ruby**, **Go**, **Python**, **JavaScript**, TypeScript, SQL
- Technologies: **AWS**, **PostgreSQL**, **DynamoDB**, Protobuf, Temporal, Terraform, Datadog, Docker, Linux

## Presentation

### Project: Item Pricing System Evolution (Full Arc)

30-minute structured presentation + Q&A for OpenAI technical project presentation round.

### Structure

1. **Problem & Business Context** (~5 min): Legacy Ruby pricing system bottleneck, business need for <200ms bulk pricing
2. **Phase 1 — New Service** (~8 min): Go service from scratch, data parsing challenges, in-memory caching, concurrency patterns, shadow diffing for correctness, 50x result
3. **Phase 2 — Replacing the Authoritative API** (~8 min): 800k req/min cutover, 8.5k LOC port with AI assistance, ~50% latency improvement, rollout strategy
4. **Phase 3 — Architectural Evolution** (~5 min): Migrating builder to upstream service, knowing when your service should get smaller, shadow diffing pattern reuse
5. **Lessons & Reflections** (~4 min): Shadow diffing as migration pattern, AI-assisted porting, what you'd do differently

### Key Themes (from OpenAI L5 Guide)

- Hard technical tradeoffs
- High scale / high correctness requirements
- Ambiguous scope
- Staff-level judgment (setting technical direction, architecture evolution)
- Clear measurable outcomes

### Prepared Q&A Topics

- Language choice (Go over alternatives)
- Schema evolution across 4 languages
- Rollback strategy for shadow diffing at scale
- Cross-team coordination (7+ teams)
- Caching trade-offs (in-memory vs distributed)

## Deliverables

| Deliverable | Location |
|---|---|
| Resume (updated) | `~/workspace/resume/resume.typ` |
| Presentation draft | `content/private/projects/Job-Hunting-2026/Photon Presentation.md` |
| Tracking doc | `content/private/projects/Job-Hunting-2026/Resume and Presentation Draft.md` |
