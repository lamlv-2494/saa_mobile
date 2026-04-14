-- ==========================================
-- SAA 2025 Mobile — Seed Data
-- Dùng cho local development
-- Data dựa trên Figma design [iOS] Home + Kudos
-- Tạo từ DB dump ngày 2026-04-14
-- ==========================================
-- Lưu ý: Sử dụng ON CONFLICT DO NOTHING để không mất data
-- khi chạy lại seed. Không xoá data đang có trong DB.
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
    ('Infra', 'Infra');
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
-- 3. AWARD CATEGORIES (6 giải — data từ Figma Award Detail screens)
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
     1, 'Cá nhân hoặc tập thể', 'Individual or Team', NULL, NULL, NULL, 6);
ON CONFLICT (id) DO NOTHING;

SELECT setval('award_categories_id_seq', GREATEST((SELECT MAX(id) FROM award_categories), 6));
-- ==========================================
-- 3.1 AWARD PRIZES (cho giải có nhiều mức giá trị)
-- Signature 2025 - Creator có 2 mức: cá nhân + tập thể
-- ==========================================

INSERT INTO award_prizes (award_category_id, prize_type, value_amount, note_vi, note_en, sort_order) VALUES
    ((SELECT id FROM award_categories WHERE slug = 'signature-2025-creator'), 'individual', 5000000, 'cho giải cá nhân', 'for individual award', 1),
    ((SELECT id FROM award_categories WHERE slug = 'signature-2025-creator'), 'team', 8000000, 'cho giải tập thể', 'for team award', 2);

-- ==========================================
-- 4. KUDOS CONFIG (Home screen Kudos section)
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
-- 7. SAMPLE USERS (dùng auth_id giả cho local dev)
-- Lưu ý: Khi đăng nhập qua Google OAuth, user record
-- sẽ được tạo tự động. Data này chỉ để test UI.
-- ==========================================

-- Tạo fake auth users trước (Supabase local)
INSERT INTO auth.users (id, email, raw_user_meta_data, created_at, updated_at, instance_id, aud, role)
VALUES
    ('a1111111-1111-1111-1111-111111111111', 'nguyenvana@sun-asterisk.com',
     '{"full_name": "Nguyễn Văn A", "avatar_url": "https://i.pravatar.cc/150?u=a"}',
     '2026-04-13 11:56:44.701371+00', '2026-04-13 11:56:44.701371+00',
     '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated'),
    ('b2222222-2222-2222-2222-222222222222', 'tranthib@sun-asterisk.com',
     '{"full_name": "Trần Thị B", "avatar_url": "https://i.pravatar.cc/150?u=b"}',
     '2026-04-13 11:56:44.701371+00', '2026-04-13 11:56:44.701371+00',
     '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated'),
    ('c3333333-3333-3333-3333-333333333333', 'levanc@sun-asterisk.com',
     '{"full_name": "Lê Văn C", "avatar_url": "https://i.pravatar.cc/150?u=c"}',
     '2026-04-13 11:56:44.701371+00', '2026-04-13 11:56:44.701371+00',
     '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated'),
    ('d4444444-4444-4444-4444-444444444444', 'phamthid@sun-asterisk.com',
     '{"full_name": "Phạm Thị D", "avatar_url": "https://i.pravatar.cc/150?u=d"}',
     '2026-04-13 11:56:44.701371+00', '2026-04-13 11:56:44.701371+00',
     '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated'),
    ('e5555555-5555-5555-5555-555555555555', 'hoangvane@sun-asterisk.com',
     '{"full_name": "Hoàng Văn E", "avatar_url": "https://i.pravatar.cc/150?u=e"}',
     '2026-04-13 11:56:44.701371+00', '2026-04-13 11:56:44.701371+00',
     '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated')
ON CONFLICT (id) DO NOTHING;

