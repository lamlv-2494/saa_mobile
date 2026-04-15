# Đặc tả tính năng: [iOS] Sun*Kudos_View kudo

**Frame ID**: `T0TR16k0vH`
**Frame Name**: `[iOS] Sun*Kudos_View kudo`
**File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Ngày tạo**: 2026-04-14
**Trạng thái**: Draft

---

## Tổng quan

Màn hình **View Kudo** hiển thị chi tiết đầy đủ của một lời cảm ơn (kudos) trong hệ thống Sun* Annual Awards 2025. Đây là màn hình detail khi người dùng bấm "Xem chi tiết" từ danh sách kudos trên màn hình chính hoặc feed All Kudos. Màn hình hiển thị đầy đủ thông tin người gửi, người nhận, nội dung, hashtag, hình ảnh đính kèm, và các nút tương tác.

**Đối tượng sử dụng**: Nhân viên Sun* (Sunner) đã đăng nhập vào ứng dụng.

**Bối cảnh kinh doanh**: Cho phép Sunner xem chi tiết kudos để hiểu rõ hơn về lý do ghi nhận, tạo cảm hứng và khuyến khích văn hóa ghi nhận lẫn nhau.

---

## Kịch bản người dùng & Kiểm thử *(bắt buộc)*

### User Story 1 - Xem chi tiết Kudos (Ưu tiên: P1)

Là một Sunner, tôi muốn xem chi tiết đầy đủ một kudos để hiểu rõ nội dung ghi nhận giữa hai đồng nghiệp.

**Lý do ưu tiên**: Đây là chức năng chính và duy nhất của màn hình — hiển thị nội dung chi tiết kudos.

**Kiểm thử độc lập**: Có thể test bằng cách mở màn hình với kudos ID mock và verify toàn bộ thông tin hiển thị.

**Kịch bản chấp nhận**:

