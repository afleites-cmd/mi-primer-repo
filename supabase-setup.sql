-- ============================================================================
--  Billetera Pro — Configuración de la base de datos en Supabase
--  Cómo usarlo:
--    1. Entra a tu proyecto en https://supabase.com
--    2. Menú izquierdo → "SQL Editor" → "New query"
--    3. Pega TODO este archivo y presiona "Run"
--  Esto crea la tabla de movimientos y la seguridad para que cada usuario
--  vea SOLO sus propios datos.
-- ============================================================================

create table if not exists public.movimientos (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid not null default auth.uid() references auth.users(id) on delete cascade,
  tipo        text not null check (tipo in ('Ingreso','Egreso')),
  descripcion text,
  monto       numeric not null default 0,
  categoria   text,
  fecha       date not null default current_date,
  created_at  timestamptz not null default now()
);

-- Índice para que la consulta por usuario y fecha sea rápida
create index if not exists movimientos_user_fecha_idx
  on public.movimientos (user_id, fecha desc);

-- Activar seguridad a nivel de fila (Row Level Security)
alter table public.movimientos enable row level security;

-- Políticas: cada usuario solo puede ver/crear/editar/borrar SUS movimientos
drop policy if exists "ver propios"     on public.movimientos;
drop policy if exists "crear propios"   on public.movimientos;
drop policy if exists "editar propios"  on public.movimientos;
drop policy if exists "borrar propios"  on public.movimientos;

create policy "ver propios"
  on public.movimientos for select
  using (auth.uid() = user_id);

create policy "crear propios"
  on public.movimientos for insert
  with check (auth.uid() = user_id);

create policy "editar propios"
  on public.movimientos for update
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

create policy "borrar propios"
  on public.movimientos for delete
  using (auth.uid() = user_id);
