# Đặc tả tính năng: [iOS] Sun*Kudos — All Kudos

**Frame ID**: `j_a2GQWKDJ`
**Frame Name**: `[iOS] Sun*Kudos_All Kudos`
**File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Ngày tạo**: 2026-04-14
**Trạng thái**: Draft

---

## Tổng quan

Màn hình **All Kudos** là trang hiển thị toàn bộ danh sách kudos trong hệ thống Sun* Annual Awards 2025. Đây là **page thứ 2 trong PageView** của Kudos screen — người dùng truy cập bằng cách tap "Xem tất cả" trên Kudos screen chính (screenId: `fO0Kt19sZZ`). PageView **KHÔNG cho phép swipe thủ công**, chỉ animate chuyển trang khi tap action.

**Đối tượng sử dụng**: Nhân viên Sun* (Sunner) đã đăng nhập, muốn duyệt toàn bộ kudos.

**Bối cảnh kinh doanh**: Trang này mở rộng trải nghiệm feed kudos — thay vì chỉ xem một vài kudos trên trang chính, người dùng có thể duyệt toàn bộ lịch sử ghi nhận, tăng sự gắn kết cộng đồng.

**Quan hệ với Kudos screen**: Là page index 1 trong `PageController` — Kudos screen (feed) là page index 0. Navigation bằng `PageController.animateToPage()` với `NeverScrollableScrollPhysics()`.

---

## Kịch bản người dùng & Kiểm thử *(bắt buộc)*

### User Story 1 — Xem danh sách tất cả Kudos (Ưu tiên: P1)

Là một Sunner, tôi muốn xem toàn bộ danh sách kudos đã được gửi trong hệ thống để theo dõi hoạt động ghi nhận của tổ chức.

**Lý do ưu tiên**: Đây là chức năng chính và duy nhất của màn hình — hiển thị danh sách kudos đầy đủ với infinite scroll / pagination.

**Kiểm thử độc lập**: Có thể test bằng cách render danh sách kudos với dữ liệu mock, verify scroll và hiển thị đúng.

**Kịch bản chấp nhận**:

1. **Cho biết** người dùng đang ở Kudos screen và bấm "Xem tất cả", **Khi** PageView animate sang page index 1, **Thì** hiển thị màn hình All Kudos với header "ALL KUDOS" và danh sách thẻ kudo dọc.
2. **Cho biết** dữ liệu đã load, **Khi** danh sách hiển thị, **Thì** mỗi thẻ kudo gồm: thông tin người gửi (avatar, tên, mã NV, badge danh hiệu) → icon mũi tên → thông tin người nhận (avatar, tên, mã NV, badge) — thời gian đăng — tiêu đề kudos — nội dung lời cảm ơn (trong khung highlight) — hashtags — action bar (heart, copy link, xem chi tiết).
3. **Cho biết** danh sách có nhiều kudos, **Khi** scroll xuống cuối, **Thì** tự động load thêm kudos (infinite scroll / pagination).
4. **Cho biết** không có kudos nào trong hệ thống, **Khi** mở All Kudos, **Thì** hiển thị empty state phù hợp.

---

### User Story 2 — Quay lại Kudos Feed (Ưu tiên: P1)

Là một Sunner, tôi muốn quay lại trang Kudos feed chính để tiếp tục xem các section khác (highlight, spotlight, stats).

**Lý do ưu tiên**: Navigation cơ bản — không thể quay lại thì người dùng bị kẹt.

**Kiểm thử độc lập**: Test bằng cách tap nút back và verify PageView animate về page 0.

**Kịch bản chấp nhận**:

1. **Cho biết** người dùng đang ở All Kudos, **Khi** bấm nút back (←) trên navbar, **Thì** PageView animate về page index 0 (Kudos Feed).
2. **Cho biết** người dùng đang scroll giữa danh sách, **Khi** bấm back, **Thì** vẫn animate về page 0 mượt mà, không bị giật.

---

### User Story 3 — Tương tác với thẻ Kudos (Ưu tiên: P2)

Là một Sunner, tôi muốn tương tác với mỗi thẻ kudos (like, copy link, xem chi tiết) để thể hiện sự đồng cảm hoặc chia sẻ.

**Lý do ưu tiên**: Tương tác tăng engagement nhưng người dùng vẫn có thể duyệt mà không cần tương tác.

**Kiểm thử độc lập**: Test từng action riêng biệt trên 1 thẻ kudos.

**Kịch bản chấp nhận**:

1. **Cho biết** thẻ kudo hiển thị nút heart với số lượt (ví dụ: "1.000"), **Khi** bấm heart, **Thì** toggle trạng thái like/unlike, cập nhật số lượt, gọi API tương ứng.
2. **Cho biết** thẻ kudo hiển thị nút "Copy Link", **Khi** bấm, **Thì** copy deep link của kudos vào clipboard và hiển thị snackbar xác nhận.
3. **Cho biết** thẻ kudo hiển thị nút "Xem chi tiết", **Khi** bấm, **Thì** điều hướng sang màn hình chi tiết kudos.
4. **Cho biết** avatar người gửi/nhận hiển thị, **Khi** bấm vào avatar, **Thì** điều hướng sang profile người đó (screenId: `bEpdheM0yU`).

