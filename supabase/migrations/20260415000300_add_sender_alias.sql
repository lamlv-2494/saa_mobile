-- ==========================================
-- Thêm cột sender_alias vào bảng kudos
-- Lưu nickname ẩn danh do người gửi tự chọn.
-- Nullable — khi null hiển thị "Người gửi ẩn danh" mặc định.
-- Max 50 ký tự.
-- Migration: 20260415000300
-- ==========================================

ALTER TABLE kudos
    ADD COLUMN IF NOT EXISTS sender_alias VARCHAR;

ALTER TABLE kudos
    ADD CONSTRAINT kudos_sender_alias_length
        CHECK (char_length(sender_alias) <= 50);