-- App-level user profiles
INSERT INTO users (id, auth_id, email, name, avatar_url, team_code, department_id, hero_tier, hero_tier_url) VALUES
    (1, 'a1111111-1111-1111-1111-111111111111', 'nguyenvana@sun-asterisk.com', 'Nguyễn Văn A',
     'https://i.pravatar.cc/150?u=a', 'TEAM-01', 1, 'rising_hero',
     '/storage/v1/object/public/hero-tiers/rising_hero.png'),
    (2, 'b2222222-2222-2222-2222-222222222222', 'tranthib@sun-asterisk.com', 'Trần Thị B',
     'https://i.pravatar.cc/150?u=b', 'TEAM-02', 2, 'new_hero',
     '/storage/v1/object/public/hero-tiers/new_hero.png'),
    (3, 'c3333333-3333-3333-3333-333333333333', 'levanc@sun-asterisk.com', 'Lê Văn C',
     'https://i.pravatar.cc/150?u=c', 'TEAM-01', 1, 'super_hero',
     '/storage/v1/object/public/hero-tiers/super_hero.png'),
    (4, 'd4444444-4444-4444-4444-444444444444', 'phamthid@sun-asterisk.com', 'Phạm Thị D',
     'https://i.pravatar.cc/150?u=d', 'TEAM-03', 3, 'none',
     NULL),
    (5, 'e5555555-5555-5555-5555-555555555555', 'hoangvane@sun-asterisk.com', 'Hoàng Văn E',
     'https://i.pravatar.cc/150?u=e', 'TEAM-02', 2, 'legend_hero',
     '/storage/v1/object/public/hero-tiers/legend_hero.png')
ON CONFLICT (id) DO NOTHING;

SELECT setval('users_id_seq', GREATEST((SELECT MAX(id) FROM users), 5));

-- ==========================================
-- 8. SAMPLE KUDOS
-- ==========================================

INSERT INTO kudos (id, sender_id, recipient_id, message, award_category_name, is_anonymous, status, created_at, award_title) VALUES
    (1, 1, 2, 'Cảm ơn chị B đã hỗ trợ team hoàn thành sprint trước deadline! Chị luôn là người reliable nhất team. 🙌',
     'Top Talent', false, 'active', '2026-04-13 09:56:44.701371+00', 'IDOL GIỚI TRẺ'),
    (2, 2, 3, 'Anh C là một leader tuyệt vời, luôn lắng nghe và support team members. Respect! 💪',
     'Top Project Leader', false, 'active', '2026-04-13 06:56:44.701371+00', 'LEADER'),
    (3, 3, 1, 'Bạn A đã có những đóng góp xuất sắc cho dự án XYZ. Code quality luôn ở top. Keep it up! ⭐',
     'MVP', false, 'active', '2026-04-12 11:56:44.701371+00', 'HERO'),
    (4, 4, 5, 'Anh E luôn sáng tạo trong cách giải quyết vấn đề. Dự án của anh là nguồn cảm hứng cho cả team!',
     'Signature 2025 - Creator', false, 'active', '2026-04-12 11:56:44.701371+00', 'IDOL GIỚI TRẺ'),
    (5, 5, 1, 'Cảm ơn bạn A đã giúp fix bug production lúc nửa đêm. Tinh thần trách nhiệm tuyệt vời! 🔥',
     NULL, false, 'active', '2026-04-11 11:56:44.701371+00', NULL),
    (6, 1, 4, 'Chị D đã tổ chức team building tuyệt vời. Mọi người đều rất vui và gắn kết hơn!',
     'Best Manager', false, 'active', '2026-04-10 11:56:44.701371+00', 'LEADER'),
    (7, 3, 2, 'Chị B training cho intern rất tận tình. Các bạn mới đều rất grateful!',
     NULL, true, 'active', '2026-04-10 11:56:44.701371+00', NULL),
    (8, 2, 5, 'Anh E đã share kiến thức về Flutter architecture rất bổ ích. Cả team đều học được nhiều!',
     NULL, false, 'active', '2026-04-09 11:56:44.701371+00', 'HERO')
ON CONFLICT (id) DO NOTHING;

SELECT setval('kudos_id_seq', GREATEST((SELECT MAX(id) FROM kudos), 8));

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
    (8, 6), (8, 10)   -- Kudos 8: #Innovation, #SunKudos
ON CONFLICT DO NOTHING;

-- ==========================================
-- 10. KUDOS REACTIONS (Hearts)
-- ==========================================

INSERT INTO kudos_reactions (id, kudos_id, user_id) VALUES
    (1, 1, 3), (2, 1, 4), (3, 1, 5),     -- Kudos 1: 3 hearts
    (4, 2, 1), (5, 2, 4),                 -- Kudos 2: 2 hearts
    (6, 3, 2), (7, 3, 4), (8, 3, 5),     -- Kudos 3: 3 hearts
    (9, 4, 1), (10, 4, 2), (11, 4, 3),   -- Kudos 4: 3 hearts
    (12, 5, 2), (13, 5, 3),               -- Kudos 5: 2 hearts
    (14, 6, 2), (15, 6, 5)                -- Kudos 6: 2 hearts
ON CONFLICT (id) DO NOTHING;

SELECT setval('kudos_reactions_id_seq', GREATEST((SELECT MAX(id) FROM kudos_reactions), 15));

