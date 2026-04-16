# Đặc tả tính năng: Language Dropdown (Chọn ngôn ngữ)

**Frame ID**: `uUvW6Qm1ve`
**Frame Name**: `[iOS] Language dropdown`
**File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Ngày tạo**: 2026-04-14
**Trạng thái**: Bản nháp

---

## Tổng quan

Dropdown popup nhỏ cho phép người dùng chọn ngôn ngữ hiển thị của ứng dụng. Hiển thị trên màn hình Login, chứa 2 lựa chọn: Tiếng Việt (VN) và Tiếng Anh (EN). Mỗi option hiển thị cờ quốc gia + mã ngôn ngữ. Khi chọn, giao diện thay đổi ngay lập tức.

---

## Kịch bản người dùng & Kiểm thử *(bắt buộc)*

### User Story 1 - Mở/đóng dropdown ngôn ngữ (Ưu tiên: P1)

Người dùng tap vào nút ngôn ngữ trên header để mở/đóng dropdown chọn ngôn ngữ.

**Lý do ưu tiên**: Chức năng cốt lõi - tương tác mở/đóng dropdown.

**Kiểm thử độc lập**: Tap vào trigger, xác nhận dropdown mở/đóng.

**Kịch bản chấp nhận**:

1. **Cho** dropdown đang đóng, **Khi** tap vào nút ngôn ngữ (cờ + mã + mũi tên xuống), **Thì** dropdown mở ra hiển thị 2 option: VN và EN.
2. **Cho** dropdown đang mở, **Khi** tap bên ngoài dropdown hoặc tap lại trigger, **Thì** dropdown đóng lại.

---

### User Story 2 - Chọn ngôn ngữ (Ưu tiên: P1)

Người dùng chọn một ngôn ngữ từ dropdown để thay đổi ngôn ngữ hiển thị.

**Lý do ưu tiên**: Chức năng cốt lõi - thay đổi ngôn ngữ app.

**Kiểm thử độc lập**: Chọn ngôn ngữ, xác nhận giao diện thay đổi.

**Kịch bản chấp nhận**:

1. **Cho** dropdown đang mở và ngôn ngữ hiện tại là VN, **Khi** chọn EN, **Thì** dropdown đóng, nút trigger cập nhật hiển thị cờ Anh + "EN", toàn bộ giao diện chuyển sang tiếng Anh ngay lập tức.
2. **Cho** dropdown đang mở và ngôn ngữ hiện tại là EN, **Khi** chọn VN, **Thì** dropdown đóng, nút trigger cập nhật hiển thị cờ VN + "VN", toàn bộ giao diện chuyển sang tiếng Việt.
3. **Cho** dropdown đang mở, **Khi** chọn ngôn ngữ đang được chọn (ví dụ VN khi đang VN), **Thì** dropdown đóng, không thay đổi gì.

---

### User Story 3 - Lưu trạng thái ngôn ngữ (Ưu tiên: P2)

Hệ thống lưu ngôn ngữ đã chọn để giữ lại khi mở lại app.

**Lý do ưu tiên**: Trải nghiệm người dùng liền mạch.

**Kiểm thử độc lập**: Chọn ngôn ngữ, tắt app, mở lại, xác nhận ngôn ngữ giữ nguyên.

**Kịch bản chấp nhận**:

1. **Cho** người dùng chọn EN, **Khi** tắt app và mở lại, **Thì** ngôn ngữ hiển thị vẫn là EN.

---

### Trường hợp biên

- Khi không có ngôn ngữ đã lưu: Mặc định hiển thị VN.
- Khi ngôn ngữ lưu không hợp lệ: Fallback về VN.
- Khi thay đổi ngôn ngữ giữa phiên (mid-session): Toàn bộ widget tree PHẢI rebuild với locale mới qua `localeNotifierProvider`. Dữ liệu đã tải từ Supabase (hỗ trợ đa ngôn ngữ) cần được refresh lại với locale mới.
- Khi thay đổi ngôn ngữ nhưng SharedPreferences ghi thất bại: Giao diện vẫn đổi ngôn ngữ trong phiên hiện tại, lần mở app sau sẽ fallback về VN.

