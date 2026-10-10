# Rollcall — Build Plan

Rollcall is a voice-first emergency accountability prototype for campuses.

An admin starts a roll call by voice. The system sends voice instructions through Telegram, records Safe / Need Assistance responses, escalates silence, assigns responders, and shows a live incident dashboard.

## Build order

### Milestone 1 — Project setup
- [x] Create GitHub repository
- [x] Clone repository locally
- [x] Create Vite React TypeScript dashboard
- [x] Add root documentation and environment template

### Milestone 2 — Supabase database
- [ ] Create Supabase project
- [ ] Add people, incidents, incident_people, responders, and events tables
- [ ] Add safety status and conflict rules
- [ ] Enable Row Level Security
- [ ] Add demo seed data

### Milestone 3 — n8n roll-call start
- [ ] Create `/rollcall-start` webhook
- [ ] Create an incident
- [ ] Add people to the incident
- [ ] Return a validated response to ElevenLabs

### Milestone 4 — Telegram delivery
- [ ] Generate ElevenLabs voice note
- [ ] Send Telegram message with Safe / Need help buttons
- [ ] Prevent duplicate button responses

### Milestone 5 — Status updates
- [ ] Create one `update-status` workflow
- [ ] Apply deterministic safety rules
- [ ] Record every change in the event timeline
- [ ] Alert responders for Need Assistance cases

### Milestone 6 — Escalation
- [ ] Send reminders for unanswered people
- [ ] Escalate unanswered people to UNACCOUNTED
- [ ] Notify wardens or responders

### Milestone 7 — Dashboard
- [ ] Show live incident status
- [ ] Show each person’s safety status
- [ ] Show event timeline
- [ ] Label the app clearly as Demo Mode

### Milestone 8 — Voice commander
- [ ] Connect ElevenLabs agent tools to n8n
- [ ] Support start, status, claim, and resolve commands
- [ ] Speak only validated n8n responses

### Milestone 9 — Final submission
- [ ] Export and sanitize n8n workflows
- [ ] Record demo video
- [ ] Complete README and documentation
- [ ] Final commit and submission

## Non-negotiable rules

- The AI only extracts intent and labels.
- n8n resolves real IDs, permissions, and final status changes.
- A person with no response becomes `UNACCOUNTED`, never `SAFE`.
- `NEED_ASSISTANCE` is never automatically downgraded.
- `SAFE` after `NEED_ASSISTANCE` keeps `NEED_ASSISTANCE` and marks a conflict.
- Every status change is recorded in the event timeline.

## Out of scope

- Emotion detection
- Voice biometrics
- CCTV
- Blockchain
- PDF reports
- Outbound phone calls
- Maps beyond simple block labels