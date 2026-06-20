-- ============================================================
-- Cours de Français — Supabase schema
-- Run this ONCE in your Supabase project: SQL Editor -> New query -> paste -> Run
-- ============================================================

-- One row per user. "state" holds the whole progress blob the app already uses
-- (streak, lessons done, spaced-repetition boxes, stats). Nothing else is stored.
create table if not exists public.progress (
  id          uuid primary key references auth.users(id) on delete cascade,
  state       jsonb not null default '{}'::jsonb,
  updated_at  timestamptz not null default now()
);

-- Row-Level Security: each person can touch ONLY their own row.
-- This is what makes the public anon key safe to ship in the front-end.
alter table public.progress enable row level security;

drop policy if exists "own row select" on public.progress;
drop policy if exists "own row insert" on public.progress;
drop policy if exists "own row update" on public.progress;

create policy "own row select" on public.progress
  for select using (auth.uid() = id);

create policy "own row insert" on public.progress
  for insert with check (auth.uid() = id);

create policy "own row update" on public.progress
  for update using (auth.uid() = id) with check (auth.uid() = id);
