BEGIN;

CREATE TABLE IF NOT EXISTS event_categories(
    event_categories_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name_categories VARCHAR(255) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at TIMESTAMPTZ
   
);

COMMIT;
