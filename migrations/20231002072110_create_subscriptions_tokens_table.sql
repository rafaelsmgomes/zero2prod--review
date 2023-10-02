-- Create subscriptions Tokens Table
create table subscriptions_tokens(
  subscriptions_token TEXT NOT NULL,
  subscriber_id uuid NOT NULL
    REFERENCES subscriptions (id),
    PRIMARY KEY(subscriptions_token)
);
