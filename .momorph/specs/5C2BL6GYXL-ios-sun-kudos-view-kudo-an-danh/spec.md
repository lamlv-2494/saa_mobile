# Đặc tả tính năng: [iOS] Sun*Kudos_View kudo ẩn danh

**Frame ID**: `5C2BL6GYXL`
**Frame Name**: `[iOS] Sun*Kudos_View kudo ẩn danh`
**File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Ngày tạo**: 2026-04-14
**Trạng thái**: Draft

---

## Tổng quan

Màn hình **View Kudo ẩn danh** là biến thể (variant) của màn hình View Kudo (`T0TR16k0vH`), hiển thị chi tiết kudos được gửi ẩn danh. Điểm khác biệt chính: thông tin người gửi bị ẩn — thay bằng avatar mặc định và text "Người gửi ẩn danh", không hiển thị phòng ban/danh hiệu. Thông tin người nhận vẫn hiển thị đầy đủ.

**Đối tượng sử dụng**: Nhân viên Sun* (Sunner) đã đăng nhập vào ứng dụng.

**Bối cảnh kinh doanh**: Hỗ trợ tính năng gửi kudos ẩn danh — cho phép Sunner ghi nhận đồng nghiệp mà không tiết lộ danh tính, khuyến khích ghi nhận chân thành.

---

## Kịch bản người dùng & Kiểm thử *(bắt buộc)*

### User Story 1 - Xem chi tiết Kudos ẩn danh (Ưu tiên: P1)

Là một Sunner, tôi muốn xem chi tiết kudos ẩn danh để hiểu nội dung ghi nhận mà vẫn tôn trọng quyền riêng tư người gửi.

**Lý do ưu tiên**: Đây là chức năng chính — hiển thị kudos ẩn danh khác với kudos thường.

**Kiểm thử độc lập**: Có thể test bằng cách mở màn hình với kudos có `isAnonymous = true`.

**Kịch bản chấp nhận**:

1. **Cho biết** kudos có `isAnonymous = true`, **Khi** mở màn hình View Kudo, **Thì** phần người gửi hiển thị: avatar mặc định (không phải ảnh thật), tên "Người gửi ẩn danh" (i18n), phòng ban hiển thị "Người gửi ẩn danh", KHÔNG hiển thị badge danh hiệu.
2. **Cho biết** kudos ẩn danh, **Khi** hiển thị, **Thì** thông tin người nhận vẫn hiển thị đầy đủ: avatar thật, tên, phòng ban, danh hiệu.
3. **Cho biết** kudos ẩn danh, **Khi** bấm vào avatar/tên người gửi, **Thì** KHÔNG có navigation (disabled/no-op) vì danh tính bị ẩn.
4. **Cho biết** kudos ẩn danh, **Khi** hiển thị, **Thì** tất cả phần còn lại (tiêu đề, nội dung, thời gian, hashtag, hình ảnh, heart, actions) hiển thị giống hệt kudos thường.

---

### User Story 2 - Tương tác với Kudos ẩn danh (Ưu tiên: P1)

Là một Sunner, tôi muốn heart và copy link kudos ẩn danh giống như kudos thường.

**Lý do ưu tiên**: Tương tác heart/copy link không khác biệt giữa kudos thường và ẩn danh.

**Kiểm thử độc lập**: Test giống User Story 2 của `T0TR16k0vH`.

**Kịch bản chấp nhận**:

1. **Cho biết** kudos ẩn danh, **Khi** bấm heart, **Thì** toggle trạng thái heart, cập nhật heartCount, sync server.
2. **Cho biết** kudos ẩn danh, **Khi** bấm Copy Link, **Thì** sao chép link và hiển thị toast 2 giây.

---

### Trường hợp biên (Edge Cases)

- Kudos thường nhưng người gửi đã bị xóa tài khoản → Hiển thị avatar mặc định + "Người dùng không tồn tại" (i18n), KHÔNG nhầm lẫn với trạng thái ẩn danh.
- Avatar mặc định cho ẩn danh PHẢI khác với avatar mặc định khi không có ảnh → Sử dụng icon ẩn danh riêng (`Assets.images.anonymousAvatar`).
- `isAnonymous = true` nhưng `senderAlias` là null → Hiển thị text mặc định "Người gửi ẩn danh" (i18n) thay cho tên.
- Kudos ẩn danh không tồn tại (API 404) → Hiển thị thông báo "Kudos không còn tồn tại" (i18n) và nút quay lại (giống View Kudo thường).
- Tất cả edge cases khác (mất kết nối, nội dung trống, v.v.) → Giống hệt View Kudo thường (`T0TR16k0vH`).

---

## Yêu cầu UI/UX *(từ Figma)*

### Thành phần màn hình

| Thành phần | Mã | Mô tả | Khác biệt so với View Kudo thường |
|-----------|-----|-------|----------------------------------|
| B.3.1 Avatar người gửi | B.3.1 | Avatar mặc định ẩn danh (không phải ảnh thật) | Avatar mặc định, border trắng |
| B.3.2 Thông tin người gửi | B.3.2 | Tên: "Anh Hùng Xạ Điêu" (hoặc alias), Phòng ban: "Người gửi ẩn danh" | Text thay đổi, không có badge |
| B.3.5 Avatar người nhận | B.3.5 | Giống hệt View Kudo thường | Không thay đổi |
| Tất cả components khác | - | Giống hệt View Kudo thường | Không thay đổi |

