-- ==========================================
-- Lưu nháp màn gửi kudos theo từng sender
-- Migration: 20260415000100
-- ==========================================

CREATE TABLE kudos_drafts (
    sender_id BIGINT PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
    recipient_id BIGINT REFERENCES users(id),
    award_title VARCHAR,
    message TEXT NOT NULL DEFAULT '',
    is_anonymous BOOLEAN NOT NULL DEFAULT false,
    hashtag_ids BIGINT[] NOT NULL DEFAULT '{}',
    image_urls TEXT[] NOT NULL DEFAULT '{}',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT kudos_drafts_award_title_check
        CHECK (award_title IS NULL OR award_title IN ('IDOL GIỚI TRẺ', 'LEADER', 'HERO'))
);

CREATE INDEX idx_kudos_drafts_updated_at ON kudos_drafts(updated_at DESC);

ALTER TABLE kudos_drafts ENABLE ROW LEVEL SECURITY;

CREATE POLICY kudos_drafts_select ON kudos_drafts FOR SELECT
USING (sender_id IN (SELECT id FROM users WHERE auth_id = auth.uid()));

CREATE POLICY kudos_drafts_insert ON kudos_drafts FOR INSERT
WITH CHECK (sender_id IN (SELECT id FROM users WHERE auth_id = auth.uid()));

CREATE POLICY kudos_drafts_update ON kudos_drafts FOR UPDATE
USING (sender_id IN (SELECT id FROM users WHERE auth_id = auth.uid()))
WITH CHECK (sender_id IN (SELECT id FROM users WHERE auth_id = auth.uid()));

CREATE POLICY kudos_drafts_delete ON kudos_drafts FOR DELETE
USING (sender_id IN (SELECT id FROM users WHERE auth_id = auth.uid()));
