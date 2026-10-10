# Architecture

## How it works

```text
Admin voice command
   ↓
ElevenLabs agent extracts intent
   ↓
n8n validates command and creates incident
   ↓
Supabase stores incident and people
   ↓
ElevenLabs creates voice note
   ↓
Telegram sends voice note and buttons
   ↓
Person taps Safe or Need help
   ↓
n8n validates response and updates Supabase
   ↓
Dashboard and timeline update
```

## Main components

| Component | Responsibility |
|---|---|
| ElevenLabs | Understands voice commands and speaks confirmations |
| n8n | Validates every action and controls the workflow |
| Supabase | Stores incidents, people, statuses, and events |
| Telegram | Delivers voice notes and receives button responses |
| React dashboard | Shows live incident status and timeline |

## Data model

```text
incidents
├── incident_people
│   ├── safety_status
│   ├── response_state
│   └── conflict
├── events
└── people
```

## Status model

```text
PENDING → SAFE
PENDING → NEED_ASSISTANCE
PENDING → UNACCOUNTED
NEED_ASSISTANCE → CLAIMED
CLAIMED → RESOLVED
```

## Status rules

- A new roll call starts every person as `PENDING`.
- `SAFE` replaces `PENDING`, `UNCLEAR`, or `UNACCOUNTED`.
- `NEED_ASSISTANCE` replaces `PENDING`, `UNCLEAR`, or `UNACCOUNTED`.
- If someone taps Safe after Need Assistance, the status remains `NEED_ASSISTANCE` and `conflict` becomes `true`.
- A responder can claim or resolve a case but cannot silently change the safety status.
- If nobody responds before the escalation window ends, the person becomes `UNACCOUNTED`.

## Security rule

The browser dashboard can read incident data, but it does not directly change safety statuses. All writes happen through n8n.