# Testing

Use these tests after each feature is added.

## 1. Roll call starts

1. Say: “Start roll call for Block B.”
2. Confirm the roll call.
3. Check Supabase.

**Expected:** one incident is created, all selected people are added, and every person starts as `PENDING`.

## 2. Safe response

1. Tap **I’m safe** in Telegram.
2. Check the dashboard.

**Expected:** the person becomes `SAFE`, the dashboard turns green, and a timeline event is added.

## 3. Need assistance

1. Tap **I need help** in Telegram.
2. Check the dashboard and responder alert.

**Expected:** the person becomes `NEED_ASSISTANCE`, and a responder alert is sent.

## 4. Conflict protection

1. Tap **I need help**.
2. Then tap **I’m safe**.

**Expected:** status remains `NEED_ASSISTANCE`, and `conflict` becomes `true`.

## 5. Escalation

1. Leave one person unanswered.
2. Wait for the escalation window.

**Expected:** a reminder is sent, then the person becomes `UNACCOUNTED`.

## 6. Duplicate protection

1. Tap the same Telegram button twice quickly.

**Expected:** only one status change and one alert are recorded.

## 7. Voice confirmation

1. Complete a voice check-in.

**Expected:** ElevenLabs speaks the confirmation returned by n8n.