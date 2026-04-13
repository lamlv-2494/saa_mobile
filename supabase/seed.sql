-- ==========================================
-- SAA 2025 Mobile — Seed Data
-- Dùng cho local development
-- Data dựa trên Figma design [iOS] Home
-- ==========================================

-- ==========================================
-- 1. DEPARTMENTS
-- ==========================================

INSERT INTO departments (name, code) VALUES
    ('CECV1', 'CECV1'),
    ('CECV3', 'CECV3'),
    ('CECV10', 'CECV10'),
    ('CEVC3', 'CEVC3'),
    ('D1', 'D1'),
    ('D2', 'D2');

-- ==========================================
-- 2. EVENT SAA 2025
-- ==========================================

INSERT INTO events (theme_name, event_date, venue, livestream_note, theme_description, livestream_note_en, theme_description_en, is_active) VALUES
    ('Root Further',
     '2025-12-26T18:00:00+07:00',
     'Âu Cơ Art Center',
     'Tường thuật trực tiếp tại Group Facebook Sun* Family',
     'Không đơn thuần là một cái tên, "Root Further" chính là tinh thần mà mỗi người Sun* đang hướng tới: luôn nhìn nhận sâu sắc trong mọi bối cảnh và không ngừng sáng tạo, mở rộng bản thân để vượt qua những giới hạn mà chính mình đã từng đặt ra. Mượn hình ảnh ẩn dụ của lý thuyết phối màu, chỉ từ ba màu cơ bản: đỏ, vàng và lam, sức sáng tạo vô tận của mỗi cá nhân có thể tạo ra số lượng màu sắc gần như vô hạn, với mỗi gam màu đều đại diện cho sự bứt phá và sáng tạo không giới hạn.',
     'Live broadcast on Facebook Group Sun* Family',
     'More than just a name, "Root Further" embodies the spirit every Sun* member strives for: always perceiving deeply in every context and continuously innovating, expanding oneself to surpass the limits we once set. Borrowing the metaphor of color mixing theory, from just three primary colors — red, yellow, and blue — the boundless creativity of each individual can produce an almost infinite number of colors, with each hue representing breakthrough and limitless innovation.',
     true);

-- ==========================================
-- 3. AWARD CATEGORIES (6 giải — theo Figma design)
-- ==========================================

INSERT INTO award_categories (event_id, name, name_en, slug, description, description_en, image_url, quantity, unit, prize_value, prize_note, sort_order) VALUES
    (1, 'Top Talent', 'Top Talent', 'top-talent',
     'Giải thưởng Top Talent vinh danh những cá nhân xuất sắc toàn diện trên mọi phương diện trong năm. Được bình chọn bởi toàn bộ nhân viên và Ban Giám đốc.',
     'The Top Talent award honors outstanding individuals across all aspects throughout the year. Selected by all employees and the Board of Directors.',
     '/storage/v1/object/public/awards/top_talent.png',
     10, 'Cá nhân', 7000000, 'cho mỗi giải thưởng', 1),
    (1, 'Top Project', 'Top Project', 'top-project',
     'Giải thưởng Top Project vinh danh các tập thể dự án xuất sắc nhất trong năm. Đánh giá dựa trên chất lượng, hiệu quả và tác động.',
     'The Top Project award honors the best project teams of the year. Evaluated based on quality, efficiency, and impact.',
     '/storage/v1/object/public/awards/top_project.png',
     5, 'Tập thể', 10000000, 'cho mỗi dự án', 2),
    (1, 'Top Project Leader', 'Top Project Leader', 'top-project-leader',
     'Giải thưởng Top Project Leader vinh danh những nhà lãnh đạo dự án xuất sắc nhất, người đã dẫn dắt team đạt kết quả vượt trội.',
     'The Top Project Leader award honors the best project leaders who have led their teams to outstanding results.',
     '/storage/v1/object/public/awards/top_project_leader.png',
     5, 'Cá nhân', 7000000, 'cho mỗi giải thưởng', 3),
    (1, 'Best Manager', 'Best Manager', 'best-manager',
     'Giải thưởng Best Manager vinh danh những quản lý xuất sắc nhất có đóng góp nổi bật trong việc phát triển đội ngũ và tổ chức.',
     'The Best Manager award honors the most outstanding managers with remarkable contributions to team and organizational development.',
     '/storage/v1/object/public/awards/best_manager.png',
     5, 'Cá nhân', 7000000, 'cho mỗi giải thưởng', 4),
    (1, 'MVP', 'MVP', 'mvp',
     'Giải thưởng MVP vinh danh cá nhân có đóng góp giá trị nhất cho tổ chức. Người được chọn thể hiện sự xuất sắc vượt trội.',
     'The MVP award honors the individual with the most valuable contribution to the organization. The selected person demonstrates exceptional excellence.',
     '/storage/v1/object/public/awards/mvp.png',
     3, 'Cá nhân', 10000000, 'cho mỗi giải thưởng', 5),
    (1, 'Signature 2025 - Creator', 'Signature 2025 - Creator', 'signature-2025-creator',
     'Giải thưởng Signature 2025 Creator vinh danh những sáng tạo đột phá trong năm. Tôn vinh tinh thần đổi mới và dám nghĩ dám làm.',
     'The Signature 2025 Creator award honors breakthrough innovations of the year. Celebrating the spirit of renewal and daring to dream big.',
     '/storage/v1/object/public/awards/signature_creator.png',
     3, 'Cá nhân', 7000000, 'cho mỗi giải thưởng', 6);

