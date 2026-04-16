-- ==========================================
-- SAA 2025 Mobile — Seed Data (hợp nhất)
-- Dùng cho local development
-- Gom từ: seed.sql + seed_kudos_mock.sql + seed_all_kudos.sql
-- Cập nhật: 2026-04-14
-- ==========================================
-- Lưu ý: ON CONFLICT DO NOTHING — không mất data đang có.
-- ==========================================

-- ==========================================
-- 1. DEPARTMENTS
-- ==========================================

INSERT INTO departments (name, code) VALUES
    ('CECV1', 'CECV1'),
    ('CECV2', 'CECV2'),
    ('CECV3', 'CECV3'),
    ('CECV4', 'CECV4'),
    ('ODP', 'ODP'),
    ('Infra', 'Infra')
ON CONFLICT (id) DO NOTHING;

SELECT setval('departments_id_seq', GREATEST((SELECT MAX(id) FROM departments), 6));

-- ==========================================
-- 2. EVENT SAA 2025
-- ==========================================

INSERT INTO events (id, theme_name, event_date, venue, livestream_note, theme_description, livestream_note_en, theme_description_en, is_active) VALUES
    (1, 'Root Further',
     '2025-12-26 11:00:00+00',
     'Âu Cơ Art Center',
     'Tường thuật trực tiếp tại Group Facebook Sun* Family',
     'Không đơn thuần là một cái tên, "Root Further" chính là tinh thần mà mỗi người Sun* đang hướng tới: luôn nhìn nhận sâu sắc trong mọi bối cảnh và không ngừng sáng tạo, mở rộng bản thân để vượt qua những giới hạn mà chính mình đã từng đặt ra. Mượn hình ảnh ẩn dụ của lý thuyết phối màu, chỉ từ ba màu cơ bản: đỏ, vàng và lam, sức sáng tạo vô tận của mỗi cá nhân có thể tạo ra số lượng màu sắc gần như vô hạn, với mỗi gam màu đều đại diện cho sự bứt phá và sáng tạo không giới hạn.',
     'Live broadcast on Facebook Group Sun* Family',
     'More than just a name, "Root Further" embodies the spirit every Sun* member strives for: always perceiving deeply in every context and continuously innovating, expanding oneself to surpass the limits we once set. Borrowing the metaphor of color mixing theory, from just three primary colors — red, yellow, and blue — the boundless creativity of each individual can produce an almost infinite number of colors, with each hue representing breakthrough and limitless innovation.',
     true)
ON CONFLICT (id) DO NOTHING;

SELECT setval('events_id_seq', GREATEST((SELECT MAX(id) FROM events), 1));

-- ==========================================
-- 3. AWARD CATEGORIES (6 giải)
-- ==========================================

