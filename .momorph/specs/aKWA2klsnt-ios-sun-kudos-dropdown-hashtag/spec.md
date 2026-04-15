# Đặc tả tính năng: [iOS] Sun*Kudos - Dropdown Hashtag

**Frame ID**: `aKWA2klsnt`
**Frame Name**: `[iOS] Sun*Kudos_Gửi lời chúc Kudos_dropdown hashtag`
**File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Ngày tạo**: 2026-04-14
**Trạng thái**: Bản nháp

---

## Tổng quan

Màn hình **Dropdown Hashtag** là overlay/modal hiển thị khi người dùng bấm nút "+ Hashtag" trong form gửi kudos. Cho phép chọn hashtag từ danh sách có sẵn để gắn vào kudos. Hashtag đã chọn hiển thị với icon check, và có thể bỏ chọn.

**Đối tượng sử dụng**: Nhân viên Sun* (Sunner) đang soạn kudos.

**Bối cảnh kinh doanh**: Hashtag giúp phân loại kudos, hỗ trợ lọc và tìm kiếm — bắt buộc ít nhất 1 hashtag.

**Màn hình chính (parent)**: `PV7jBVZU1N` — Gửi lời chúc Kudos

---

## Kịch bản người dùng & Kiểm thử *(bắt buộc)*

### User Story 1 - Chọn hashtag từ danh sách (Ưu tiên: P1)

Là một Sunner, tôi muốn chọn hashtag từ danh sách có sẵn để phân loại kudos.

**Lý do ưu tiên**: Core function của dropdown — không thể gửi kudos mà không có hashtag.

**Kiểm thử độc lập**: Có thể test bằng cách mở dropdown và chọn/bỏ chọn hashtag.

**Kịch bản chấp nhận**:

1. **Cho biết** người dùng bấm "+ Hashtag", **Khi** dropdown mở, **Thì** hiển thị danh sách hashtag có sẵn, mỗi item gồm tên hashtag.
2. **Cho biết** dropdown đang mở, **Khi** bấm vào một hashtag chưa chọn, **Thì** hashtag được đánh dấu đã chọn (hiện icon check) và thêm vào danh sách chip ở form.
3. **Cho biết** hashtag đã được chọn (có icon check), **Khi** bấm lại, **Thì** bỏ chọn hashtag và xóa chip khỏi form.
4. **Cho biết** đã chọn 5 hashtag (max), **Khi** xem danh sách, **Thì** các hashtag chưa chọn hiển thị ở trạng thái disabled (opacity: 0.4) và không thể bấm.
5. **Cho biết** đã chọn 5 hashtag, **Khi** bỏ chọn 1 hashtag (bấm lại), **Thì** các hashtag chưa chọn quay lại trạng thái enabled.
6. **Cho biết** đã chọn xong, **Khi** bấm ra ngoài dropdown (overlay area), **Thì** dropdown đóng lại và form hiển thị các chip hashtag đã chọn.

---

### Trường hợp biên (Edge Cases)