-- ==========================================
-- 4. KUDOS CONFIG (Home screen Kudos section)
-- ==========================================

INSERT INTO kudos_config (event_id, title, description, banner_image_url, is_enabled) VALUES
    (1,
     'ĐIỂM MỚI CỦA SAA 2025',
     'Nhắn gửi yêu thương và sự biết ơn đến 845 nghìn Sunner trên toàn cầu! Sun* Kudos là tính năng mới trong SAA 2025, cho phép bạn gửi lời cảm ơn, ghi nhận đóng góp và thể hiện tình cảm đến đồng nghiệp một cách dễ dàng. Hãy để những thông điệp Ready Hearts thắp sáng mùa lễ hội!',
     '/kudos/banner_kudos.png',
     true);

-- ==========================================
-- 5. HASHTAGS
-- ==========================================

INSERT INTO hashtags (name) VALUES
    ('#Dedicated'),
    ('#Inspiring'),
    ('#Creative'),
    ('#TeamPlayer'),
    ('#Leadership'),
    ('#Innovation'),
    ('#RootFurther'),
    ('#Grateful'),
    ('#BestColleague'),
    ('#SunKudos');

-- ==========================================
-- 6. BADGES
-- ==========================================

INSERT INTO badges (name, image_url, description) VALUES
    ('New Hero', '/badges/new_hero.svg', 'Tân binh xuất sắc — Nhận được 5 Kudos đầu tiên'),
    ('Rising Hero', '/badges/rising_hero.svg', 'Ngôi sao đang lên — Nhận được 20 Kudos'),
    ('Super Hero', '/badges/super_hero.svg', 'Siêu anh hùng — Nhận được 50 Kudos'),
    ('Legend Hero', '/badges/legend_hero.svg', 'Huyền thoại — Nhận được 100 Kudos');

-- ==========================================
-- 7. SAMPLE USERS (dùng auth_id giả cho local dev)
-- Lưu ý: Khi đăng nhập qua Google OAuth, user record
-- sẽ được tạo tự động. Data này chỉ để test UI.
-- ==========================================

-- Tạo fake auth users trước (Supabase local)
INSERT INTO auth.users (id, email, raw_user_meta_data, created_at, updated_at, instance_id, aud, role)
VALUES
    ('a1111111-1111-1111-1111-111111111111', 'nguyenvana@sun-asterisk.com',
     '{"full_name": "Nguyễn Văn A", "avatar_url": "https://i.pravatar.cc/150?u=a"}',
     NOW(), NOW(), '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated'),
    ('b2222222-2222-2222-2222-222222222222', 'tranthib@sun-asterisk.com',
     '{"full_name": "Trần Thị B", "avatar_url": "https://i.pravatar.cc/150?u=b"}',
     NOW(), NOW(), '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated'),
    ('c3333333-3333-3333-3333-333333333333', 'levanc@sun-asterisk.com',
     '{"full_name": "Lê Văn C", "avatar_url": "https://i.pravatar.cc/150?u=c"}',
     NOW(), NOW(), '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated'),
    ('d4444444-4444-4444-4444-444444444444', 'phamthid@sun-asterisk.com',
     '{"full_name": "Phạm Thị D", "avatar_url": "https://i.pravatar.cc/150?u=d"}',
     NOW(), NOW(), '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated'),
    ('e5555555-5555-5555-5555-555555555555', 'hoangvane@sun-asterisk.com',
     '{"full_name": "Hoàng Văn E", "avatar_url": "https://i.pravatar.cc/150?u=e"}',
     NOW(), NOW(), '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated');

