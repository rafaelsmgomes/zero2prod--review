-- Add migration script here
ALTER TABLE subscriptions_tokens RENAME COLUMN subscriptions_token TO subscription_token;
