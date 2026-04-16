-- Xóa cột hero_tier_url khỏi bảng users (không còn sử dụng)
ALTER TABLE users DROP COLUMN IF EXISTS hero_tier_url;
