CREATE TABLE IF NOT EXISTS "users" (
    "username" VARCHAR PRIMARY KEY,
    "hashed_password" VARCHAR NOT NULL,
    "full_name" VARCHAR NOT NULL,
    "email" VARCHAR(50) UNIQUE NOT NULL,
    "password_changed_at" TIMESTAMPTZ NOT NULL DEFAULT '0001-01-01 00:00:00Z',
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT (NOW())
);

CREATE TABLE IF NOT EXISTS "accounts" (
    "id" BIGSERIAL PRIMARY KEY,
    "owner" VARCHAR(100) NOT NULL,
    "balance" BIGINT NOT NULL,
    "currency" VARCHAR(50) NOT NULL,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT (NOW())
);

CREATE TABLE IF NOT EXISTS "entries" (
    "id" BIGSERIAL PRIMARY KEY,
    "account_id" BIGINT NOT NULL,
    "amount" BIGINT NOT NULL,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT (NOW())
);

CREATE TABLE IF NOT EXISTS "transfers" (
    "id" BIGSERIAL PRIMARY KEY,
    "from_account_id" BIGINT NOT NULL,
    "to_account_id" BIGINT NOT NULL,
    "amount" BIGINT NOT NULL,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT (NOW())
);

ALTER TABLE "accounts" ADD FOREIGN KEY ("owner") REFERENCES "users" ("username");

ALTER TABLE "entries" ADD FOREIGN KEY ("account_id") REFERENCES "accounts" ("id");

ALTER TABLE "transfers" ADD FOREIGN KEY ("from_account_id") REFERENCES "accounts" ("id");

ALTER TABLE "transfers" ADD FOREIGN KEY ("to_account_id") REFERENCES "accounts" ("id");

CREATE INDEX ON "accounts" ("owner");

CREATE UNIQUE INDEX ON "accounts" ("owner", "currency");

CREATE INDEX ON "entries" ("account_id");

CREATE INDEX ON "transfers" ("from_account_id");

CREATE INDEX ON "transfers" ("to_account_id");

CREATE INDEX ON "transfers" ("from_account_id", "to_account_id");

COMMENT ON COLUMN "entries"."amount" IS 'can be negative or positive';

COMMENT ON COLUMN "transfers"."amount" IS 'must be positive';