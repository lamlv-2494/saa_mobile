-- Xóa cột image_url khỏi bảng award_categories (không còn sử dụng, dùng slug để map local asset)
ALTER TABLE award_categories DROP COLUMN IF EXISTS image_url;