---

### User Story 4 — Header hiển thị context (Ưu tiên: P3)

Là một Sunner, tôi muốn thấy rõ mình đang ở section "ALL KUDOS" trong chương trình "Sun* Annual Awards 2025".

**Lý do ưu tiên**: Đây là UI hiển thị tĩnh, không ảnh hưởng đến chức năng chính.

**Kiểm thử độc lập**: Verify header render đúng text và style.

**Kịch bản chấp nhận**:

1. **Cho biết** màn hình All Kudos đã load, **Khi** nhìn vào header, **Thì** hiển thị "Sun* Annual Awards 2025" (subtitle nhỏ) → đường kẻ → "ALL KUDOS" (title lớn màu vàng gold).

---

### Trường hợp biên (Edge Cases)

- **Mất kết nối mạng** khi đang load → Hiển thị thông báo lỗi và nút retry.
- **Load thêm thất bại** (pagination error) → Hiển thị nút "Thử lại" ở cuối danh sách, giữ nguyên data đã load.
- **Nội dung kudos quá dài** → Truncate tối đa 3 dòng, hiển thị "..." với nút "Xem chi tiết".
- **Hashtag quá nhiều** → Truncate tối đa 2 dòng, hiển thị "...".
- **Heart toggle khi offline** → Optimistic update UI, retry khi có mạng hoặc rollback.
- **Pull-to-refresh** → Reload danh sách từ trang 1.
- **Tên người dùng quá dài** → Truncate với "..." (thiết kế cho max ~109px width).
- **Không có badge danh hiệu** → Ẩn badge, chỉ hiển thị tên + mã NV.
- **PageView không cho swipe** → Phải dùng `NeverScrollableScrollPhysics()` trên PageView. Scroll dọc trong page vẫn hoạt động bình thường.

---

## Yêu cầu UI/UX *(từ Figma)*

### Thành phần màn hình

| Thành phần | Mô tả | Tương tác |
|-----------|-------|-----------|
| TopNavigation | Navbar với gradient, nút back (←) + title "All Kudos" | Bấm back → animate về Kudos Feed (page 0) |
| mm_media_bg | Background layer: key visual + shadow overlays | Chỉ hiển thị (reuse từ Kudos screen) |
| Header | Subtitle "Sun* Annual Awards 2025" + divider + title "ALL KUDOS" | Chỉ hiển thị |
| Danh sách Kudo | Scrollable list chứa các thẻ KUDO card, gap 12px | Scroll dọc |
| KUDO Card (B.3) | Thẻ kudo highlight — sender → receiver + nội dung + actions | Chứa nhiều tương tác bên trong |
| B.3.1 Avatar người gửi | Avatar tròn 24px | Bấm → profile |
| B.3.2 Thông tin người gửi | Tên + mã NV + badge danh hiệu | Chỉ hiển thị |
| B.3.4 Icon mũi tên | Icon chỉ hướng gửi → nhận | Chỉ hiển thị |
| B.3.5 Avatar người nhận | Avatar tròn 24px | Bấm → profile |
| B.4 Nội dung lời cảm ơn | Container: thời gian + title + content + hashtags | Chỉ hiển thị |
| B.4.1 Thời gian đăng | Format: "HH:mm - MM/dd/yyyy" | Chỉ hiển thị |
| B.4.2 Nội dung | Khung highlight vàng chứa text cảm ơn | Chỉ hiển thị (truncate nếu dài) |
| B.4.3 Hashtag | Danh sách hashtag đỏ | Chỉ hiển thị |
| B.4.4 Action Bar | Heart count + Copy Link + Xem chi tiết | Bấm từng nút → action tương ứng |
| Bottom Navigation | Tab bar chung toàn app | Tab navigation |

### Luồng điều hướng

- **Từ**: Kudos screen chính (screenId: `fO0Kt19sZZ`) → tap "Xem tất cả" → PageView animate sang page 1
- **Quay lại**: Nút back (←) → PageView animate về page 0
- **Đi tiếp**: Xem chi tiết kudos, profile người dùng, bottom tab navigation

### Yêu cầu visual

- **Mobile-only** — thiết kế 375px width
- **Animations**: PageView transition (300ms ease-in-out), heart button scale animation
- **Accessibility**: Contrast ratio đủ cho text trên nền sáng/tối, touch target >= 44px cho các nút

> Chi tiết style đầy đủ xem tại [design-style.md](./design-style.md)

---

## Yêu cầu *(bắt buộc)*

### Yêu cầu chức năng