---

## Yêu cầu UI/UX *(từ Figma)*

### Thành phần màn hình

| Thành phần | Mô tả | Tương tác |
|-----------|-------|-----------|
| Trigger Button | Cờ quốc gia + mã ngôn ngữ + icon mũi tên xuống | Tap để mở/đóng |
| Dropdown List (A) | Container chứa 2 option ngôn ngữ | Hiển thị khi mở |
| Option VN (A.1) | Cờ VN + "VN", nền highlight khi selected | Tap để chọn |
| Option EN (A.2) | Cờ Anh + "EN" | Tap để chọn |

### Luồng điều hướng

- Từ: Màn hình Login (header)
- Đến: Không chuyển màn hình - chỉ thay đổi ngôn ngữ
- Kích hoạt: Tap vào trigger button / option

---

## Yêu cầu *(bắt buộc)*

### Yêu cầu chức năng

- **FR-001**: Hệ thống PHẢI hiển thị dropdown với 2 option: VN và EN.
- **FR-002**: Mỗi option PHẢI hiển thị cờ quốc gia + mã ngôn ngữ.
- **FR-003**: Option đang được chọn PHẢI có nền highlight khác biệt.
- **FR-004**: Chọn ngôn ngữ PHẢI cập nhật giao diện ngay lập tức, không cần reload.
- **FR-005**: Hệ thống PHẢI lưu ngôn ngữ đã chọn vào local storage.

### Quản lý trạng thái

- Sử dụng `localeNotifierProvider` (StateNotifier) — state đơn giản, không cần AsyncNotifier.
- Khi chọn ngôn ngữ mới: cập nhật `localeNotifierProvider` -> `LocaleState` thay đổi -> slang rebuild toàn bộ text -> widget tree rebuild.
- App root (`MaterialApp.router`) PHẢI watch `localeNotifierProvider` để cập nhật `locale` property.

### Yêu cầu kỹ thuật

- **TR-001**: Sử dụng `localeNotifierProvider` (StateNotifier) để quản lý ngôn ngữ. App root PHẢI watch provider này để trigger rebuild toàn bộ app khi đổi ngôn ngữ.
- **TR-002**: Icon cờ quốc gia dùng SVG, đường dẫn qua `Assets.icons.flags.xxx`.
- **TR-003**: Ngôn ngữ được persist qua SharedPreferences hoặc Hive. Đọc giá trị khi khởi tạo `localeNotifierProvider`.
- **TR-004**: Dropdown hiển thị dạng overlay/popup (sử dụng `OverlayEntry` hoặc `PopupMenuButton`), không phải full-screen.
- **TR-005**: Dropdown widget PHẢI đặt trong `lib/shared/widgets/language_dropdown.dart` vì có thể tái sử dụng ở nhiều màn hình (Login, Settings...).

---

## Phụ thuộc API

| Endpoint | Phương thức | Mục đích | Trạng thái |
|----------|------------|---------|-----------|
| Không có | - | Xử lý hoàn toàn client-side | - |

---

## Tiêu chí thành công *(bắt buộc)*

- **SC-001**: Dropdown mở/đóng mượt mà trong < 150ms.
- **SC-002**: Giao diện thay đổi ngôn ngữ ngay lập tức sau khi chọn.
- **SC-003**: Ngôn ngữ được lưu và khôi phục đúng khi mở lại app.

---

## Ngoài phạm vi

- Thêm ngôn ngữ mới (chỉ hỗ trợ VN/EN)
- Ngôn ngữ theo vùng (regional locale)
- Auto-detect ngôn ngữ từ hệ thống

---

## Ghi chú

- Dropdown hiển thị trên màn hình Login, nằm ở góc phải trên header.
- Mặc định hiển thị VN (xác định trên client).
- Option đang được chọn có nền `rgba(255, 234, 158, 0.2)` để phân biệt.
- Dropdown là overlay nhỏ, không phải bottom sheet hay dialog.