INSERT INTO award_categories (event_id, name, name_en, slug, description, description_en, image_url, quantity, unit, unit_en, prize_value, prize_note, prize_note_en, sort_order) VALUES
    (1, 'Top Talent', 'Top Talent', 'top-talent',
     'Giải thưởng Top Talent vinh danh những cá nhân xuất sắc toàn diện – những người không ngừng khẳng định năng lực chuyên môn vững vàng, hiệu suất công việc vượt trội, luôn mang lại giá trị vượt kỳ vọng, được đánh giá cao bởi khách hàng và đồng đội. Với tinh thần sẵn sàng nhận mọi nhiệm vụ tổ chức giao phó, họ luôn là nguồn cảm hứng, thúc đẩy động lực và tạo ảnh hưởng tích cực đến cả tập thể.',
     'The Top Talent award honors well-rounded outstanding individuals – those who continuously demonstrate solid professional competence, exceptional work performance, consistently deliver beyond expectations, and are highly regarded by clients and colleagues. With a spirit of readiness to take on any task assigned by the organization, they are always a source of inspiration, driving motivation and creating a positive impact on the entire team.',
     '/storage/v1/object/public/awards/top_talent.png',
     10, 'Cá nhân', 'Individual', 7000000, 'cho mỗi giải thưởng', 'per award', 1),
    (1, 'Top Project', 'Top Project', 'top-project',
     'Giải thưởng Top Project vinh danh các tập thể dự án xuất sắc với kết quả kinh doanh vượt kỳ vọng, hiệu quả vận hành tối ưu và tinh thần làm việc tận tâm. Đây là các dự án có độ phức tạp kỹ thuật cao, hiệu quả tối ưu hóa nguồn lực và chi phí tốt, đề xuất các ý tưởng có giá trị cho khách hàng, đem lại lợi nhuận vượt trội và nhận được phản hồi tích cực từ khách hàng. Các thành viên tuân thủ nghiêm ngặt các tiêu chuẩn phát triển nội bộ trong phát triển dự án, tạo nên một hình mẫu về sự xuất sắc và chuyên nghiệp.',
     'The Top Project award honors outstanding project teams with business results exceeding expectations, optimal operational efficiency, and a dedicated work ethic. These are projects with high technical complexity, excellent resource and cost optimization, valuable ideas proposed to clients, outstanding profitability, and positive client feedback. Team members strictly adhere to internal development standards, creating a model of excellence and professionalism.',
     '/storage/v1/object/public/awards/top_project.png',
     2, 'Tập thể', 'Team', 15000000, 'cho mỗi giải thưởng', 'per award', 2),
    (1, 'Top Project Leader', 'Top Project Leader', 'top-project-leader',
     'Giải thưởng Top Project Leader vinh danh những nhà quản lý dự án xuất sắc – những người hội tụ năng lực quản lý vững vàng, khả năng truyền cảm hứng mạnh mẽ, và tư duy "Aim High – Be Agile" trong mọi bài toán và bối cảnh. Dưới sự dẫn dắt của họ, các thành viên không chỉ cùng nhau vượt qua thử thách và đạt được mục tiêu đề ra, mà còn giữ vững ngọn lửa nhiệt huyết, tinh thần Wasshoi, và trưởng thành để trở thành phiên bản tinh hoa – hạnh phúc hơn của chính mình.',
     'The Top Project Leader award honors outstanding project managers – those who combine solid management capabilities, strong inspirational skills, and an "Aim High – Be Agile" mindset in every challenge and context. Under their leadership, team members not only overcome challenges together and achieve set goals, but also maintain the fire of enthusiasm, the Wasshoi spirit, and grow to become the finest, happiest version of themselves.',
     '/storage/v1/object/public/awards/top_project_leader.png',
     3, 'Cá nhân', 'Individual', 7000000, 'cho mỗi giải thưởng', 'per award', 3),
    (1, 'Best Manager', 'Best Manager', 'best-manager',
     'Giải thưởng Best Manager vinh danh những nhà lãnh đạo tiêu biểu – người đã dẫn dắt đội ngũ của mình tạo ra kết quả vượt kỳ vọng, tác động nổi bật đến hiệu quả kinh doanh và sự phát triển bền vững của tổ chức. Dưới sự lãnh đạo của họ, đội ngũ luôn chinh phục và làm chủ mọi mục tiêu bằng năng lực đa nhiệm, khả năng phối hợp hiệu quả, và tư duy ứng dụng công nghệ linh hoạt trong kỷ nguyên số. Họ truyền cảm hứng để tập thể trở nên tự tin tràn đầy năng lượng, sẵn sàng đón nhận, thậm chí dẫn dắt tạo ra những thay đổi có tính cách mạng.',
     'The Best Manager award honors exemplary leaders – those who have led their teams to deliver results exceeding expectations, making a remarkable impact on business efficiency and the sustainable development of the organization. Under their leadership, teams consistently conquer and master every goal through multitasking capabilities, effective coordination, and flexible technology-driven thinking in the digital era. They inspire their teams to become confident, energized, and ready to embrace – even lead – revolutionary changes.',
     '/storage/v1/object/public/awards/best_manager.png',
     1, 'Cá nhân', 'Individual', 10000000, 'cho mỗi giải thưởng', 'per award', 4),
    (1, 'MVP', 'MVP (Most Valuable Person)', 'mvp',
     'Giải thưởng MVP vinh danh cá nhân xuất sắc nhất năm – gương mặt tiêu biểu đại diện cho toàn bộ tập thể Sun*. Họ là người đã thể hiện năng lực vượt trội, tinh thần cống hiến bền bỉ, và tầm ảnh hưởng sâu rộng, để lại dấu ấn mạnh mẽ trong hành trình của Sun* suốt năm qua. Không chỉ nổi bật bởi hiệu suất và kết quả công việc, họ còn là nguồn cảm hứng lan tỏa – thông qua suy nghĩ, hành động và ảnh hưởng tích cực của mình đối với tập thể. MVP là người hội tụ đầy đủ phẩm chất của người Sun* ưu tú, đồng thời mang trên mình trọng trách lớn lao: trở thành hình mẫu đại diện cho con người và tinh thần Sun*, góp phần dẫn dắt tập thể vươn tới những đỉnh cao mới.',
     'The MVP award honors the most outstanding individual of the year – the representative face of the entire Sun* community. They have demonstrated exceptional capabilities, persistent dedication, and far-reaching influence, leaving a strong mark on Sun*''s journey throughout the past year. Not only standing out for their performance and work results, they are also a spreading source of inspiration – through their thinking, actions, and positive influence on the team. The MVP embodies all the qualities of an elite Sun* member, while carrying the great responsibility of becoming a role model representing the people and spirit of Sun*, helping to lead the community toward new heights.',
     '/storage/v1/object/public/awards/mvp.png',
     1, 'Cá nhân', 'Individual', 15000000, 'cho giải cá nhân', 'for individual award', 5),
    (1, 'Signature 2025 - Creator', 'Signature 2025 - Creator', 'signature-2025-creator',
     'Giải thưởng Signature vinh danh cá nhân hoặc tập thể thể hiện tinh thần đặc trưng mà Sun* hướng tới trong từng thời kỳ. Trong năm 2025, giải thưởng Signature vinh danh Creator - cá nhân/tập thể mang tư duy chủ động và nhạy bén, luôn nhìn thấy cơ hội trong thách thức và tiên phong trong hành động. Họ không chỉ dừng lại ở việc thực hiện nhiệm vụ mà còn kiến tạo giá trị mới, mở ra hướng đi sáng tạo cho tập thể và tổ chức. Creator là người dám nghĩ khác, dám làm khác và truyền cảm hứng để những người xung quanh cùng bứt phá.',
     'The Signature award honors individuals or teams that embody the distinctive spirit Sun* strives for in each era. In 2025, the Signature award celebrates the Creator – individuals/teams with a proactive and agile mindset, who always see opportunities in challenges and pioneer in action. They go beyond just executing tasks to create new value, opening creative pathways for the team and organization. The Creator dares to think differently, act differently, and inspires those around them to break through together.',
     '/storage/v1/object/public/awards/signature_creator.png',
     1, 'Cá nhân hoặc tập thể', 'Individual or Team', NULL, NULL, NULL, 6)
