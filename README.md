# Rollcall

Voice-operated campus emergency roll call built with ElevenLabs, n8n, Supabase, Telegram, and React.

An admin starts a roll call by voice. Rollcall sends an ElevenLabs-generated voice note through Telegram, collects Safe / Need Assistance responses, escalates silence, assigns responders, and updates a live incident dashboard.

## Status

**Hackathon prototype — in development.**

This project uses synthetic demo data and is intended for campus safety drills. It is not a certified life-safety system.

## Core loop

1. Admin says: “Start roll call for Block B.”
2. Rollcall asks: “Block B has 10 people. Confirm?”
3. Admin says: “Confirm.”
4. n8n creates the incident and adds people to it.
5. n8n generates an ElevenLabs voice note.
6. Telegram sends the voice note with Safe / Need help buttons.
7. Responses update Supabase.
8. Need Assistance triggers a responder alert.
9. Silence escalates to `UNACCOUNTED`.
10. The dashboard and event timeline update.

## Architecture

```text
ElevenLabs Agent
      ↓
n8n webhook tools
      ↓
Supabase Postgres
      ↓
Telegram
      ↓
React dashboard
```

## Safety design

The ElevenLabs agent extracts only:

- `intent`
- `target_label`
- `reported_status`
- `note`

n8n resolves the real person, incident, permissions, and final status transition. The AI never decides who someone is or what their final safety status is.

## Tech stack

- ElevenLabs Conversational AI
- n8n
- Supabase Postgres
- Telegram Bot API
- Vite + React + TypeScript
- Tailwind CSS
- Zod

## Repository structure

```text
Rollcall/
├── dashboard/          # React dashboard
├── docs/               # Architecture, testing, demo, limitations
├── n8n-workflows/      # Exported n8n workflow JSON
├── supabase/           # Database schema and seed data
├── .env.example        # Required environment variables
├── PLAN.md             # Build milestones
└── README.md
```


## Live demo
- **Voice commander:** ElevenLabs agent �Rollcall Commander�
- **Telegram bot:** Rollcall Demo
- **Live dashboard:** In progress / optional
- **Demo flow:** Voice command ? n8n ? Supabase ? Telegram buttons ? Supabase status update