- Danh sách hashtag rỗng (server trả rỗng) → Hiển thị "Không có hashtag nào." (centered, 14px/400, #999).
- Mất mạng khi load hashtag → Hiển thị "Không thể tải hashtag. Thử lại." với nút retry.
- Danh sách hashtag dài (> 6 items) → Hỗ trợ vertical scroll trong dropdown (max-height: 240px).
- Hashtag đã chọn từ trước (trong chip) → PHẢI được đánh dấu (icon check + background selected) khi mở dropdown.
- Bấm overlay (vùng tối bên ngoài dropdown) → Đóng dropdown.
- Đã chọn đủ 5 → Các item chưa chọn hiển thị disabled (opacity: 0.4), không phản hồi bấm.

---

## Yêu cầu UI/UX *(từ Figma)*

### Thành phần màn hình

| Thành phần | Mô tả | Tương tác |
|-----------|-------|-----------|
| A. Hashtag đã chọn | Hiển thị hashtag hiện tại đang được chọn (chip với icon check) | Bấm → Bỏ chọn |
| A.1. Hashtag text | Tên hashtag (ví dụ: "#teamwork") | Chỉ hiển thị |
| A.2. Icon đã chọn | Icon checkmark xác nhận đã chọn | Chỉ hiển thị (indicator) |
| Dropdown List | Danh sách tất cả hashtag có sẵn, scroll nếu dài | Bấm item → Toggle chọn/bỏ chọn |

### Luồng điều hướng

- **Từ**: Form gửi kudos (screenId: `PV7jBVZU1N`) — bấm "+ Hashtag"
- **Đến**: Quay lại form gửi kudos với hashtag đã chọn
- **Triggers**: Bấm item, bấm ra ngoài

### Yêu cầu hình ảnh

- Dropdown overlay trên form — không phải full-screen
- Background: overlay bán trong suốt phía sau dropdown
- Dark theme phù hợp với form parent

### Accessibility (VoiceOver)

| Thành phần | Semantic Label | Trait |
|-----------|---------------|-------|
| Dropdown list | "Chọn hashtag. {Số đã chọn}/5" | List |
| Hashtag item (chưa chọn) | "{Tên hashtag}. Chưa chọn" | Button |
| Hashtag item (đã chọn) | "{Tên hashtag}. Đã chọn" | Button, selected |

> Chi tiết visual specs xem tại [design-style.md](design-style.md)

---

## Yêu cầu *(bắt buộc)*

### Yêu cầu chức năng

- **FR-001**: Dropdown PHẢI hiển thị danh sách tất cả hashtag có sẵn từ server.
- **FR-002**: Mỗi hashtag PHẢI toggle giữa trạng thái chọn và bỏ chọn.
- **FR-003**: Hashtag đã chọn PHẢI hiển thị icon check.
- **FR-004**: Giới hạn tối đa 5 hashtag được chọn đồng thời.
- **FR-005**: Khi đóng dropdown, form PHẢI cập nhật danh sách chip hashtag.
- **FR-006**: Hệ thống PHẢI hỗ trợ đa ngôn ngữ (VN/EN).

### Yêu cầu kỹ thuật

- **TR-001**: Danh sách hashtag PHẢI được fetch từ API và cache trong ViewModel.
- **TR-002**: Dropdown PHẢI là widget overlay (không phải navigate sang screen mới).
- **TR-003**: Asset paths PHẢI sử dụng `flutter_gen`.

### Thực thể chính

- **Hashtag**: id, name — item trong danh sách

---

## Quản lý trạng thái (State Management)

Dropdown hashtag sử dụng state từ `SendKudosState` (parent ViewModel):
- `availableHashtags: List<Hashtag>` — danh sách hashtag có sẵn (pre-loaded)
- `hashtags: List<Hashtag>` — danh sách hashtag đã chọn

### Trạng thái Loading/Error

| Thành phần | Loading | Error | Empty |
|-----------|---------|-------|-------|
| Dropdown List | Shimmer placeholder (3 items) | "Không thể tải hashtag. Thử lại." + nút retry | "Không có hashtag nào." |

---

## Phụ thuộc API

| Endpoint | Method | Mục đích | Trạng thái |
|----------|--------|----------|------------|
| `/api/v1/hashtags` | GET | Lấy danh sách hashtag có sẵn | Dự đoán |

---

## Tiêu chí thành công *(bắt buộc)*

### Kết quả đo lường

- **SC-001**: Dropdown mở trong vòng 200ms.
- **SC-002**: Toggle chọn/bỏ chọn phản hồi dưới 100ms.
- **SC-003**: Hỗ trợ hiển thị đúng cả 2 ngôn ngữ VN và EN.

---

## Ngoài phạm vi

- Tạo hashtag mới (chỉ chọn từ danh sách có sẵn).
- Tìm kiếm/filter trong danh sách hashtag (nếu danh sách ngắn).

---

## Phụ thuộc

- [x] Constitution document tồn tại (`.momorph/constitution.md`)
- [x] Spec màn hình gửi kudos (`.momorph/specs/PV7jBVZU1N-ios-sun-kudos-gui-loi-chuc/spec.md`)

---

## Ghi chú

- Đây là overlay/modal state của form gửi kudos, không phải màn hình riêng biệt.
- Implement bằng `showModalBottomSheet` hoặc `OverlayEntry` trong Flutter.
- Danh sách hashtag nên được pre-load khi mở form (không chờ đến khi bấm "+").
- Hashtag đã chọn từ trước (trong chip) PHẢI được đánh dấu khi mở dropdown.