ON CONFLICT (id) DO NOTHING;

SELECT setval('award_categories_id_seq', GREATEST((SELECT MAX(id) FROM award_categories), 6));

-- ==========================================
-- 3.1 AWARD PRIZES (Signature có 2 mức)
-- ==========================================

INSERT INTO award_prizes (award_category_id, prize_type, value_amount, note_vi, note_en, sort_order) VALUES
    ((SELECT id FROM award_categories WHERE slug = 'signature-2025-creator'), 'individual', 5000000, 'cho giải cá nhân', 'for individual award', 1),
    ((SELECT id FROM award_categories WHERE slug = 'signature-2025-creator'), 'team', 8000000, 'cho giải tập thể', 'for team award', 2);

-- ==========================================
-- 4. KUDOS CONFIG
-- ==========================================

INSERT INTO kudos_config (id, event_id, title, description, banner_image_url, is_enabled) VALUES
    (1, 1,
     'ĐIỂM MỚI CỦA SAA 2025',
     'Nhắn gửi yêu thương và sự biết ơn đến 845 nghìn Sunner trên toàn cầu! Sun* Kudos là tính năng mới trong SAA 2025, cho phép bạn gửi lời cảm ơn, ghi nhận đóng góp và thể hiện tình cảm đến đồng nghiệp một cách dễ dàng. Hãy để những thông điệp Ready Hearts thắp sáng mùa lễ hội!',
     '/kudos/banner_kudos.png',
     true)
ON CONFLICT (id) DO NOTHING;

SELECT setval('kudos_config_id_seq', GREATEST((SELECT MAX(id) FROM kudos_config), 1));

-- ==========================================
-- 5. HASHTAGS
-- ==========================================

INSERT INTO hashtags (id, name) VALUES
    (1, '#Dedicated'),
    (2, '#Inspiring'),
    (3, '#Creative'),
    (4, '#TeamPlayer'),
    (5, '#Leadership'),
    (6, '#Innovation'),
    (7, '#RootFurther'),
    (8, '#Grateful'),
    (9, '#BestColleague'),
    (10, '#SunKudos')
ON CONFLICT (id) DO NOTHING;

SELECT setval('hashtags_id_seq', GREATEST((SELECT MAX(id) FROM hashtags), 10));

-- ==========================================
-- 6. BADGES
-- ==========================================

INSERT INTO badges (id, name, image_url, description) VALUES
    (1, 'New Hero', '/storage/v1/object/public/hero-tiers/new_hero.png', 'Tân binh xuất sắc — Nhận được 5 Kudos đầu tiên'),
    (2, 'Rising Hero', '/storage/v1/object/public/hero-tiers/rising_hero.png', 'Ngôi sao đang lên — Nhận được 20 Kudos'),
    (3, 'Super Hero', '/storage/v1/object/public/hero-tiers/super_hero.png', 'Siêu anh hùng — Nhận được 50 Kudos'),
    (4, 'Legend Hero', '/storage/v1/object/public/hero-tiers/legend_hero.png', 'Huyền thoại — Nhận được 100 Kudos')
ON CONFLICT (id) DO NOTHING;

SELECT setval('badges_id_seq', GREATEST((SELECT MAX(id) FROM badges), 4));

-- ==========================================
-- 7. USERS (15 users: 5 cơ bản + 10 bổ sung)
-- ==========================================

-- 7a. Auth users (fake UUIDs cho local dev)
INSERT INTO auth.users (id, email, raw_user_meta_data, created_at, updated_at, instance_id, aud, role) VALUES
    ('a1111111-1111-1111-1111-111111111111', 'nguyenvana@sun-asterisk.com', '{"full_name": "Nguyễn Văn A", "avatar_url": "https://i.pravatar.cc/150?u=a"}', '2026-04-13 11:56:44.701371+00', '2026-04-13 11:56:44.701371+00', '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated'),
    ('b2222222-2222-2222-2222-222222222222', 'tranthib@sun-asterisk.com', '{"full_name": "Trần Thị B", "avatar_url": "https://i.pravatar.cc/150?u=b"}', '2026-04-13 11:56:44.701371+00', '2026-04-13 11:56:44.701371+00', '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated'),
    ('c3333333-3333-3333-3333-333333333333', 'levanc@sun-asterisk.com', '{"full_name": "Lê Văn C", "avatar_url": "https://i.pravatar.cc/150?u=c"}', '2026-04-13 11:56:44.701371+00', '2026-04-13 11:56:44.701371+00', '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated'),
    ('d4444444-4444-4444-4444-444444444444', 'phamthid@sun-asterisk.com', '{"full_name": "Phạm Thị D", "avatar_url": "https://i.pravatar.cc/150?u=d"}', '2026-04-13 11:56:44.701371+00', '2026-04-13 11:56:44.701371+00', '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated'),
    ('e5555555-5555-5555-5555-555555555555', 'hoangvane@sun-asterisk.com', '{"full_name": "Hoàng Văn E", "avatar_url": "https://i.pravatar.cc/150?u=e"}', '2026-04-13 11:56:44.701371+00', '2026-04-13 11:56:44.701371+00', '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated'),
    -- Users 6-15
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

