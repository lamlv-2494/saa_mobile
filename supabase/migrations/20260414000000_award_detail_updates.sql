-- ==========================================
-- Cập nhật schema award_categories cho Award Detail screen
-- - Thêm cột i18n: unit_en, prize_note_en
-- - Mở rộng CHECK constraint trên unit (thêm 'Cá nhân hoặc tập thể')
-- - Tạo bảng award_prizes (cho giải có nhiều mức giá trị)
-- ==========================================

-- 1. Thêm cột i18n còn thiếu
ALTER TABLE award_categories ADD COLUMN IF NOT EXISTS unit_en VARCHAR;
ALTER TABLE award_categories ADD COLUMN IF NOT EXISTS prize_note_en VARCHAR;

-- 2. Mở rộng CHECK constraint trên unit
ALTER TABLE award_categories DROP CONSTRAINT IF EXISTS award_categories_unit_check;
ALTER TABLE award_categories ADD CONSTRAINT award_categories_unit_check
    CHECK (unit IN ('Cá nhân', 'Tập thể', 'Cá nhân hoặc tập thể'));

-- 3. Tạo bảng award_prizes (cho giải có nhiều mức giá trị, ví dụ: Signature)
CREATE TABLE IF NOT EXISTS award_prizes (
    id BIGSERIAL PRIMARY KEY,
    award_category_id BIGINT NOT NULL REFERENCES award_categories(id) ON DELETE CASCADE,
    prize_type VARCHAR NOT NULL CHECK (prize_type IN ('individual', 'team')),
    value_amount BIGINT NOT NULL,
    note_vi VARCHAR NOT NULL,
    note_en VARCHAR NOT NULL,
    sort_order INT NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_award_prizes_category_id ON award_prizes(award_category_id);
