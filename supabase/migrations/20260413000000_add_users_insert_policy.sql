-- Cho phép authenticated user tự tạo profile khi login lần đầu
CREATE POLICY users_insert ON users FOR INSERT
    WITH CHECK (auth_id = auth.uid());
