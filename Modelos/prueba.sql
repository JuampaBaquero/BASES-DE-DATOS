CREATE TABLE "follows" (
  "following_user_id" integer,
  "followed_user_id" integer,
  "created_at" timestamp
);

CREATE TABLE "users" (
  "id" integer PRIMARY KEY,
  "username" varchar,
  "role" varchar,
  "created_at" timestamp
);

CREATE TABLE "posts" (
  "id" integer PRIMARY KEY,
  "title" varchar,
  "body" text,
  "user_id" integer NOT NULL,
  "status" varchar,
  "created_at" timestamp
);

COMMENT ON COLUMN "posts"."body" IS 'Content of the post';

ALTER TABLE "posts" ADD CONSTRAINT "user_posts" FOREIGN KEY ("user_id") REFERENCES "users" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "follows" ADD FOREIGN KEY ("following_user_id") REFERENCES "users" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "follows" ADD FOREIGN KEY ("followed_user_id") REFERENCES "users" ("id") DEFERRABLE INITIALLY IMMEDIATE;

-- Disable constraint checking for INSERT
SET CONSTRAINTS ALL DEFERRED;

INSERT ALL
  INTO "users" ("id", "username", "role") VALUES (0, 'Alice', 'admin')
  INTO "users" ("id", "username", "role") VALUES (1, 'Bob', 'moderator')
  INTO "users" ("id", "username", "role") VALUES (2, 'Candice', 'moderator')
  INTO "users" ("id", "username", "role") VALUES (3, 'David', 'member')
SELECT * FROM dual;
INSERT ALL
  INTO "follows" ("following_user_id", "followed_user_id", "created_at") VALUES (1, 0, TO_TIMESTAMP('2026-01-01 05:00:00.000', 'YYYY-MM-DD HH24:MI:SS.FF3'))
  INTO "follows" ("following_user_id", "followed_user_id", "created_at") VALUES (3, 2, TO_TIMESTAMP('2026-02-28 05:00:00.000', 'YYYY-MM-DD HH24:MI:SS.FF3'))
SELECT * FROM dual;
INSERT ALL
  INTO "posts" ("id", "title", "user_id") VALUES (0, 'Welcome to the forum!', 0)
  INTO "posts" ("id", "title", "user_id") VALUES (1, 'Guidelines', 1)
  INTO "posts" ("id", "title", "user_id") VALUES (2, 'Hello all!', 3)
SELECT * FROM dual;

SET CONSTRAINTS ALL IMMEDIATE;
COMMIT;