BEGIN;

CREATE TABLE IF NOT EXISTS event_categories(
    event_category_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name_category VARCHAR(255) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at TIMESTAMPTZ
   
);

COMMIT;
