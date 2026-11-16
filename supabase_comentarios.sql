-- PULSO · tabla de comentarios (se publican al instante)
-- Pegar en Supabase → SQL Editor → Run

create table if not exists comentarios (
  id bigint generated always as identity primary key,
  nota text not null check (char_length(nota) between 1 and 80),
  nombre text not null check (char_length(nombre) between 2 and 60),
  texto text not null check (char_length(texto) between 3 and 1500),
  creado timestamptz not null default now()
);

create index if not exists comentarios_nota_idx on comentarios (nota, creado desc);

alter table comentarios enable row level security;

-- cualquiera puede comentar
create policy "comentar" on comentarios
  for insert to anon with check (true);

-- cualquiera puede leer los comentarios
create policy "leer" on comentarios
  for select to anon using (true);

-- (no hay políticas de update/delete: desde el sitio nadie puede editar ni borrar;
--  para moderar, borrá filas desde Table Editor en el panel de Supabase)