-- 7b. App-level user profiles
INSERT INTO users (id, auth_id, email, name, avatar_url, team_code, department_id, hero_tier, hero_tier_url) VALUES
    (1, 'a1111111-1111-1111-1111-111111111111', 'nguyenvana@sun-asterisk.com', 'Nguyễn Văn A', 'https://i.pravatar.cc/150?u=a', 'TEAM-01', 1, 'rising_hero', '/storage/v1/object/public/hero-tiers/rising_hero.png'),
    (2, 'b2222222-2222-2222-2222-222222222222', 'tranthib@sun-asterisk.com', 'Trần Thị B', 'https://i.pravatar.cc/150?u=b', 'TEAM-02', 2, 'new_hero', '/storage/v1/object/public/hero-tiers/new_hero.png'),
    (3, 'c3333333-3333-3333-3333-333333333333', 'levanc@sun-asterisk.com', 'Lê Văn C', 'https://i.pravatar.cc/150?u=c', 'TEAM-01', 1, 'super_hero', '/storage/v1/object/public/hero-tiers/super_hero.png'),
    (4, 'd4444444-4444-4444-4444-444444444444', 'phamthid@sun-asterisk.com', 'Phạm Thị D', 'https://i.pravatar.cc/150?u=d', 'TEAM-03', 3, 'super_hero', '/storage/v1/object/public/hero-tiers/super_hero.png'),
    (5, 'e5555555-5555-5555-5555-555555555555', 'hoangvane@sun-asterisk.com', 'Hoàng Văn E', 'https://i.pravatar.cc/150?u=e', 'TEAM-02', 2, 'legend_hero', '/storage/v1/object/public/hero-tiers/legend_hero.png'),
    (6, 'f6666666-6666-6666-6666-666666666666', 'dohoahiep@sun-asterisk.com', 'Đỗ Hoàng Hiệp', 'https://i.pravatar.cc/150?u=f6', 'TEAM-01', 1, 'super_hero', '/storage/v1/object/public/hero-tiers/super_hero.png'),
    (7, 'a7777777-7777-7777-7777-777777777777', 'duongthuyan@sun-asterisk.com', 'Dương Thúy An', 'https://i.pravatar.cc/150?u=a7', 'TEAM-02', 2, 'rising_hero', '/storage/v1/object/public/hero-tiers/rising_hero.png'),
    (8, 'b8888888-8888-8888-8888-888888888888', 'phamdindat@sun-asterisk.com', 'Phạm Đình Đạt', 'https://i.pravatar.cc/150?u=b8', 'TEAM-03', 3, 'new_hero', '/storage/v1/object/public/hero-tiers/new_hero.png'),
    (9, 'c9999999-9999-9999-9999-999999999999', 'huynhdindat@sun-asterisk.com', 'Huỳnh Đình Đạt', 'https://i.pravatar.cc/150?u=c9', 'TEAM-01', 1, 'legend_hero', '/storage/v1/object/public/hero-tiers/legend_hero.png'),
    (10, 'd0000000-0000-0000-0000-000000000010', 'nguyenthimai@sun-asterisk.com', 'Nguyễn Thị Mai', 'https://i.pravatar.cc/150?u=d0', 'TEAM-02', 4, 'rising_hero', '/storage/v1/object/public/hero-tiers/rising_hero.png'),
    (11, 'e1111111-1111-1111-1111-111111111112', 'vothanhson@sun-asterisk.com', 'Võ Thanh Sơn', 'https://i.pravatar.cc/150?u=e1', 'TEAM-03', 5, 'new_hero', '/storage/v1/object/public/hero-tiers/new_hero.png'),
    (12, 'f2222222-2222-2222-2222-222222222223', 'tranminhquan@sun-asterisk.com', 'Trần Minh Quân', 'https://i.pravatar.cc/150?u=f2', 'TEAM-01', 6, 'super_hero', '/storage/v1/object/public/hero-tiers/super_hero.png'),
    (13, 'a3333333-3333-3333-3333-333333333334', 'lethihong@sun-asterisk.com', 'Lê Thị Hồng', 'https://i.pravatar.cc/150?u=a3', 'TEAM-02', 1, 'rising_hero', '/storage/v1/object/public/hero-tiers/rising_hero.png'),
    (14, 'b4444444-4444-4444-4444-444444444445', 'dangvantung@sun-asterisk.com', 'Đặng Văn Tùng', 'https://i.pravatar.cc/150?u=b4', 'TEAM-03', 2, 'rising_hero', '/storage/v1/object/public/hero-tiers/rising_hero.png'),
    (15, 'c5555555-5555-5555-5555-555555555556', 'buithiyen@sun-asterisk.com', 'Bùi Thị Yến', 'https://i.pravatar.cc/150?u=c5', 'TEAM-01', 3, 'new_hero', '/storage/v1/object/public/hero-tiers/new_hero.png')
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    avatar_url = EXCLUDED.avatar_url,
    team_code = EXCLUDED.team_code,
    department_id = EXCLUDED.department_id,
    hero_tier = EXCLUDED.hero_tier,
    hero_tier_url = EXCLUDED.hero_tier_url;

SELECT setval('users_id_seq', GREATEST((SELECT MAX(id) FROM users), 15));

-- ==========================================
-- 8. KUDOS (48 records — đủ 2+ pages phân trang)
-- ==========================================

