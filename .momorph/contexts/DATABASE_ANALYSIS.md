# Database Analysis — SAA 2025 Mobile

> Generated from Figma file: `9ypp4enmFmdK3YAFJLIu6C`
> Last updated: 2026-04-10

## Phân tích theo màn hình

### [iOS] Login (`8HGlvYGJWq`)

**Entities**: users
**Fields**:
- Đăng nhập qua Supabase Auth (email/OAuth)
- Không có form đăng ký trực tiếp — SSO/OAuth doanh nghiệp

---

### [iOS] Home (`OuH1BUTYT0`)

**Entities**: events, award_categories, kudos_info
**Fields**:
- Event: theme_name, event_date, venue, livestream_note, theme_description, hero_image_url, theme_logo_url
- Award categories: name, image_url, description (danh sách cuộn ngang)
- Kudos section: banner_image_url, title, description, is_enabled
- Countdown timer: computed từ event_date
- Notification badge: unread count (dot only)

---

### [iOS] Award Detail (`c-QM3_zjkG` — Top Talent, tương tự cho 5 giải khác)

**Entities**: award_categories
**Fields**:
- name: "Top Talent", "Top Project", "Top Project Leader", "Best Manager", "MVP", "Signature 2025 Creator"
- description: mô tả chi tiết tiêu chí
- image_url: graphic huy hiệu tròn
- quantity: số lượng giải (VD: 10)
- unit: "Cá nhân" hoặc "Tập thể"
- prize_value: giá trị tiền thưởng (VD: 7.000.000 VNĐ)
- prize_note: ghi chú (VD: "cho mỗi giải thưởng")

---

### [iOS] Profile bản thân (`hSH7L8doXB`)

**Entities**: users, user_badges, kudos, secret_boxes
**Fields**:
- User: avatar, name, team_code, hero_tier
- Stats: kudos_received_count, kudos_sent_count, hearts_received_count, secret_boxes_opened, secret_boxes_unopened
- Icon collection: danh sách badges/icons đã đạt
- Kudos list: filter "Đã nhận" / "Đã gửi", hiển thị cards

---

### [iOS] Profile người khác (`bEpdheM0yU`)

**Entities**: users, kudos
**Fields**: Tương tự Profile bản thân nhưng read-only, không có nút "Mở Secret Box"

---

### [iOS] Sun*Kudos Feed (`_b68CBWKl5`)

**Entities**: kudos, users, hashtags, departments
**Fields**:
- Kudos card: sender, recipient, message, photos, hashtags, timestamp, heart_count, award_category_name
- Filter: dropdown "Đã nhận / Đã gửi"
- Spam flag: label trên card
- Actions: Copy Link, Xem chi tiết, Heart reaction

---

### [iOS] Gửi lời chúc Kudos (`PV7jBVZU1N`)

**Entities**: kudos, kudos_photos, hashtags
**Input Fields**:
- Người nhận: search sunner (FK users)
- Danh hiệu: dropdown select (award category name / hashtag group)
- Nội dung: rich text (bold, italic, strikethrough, numbered list, link, quote)
- Hashtags: multi-select từ dropdown
- Ảnh: upload tối đa 4 ảnh
- Gửi ẩn danh: toggle boolean
- Tiêu chuẩn cộng đồng: link đến trang thể lệ

---

### [iOS] View Kudo (`T0TR16k0vH`)

**Entities**: kudos, kudos_photos, kudos_reactions
**Fields**: Chi tiết đầy đủ của 1 Kudos (sender, recipient, message, photos, hashtags, hearts, timestamp)

---

### [iOS] View Kudo ẩn danh (`5C2BL6GYXL`)

**Entities**: kudos
**Fields**: Tương tự View Kudo nhưng sender ẩn danh (avatar + tên ẩn)

---

### [iOS] Open Secret Box (`kQk65hSYF2`)

**Entities**: secret_boxes
**Fields**:
- Hình ảnh hộp quà
- Số box chưa mở
- Trạng thái: chưa mở → action bấm mở → standby (7 trạng thái animation)

---

### [iOS] Search Sunner (`3jgwke3E8O`)

**Entities**: users, search_history
**Fields**:
- Search bar: tìm theo tên/email
- Recent searches: tối đa 5, xóa được từng item
- Kết quả: avatar, name, team_code

---

### [iOS] Sun*Kudos Dropdown Filters

**Entities**: hashtags, departments
- Dropdown hashtag (`V5GRjAdJyb`): danh sách hashtags
- Dropdown phòng ban (`76k69LQPfj`): danh sách departments

---

## Bảng ánh xạ Entity

| Màn hình | Entities | Relationships |
|----------|----------|---------------|
| Login | users | — |
| Home | events, award_categories | — |
| Award Detail | award_categories | — |
| Profile | users, user_badges, kudos, secret_boxes | User → Badges, User → Kudos, User → SecretBoxes |
| Kudos Feed | kudos, users, hashtags | Kudos → Sender/Recipient, Kudos → Hashtags |
| Gửi Kudos | kudos, kudos_photos, hashtags, users | Kudos → Photos, Kudos → Hashtags |
| View Kudo | kudos, kudos_reactions | Kudos → Reactions |
| Secret Box | secret_boxes, users | SecretBox → User |
| Search Sunner | users, search_history | SearchHistory → User |
| Notifications | notifications, users | Notification → User |

## Luồng dữ liệu

```
Login → Auth (Supabase) → Home
  ├── Events API → Countdown, Event Info
  ├── Awards API → Award Categories List
  ├── Kudos Info API → Kudos Section
  └── Notifications API → Badge Count

Home → Awards Tab → Award Detail (by category)
Home → Kudos Tab → Kudos Feed
  ├── Filter by: Đã nhận / Đã gửi / Hashtag / Phòng ban
  ├── Send Kudos → Create Kudos + Photos + Hashtags
  └── View Kudo → Heart Reaction, Copy Link

Home → Profile Tab
  ├── Stats (computed aggregates)
  ├── Badge Collection
  ├── Kudos List (sent/received)
  └── Open Secret Box → Secret Box Interaction

Search → Search Sunner → Profile người khác
```