-- App-level user profiles
INSERT INTO users (auth_id, email, name, avatar_url, team_code, department_id, hero_tier) VALUES
    ('a1111111-1111-1111-1111-111111111111', 'nguyenvana@sun-asterisk.com', 'Nguyễn Văn A',
     'https://i.pravatar.cc/150?u=a', 'TEAM-01', 1, 'rising_hero'),
    ('b2222222-2222-2222-2222-222222222222', 'tranthib@sun-asterisk.com', 'Trần Thị B',
     'https://i.pravatar.cc/150?u=b', 'TEAM-02', 2, 'new_hero'),
    ('c3333333-3333-3333-3333-333333333333', 'levanc@sun-asterisk.com', 'Lê Văn C',
     'https://i.pravatar.cc/150?u=c', 'TEAM-01', 1, 'super_hero'),
    ('d4444444-4444-4444-4444-444444444444', 'phamthid@sun-asterisk.com', 'Phạm Thị D',
     'https://i.pravatar.cc/150?u=d', 'TEAM-03', 3, 'none'),
    ('e5555555-5555-5555-5555-555555555555', 'hoangvane@sun-asterisk.com', 'Hoàng Văn E',
     'https://i.pravatar.cc/150?u=e', 'TEAM-02', 2, 'legend_hero');

-- ==========================================
-- 8. SAMPLE KUDOS
-- ==========================================

INSERT INTO kudos (sender_id, recipient_id, message, award_category_name, is_anonymous, status, created_at) VALUES
    (1, 2, 'Cảm ơn chị B đã hỗ trợ team hoàn thành sprint trước deadline! Chị luôn là người reliable nhất team. 🙌', 'Top Talent', false, 'active', NOW() - INTERVAL '2 hours'),
    (2, 3, 'Anh C là một leader tuyệt vời, luôn lắng nghe và support team members. Respect! 💪', 'Top Project Leader', false, 'active', NOW() - INTERVAL '5 hours'),
    (3, 1, 'Bạn A đã có những đóng góp xuất sắc cho dự án XYZ. Code quality luôn ở top. Keep it up! ⭐', 'MVP', false, 'active', NOW() - INTERVAL '1 day'),
    (4, 5, 'Anh E luôn sáng tạo trong cách giải quyết vấn đề. Dự án của anh là nguồn cảm hứng cho cả team!', 'Signature 2025 - Creator', false, 'active', NOW() - INTERVAL '1 day'),
    (5, 1, 'Cảm ơn bạn A đã giúp fix bug production lúc nửa đêm. Tinh thần trách nhiệm tuyệt vời! 🔥', NULL, false, 'active', NOW() - INTERVAL '2 days'),
    (1, 4, 'Chị D đã tổ chức team building tuyệt vời. Mọi người đều rất vui và gắn kết hơn!', 'Best Manager', false, 'active', NOW() - INTERVAL '3 days'),
    (3, 2, 'Chị B training cho intern rất tận tình. Các bạn mới đều rất grateful!', NULL, true, 'active', NOW() - INTERVAL '3 days'),
    (2, 5, 'Anh E đã share kiến thức về Flutter architecture rất bổ ích. Cả team đều học được nhiều!', NULL, false, 'active', NOW() - INTERVAL '4 days');

-- ==========================================
-- 9. KUDOS HASHTAGS
-- ==========================================

INSERT INTO kudos_hashtags (kudos_id, hashtag_id) VALUES
    (1, 1), (1, 4),   -- Kudos 1: #Dedicated, #TeamPlayer
    (2, 5), (2, 2),   -- Kudos 2: #Leadership, #Inspiring
    (3, 3), (3, 6),   -- Kudos 3: #Creative, #Innovation
    (4, 3), (4, 7),   -- Kudos 4: #Creative, #RootFurther
    (5, 1), (5, 8),   -- Kudos 5: #Dedicated, #Grateful
    (6, 4), (6, 9),   -- Kudos 6: #TeamPlayer, #BestColleague
    (7, 2), (7, 8),   -- Kudos 7: #Inspiring, #Grateful
    (8, 6), (8, 10);  -- Kudos 8: #Innovation, #SunKudos