INSERT INTO kudos (id, sender_id, recipient_id, message, award_category_name, award_title, is_anonymous, status, created_at) VALUES
    -- Kudos 1-8: base data
    (1, 1, 2, 'Cảm ơn chị B đã hỗ trợ team hoàn thành sprint trước deadline! Chị luôn là người reliable nhất team. 🙌', 'Top Talent', 'IDOL GIỚI TRẺ', false, 'active', '2026-04-13 09:56:44.701371+00'),
    (2, 2, 3, 'Anh C là một leader tuyệt vời, luôn lắng nghe và support team members. Respect! 💪', 'Top Project Leader', 'LEADER', false, 'active', '2026-04-13 06:56:44.701371+00'),
    (3, 3, 1, 'Bạn A đã có những đóng góp xuất sắc cho dự án XYZ. Code quality luôn ở top. Keep it up! ⭐', 'MVP', 'HERO', false, 'active', '2026-04-12 11:56:44.701371+00'),
    (4, 4, 5, 'Anh E luôn sáng tạo trong cách giải quyết vấn đề. Dự án của anh là nguồn cảm hứng cho cả team!', 'Signature 2025 - Creator', 'IDOL GIỚI TRẺ', false, 'active', '2026-04-12 11:56:44.701371+00'),
    (5, 5, 1, 'Cảm ơn bạn A đã giúp fix bug production lúc nửa đêm. Tinh thần trách nhiệm tuyệt vời! 🔥', NULL, NULL, false, 'active', '2026-04-11 11:56:44.701371+00'),
    (6, 1, 4, 'Chị D đã tổ chức team building tuyệt vời. Mọi người đều rất vui và gắn kết hơn!', 'Best Manager', 'LEADER', false, 'active', '2026-04-10 11:56:44.701371+00'),
    (7, 3, 2, 'Chị B training cho intern rất tận tình. Các bạn mới đều rất grateful!', NULL, NULL, true, 'active', '2026-04-10 11:56:44.701371+00'),
    (8, 2, 5, 'Anh E đã share kiến thức về Flutter architecture rất bổ ích. Cả team đều học được nhiều!', NULL, 'HERO', false, 'active', '2026-04-09 11:56:44.701371+00'),
    -- Kudos 9-28: mock data mở rộng (từ users 6-15)
    (9, 6, 7, 'Chị An luôn tận tâm với công việc, giúp đỡ mọi người trong team. Cảm ơn chị! 💛', 'Top Talent', 'IDOL GIỚI TRẺ', false, 'active', NOW() - INTERVAL '30 minutes'),
    (10, 7, 6, 'Anh Hiệp là mentor tuyệt vời nhất! Cảm ơn anh đã giúp mình grow up! 🌟', 'MVP', 'HERO', false, 'active', NOW() - INTERVAL '1 hour'),
    (11, 8, 9, 'Anh Đạt lead team vượt qua giai đoạn khó khăn. Respect anh! 💪', 'Top Project Leader', 'LEADER', false, 'active', NOW() - INTERVAL '2 hours'),
    (12, 9, 10, 'Chị Mai workshop xuất sắc, giúp team nâng cao kỹ năng. Thank you! 🎯', 'Best Manager', 'LEADER', false, 'active', NOW() - INTERVAL '3 hours'),
    (13, 10, 11, 'Anh Sơn sáng tạo trong cách tiếp cận. Impact lớn cho công ty!', 'Signature 2025 - Creator', 'IDOL GIỚI TRẺ', false, 'active', NOW() - INTERVAL '4 hours'),
    (14, 11, 12, 'Anh Quân share knowledge system design. Team benefit rất nhiều!', NULL, NULL, false, 'active', NOW() - INTERVAL '5 hours'),
    (15, 12, 13, 'Chị Hồng positive và spread energy tốt. Sunshine của team! ☀️', NULL, NULL, false, 'active', NOW() - INTERVAL '6 hours'),
    (16, 13, 14, 'Anh Tùng optimize CI/CD giúp team tiết kiệm hàng giờ. Amazing!', NULL, NULL, false, 'active', NOW() - INTERVAL '7 hours'),
    (17, 14, 15, 'Chị Yến review code tận tình, junior learn rất nhiều. 🙏', NULL, NULL, false, 'active', NOW() - INTERVAL '8 hours'),
    (18, 15, 6, 'Anh Hiệp fix critical bug cuối tuần. Dedication tuyệt vời!', 'Top Talent', NULL, false, 'active', NOW() - INTERVAL '10 hours'),
    (19, 6, 8, 'Bạn Đạt demo sản phẩm trước khách hàng impressive! 🎉', NULL, NULL, false, 'active', NOW() - INTERVAL '12 hours'),
    (20, 7, 1, 'Anh A support mọi người không điều kiện. Backbone của team! 💙', NULL, NULL, false, 'active', NOW() - INTERVAL '1 day'),
    (21, 1, 6, 'Anh Hiệp đi đầu áp dụng công nghệ mới. Pioneer thực sự! 🚀', 'MVP', 'HERO', false, 'active', NOW() - INTERVAL '2 days'),
    (22, 2, 7, 'Chị An coordinate cross-team flawlessly. Impressive leadership!', 'Top Project Leader', 'LEADER', false, 'active', NOW() - INTERVAL '2 days'),
    (23, 3, 9, 'Anh Đạt code clean và document kỹ. Best practices role model!', NULL, NULL, false, 'active', NOW() - INTERVAL '3 days'),
    (24, 4, 10, 'Chị Mai plan sprint chi tiết, team deliver đúng deadline!', 'Best Manager', 'LEADER', false, 'active', NOW() - INTERVAL '3 days'),
    (25, 5, 11, 'Anh Sơn volunteer đầu tiên khi team cần help. True team player!', NULL, NULL, false, 'active', NOW() - INTERVAL '4 days'),
    (26, 6, 12, 'Anh Quân build internal tool tiết kiệm thời gian cả công ty!', 'Signature 2025 - Creator', 'IDOL GIỚI TRẺ', false, 'active', NOW() - INTERVAL '5 days'),
    (27, 9, 1, 'Bạn A handle incident production chuyên nghiệp. Calm under pressure! 🧘', NULL, NULL, false, 'active', NOW() - INTERVAL '6 days'),
    (28, 8, 3, 'Anh C luôn giải đáp thắc mắc kỹ thuật cho team. Guru thực sự!', NULL, NULL, true, 'active', NOW() - INTERVAL '7 days'),
    -- Kudos 29-48: thêm cho đủ phân trang
    (29, 7, 3, 'Anh C đã mentor em suốt 3 tháng. Từ fresher giờ em tự tin handle project rồi! 🌱', 'Top Talent', 'HERO', false, 'active', NOW() - INTERVAL '9 hours'),
    (30, 12, 1, 'Bạn A viết test coverage 95%, best practice example cho cả team!', NULL, NULL, false, 'active', NOW() - INTERVAL '11 hours'),
    (31, 3, 14, 'Anh Tùng deploy zero-downtime, khách hàng không bị ảnh hưởng gì. Pro! 🎯', NULL, 'IDOL GIỚI TRẺ', false, 'active', NOW() - INTERVAL '13 hours'),
    (32, 15, 2, 'Chị B onboard member mới smooth. Người mới hòa nhập cực nhanh!', 'Best Manager', 'LEADER', false, 'active', NOW() - INTERVAL '14 hours'),
    (33, 10, 3, 'Anh C refactor codebase giúp giảm tech debt 40%. Game changer!', 'Top Talent', 'HERO', false, 'active', NOW() - INTERVAL '16 hours'),
    (34, 1, 12, 'Anh Quân design API clean, dễ integrate. FE team rất happy! 😊', NULL, NULL, false, 'active', NOW() - INTERVAL '1 day 2 hours'),
    (35, 11, 7, 'Chị An communication với khách hàng xuất sắc. Project saved!', 'Top Project Leader', 'LEADER', false, 'active', NOW() - INTERVAL '1 day 4 hours'),
    (36, 14, 10, 'Chị Mai organize tech talk hàng tuần. Knowledge sharing culture! 📚', NULL, 'IDOL GIỚI TRẺ', false, 'active', NOW() - INTERVAL '1 day 6 hours'),
    (37, 8, 15, 'Chị Yến pair programming giúp em fix tricky bug. Learned so much!', NULL, NULL, false, 'active', NOW() - INTERVAL '1 day 8 hours'),
    (38, 6, 2, 'Chị B xây dựng team culture tuyệt vời. Ai cũng muốn join team chị! 💖', 'Best Manager', 'LEADER', false, 'active', NOW() - INTERVAL '1 day 10 hours'),
    (39, 9, 6, 'Anh Hiệp giải thích kiến trúc system rõ ràng. Junior hiểu ngay!', NULL, NULL, false, 'active', NOW() - INTERVAL '2 days 1 hour'),
    (40, 13, 8, 'Bạn Đạt đề xuất automation testing framework. Efficiency tăng 60%!', 'Signature 2025 - Creator', 'IDOL GIỚI TRẺ', false, 'active', NOW() - INTERVAL '2 days 3 hours'),
    (41, 2, 11, 'Anh Sơn stay late help fix security vulnerability. Bảo vệ user data! 🔒', NULL, 'HERO', false, 'active', NOW() - INTERVAL '2 days 5 hours'),
    (42, 4, 13, 'Chị Hồng thiết kế UX flow mới. User satisfaction tăng 30%!', NULL, NULL, false, 'active', NOW() - INTERVAL '2 days 7 hours'),
    (43, 5, 9, 'Anh Đạt present kết quả sprint ấn tượng. Stakeholders rất satisfied!', NULL, NULL, true, 'active', NOW() - INTERVAL '3 days'),
    (44, 10, 14, 'Anh Tùng setup monitoring alerting cho production. Peace of mind! 🛡️', NULL, 'IDOL GIỚI TRẺ', false, 'active', NOW() - INTERVAL '4 days 2 hours'),
    (45, 7, 4, 'Chị D negotiate contract mới với khách hàng. Win-win deal!', 'Best Manager', 'LEADER', false, 'active', NOW() - INTERVAL '5 days 1 hour'),
    (46, 11, 15, 'Chị Yến viết documentation chi tiết. API docs now top-notch!', NULL, NULL, false, 'active', NOW() - INTERVAL '5 days 5 hours'),
    (47, 14, 6, 'Anh Hiệp contribute open source library. Sun* brand nổi bật! 🌐', 'MVP', 'HERO', false, 'active', NOW() - INTERVAL '6 days'),
    (48, 15, 13, 'Chị Hồng organize year-end party. Best party ever! 🎉', NULL, NULL, false, 'active', NOW() - INTERVAL '7 days')
