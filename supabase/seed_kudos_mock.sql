-- ==========================================
-- Mock data bổ sung cho màn hình [iOS] Sun*Kudos
-- ==========================================

-- Thêm auth users (valid hex UUIDs)
INSERT INTO auth.users (id, email, raw_user_meta_data, created_at, updated_at, instance_id, aud, role) VALUES
    ('f6666666-6666-6666-6666-666666666666', 'dohoahiep@sun-asterisk.com', '{"full_name": "Đỗ Hoàng Hiệp", "avatar_url": "https://i.pravatar.cc/150?u=f6"}', NOW(), NOW(), '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated'),
    ('a7777777-7777-7777-7777-777777777777', 'duongthuyan@sun-asterisk.com', '{"full_name": "Dương Thúy An", "avatar_url": "https://i.pravatar.cc/150?u=a7"}', NOW(), NOW(), '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated'),
    ('b8888888-8888-8888-8888-888888888888', 'phamdindat@sun-asterisk.com', '{"full_name": "Phạm Đình Đạt", "avatar_url": "https://i.pravatar.cc/150?u=b8"}', NOW(), NOW(), '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated'),
    ('c9999999-9999-9999-9999-999999999999', 'huynhdindat@sun-asterisk.com', '{"full_name": "Huỳnh Đình Đạt", "avatar_url": "https://i.pravatar.cc/150?u=c9"}', NOW(), NOW(), '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated'),
    ('d0000000-0000-0000-0000-000000000010', 'nguyenthimai@sun-asterisk.com', '{"full_name": "Nguyễn Thị Mai", "avatar_url": "https://i.pravatar.cc/150?u=d0"}', NOW(), NOW(), '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated'),
    ('e1111111-1111-1111-1111-111111111112', 'vothanhson@sun-asterisk.com', '{"full_name": "Võ Thanh Sơn", "avatar_url": "https://i.pravatar.cc/150?u=e1"}', NOW(), NOW(), '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated'),
    ('f2222222-2222-2222-2222-222222222223', 'tranminhquan@sun-asterisk.com', '{"full_name": "Trần Minh Quân", "avatar_url": "https://i.pravatar.cc/150?u=f2"}', NOW(), NOW(), '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated'),
    ('a3333333-3333-3333-3333-333333333334', 'lethihong@sun-asterisk.com', '{"full_name": "Lê Thị Hồng", "avatar_url": "https://i.pravatar.cc/150?u=a3"}', NOW(), NOW(), '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated'),
    ('b4444444-4444-4444-4444-444444444445', 'dangvantung@sun-asterisk.com', '{"full_name": "Đặng Văn Tùng", "avatar_url": "https://i.pravatar.cc/150?u=b4"}', NOW(), NOW(), '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated'),
    ('c5555555-5555-5555-5555-555555555556', 'buithiyen@sun-asterisk.com', '{"full_name": "Bùi Thị Yến", "avatar_url": "https://i.pravatar.cc/150?u=c5"}', NOW(), NOW(), '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated')
ON CONFLICT (id) DO NOTHING;

-- App-level user profiles
INSERT INTO users (auth_id, email, name, avatar_url, team_code, department_id, hero_tier) VALUES
    ('f6666666-6666-6666-6666-666666666666', 'dohoahiep@sun-asterisk.com', 'Đỗ Hoàng Hiệp', 'https://i.pravatar.cc/150?u=f6', 'TEAM-01', 1, 'super_hero'),
    ('a7777777-7777-7777-7777-777777777777', 'duongthuyan@sun-asterisk.com', 'Dương Thúy An', 'https://i.pravatar.cc/150?u=a7', 'TEAM-02', 2, 'rising_hero'),
    ('b8888888-8888-8888-8888-888888888888', 'phamdindat@sun-asterisk.com', 'Phạm Đình Đạt', 'https://i.pravatar.cc/150?u=b8', 'TEAM-03', 3, 'new_hero'),
    ('c9999999-9999-9999-9999-999999999999', 'huynhdindat@sun-asterisk.com', 'Huỳnh Đình Đạt', 'https://i.pravatar.cc/150?u=c9', 'TEAM-01', 1, 'legend_hero'),
    ('d0000000-0000-0000-0000-000000000010', 'nguyenthimai@sun-asterisk.com', 'Nguyễn Thị Mai', 'https://i.pravatar.cc/150?u=d0', 'TEAM-02', 4, 'rising_hero'),
    ('e1111111-1111-1111-1111-111111111112', 'vothanhson@sun-asterisk.com', 'Võ Thanh Sơn', 'https://i.pravatar.cc/150?u=e1', 'TEAM-03', 5, 'new_hero'),
    ('f2222222-2222-2222-2222-222222222223', 'tranminhquan@sun-asterisk.com', 'Trần Minh Quân', 'https://i.pravatar.cc/150?u=f2', 'TEAM-01', 6, 'super_hero'),
    ('a3333333-3333-3333-3333-333333333334', 'lethihong@sun-asterisk.com', 'Lê Thị Hồng', 'https://i.pravatar.cc/150?u=a3', 'TEAM-02', 1, 'none'),
    ('b4444444-4444-4444-4444-444444444445', 'dangvantung@sun-asterisk.com', 'Đặng Văn Tùng', 'https://i.pravatar.cc/150?u=b4', 'TEAM-03', 2, 'rising_hero'),
    ('c5555555-5555-5555-5555-555555555556', 'buithiyen@sun-asterisk.com', 'Bùi Thị Yến', 'https://i.pravatar.cc/150?u=c5', 'TEAM-01', 3, 'new_hero')