- **FR-001**: Hệ thống PHẢI hiển thị danh sách tất cả kudos dạng scrollable list dọc.
- **FR-002**: Mỗi thẻ kudo PHẢI hiển thị: thông tin người gửi (avatar, tên, mã NV, badge) → icon mũi tên → thông tin người nhận (avatar, tên, mã NV, badge).
- **FR-003**: Mỗi thẻ kudo PHẢI hiển thị: thời gian đăng, tiêu đề kudos, nội dung lời cảm ơn (trong khung highlight), hashtags.
- **FR-004**: Mỗi thẻ kudo PHẢI có action bar: heart (toggle like/unlike + count), copy link, xem chi tiết.
- **FR-005**: Hệ thống PHẢI hỗ trợ pagination / infinite scroll cho danh sách kudos.
- **FR-006**: Nút back (←) PHẢI animate PageView về page 0 (Kudos Feed), KHÔNG navigate pop.
- **FR-007**: PageView PHẢI sử dụng `NeverScrollableScrollPhysics()` — không cho phép swipe thủ công.
- **FR-008**: Bấm avatar PHẢI điều hướng sang profile người đó.
- **FR-009**: Hệ thống PHẢI hỗ trợ pull-to-refresh để reload danh sách.

### Yêu cầu kỹ thuật

- **TR-001**: Sử dụng `PageController.animateToPage()` cho transition giữa Kudos Feed và All Kudos.
- **TR-002**: Tuân thủ kiến trúc MVVM — All Kudos là phần mở rộng của `KudosViewModel` (cùng 1 state model `KudosState`), KHÔNG tạo ViewModel riêng.
- **TR-003**: Reuse component `KudosCard` (widget `kudos_card.dart`) đã có sẵn từ Kudos screen.
- **TR-004**: Sử dụng i18n (slang) cho tất cả text hiển thị — KHÔNG hardcode string.
- **TR-005**: Asset paths dùng `Assets.icons.*` qua flutter_gen — KHÔNG hardcode path.

### Thực thể dữ liệu chính

- **Kudos**: id, sender (User), receiver (User), content, title, hashtags, heartCount, isHearted, createdAt
- **User (trong context Kudos)**: id, name, avatar, employeeCode, badges (danh hiệu)
- **Badge**: name, level (Rising Hero, Legend Hero, etc.)

---

## API Dependencies

| Endpoint | Method | Mục đích | Trạng thái |
|----------|--------|---------|-----------|
| /rest/v1/kudos | GET | Lấy danh sách kudos (có pagination: offset, limit) | Đã có |
| /rest/v1/kudos/{id}/heart | POST | Toggle heart cho kudos | Đã có |
| /rest/v1/kudos/{id}/heart | DELETE | Bỏ heart cho kudos | Đã có |

---

## Tiêu chí thành công *(bắt buộc)*

### Kết quả đo lường

- **SC-001**: Danh sách kudos load trong < 2 giây (first page).
- **SC-002**: Scroll mượt mà (60fps) khi duyệt danh sách kudos.
- **SC-003**: PageView transition giữa Kudos Feed ↔ All Kudos animation mượt (300ms).
- **SC-004**: Heart toggle phản hồi tức thì (optimistic update < 100ms).

---

## Ngoài phạm vi

- **Gửi kudos mới** — có màn hình riêng (screenId: `PV7jBVZU1N`).
- **Filter/Sort kudos** — chưa có trong design màn này (chỉ filter ở Kudos Feed highlight).
- **Search kudos** — không có ô search trên màn All Kudos.
- **Xóa / chỉnh sửa kudos** — không có trong design.
- **Real-time update** (live feed) — dùng pull-to-refresh thay vì WebSocket.

---

## Phụ thuộc

- [x] Constitution document (`.momorph/constitution.md`)
- [x] Screen flow documented (`.momorph/SCREENFLOW.md`)
- [x] Kudos screen spec (`.momorph/specs/fO0Kt19sZZ-ios-sun-kudos/spec.md`)
- [x] Kudos feature code đã có (`lib/features/kudos/`)
- [x] KudosCard widget đã có (`lib/features/kudos/presentation/widgets/kudos_card.dart`)
- [ ] API documentation / Supabase schema cho pagination

---

## Ghi chú

- Màn hình này là **page view page**, KHÔNG phải route riêng — không push/pop trên navigation stack mà dùng `PageController` trong Kudos screen.
- Thẻ kudo dùng cùng component `KUDO - Highlight` như trong Kudos Feed — reuse widget `KudosCard` hoặc `KudosContentCard`.
- Header section (subtitle + divider + title) là component tái sử dụng — cũng xuất hiện trên Kudos Feed.
- Tất cả text PHẢI hỗ trợ đa ngôn ngữ (VN/EN) qua i18n slang.
- Khi seed data cho All Kudos, chỉ **thêm mới** — KHÔNG xóa data hiện có trong DB.