ON CONFLICT (id) DO NOTHING;

SELECT setval('kudos_id_seq', GREATEST((SELECT MAX(id) FROM kudos), 48));

-- ==========================================
-- 9. KUDOS HASHTAGS (mỗi kudos 2 hashtags)
-- ==========================================

INSERT INTO kudos_hashtags (kudos_id, hashtag_id) VALUES
    (1, 1), (1, 4),   (2, 5), (2, 2),   (3, 3), (3, 6),   (4, 3), (4, 7),
    (5, 1), (5, 8),   (6, 4), (6, 9),   (7, 2), (7, 8),   (8, 6), (8, 10),
    (9, 1), (9, 2),   (10, 5), (10, 6),  (11, 5), (11, 4),  (12, 5), (12, 2),
    (13, 3), (13, 7),  (14, 6), (14, 10), (15, 2), (15, 9),  (16, 6), (16, 3),
    (17, 1), (17, 8),  (18, 1), (18, 4),  (19, 3), (19, 2),  (20, 4), (20, 8),
    (21, 6), (21, 7),  (22, 5), (22, 4),  (23, 1), (23, 6),  (24, 5), (24, 4),
    (25, 4), (25, 9),  (26, 3), (26, 6),  (27, 1), (27, 8),  (28, 2), (28, 10),
    (29, 1), (29, 2),  (30, 1), (30, 6),  (31, 6), (31, 3),  (32, 5), (32, 9),
    (33, 6), (33, 1),  (34, 3), (34, 6),  (35, 5), (35, 4),  (36, 2), (36, 10),
    (37, 4), (37, 8),  (38, 9), (38, 2),  (39, 2), (39, 6),  (40, 3), (40, 7),
    (41, 1), (41, 4),  (42, 3), (42, 6),  (43, 2), (43, 5),  (44, 6), (44, 1),
    (45, 5), (45, 9),  (46, 1), (46, 10), (47, 7), (47, 6),  (48, 9), (48, 8)
