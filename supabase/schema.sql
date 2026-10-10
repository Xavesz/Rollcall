-- Rollcall initial schema

create extension if not exists pgcrypto;

-- Responders
create table if not exists responders (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  role text not null default 'warden',
  telegram_chat_id text,
  created_at timestamptz not null default now()
);

-- People directory
create table if not exists people (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  block text not null,
  room text,
  telegram_chat_id text,
  phone text,
  created_at timestamptz not null default now()
);

-- Incidents
create table if not exists incidents (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  target_block text not null,
  status text not null default 'ACTIVE',
  created_at timestamptz not null default now(),
  resolved_at timestamptz
);

-- Live safety state for each person in each incident
create table if not exists incident_people (
  id uuid primary key default gen_random_uuid(),
  incident_id uuid not null references incidents(id) on delete cascade,
  person_id uuid not null references people(id) on delete cascade,
  safety_status text not null default 'PENDING',
  conflict boolean not null default false,
  response_state text not null default 'NONE',
  assigned_responder_id uuid references responders(id) on delete set null,
  notes text,
  updated_at timestamptz not null default now(),
  unique (incident_id, person_id)
);

-- Audit timeline
create table if not exists events (
  id uuid primary key default gen_random_uuid(),
  incident_id uuid not null references incidents(id) on delete cascade,
  person_id uuid references people(id) on delete set null,
  event_type text not null,
  payload jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

-- Indexes
create index if not exists incident_people_incident_idx
on incident_people(incident_id);

create index if not exists incident_people_status_idx
on incident_people(safety_status);

create index if not exists events_incident_created_idx
on events(incident_id, created_at desc);

-- Enable Row Level Security
alter table responders enable row level security;
alter table people enable row level security;
alter table incidents enable row level security;
alter table incident_people enable row level security;
alter table events enable row level security;

-- Public read-only access for the dashboard.
-- All writes will be performed by n8n using the service role.
create policy "Allow public read on responders"
on responders for select using (true);

create policy "Allow public read on people"
on people for select using (true);

create policy "Allow public read on incidents"
on incidents for select using (true);

create policy "Allow public read on incident_people"
on incident_people for select using (true);

create policy "Allow public read on events"
on events for select using (true);

-- Demo seed data
insert into responders (name, role) values
  ('Warden Sharma', 'Lead Responder'),
  ('Security Officer John', 'Field Responder');

insert into people (name, block, room) values
  ('Aarav Mehta', 'Block B', 'B-101'),
  ('Priya Patel', 'Block B', 'B-102'),
  ('Rohan Das', 'Block B', 'B-103'),
  ('Sneha Roy', 'Block B', 'B-104'),
  ('Vikram Malhotra', 'Block B', 'B-105');