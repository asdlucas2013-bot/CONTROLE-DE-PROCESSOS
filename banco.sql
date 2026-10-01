-- Execute este SQL no SQL Editor do seu projeto Supabase.
create extension if not exists pgcrypto;

create table if not exists public.processos (
  id uuid primary key default gen_random_uuid(),
  data date not null,
  parceiro text not null,
  cliente text not null,
  status text not null check (status in (
    'Processo de Vídeo',
    'Emissão Online',
    'Pendente de Documento',
    'Pendente de PG',
    'Concluído'
  )),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create or replace function public.set_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end; $$;

drop trigger if exists processos_updated_at on public.processos;
create trigger processos_updated_at
before update on public.processos
for each row execute function public.set_updated_at();

alter table public.processos enable row level security;

drop policy if exists "usuarios autenticados podem ver processos" on public.processos;
create policy "usuarios autenticados podem ver processos"
on public.processos for select
to authenticated using (true);

drop policy if exists "usuarios autenticados podem inserir processos" on public.processos;
create policy "usuarios autenticados podem inserir processos"
on public.processos for insert
to authenticated with check (true);

drop policy if exists "usuarios autenticados podem atualizar processos" on public.processos;
create policy "usuarios autenticados podem atualizar processos"
on public.processos for update
to authenticated using (true) with check (true);

drop policy if exists "usuarios autenticados podem excluir processos" on public.processos;
create policy "usuarios autenticados podem excluir processos"
on public.processos for delete
to authenticated using (true);

-- IMPORTANTE:
-- O administrador inicial deve ser criado em Authentication > Users no Supabase.
-- Depois podemos acrescentar uma tabela de perfis/roles para separar ADMIN e OPERADOR
-- e restringir as ações administrativas por função.