ON CONFLICT DO NOTHING;

-- ==========================================
-- 10. KUDOS REACTIONS (hearts)
-- ==========================================

INSERT INTO kudos_reactions (kudos_id, user_id) VALUES
    -- Kudos 1-8
    (1, 3), (1, 4), (1, 5),
    (2, 1), (2, 4),
    (3, 2), (3, 4), (3, 5),
    (4, 1), (4, 2), (4, 3),
    (5, 2), (5, 3),
    (6, 2), (6, 5),
    -- Kudos 9-28
    (9, 1), (9, 3), (9, 10),
    (10, 1), (10, 2), (10, 8), (10, 15),
    (11, 6), (11, 7),
    (12, 6), (12, 8), (12, 11),
    (13, 6), (13, 9),
    (14, 8),
    (15, 6), (15, 14),
    (16, 6), (16, 7), (16, 15),
    (17, 6), (17, 13),
    (18, 1), (18, 2), (18, 7), (18, 9),
    (19, 7),
    (20, 6), (20, 8), (20, 9),
    (21, 2), (21, 3), (21, 7), (21, 9), (21, 15),
    (22, 1), (22, 6),
    (23, 4), (23, 10),
    (24, 1), (24, 5), (24, 11),
    (25, 6),
    (26, 1), (26, 7), (26, 9), (26, 13),
    (27, 2), (27, 6),
    (28, 1), (28, 4), (28, 7),
    -- Kudos 29-48
    (29, 1), (29, 6), (29, 10),
    (30, 3), (30, 7),
    (31, 1), (31, 6), (31, 12), (31, 15),
    (32, 1), (32, 3),
    (33, 1), (33, 7), (33, 11), (33, 14), (33, 15),
    (34, 6), (34, 7), (34, 13),
    (35, 1), (35, 6),
    (36, 1), (36, 6), (36, 11),
    (37, 6), (37, 9),
    (38, 1), (38, 7), (38, 11), (38, 14),
    (39, 7), (39, 10),
    (40, 1), (40, 6), (40, 9),
    (41, 1), (41, 4), (41, 10),
    (42, 2), (42, 6),
    (43, 1), (43, 6), (43, 10),
    (44, 1), (44, 7),
    (45, 1), (45, 5), (45, 6),
    (46, 6), (46, 7),
    (47, 1), (47, 2), (47, 7), (47, 9), (47, 12),
    (48, 1), (48, 6), (48, 7), (48, 11)
ON CONFLICT (kudos_id, user_id) DO NOTHING;

-- ==========================================
-- 11. KUDOS PHOTOS
-- ==========================================

INSERT INTO kudos_photos (id, kudos_id, image_url, sort_order) VALUES
    (1, 1, '/kudos/photos/kudos1_1.jpg', 0),
    (2, 1, '/kudos/photos/kudos1_2.jpg', 1),
    (3, 3, '/kudos/photos/kudos3_1.jpg', 0),
    (4, 3, '/kudos/photos/kudos3_2.jpg', 1),
    (5, 3, '/kudos/photos/kudos3_3.jpg', 2),
    (6, 4, '/kudos/photos/kudos4_1.jpg', 0)
ON CONFLICT (id) DO NOTHING;

SELECT setval('kudos_photos_id_seq', GREATEST((SELECT MAX(id) FROM kudos_photos), 6));

-- ==========================================
-- 12. USER BADGES
-- ==========================================

INSERT INTO user_badges (user_id, badge_id, earned_at) VALUES
    (1, 2, '2026-03-14 11:56:44.701371+00'),
    (2, 1, '2026-03-29 11:56:44.701371+00'),
    (3, 3, '2026-02-12 11:56:44.701371+00'),
    (5, 4, '2026-01-13 11:56:44.701371+00')
ON CONFLICT DO NOTHING;

-- ==========================================
-- 13. NOTIFICATIONS
-- ==========================================