-- ==========================================
-- 10b. KUDOS PHOTOS (tối đa 5 ảnh/kudos)
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
-- 11. USER BADGES
-- ==========================================

INSERT INTO user_badges (user_id, badge_id, earned_at) VALUES
    (1, 2, '2026-03-14 11:56:44.701371+00'),   -- User A: Rising Hero
    (2, 1, '2026-03-29 11:56:44.701371+00'),   -- User B: New Hero
    (3, 3, '2026-02-12 11:56:44.701371+00'),   -- User C: Super Hero
    (5, 4, '2026-01-13 11:56:44.701371+00')    -- User E: Legend Hero
ON CONFLICT DO NOTHING;

-- ==========================================
-- 12. NOTIFICATIONS (sample cho User A — id=1)
-- ==========================================

INSERT INTO notifications (id, user_id, type, title, message, reference_type, reference_id, is_read, created_at) VALUES
    (1, 1, 'kudos_received', 'Bạn nhận được Kudos!',
     'Lê Văn C đã gửi kudos cho bạn: "Bạn A đã có những đóng góp xuất sắc..."',
     'kudos', 3, false, '2026-04-12 11:56:44.701371+00'),
    (2, 1, 'kudos_received', 'Bạn nhận được Kudos!',
     'Hoàng Văn E đã gửi kudos cho bạn: "Cảm ơn bạn A đã giúp fix bug..."',
     'kudos', 5, false, '2026-04-11 11:56:44.701371+00'),
    (3, 1, 'heart_received', 'Kudos của bạn được yêu thích!',
     'Phạm Thị D đã thích kudos bạn gửi cho Trần Thị B',
     'kudos', 1, false, '2026-04-13 08:56:44.701371+00'),
    (4, 1, 'announcement', 'SAA 2025 sắp diễn ra!',
     'Còn ít ngày nữa đến sự kiện SAA 2025. Hãy chuẩn bị tinh thần!',
     NULL, NULL, true, '2026-04-08 11:56:44.701371+00'),
    (5, 1, 'system', 'Chào mừng đến SAA 2025',
     'Tải ứng dụng thành công. Khám phá các tính năng mới!',
     NULL, NULL, true, '2026-04-06 11:56:44.701371+00'),
    -- Notifications cho User B — id=2
    (6, 2, 'kudos_received', 'Bạn nhận được Kudos!',
     'Nguyễn Văn A đã gửi kudos cho bạn',
     'kudos', 1, false, '2026-04-13 09:56:44.701371+00'),
    (7, 2, 'kudos_received', 'Bạn nhận được Kudos ẩn danh!',
     'Một đồng nghiệp đã gửi kudos cho bạn',
     'kudos', 7, false, '2026-04-10 11:56:44.701371+00')
ON CONFLICT (id) DO NOTHING;

SELECT setval('notifications_id_seq', GREATEST((SELECT MAX(id) FROM notifications), 7));

-- ==========================================
-- 13. CAMPAIGNS (sample)
-- ==========================================

INSERT INTO campaigns (id, name, description, start_date, end_date, status) VALUES
    (1, 'Kudos Mùa Lễ Hội',
     'Gửi kudos và nhận phần quà đặc biệt mùa lễ hội SAA 2025!',
     '2025-11-30 17:00:00+00', '2025-12-31 16:59:59+00', 'active'),
    (2, 'Root Further Challenge',
     'Thử thách gửi 10 kudos trong tuần — nhận badge đặc biệt!',
     '2025-12-14 17:00:00+00', '2025-12-22 16:59:59+00', 'draft')
ON CONFLICT (id) DO NOTHING;

SELECT setval('campaigns_id_seq', GREATEST((SELECT MAX(id) FROM campaigns), 2));

-- ==========================================
-- 14. SECRET BOXES (sample cho User A)
-- ==========================================

INSERT INTO secret_boxes (id, user_id, is_opened, opened_at, reward_type, reward_value) VALUES
    (1, 1, true, '2026-04-11 11:56:44.701371+00', 'badge', 'New Hero'),
    (2, 1, false, NULL, NULL, NULL),
    (3, 2, false, NULL, NULL, NULL)
ON CONFLICT (id) DO NOTHING;

SELECT setval('secret_boxes_id_seq', GREATEST((SELECT MAX(id) FROM secret_boxes), 3));

-- ==========================================
-- 15. STORAGE BUCKETS
-- ==========================================

INSERT INTO storage.buckets (id, name, public) VALUES
    ('hero-tiers', 'hero-tiers', true),
    ('award', 'award', true)
ON CONFLICT (id) DO NOTHING;
