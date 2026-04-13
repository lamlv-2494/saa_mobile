-- ==========================================
-- Thêm cột _en cho đa ngôn ngữ (VN/EN)
-- Cột gốc giữ nguyên = tiếng Việt (default)
-- Cột _en = English translation
-- ==========================================

-- EVENTS
ALTER TABLE events ADD COLUMN livestream_note_en TEXT;
ALTER TABLE events ADD COLUMN theme_description_en TEXT;

-- AWARD CATEGORIES
ALTER TABLE award_categories ADD COLUMN name_en VARCHAR;
ALTER TABLE award_categories ADD COLUMN description_en TEXT;
