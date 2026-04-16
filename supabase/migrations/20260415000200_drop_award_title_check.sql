-- ==========================================
-- Xoá CHECK constraint trên cột award_title
-- Theo spec, award_title là free-form text (max 100 ký tự)
-- do người dùng tự nhập, không giới hạn giá trị cố định.
-- Thay bằng constraint max length 100.
-- Migration: 20260415000200
-- ==========================================

ALTER TABLE kudos
    DROP CONSTRAINT kudos_award_title_check;

ALTER TABLE kudos
    ADD CONSTRAINT kudos_award_title_length
        CHECK (char_length(award_title) <= 100);