-- ==========================================
-- 10. KUDOS REACTIONS (Hearts)
-- ==========================================

INSERT INTO kudos_reactions (kudos_id, user_id) VALUES
    (1, 3), (1, 4), (1, 5),   -- Kudos 1: 3 hearts
    (2, 1), (2, 4),           -- Kudos 2: 2 hearts
    (3, 2), (3, 4), (3, 5),   -- Kudos 3: 3 hearts
    (4, 1), (4, 2), (4, 3),   -- Kudos 4: 3 hearts
    (5, 2), (5, 3),           -- Kudos 5: 2 hearts
    (6, 2), (6, 5);           -- Kudos 6: 2 hearts

-- ==========================================
-- 11. USER BADGES
-- ==========================================

INSERT INTO user_badges (user_id, badge_id, earned_at) VALUES
    (1, 2, NOW() - INTERVAL '30 days'),   -- User A: Rising Hero
    (2, 1, NOW() - INTERVAL '15 days'),   -- User B: New Hero
    (3, 3, NOW() - INTERVAL '60 days'),   -- User C: Super Hero
    (5, 4, NOW() - INTERVAL '90 days');   -- User E: Legend Hero

-- ==========================================
-- 12. NOTIFICATIONS (sample cho User A — id=1)
-- ==========================================

INSERT INTO notifications (user_id, type, title, message, reference_type, reference_id, is_read, created_at) VALUES
    (1, 'kudos_received', 'Bạn nhận được Kudos!', 'Lê Văn C đã gửi kudos cho bạn: "Bạn A đã có những đóng góp xuất sắc..."', 'kudos', 3, false, NOW() - INTERVAL '1 day'),
    (1, 'kudos_received', 'Bạn nhận được Kudos!', 'Hoàng Văn E đã gửi kudos cho bạn: "Cảm ơn bạn A đã giúp fix bug..."', 'kudos', 5, false, NOW() - INTERVAL '2 days'),
    (1, 'heart_received', 'Kudos của bạn được yêu thích!', 'Phạm Thị D đã thích kudos bạn gửi cho Trần Thị B', 'kudos', 1, false, NOW() - INTERVAL '3 hours'),
    (1, 'announcement', 'SAA 2025 sắp diễn ra!', 'Còn ít ngày nữa đến sự kiện SAA 2025. Hãy chuẩn bị tinh thần!', NULL, NULL, true, NOW() - INTERVAL '5 days'),
    (1, 'system', 'Chào mừng đến SAA 2025', 'Tải ứng dụng thành công. Khám phá các tính năng mới!', NULL, NULL, true, NOW() - INTERVAL '7 days');

-- Notifications cho User B — id=2
INSERT INTO notifications (user_id, type, title, message, reference_type, reference_id, is_read, created_at) VALUES
    (2, 'kudos_received', 'Bạn nhận được Kudos!', 'Nguyễn Văn A đã gửi kudos cho bạn', 'kudos', 1, false, NOW() - INTERVAL '2 hours'),
    (2, 'kudos_received', 'Bạn nhận được Kudos ẩn danh!', 'Một đồng nghiệp đã gửi kudos cho bạn', 'kudos', 7, false, NOW() - INTERVAL '3 days');

-- ==========================================
-- 13. CAMPAIGNS (sample)
-- ==========================================

INSERT INTO campaigns (name, description, start_date, end_date, status) VALUES
    ('Kudos Mùa Lễ Hội', 'Gửi kudos và nhận phần quà đặc biệt mùa lễ hội SAA 2025!', '2025-12-01T00:00:00+07:00', '2025-12-31T23:59:59+07:00', 'active'),
    ('Root Further Challenge', 'Thử thách gửi 10 kudos trong tuần — nhận badge đặc biệt!', '2025-12-15T00:00:00+07:00', '2025-12-22T23:59:59+07:00', 'draft');

-- ==========================================
-- 14. SECRET BOXES (sample cho User A)
-- ==========================================

INSERT INTO secret_boxes (user_id, is_opened, opened_at, reward_type, reward_value) VALUES
    (1, true, NOW() - INTERVAL '2 days', 'badge', 'New Hero'),
    (1, false, NULL, NULL, NULL),
    (2, false, NULL, NULL, NULL);
