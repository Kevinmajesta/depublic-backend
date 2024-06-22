BEGIN;

CREATE TABLE IF NOT EXISTS transaction_details (
    transaction_details_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    transaction_id VARCHAR(255) NOT NULL,
    event_id VARCHAR(255) NOT NULL,
    name_event VARCHAR(255) NOT NULL,
    qty_event int NOT NULL,
    price BIGINT NOT NULL,
    ticket_date VARCHAR(255) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at TIMESTAMPTZ
   
);

COMMIT;