> **Quan trọng**: Theo Figma, sender ẩn danh hiển thị text "Anh Hùng Xạ Điêu" (alias ngẫu nhiên/cố định) và dòng phụ "Người gửi ẩn danh" thay cho phòng ban. Avatar sử dụng hình mặc định riêng cho ẩn danh.

### Luồng điều hướng

- Giống hệt View Kudo thường (`T0TR16k0vH`) — xem spec tương ứng.
- **Ngoại lệ**: Bấm avatar/tên người gửi → KHÔNG điều hướng (disabled).

### Accessibility (VoiceOver)

| Thành phần | Semantic Label | Trait |
|-----------|---------------|-------|
| Avatar người gửi ẩn danh | "Người gửi ẩn danh" | Image (không phải Button) |
| Tên người gửi ẩn danh | "Người gửi ẩn danh" | StaticText |

> Chi tiết visual specs xem tại [design-style.md](design-style.md)

---

## Yêu cầu *(bắt buộc)*

### Yêu cầu chức năng

- **FR-001**: Khi `isAnonymous = true`, hệ thống PHẢI ẩn thông tin thật của người gửi — thay bằng avatar mặc định ẩn danh và text "Người gửi ẩn danh" (i18n).
- **FR-002**: Khi `isAnonymous = true`, hệ thống KHÔNG ĐƯỢC hiển thị badge danh hiệu của người gửi.
- **FR-003**: Khi `isAnonymous = true`, bấm avatar/tên người gửi KHÔNG ĐƯỢC điều hướng.
- **FR-004**: Thông tin người nhận PHẢI luôn hiển thị đầy đủ bất kể kudos có ẩn danh hay không.
- **FR-005**: Tất cả chức năng khác (heart, copy link, view content) PHẢI hoạt động giống kudos thường.
- **FR-006**: Hệ thống PHẢI hỗ trợ đa ngôn ngữ (VN/EN) cho text "Người gửi ẩn danh".

### Yêu cầu kỹ thuật

- **TR-001**: View Kudo và View Kudo ẩn danh PHẢI dùng chung 1 widget/screen, phân biệt bằng flag `isAnonymous` trên model Kudos.
- **TR-002**: Avatar mặc định ẩn danh PHẢI dùng asset riêng qua `flutter_gen`.
- **TR-003**: Logic ẩn thông tin sender PHẢI nằm trong ViewModel hoặc model (không phải trong widget).

### Yêu cầu chức năng bổ sung

- **FR-007**: Nút "Xem chi tiết" trên action bar PHẢI bị ẩn hoặc disabled khi đang ở màn hình chi tiết (vì đã đang xem chi tiết). Nút này chỉ hiển thị trên kudos card trong feed.

### Thực thể chính

- Giống `T0TR16k0vH` — thêm field `isAnonymous: bool` và `senderAlias: String?` (alias hiển thị thay tên thật khi ẩn danh).

### Bảng so sánh chi tiết: View Kudo thường vs View Kudo ẩn danh

| Thành phần | View Kudo thường (`T0TR16k0vH`) | View Kudo ẩn danh (`5C2BL6GYXL`) |
|-----------|--------------------------------|----------------------------------|
| Avatar người gửi | Ảnh thật từ profile | Avatar mặc định ẩn danh (asset riêng) |
| Tên người gửi | Tên thật | `senderAlias` hoặc "Người gửi ẩn danh" (i18n) |
| Phòng ban người gửi | Mã phòng ban thật | "Người gửi ẩn danh" (i18n) |
| Badge danh hiệu người gửi | Hiển thị | **Ẩn hoàn toàn** |
| Bấm avatar/tên người gửi | Navigate đến Profile | **Disabled** (không có tương tác) |
| Avatar người nhận | Ảnh thật | Ảnh thật (không thay đổi) |
| Tên/phòng ban/badge người nhận | Đầy đủ | Đầy đủ (không thay đổi) |
| Tiêu đề, nội dung, hashtag | Hiển thị | Hiển thị (không thay đổi) |
| Heart, Copy Link | Hoạt động | Hoạt động (không thay đổi) |
| Hình ảnh đính kèm | Hiển thị | Hiển thị (không thay đổi) |

---

## Phụ thuộc API

| Endpoint | Method | Mục đích | Trạng thái |
|----------|--------|----------|------------|
| `/api/v1/kudos/{id}` | GET | Lấy chi tiết kudos (bao gồm isAnonymous flag) | Dự đoán |

---

## Tiêu chí thành công *(bắt buộc)*

### Kết quả đo lường

- **SC-001**: 100% kudos ẩn danh KHÔNG tiết lộ danh tính người gửi trên UI.
- **SC-002**: Hỗ trợ hiển thị đúng cả 2 ngôn ngữ VN và EN.

---

## Ngoài phạm vi

- Tiết lộ danh tính người gửi ẩn danh (không có trong thiết kế).
- Cài đặt quyền riêng tư cho ẩn danh (thuộc flow gửi kudos).

---

## Phụ thuộc

- [x] Constitution document tồn tại (`.momorph/constitution.md`)
- [x] Spec View Kudo thường (`.momorph/specs/T0TR16k0vH-ios-sun-kudos-view-kudo/spec.md`)

---

## Ghi chú

- Đây là variant của cùng 1 màn hình với View Kudo (`T0TR16k0vH`). Implementation nên dùng chung widget với conditional rendering dựa trên `isAnonymous`.
- Text "Anh Hùng Xạ Điêu" trong Figma là ví dụ alias — backend sẽ cung cấp `senderAlias` cho kudos ẩn danh.
- Text "Người gửi ẩn danh" PHẢI được khai báo trong i18n, không hardcode.
