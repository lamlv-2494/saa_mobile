-- ==========================================
-- SAA 2025 Mobile — Kudos Config Table
-- Lưu cấu hình hiển thị Kudos section trên Home
-- ==========================================

CREATE TABLE kudos_config (
    id BIGSERIAL PRIMARY KEY,
    event_id BIGINT NOT NULL REFERENCES events(id),
    title VARCHAR NOT NULL,
    description TEXT,
    banner_image_url VARCHAR,
    is_enabled BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_kudos_config_event_id ON kudos_config(event_id);

-- Public read (no RLS needed — config data)
