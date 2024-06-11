BEGIN;

CREATE TABLE IF NOT EXISTS transactions (
    transactions_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    cart_id UUID NOT NULL,
    user_id UUID NOT NULL,
    fullname_user VARCHAR(255) NOT NULL,
    trx_date DATE NOT NULL,
    payment VARCHAR(255) NOT NULL,
    payment_url VARCHAR(255) NOT NULL,
    amount BIGINT NOT NULL,
    status BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at TIMESTAMPTZ
);

COMMIT;
