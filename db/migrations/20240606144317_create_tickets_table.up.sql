BEGIN;

CREATE TABLE IF NOT EXISTS tickets(
    tickets_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    transaction_id UUID NOT NULL,
    event_id UUID NOT NULL,
    code_qr VARCHAR(255) NOT NULL ,
    name_event VARCHAR(255) NOT NULL,
    ticket_date DATE NOT NULL,
    qty int NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at TIMESTAMPTZ
);

COMMIT;