ON CONFLICT (auth_id) DO NOTHING;

-- Thêm kudos (sender/recipient dùng user IDs 6-15)
INSERT INTO kudos (sender_id, recipient_id, message, award_category_name, is_anonymous, status, created_at) VALUES
    (6, 7, 'Chị An luôn tận tâm với công việc, giúp đỡ mọi người trong team. Cảm ơn chị! 💛', 'Top Talent', false, 'active', NOW() - INTERVAL '30 minutes'),
    (7, 6, 'Anh Hiệp là mentor tuyệt vời nhất! Cảm ơn anh đã giúp mình grow up! 🌟', 'MVP', false, 'active', NOW() - INTERVAL '1 hour'),
    (8, 9, 'Anh Đạt lead team vượt qua giai đoạn khó khăn. Respect anh! 💪', 'Top Project Leader', false, 'active', NOW() - INTERVAL '2 hours'),
    (9, 10, 'Chị Mai workshop xuất sắc, giúp team nâng cao kỹ năng. Thank you! 🎯', 'Best Manager', false, 'active', NOW() - INTERVAL '3 hours'),
    (10, 11, 'Anh Sơn sáng tạo trong cách tiếp cận. Impact lớn cho công ty!', 'Signature 2025 - Creator', false, 'active', NOW() - INTERVAL '4 hours'),
    (11, 12, 'Anh Quân share knowledge system design. Team benefit rất nhiều!', NULL, false, 'active', NOW() - INTERVAL '5 hours'),
    (12, 13, 'Chị Hồng positive và spread energy tốt. Sunshine của team! ☀️', NULL, false, 'active', NOW() - INTERVAL '6 hours'),
    (13, 14, 'Anh Tùng optimize CI/CD giúp team tiết kiệm hàng giờ. Amazing!', NULL, false, 'active', NOW() - INTERVAL '7 hours'),
    (14, 15, 'Chị Yến review code tận tình, junior learn rất nhiều. 🙏', NULL, false, 'active', NOW() - INTERVAL '8 hours'),
    (15, 6, 'Anh Hiệp fix critical bug cuối tuần. Dedication tuyệt vời!', 'Top Talent', false, 'active', NOW() - INTERVAL '10 hours'),
    (6, 8, 'Bạn Đạt demo sản phẩm trước khách hàng impressive! 🎉', NULL, false, 'active', NOW() - INTERVAL '12 hours'),
    (7, 1, 'Anh A support mọi người không điều kiện. Backbone của team! 💙', NULL, false, 'active', NOW() - INTERVAL '1 day'),
    (1, 6, 'Anh Hiệp đi đầu áp dụng công nghệ mới. Pioneer thực sự! 🚀', 'MVP', false, 'active', NOW() - INTERVAL '2 days'),
    (2, 7, 'Chị An coordinate cross-team flawlessly. Impressive leadership!', 'Top Project Leader', false, 'active', NOW() - INTERVAL '2 days'),
    (3, 9, 'Anh Đạt code clean và document kỹ. Best practices role model!', NULL, false, 'active', NOW() - INTERVAL '3 days'),
    (4, 10, 'Chị Mai plan sprint chi tiết, team deliver đúng deadline!', 'Best Manager', false, 'active', NOW() - INTERVAL '3 days'),
    (5, 11, 'Anh Sơn volunteer đầu tiên khi team cần help. True team player!', NULL, false, 'active', NOW() - INTERVAL '4 days'),
    (6, 12, 'Anh Quân build internal tool tiết kiệm thời gian cả công ty!', 'Signature 2025 - Creator', false, 'active', NOW() - INTERVAL '5 days'),
    (9, 1, 'Bạn A handle incident production chuyên nghiệp. Calm under pressure! 🧘', NULL, false, 'active', NOW() - INTERVAL '6 days'),
    (8, 3, 'Anh C luôn giải đáp thắc mắc kỹ thuật cho team. Guru thực sự!', NULL, true, 'active', NOW() - INTERVAL '7 days');
