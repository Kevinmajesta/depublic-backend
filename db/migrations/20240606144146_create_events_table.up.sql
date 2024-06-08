BEGIN;

CREATE TABLE IF NOT EXISTS events(
    event_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    category_id VARCHAR(255) NOT NULL,
    title_event VARCHAR(255) NOT NULL,
    date_event DATE NOT NULL,
    price_event int NOT NULL,
    city_event VARCHAR(255) NOT NULL,
    address_event VARCHAR(255) NOT NULL,
    qty_event int NOT NULL,
    description_event TEXT NOT NULL,
    image_url TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at TIMESTAMPTZ
   
);

COMMIT;
