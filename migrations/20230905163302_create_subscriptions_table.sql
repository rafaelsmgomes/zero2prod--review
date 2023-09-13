-- Add migration script here
create table subscriptions(
  id uuid NOT NULL,
  PRIMARY KEY(id),
  email TEXT NOT NULL unique,
  name text not null,
  subscribed_at timestamptz not null
);
