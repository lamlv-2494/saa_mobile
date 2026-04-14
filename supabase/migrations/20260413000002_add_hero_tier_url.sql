-- ==========================================
-- Thêm hero_tier_url vào bảng users
-- Lưu URL ảnh badge hero tier từ Supabase Storage
-- ==========================================

ALTER TABLE users ADD COLUMN hero_tier_url VARCHAR;

-- Tạo storage bucket cho hero tier badges
INSERT INTO storage.buckets (id, name, public)
VALUES ('hero-tiers', 'hero-tiers', true)
ON CONFLICT (id) DO NOTHING;

-- Policy cho phép đọc public
CREATE POLICY "Public read hero-tiers"
ON storage.objects FOR SELECT
USING (bucket_id = 'hero-tiers');

-- Policy cho phép admin upload
CREATE POLICY "Admin upload hero-tiers"
ON storage.objects FOR INSERT
WITH CHECK (
    bucket_id = 'hero-tiers'
    AND auth.role() = 'authenticated'
);
