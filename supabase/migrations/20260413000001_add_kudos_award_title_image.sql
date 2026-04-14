-- ==========================================
-- Thêm cột award_title vào bảng kudos
-- Ảnh kudos được lưu tại bảng kudos_photos (tối đa 5 ảnh/kudos)
-- Migration: 20260413000001
-- ==========================================

ALTER TABLE kudos
    ADD COLUMN award_title VARCHAR
        CHECK (award_title IN ('IDOL GIỚI TRẺ', 'LEADER', 'HERO'));
