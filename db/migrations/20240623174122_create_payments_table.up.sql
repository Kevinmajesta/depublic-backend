
BEGIN;
CREATE TABLE IF NOT EXISTS payments (
    payment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    transaksi_id UUID NOT NULL,
    status_pay varchar(255) NOT NULL,
    pay_time TIMESTAMPTZ NOT NULL DEFAULT now(),
    pay_settlement_time TIMESTAMPTZ NOT NULL DEFAULT now(),
    pay_type varchar(100) NOT NULL,
    signature_key TEXT NOT NULL,
    Created_At TIMESTAMPTZ NOT NULL DEFAULT now(),
    Updated_At TIMESTAMPTZ NOT NULL DEFAULT now(),
    Deleted_At TIMESTAMPTZ
);
COMMIT;