INSERT INTO notifications (id, user_id, type, title, message, reference_type, reference_id, is_read, created_at) VALUES
    (1, 1, 'kudos_received', 'Bạn nhận được Kudos!', 'Lê Văn C đã gửi kudos cho bạn: "Bạn A đã có những đóng góp xuất sắc..."', 'kudos', 3, false, '2026-04-12 11:56:44.701371+00'),
    (2, 1, 'kudos_received', 'Bạn nhận được Kudos!', 'Hoàng Văn E đã gửi kudos cho bạn: "Cảm ơn bạn A đã giúp fix bug..."', 'kudos', 5, false, '2026-04-11 11:56:44.701371+00'),
    (3, 1, 'heart_received', 'Kudos của bạn được yêu thích!', 'Phạm Thị D đã thích kudos bạn gửi cho Trần Thị B', 'kudos', 1, false, '2026-04-13 08:56:44.701371+00'),
    (4, 1, 'announcement', 'SAA 2025 sắp diễn ra!', 'Còn ít ngày nữa đến sự kiện SAA 2025. Hãy chuẩn bị tinh thần!', NULL, NULL, true, '2026-04-08 11:56:44.701371+00'),
    (5, 1, 'system', 'Chào mừng đến SAA 2025', 'Tải ứng dụng thành công. Khám phá các tính năng mới!', NULL, NULL, true, '2026-04-06 11:56:44.701371+00'),
    (6, 2, 'kudos_received', 'Bạn nhận được Kudos!', 'Nguyễn Văn A đã gửi kudos cho bạn', 'kudos', 1, false, '2026-04-13 09:56:44.701371+00'),
    (7, 2, 'kudos_received', 'Bạn nhận được Kudos ẩn danh!', 'Một đồng nghiệp đã gửi kudos cho bạn', 'kudos', 7, false, '2026-04-10 11:56:44.701371+00')
ON CONFLICT (id) DO NOTHING;

SELECT setval('notifications_id_seq', GREATEST((SELECT MAX(id) FROM notifications), 7));

-- ==========================================
-- 14. CAMPAIGNS
-- ==========================================

INSERT INTO campaigns (id, name, description, start_date, end_date, status) VALUES
    (1, 'Kudos Mùa Lễ Hội', 'Gửi kudos và nhận phần quà đặc biệt mùa lễ hội SAA 2025!', '2025-11-30 17:00:00+00', '2025-12-31 16:59:59+00', 'active'),
    (2, 'Root Further Challenge', 'Thử thách gửi 10 kudos trong tuần — nhận badge đặc biệt!', '2025-12-14 17:00:00+00', '2025-12-22 16:59:59+00', 'draft')
ON CONFLICT (id) DO NOTHING;

SELECT setval('campaigns_id_seq', GREATEST((SELECT MAX(id) FROM campaigns), 2));

-- ==========================================
-- 15. SECRET BOXES
-- ==========================================

INSERT INTO secret_boxes (id, user_id, is_opened, opened_at, reward_type, reward_value) VALUES
    (1, 1, true, '2026-04-11 11:56:44.701371+00', 'badge', 'New Hero'),
    (2, 1, false, NULL, NULL, NULL),
    (3, 2, false, NULL, NULL, NULL)
ON CONFLICT (id) DO NOTHING;

SELECT setval('secret_boxes_id_seq', GREATEST((SELECT MAX(id) FROM secret_boxes), 11));

-- ==========================================
-- 15b. THÊM SECRET BOXES CHO TESTING PROFILE
-- ==========================================

INSERT INTO secret_boxes (id, user_id, is_opened, opened_at, reward_type, reward_value) VALUES
    (4, 2, true, '2026-04-10 09:00:00+00', 'badge', 'Rising Hero'),
    (5, 3, true, '2026-04-08 14:00:00+00', 'coupon', '50K VND'),
    (6, 3, false, NULL, NULL, NULL),
    (7, 4, true, '2026-04-05 10:00:00+00', 'badge', 'Super Hero'),
    (8, 4, false, NULL, NULL, NULL),
    (9, 4, false, NULL, NULL, NULL),
    (10, 5, true, '2026-04-01 08:00:00+00', 'coupon', '100K VND'),
    (11, 5, false, NULL, NULL, NULL)
ON CONFLICT (id) DO NOTHING;

SELECT setval('secret_boxes_id_seq', GREATEST((SELECT MAX(id) FROM secret_boxes), 11));

-- ==========================================
-- 15c. THÊM USER BADGES CHO TESTING PROFILE
-- ==========================================

INSERT INTO user_badges (user_id, badge_id, earned_at) VALUES
    (4, 3, '2026-03-01 10:00:00+00'),
    (6, 3, '2026-03-10 10:00:00+00'),
    (6, 2, '2026-02-15 10:00:00+00'),
    (7, 2, '2026-03-20 10:00:00+00'),
    (7, 1, '2026-02-01 10:00:00+00'),
    (8, 1, '2026-03-25 10:00:00+00'),
    (9, 4, '2026-01-10 10:00:00+00'),
    (9, 3, '2026-02-20 10:00:00+00'),
    (9, 2, '2026-03-05 10:00:00+00'),
    (10, 2, '2026-03-15 10:00:00+00'),
    (11, 1, '2026-03-28 10:00:00+00'),
    (12, 3, '2026-02-28 10:00:00+00'),
    (12, 2, '2026-01-20 10:00:00+00'),
    (13, 2, '2026-03-12 10:00:00+00'),
    (14, 2, '2026-03-18 10:00:00+00'),
    (14, 1, '2026-02-10 10:00:00+00'),
    (15, 1, '2026-03-22 10:00:00+00')
ON CONFLICT DO NOTHING;

-- ==========================================
-- 16. STORAGE BUCKETS
-- ==========================================

INSERT INTO storage.buckets (id, name, public) VALUES
    ('hero-tiers', 'hero-tiers', true),
    ('awards', 'awards', true),
    ('kudos-photos', 'kudos-photos', true)
ON CONFLICT (id) DO NOTHING;