1. **Cho biết** người dùng bấm "Xem chi tiết" từ kudos card trên feed, **Khi** màn hình View Kudo được mở, **Thì** hiển thị đầy đủ thông tin: avatar + tên + phòng ban + danh hiệu người gửi, icon mũi tên "sent", avatar + tên + phòng ban + danh hiệu người nhận, tiêu đề kudos, thời gian đăng, nội dung chi tiết (full text không truncate), danh sách hình ảnh đính kèm, hashtag, số heart, nút Copy Link, nút Xem chi tiết.
2. **Cho biết** kudos có nội dung dài, **Khi** hiển thị, **Thì** nội dung hiển thị đầy đủ (full text) trong khung có border, hỗ trợ scroll nếu cần.
3. **Cho biết** kudos có nhiều hashtag, **Khi** hiển thị, **Thì** tất cả hashtag đều được hiển thị với màu đỏ (#D4271D).

---

### User Story 2 - Tương tác với Kudos (Ưu tiên: P1)

Là một Sunner, tôi muốn tương tác (heart, copy link) với kudos để thể hiện sự đồng cảm hoặc chia sẻ.

**Lý do ưu tiên**: Tương tác heart và copy link là hành động chính trên màn hình chi tiết.

**Kiểm thử độc lập**: Có thể test bằng cách bấm nút heart/copy link và verify hành vi.

**Kịch bản chấp nhận**:

1. **Cho biết** người dùng đang xem chi tiết kudos, **Khi** bấm icon heart, **Thì** toggle trạng thái heart (like/unlike), cập nhật heartCount hiển thị, và đồng bộ với server.
2. **Cho biết** người dùng bấm nút "Copy Link", **Khi** copy thành công, **Thì** hiển thị snackbar/toast "Đã sao chép liên kết" trong 2 giây.

---

### User Story 3 - Xem hình ảnh đính kèm (Ưu tiên: P2)

Là một Sunner, tôi muốn xem danh sách hình ảnh đính kèm trong kudos để xem thêm bối cảnh.

**Lý do ưu tiên**: Hình ảnh là nội dung bổ sung, không phải core flow.

**Kiểm thử độc lập**: Có thể test bằng cách hiển thị danh sách thumbnail hình ảnh.

**Kịch bản chấp nhận**:

1. **Cho biết** kudos có hình ảnh đính kèm, **Khi** hiển thị, **Thì** hiển thị danh sách thumbnail hình ảnh (tối đa 5) dạng hàng ngang với border vàng (#998C5F), radius 8px.
2. **Cho biết** kudos không có hình ảnh, **Khi** hiển thị, **Thì** ẩn phần danh sách hình ảnh.

---

### User Story 4 - Điều hướng quay lại (Ưu tiên: P1)

Là một Sunner, tôi muốn quay lại màn hình trước đó sau khi xem xong chi tiết kudos.

**Lý do ưu tiên**: Điều hướng cơ bản, cần thiết cho mọi flow.

**Kiểm thử độc lập**: Có thể test bằng cách bấm nút back và verify navigation.

**Kịch bản chấp nhận**:

1. **Cho biết** người dùng đang ở màn hình View Kudo, **Khi** bấm nút back (mũi tên trái) trên top navigation, **Thì** quay lại màn hình trước đó (Kudos feed hoặc All Kudos).

---

### Trường hợp biên (Edge Cases)

- Kudos không tồn tại (API trả về 404) → Hiển thị thông báo "Kudos không còn tồn tại" (i18n) và nút quay lại.
- Kudos bị xóa trong khi đang xem → Hiển thị thông báo "Kudos không còn tồn tại" (i18n) và nút quay lại.
- Mất kết nối khi load chi tiết → Hiển thị thông báo lỗi "Không thể kết nối. Vui lòng thử lại." (i18n) và nút retry.
- Mất kết nối khi bấm heart → Hiển thị lỗi "Không thể kết nối. Vui lòng thử lại." (i18n) và rollback trạng thái heart (optimistic revert).
- Nội dung kudos trống → Hiển thị placeholder "(Không có nội dung)" (i18n).
- Kudos có 0 hình ảnh → Ẩn phần danh sách hình ảnh đính kèm.
- Avatar người gửi/nhận không có → Hiển thị avatar mặc định (khác với avatar ẩn danh).
- Kudos có `isAnonymous = true` → Chuyển sang variant ẩn danh (xem spec `5C2BL6GYXL`).
- Tiêu đề kudos trống → Ẩn phần tiêu đề, không hiển thị khoảng trắng thừa.

---

## Yêu cầu UI/UX *(từ Figma)*

### Thành phần màn hình

| Thành phần | Mã | Mô tả | Tương tác |
|-----------|-----|-------|-----------|
| Top Navigation | - | Header với nút back + tiêu đề "Kudo" | Bấm back → quay lại |
| B.3 KUDO Highlight Card | B.3 | Card chi tiết kudos với nền `#FFF8E1`, border `#FFEA9E` | Container |
| B.3.1 Avatar người gửi | B.3.1 | Avatar tròn 24px, border trắng | Bấm → Profile người gửi |
| B.3.2 Thông tin người gửi | B.3.2 | Tên + phòng ban + danh hiệu | Bấm → Profile người gửi |
| B.3.4 Icon mũi tên | B.3.4 | Icon "sent" giữa người gửi và người nhận | Chỉ hiển thị |
| B.3.5 Avatar người nhận | B.3.5 | Avatar tròn 24px, border trắng | Bấm → Profile người nhận |
| B.4.0 Tiêu đề | B.4.0 | Tiêu đề kudos (ví dụ: "NGƯỜI HÙNG CỦA LÒNG EM"), bold, center | Chỉ hiển thị |
| B.4.1 Thời gian đăng | B.4.1 | Format "HH:mm - MM/DD/YYYY" | Chỉ hiển thị |
| B.4.2 Nội dung | B.4.2 | Full text nội dung kudos trong khung border vàng | Scroll nếu dài |
| B.4.3 Hashtag | B.4.3 | Danh sách hashtag màu đỏ (#D4271D) | Chỉ hiển thị |
| F.2 Hình ảnh đính kèm | F.2 | Danh sách thumbnail 32x32px, border vàng | Bấm → Xem ảnh lớn |
| B.4.4 Action | B.4.4 | Heart count + Copy Link + Xem chi tiết | Bấm tương ứng |
| Nav Bar | - | Bottom tab navigation (Kudos tab active) | Chuyển tab |

### Luồng điều hướng

- **Từ**: Kudos feed (screenId: `fO0Kt19sZZ`) hoặc All Kudos (screenId: `j_a2GQWKDJ`)
- **Đến**:
  - Profile người gửi/nhận (bấm avatar/tên)
  - Quay lại (bấm nút back)
- **Triggers**: Bấm "Xem chi tiết" trên kudos card, deep link

### Yêu cầu hình ảnh

- Ứng dụng chỉ dành cho mobile (iOS) — width: 375px
- Animations/Transitions: Slide-in từ phải khi mở, slide-out khi quay lại

### Accessibility (VoiceOver)

| Thành phần | Semantic Label | Trait |
|-----------|---------------|-------|
| Nút Back | "Quay lại" | Button |
| Avatar người gửi | "Ảnh đại diện {tên người gửi}" | Image, Button |
| Avatar người nhận | "Ảnh đại diện {tên người nhận}" | Image, Button |
| Tiêu đề kudos | "{tiêu đề}" | Header |
| Nội dung kudos | "Nội dung kudos: {nội dung}" | StaticText |
| Heart icon | "{count} lượt thích. {Đã thích / Chưa thích}" | Button, toggle |
| Copy Link | "Sao chép liên kết" | Button |
| Hình ảnh đính kèm | "Ảnh đính kèm {index} trên {total}" | Image, Button |

> Chi tiết visual specs xem tại [design-style.md](design-style.md)

---

## Yêu cầu *(bắt buộc)*

### Yêu cầu chức năng

- **FR-001**: Hệ thống PHẢI hiển thị đầy đủ thông tin kudos: người gửi, người nhận, tiêu đề, nội dung, thời gian, hashtag, hình ảnh, heart count.
- **FR-002**: Nội dung kudos PHẢI hiển thị full text (không truncate) trong khung có border.
- **FR-003**: Nút heart PHẢI là toggle — like/unlike cập nhật heartCount (optimistic update).
- **FR-004**: Nút Copy Link PHẢI sao chép link kudos vào clipboard và hiển thị toast 2 giây.
- **FR-005**: Danh hiệu (badge) của người gửi và người nhận PHẢI hiển thị bên cạnh phòng ban.
- **FR-006**: Hệ thống PHẢI hỗ trợ đa ngôn ngữ (VN/EN) cho tất cả text hiển thị.
- **FR-007**: Bấm avatar/tên PHẢI điều hướng đến profile tương ứng.
- **FR-008**: Nút "Xem chi tiết" trên action bar PHẢI bị ẩn hoặc disabled khi đang ở màn hình chi tiết (vì đã đang xem chi tiết rồi). Nút này chỉ hiển thị trên kudos card trong feed.

### Yêu cầu kỹ thuật

- **TR-001**: Dữ liệu kudos PHẢI được truyền qua route parameter (kudosId) hoặc từ cache state.
- **TR-002**: Asset paths PHẢI sử dụng `flutter_gen` (`Assets.xxx`), không hardcode string.
- **TR-003**: Kiến trúc PHẢI tuân theo MVVM pattern — màn hình này sử dụng chung `KudosViewModel`.
- **TR-004**: Heart action PHẢI dùng optimistic update (cập nhật UI ngay, sync server sau).

### Thực thể chính

- **Kudos**: id, senderId, receiverId, title, content, hashtags, heartCount, createdAt, isAnonymous, images
- **User (Sunner)**: id, name, avatar, department, badge/title

---

## Quản lý trạng thái (State Management)

### Tích hợp với KudosViewModel

Màn hình View Kudo sử dụng chung `KudosViewModel` từ Kudos feed. Khi mở chi tiết:
- Nếu kudos đã có trong `allKudos` hoặc `highlightKudos` → hiển thị từ cache.
- Nếu chưa có (deep link) → gọi API `GET /api/v1/kudos/{id}` để fetch.

### Trạng thái Loading/Error

| Trạng thái | Hiển thị |
|-----------|----------|
| Loading (từ API) | Shimmer placeholder cho toàn bộ card |
| Loaded | Hiển thị đầy đủ thông tin kudos |
| Error (network) | Thông báo lỗi + nút retry |
| Not Found (404) | Thông báo "Kudos không còn tồn tại" + nút quay lại |

### Heart State (Optimistic Update)

- Bấm heart → cập nhật UI ngay (tăng/giảm heartCount, đổi icon).
- Gửi request POST `/api/v1/kudos/{id}/heart`.
- Nếu request thất bại → rollback UI về trạng thái trước và hiển thị thông báo lỗi.

---

## Phụ thuộc API

| Endpoint | Method | Mục đích | Trạng thái |
|----------|--------|----------|------------|
| `/api/v1/kudos/{id}` | GET | Lấy chi tiết kudos theo ID | Dự đoán |
| `/api/v1/kudos/{id}/heart` | POST | Thả/bỏ heart cho kudos | Dự đoán |

---

## Tiêu chí thành công *(bắt buộc)*

### Kết quả đo lường

- **SC-001**: Màn hình chi tiết kudos load trong vòng 1 giây (từ cache).
- **SC-002**: Tỷ lệ người dùng bấm heart trên màn hình chi tiết >= 20%.
- **SC-003**: Hỗ trợ hiển thị đúng cả 2 ngôn ngữ VN và EN.

---

## Ngoài phạm vi

- Chỉnh sửa/xóa kudos (thuộc flow admin).
- Bình luận trên kudos (chưa có trong thiết kế).
- Chia sẻ kudos qua mạng xã hội bên ngoài.

---

## Phụ thuộc

- [x] Constitution document tồn tại (`.momorph/constitution.md`)
- [x] Spec màn hình chính Kudos (`.momorph/specs/fO0Kt19sZZ-ios-sun-kudos/spec.md`)
- [ ] API specifications (`.momorph/contexts/api-docs.yaml`)

---

## Ghi chú

- Màn hình View Kudo và View Kudo ẩn danh (screenId: `5C2BL6GYXL`) là 2 variant của cùng 1 màn hình. Khi `isAnonymous = true`, thông tin người gửi bị ẩn (xem spec `5C2BL6GYXL`).
- Tất cả text PHẢI hỗ trợ đa ngôn ngữ VN/EN thông qua hệ thống i18n (slang).
- Card nền sử dụng màu `#FFF8E1` với border `#FFEA9E`, giống style Highlight Card trên Kudos feed.
- Background sử dụng Key Visual gradient giống màn hình chính Kudos.
