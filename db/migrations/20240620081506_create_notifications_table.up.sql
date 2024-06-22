BEGIN;
CREATE TABLE IF NOT EXISTS notifications (
    notification_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    type TEXT,
    message TEXT,
    is_read BOOLEAN DEFAULT FALSE,
    Created_At TIMESTAMPTZ NOT NULL DEFAULT now(),
    Updated_At TIMESTAMPTZ NOT NULL DEFAULT now(),
    Deleted_At TIMESTAMPTZ
);
COMMIT;