-- ==========================================
-- SAA 2025 Mobile — Initial Database Schema
-- Backend: Supabase (PostgreSQL)
-- Migration: 20260410000000
-- ==========================================

-- ==========================================
-- 1. DEPARTMENTS (tạo trước vì users reference)
-- ==========================================

CREATE TABLE departments (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    code VARCHAR NOT NULL UNIQUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_departments_code ON departments(code);

-- ==========================================
-- 2. USERS (extends auth.users)
-- ==========================================

CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    auth_id UUID NOT NULL UNIQUE REFERENCES auth.users(id) ON DELETE CASCADE,
    email VARCHAR NOT NULL UNIQUE,
    name VARCHAR NOT NULL,
    avatar_url VARCHAR,
    team_code VARCHAR,
    department_id BIGINT REFERENCES departments(id),
    hero_tier VARCHAR NOT NULL DEFAULT 'none'
        CHECK (hero_tier IN ('none', 'new_hero', 'rising_hero', 'super_hero', 'legend_hero')),
    language_preference VARCHAR NOT NULL DEFAULT 'vi'
        CHECK (language_preference IN ('vi', 'en')),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_users_auth_id ON users(auth_id);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_department_id ON users(department_id);
CREATE INDEX idx_users_name ON users(name);

-- ==========================================
-- 3. EVENTS
-- ==========================================

CREATE TABLE events (
    id BIGSERIAL PRIMARY KEY,
    theme_name VARCHAR NOT NULL,
    event_date TIMESTAMPTZ NOT NULL,
    venue VARCHAR NOT NULL,
    livestream_note TEXT,
    theme_description TEXT,
    hero_image_url VARCHAR,
    theme_logo_url VARCHAR,
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==========================================
-- 4. AWARD CATEGORIES
-- ==========================================

CREATE TABLE award_categories (
    id BIGSERIAL PRIMARY KEY,
    event_id BIGINT NOT NULL REFERENCES events(id),
    name VARCHAR NOT NULL,
    slug VARCHAR NOT NULL UNIQUE,
    description TEXT,
    image_url VARCHAR,
    quantity INT NOT NULL DEFAULT 0,
    unit VARCHAR NOT NULL DEFAULT 'Cá nhân'
        CHECK (unit IN ('Cá nhân', 'Tập thể')),
    prize_value DECIMAL(12, 0),
    prize_note VARCHAR,
    sort_order INT NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_award_categories_event_id ON award_categories(event_id);
CREATE INDEX idx_award_categories_slug ON award_categories(slug);
CREATE INDEX idx_award_categories_sort ON award_categories(sort_order);

-- ==========================================
-- 5. HASHTAGS
-- ==========================================

CREATE TABLE hashtags (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR NOT NULL UNIQUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_hashtags_name ON hashtags(name);

-- ==========================================
-- 6. KUDOS
-- ==========================================

CREATE TABLE kudos (
    id BIGSERIAL PRIMARY KEY,
    sender_id BIGINT NOT NULL REFERENCES users(id),
    recipient_id BIGINT NOT NULL REFERENCES users(id),
    message TEXT NOT NULL,
    award_category_name VARCHAR,
    is_anonymous BOOLEAN NOT NULL DEFAULT false,
    status VARCHAR NOT NULL DEFAULT 'active'
        CHECK (status IN ('active', 'spam', 'hidden')),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_kudos_sender_id ON kudos(sender_id);
CREATE INDEX idx_kudos_recipient_id ON kudos(recipient_id);
CREATE INDEX idx_kudos_status_created ON kudos(status, created_at DESC);
CREATE INDEX idx_kudos_created_at ON kudos(created_at DESC);

-- ==========================================
-- 7. KUDOS PHOTOS
-- ==========================================

CREATE TABLE kudos_photos (
    id BIGSERIAL PRIMARY KEY,
    kudos_id BIGINT NOT NULL REFERENCES kudos(id) ON DELETE CASCADE,
    image_url VARCHAR NOT NULL,
    sort_order INT NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_kudos_photos_kudos_id ON kudos_photos(kudos_id);

-- ==========================================
-- 8. KUDOS HASHTAGS (Junction)
-- ==========================================

CREATE TABLE kudos_hashtags (
    kudos_id BIGINT NOT NULL REFERENCES kudos(id) ON DELETE CASCADE,
    hashtag_id BIGINT NOT NULL REFERENCES hashtags(id) ON DELETE CASCADE,
    PRIMARY KEY (kudos_id, hashtag_id)
);

CREATE INDEX idx_kudos_hashtags_hashtag_id ON kudos_hashtags(hashtag_id);

-- ==========================================
-- 9. KUDOS REACTIONS (Hearts)
-- ==========================================

CREATE TABLE kudos_reactions (
    id BIGSERIAL PRIMARY KEY,
    kudos_id BIGINT NOT NULL REFERENCES kudos(id) ON DELETE CASCADE,
    user_id BIGINT NOT NULL REFERENCES users(id),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE (kudos_id, user_id)
);

CREATE INDEX idx_kudos_reactions_kudos_id ON kudos_reactions(kudos_id);
CREATE INDEX idx_kudos_reactions_user_id ON kudos_reactions(user_id);

-- ==========================================
-- 10. KUDOS REPORTS (Spam)
-- ==========================================

CREATE TABLE kudos_reports (
    id BIGSERIAL PRIMARY KEY,
    kudos_id BIGINT NOT NULL REFERENCES kudos(id) ON DELETE CASCADE,
    reporter_id BIGINT NOT NULL REFERENCES users(id),
    reason TEXT,
    status VARCHAR NOT NULL DEFAULT 'pending'
        CHECK (status IN ('pending', 'reviewed', 'dismissed')),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    reviewed_at TIMESTAMPTZ,
    UNIQUE (kudos_id, reporter_id)
);

CREATE INDEX idx_kudos_reports_kudos_id ON kudos_reports(kudos_id);
CREATE INDEX idx_kudos_reports_status ON kudos_reports(status);

-- ==========================================
-- 11. BADGES (Icon Collection)
-- ==========================================

CREATE TABLE badges (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    image_url VARCHAR NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==========================================
-- 12. USER BADGES (Junction)
-- ==========================================

CREATE TABLE user_badges (
    user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    badge_id BIGINT NOT NULL REFERENCES badges(id) ON DELETE CASCADE,
    earned_at TIMESTAMPTZ DEFAULT NOW(),
    PRIMARY KEY (user_id, badge_id)
);

CREATE INDEX idx_user_badges_badge_id ON user_badges(badge_id);

-- ==========================================
-- 13. SECRET BOXES
-- ==========================================

CREATE TABLE secret_boxes (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users(id),
    is_opened BOOLEAN NOT NULL DEFAULT false,
    opened_at TIMESTAMPTZ,
    reward_type VARCHAR
        CHECK (reward_type IN ('badge', 'points', 'message', 'special')),
    reward_value VARCHAR,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_secret_boxes_user_id ON secret_boxes(user_id);
CREATE INDEX idx_secret_boxes_user_unopened ON secret_boxes(user_id, is_opened)
    WHERE is_opened = false;

-- ==========================================
-- 14. NOTIFICATIONS
-- ==========================================

CREATE TABLE notifications (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    type VARCHAR NOT NULL
        CHECK (type IN ('kudos_received', 'heart_received', 'secret_box', 'announcement', 'system')),
    title VARCHAR NOT NULL,
    message TEXT,
    reference_type VARCHAR,
    reference_id BIGINT,
    is_read BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_notifications_user_unread ON notifications(user_id, is_read, created_at DESC)
    WHERE is_read = false;
CREATE INDEX idx_notifications_user_created ON notifications(user_id, created_at DESC);

-- ==========================================
-- 15. SEARCH HISTORY
-- ==========================================

CREATE TABLE search_history (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    searched_user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    searched_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE (user_id, searched_user_id)
);

CREATE INDEX idx_search_history_user_recent ON search_history(user_id, searched_at DESC);

-- ==========================================
-- 16. CAMPAIGNS (Admin)
-- ==========================================

CREATE TABLE campaigns (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    description TEXT,
    start_date TIMESTAMPTZ NOT NULL,
    end_date TIMESTAMPTZ NOT NULL,
    status VARCHAR NOT NULL DEFAULT 'draft'
        CHECK (status IN ('draft', 'active', 'ended', 'cancelled')),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_campaigns_status ON campaigns(status);
CREATE INDEX idx_campaigns_dates ON campaigns(start_date, end_date);

-- ==========================================
-- VIEW: User Stats (Profile screen)
-- ==========================================

CREATE VIEW user_stats AS
SELECT
    u.id AS user_id,
    COALESCE(kr.kudos_received, 0) AS kudos_received_count,
    COALESCE(ks.kudos_sent, 0) AS kudos_sent_count,
    COALESCE(hr.hearts_received, 0) AS hearts_received_count,
    COALESCE(sbo.boxes_opened, 0) AS secret_boxes_opened,
    COALESCE(sbu.boxes_unopened, 0) AS secret_boxes_unopened
FROM users u
LEFT JOIN (
    SELECT recipient_id, COUNT(*) AS kudos_received
    FROM kudos WHERE status = 'active' AND deleted_at IS NULL
    GROUP BY recipient_id
) kr ON kr.recipient_id = u.id
LEFT JOIN (
    SELECT sender_id, COUNT(*) AS kudos_sent
    FROM kudos WHERE status = 'active' AND deleted_at IS NULL
    GROUP BY sender_id
) ks ON ks.sender_id = u.id
LEFT JOIN (
    SELECT k.recipient_id, COUNT(*) AS hearts_received
    FROM kudos_reactions r
    JOIN kudos k ON k.id = r.kudos_id
    WHERE k.status = 'active' AND k.deleted_at IS NULL
    GROUP BY k.recipient_id
) hr ON hr.recipient_id = u.id
LEFT JOIN (
    SELECT user_id, COUNT(*) AS boxes_opened
    FROM secret_boxes WHERE is_opened = true
    GROUP BY user_id
) sbo ON sbo.user_id = u.id
LEFT JOIN (
    SELECT user_id, COUNT(*) AS boxes_unopened
    FROM secret_boxes WHERE is_opened = false
    GROUP BY user_id
) sbu ON sbu.user_id = u.id;

-- ==========================================
-- ROW LEVEL SECURITY
-- ==========================================

-- Public read tables (no RLS needed — anyone can read)
-- events, award_categories, hashtags, badges, campaigns, departments
-- These are reference/config data, no user-specific access control

-- User profiles: everyone read, only own update
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
CREATE POLICY users_select ON users FOR SELECT USING (true);
CREATE POLICY users_update ON users FOR UPDATE USING (auth_id = auth.uid());

-- Kudos: everyone read active, sender can insert
ALTER TABLE kudos ENABLE ROW LEVEL SECURITY;
CREATE POLICY kudos_select ON kudos FOR SELECT USING (status = 'active' AND deleted_at IS NULL);
CREATE POLICY kudos_insert ON kudos FOR INSERT WITH CHECK (
    sender_id IN (SELECT id FROM users WHERE auth_id = auth.uid())
);

-- Kudos photos: read if parent kudos visible, insert if sender
ALTER TABLE kudos_photos ENABLE ROW LEVEL SECURITY;
CREATE POLICY kudos_photos_select ON kudos_photos FOR SELECT USING (
    kudos_id IN (SELECT id FROM kudos WHERE status = 'active' AND deleted_at IS NULL)
);
CREATE POLICY kudos_photos_insert ON kudos_photos FOR INSERT WITH CHECK (
    kudos_id IN (SELECT id FROM kudos WHERE sender_id IN (SELECT id FROM users WHERE auth_id = auth.uid()))
);

-- Kudos hashtags: read if parent kudos visible, insert if sender
ALTER TABLE kudos_hashtags ENABLE ROW LEVEL SECURITY;
CREATE POLICY kudos_hashtags_select ON kudos_hashtags FOR SELECT USING (
    kudos_id IN (SELECT id FROM kudos WHERE status = 'active' AND deleted_at IS NULL)
);
CREATE POLICY kudos_hashtags_insert ON kudos_hashtags FOR INSERT WITH CHECK (
    kudos_id IN (SELECT id FROM kudos WHERE sender_id IN (SELECT id FROM users WHERE auth_id = auth.uid()))
);

-- Kudos reactions: everyone read, authenticated user insert/delete own
ALTER TABLE kudos_reactions ENABLE ROW LEVEL SECURITY;
CREATE POLICY kudos_reactions_select ON kudos_reactions FOR SELECT USING (true);
CREATE POLICY kudos_reactions_insert ON kudos_reactions FOR INSERT WITH CHECK (
    user_id IN (SELECT id FROM users WHERE auth_id = auth.uid())
);
CREATE POLICY kudos_reactions_delete ON kudos_reactions FOR DELETE USING (
    user_id IN (SELECT id FROM users WHERE auth_id = auth.uid())
);

-- Kudos reports: only reporter can insert, admin can read (simplified: authenticated can insert)
ALTER TABLE kudos_reports ENABLE ROW LEVEL SECURITY;
CREATE POLICY kudos_reports_insert ON kudos_reports FOR INSERT WITH CHECK (
    reporter_id IN (SELECT id FROM users WHERE auth_id = auth.uid())
);

-- Secret boxes: only own boxes
ALTER TABLE secret_boxes ENABLE ROW LEVEL SECURITY;
CREATE POLICY secret_boxes_select ON secret_boxes FOR SELECT
    USING (user_id IN (SELECT id FROM users WHERE auth_id = auth.uid()));
CREATE POLICY secret_boxes_update ON secret_boxes FOR UPDATE
    USING (user_id IN (SELECT id FROM users WHERE auth_id = auth.uid()));

-- Notifications: only own
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;
CREATE POLICY notifications_select ON notifications FOR SELECT
    USING (user_id IN (SELECT id FROM users WHERE auth_id = auth.uid()));
CREATE POLICY notifications_update ON notifications FOR UPDATE
    USING (user_id IN (SELECT id FROM users WHERE auth_id = auth.uid()));

-- Search history: only own
ALTER TABLE search_history ENABLE ROW LEVEL SECURITY;
CREATE POLICY search_history_all ON search_history FOR ALL
    USING (user_id IN (SELECT id FROM users WHERE auth_id = auth.uid()));

-- User badges: everyone read
ALTER TABLE user_badges ENABLE ROW LEVEL SECURITY;
CREATE POLICY user_badges_select ON user_badges FOR SELECT USING (true);
