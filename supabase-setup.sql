-- ============================================================
-- JoySmith Studio — Supabase setup
-- Run this ONCE in your Supabase project: Dashboard → SQL Editor
-- → New query → paste everything → Run.
-- ============================================================

-- 1) MEMBER PROFILES — saved delivery details, one row per member
create table public.profiles (
  id         uuid primary key references auth.users(id) on delete cascade,
  name       text,
  phone      text,
  addr       text,
  post       text,
  city       text,
  state      text,
  updated_at timestamptz default now()
);
alter table public.profiles enable row level security;
create policy "members read own profile"   on public.profiles for select using (auth.uid() = id);
create policy "members create own profile" on public.profiles for insert with check (auth.uid() = id);
create policy "members update own profile" on public.profiles for update using (auth.uid() = id);

-- 2) VOUCHERS — you manage these rows in Dashboard → Table Editor
--    kind:  'percent' (value = % off subtotal) or 'fixed' (value = RM off)
--    min_spend:    minimum subtotal required (0 = none)
--    members_only: true = customer must be signed in
--    active:       flip to false to switch a code off instantly
--    expires_at:   optional end date (null = never expires)
create table public.vouchers (
  code         text primary key,
  kind         text not null check (kind in ('percent','fixed')),
  value        numeric not null check (value > 0),
  min_spend    numeric not null default 0,
  members_only boolean not null default false,
  active       boolean not null default true,
  expires_at   timestamptz
);
alter table public.vouchers enable row level security;
-- customers can only see codes that are active and unexpired (and only by exact code)
create policy "read active vouchers" on public.vouchers for select
  using (active = true and (expires_at is null or expires_at > now()));

-- Example voucher (INACTIVE until you set active = true — discount amounts
-- still to be decided, edit or delete freely):
insert into public.vouchers (code, kind, value, min_spend, members_only, active)
values ('WELCOME10', 'percent', 10, 50, true, false);

-- 3) ORDERS — every order placed on the site lands here (guests included).
--    View them in Dashboard → Table Editor → orders.
create table public.orders (
  id            bigint generated always as identity primary key,
  order_no      text not null,
  user_id       uuid references auth.users(id) on delete set null,
  customer_name text,
  phone         text,
  addr          text,
  post          text,
  city          text,
  state         text,
  note          text,
  items         jsonb not null,
  subtotal      numeric not null,
  shipping      numeric not null,
  voucher_code  text,
  discount      numeric not null default 0,
  total         numeric not null,
  created_at    timestamptz default now()
);
alter table public.orders enable row level security;
-- anyone can place an order; only the owner (you, via dashboard) reads them all
create policy "anyone can place an order" on public.orders for insert
  to anon, authenticated with check (true);
create policy "members read own orders" on public.orders for select
  using (auth.uid() = user_id);
