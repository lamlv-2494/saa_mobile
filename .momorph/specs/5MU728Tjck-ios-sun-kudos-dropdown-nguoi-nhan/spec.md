# Đặc tả tính năng: [iOS] Sun*Kudos - Dropdown Tên Người Nhận

**Frame ID**: `5MU728Tjck`
**Frame Name**: `[iOS] Sun*Kudos_Gửi lời chúc Kudos_dropdown tên người nhận`
**File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Ngày tạo**: 2026-04-14
**Trạng thái**: Bản nháp

---

## Tổng quan

Màn hình **Dropdown Tên Người Nhận** là overlay/modal hiển thị khi người dùng bấm vào input "Người nhận" trong form gửi kudos. Cho phép tìm kiếm và chọn đồng nghiệp (Sunner) làm người nhận kudos. Hiển thị danh sách kết quả tìm kiếm với avatar, tên, và đơn vị/phòng ban.

**Đối tượng sử dụng**: Nhân viên Sun* (Sunner) đang soạn kudos.

**Bối cảnh kinh doanh**: Người nhận là trường bắt buộc — dropdown search giúp tìm đúng người một cách nhanh chóng.

**Màn hình chính (parent)**: `PV7jBVZU1N` — Gửi lời chúc Kudos

---

## Kịch bản người dùng & Kiểm thử *(bắt buộc)*

### User Story 1 - Tìm kiếm và chọn người nhận (Ưu tiên: P1)

Là một Sunner, tôi muốn tìm kiếm đồng nghiệp theo tên hoặc đơn vị để chọn làm người nhận kudos.

**Lý do ưu tiên**: Core function — không thể gửi kudos mà không có người nhận.

**Kiểm thử độc lập**: Có thể test bằng cách gõ tên và verify kết quả hiển thị.

**Kịch bản chấp nhận**:

1. **Cho biết** người dùng bấm vào input "Người nhận", **Khi** dropdown mở, **Thì** hiển thị input tìm kiếm ở trên (auto-focus, hiện keyboard) và danh sách rỗng bên dưới chờ nhập.
2. **Cho biết** dropdown đã mở, **Khi** gõ ít nhất 2 ký tự (ví dụ: "Ng"), **Thì** sau debounce 300ms, gọi API tìm kiếm và hiển thị kết quả phù hợp, mỗi item gồm: avatar, tên đầy đủ, đơn vị/phòng ban.
3. **Cho biết** dropdown đã mở, **Khi** gõ ít hơn 2 ký tự, **Thì** không gọi API, hiển thị hint "Nhập ít nhất 2 ký tự để tìm kiếm."
4. **Cho biết** đang tìm kiếm (sau debounce), **Khi** API đang gọi, **Thì** hiển thị loading indicator (shimmer 3 items) trong dropdown.
5. **Cho biết** danh sách kết quả hiển thị, **Khi** bấm vào một người, **Thì** đóng dropdown ngay lập tức và hiển thị tên + avatar người đã chọn trong input "Người nhận" trên form.
6. **Cho biết** gõ tên không khớp ai, **Khi** hệ thống trả về rỗng, **Thì** hiển thị "Không tìm thấy kết quả." (centered, 14px/400, #999).
7. **Cho biết** đã có người nhận được chọn trước đó, **Khi** mở dropdown lại, **Thì** input hiển thị tên đã chọn, cho phép xóa (icon clear) và tìm lại.
8. **Cho biết** người dùng chọn chính mình, **Khi** submit form, **Thì** hiển thị lỗi "Bạn không thể gửi kudo cho chính mình." Lưu ý: KHÔNG chặn ở dropdown — chặn ở bước validate khi submit.

---

### User Story 2 - Xem thông tin người nhận (Ưu tiên: P2)

Là một Sunner, tôi muốn xem avatar và đơn vị của đồng nghiệp trong danh sách để chọn đúng người.

**Lý do ưu tiên**: Giúp phân biệt người cùng tên ở các đơn vị khác nhau.

**Kiểm thử độc lập**: Verify mỗi item hiển thị đủ avatar + tên + đơn vị.

**Kịch bản chấp nhận**:

1. **Cho biết** danh sách kết quả hiển thị, **Khi** xem mỗi item, **Thì** thấy: avatar tròn (bên trái), tên đầy đủ (dòng 1, bold), đơn vị/phòng ban (dòng 2, lighter).

---

### Trường hợp biên (Edge Cases)

- Danh sách người dùng rỗng (lỗi server 500) → Hiển thị "Đã xảy ra lỗi. Vui lòng thử lại." + nút retry.
- Tìm kiếm khi mất mạng → Hiển thị "Không thể tìm kiếm. Kiểm tra kết nối mạng."
- Gõ quá nhanh → Debounce search (300ms delay) — chỉ gọi API sau khi ngừng gõ 300ms.
- Gõ ít hơn 2 ký tự → Không gọi API, hiển thị hint.
- Người dùng đã chọn trước đó → Hiển thị tên trong input, icon clear (X) ở bên phải để xóa và tìm lại.
- Người dùng xóa text search (clear) → Danh sách kết quả ẩn, hiển thị hint.
- Bấm overlay (vùng tối bên ngoài dropdown) → Đóng dropdown, giữ nguyên lựa chọn cũ (nếu có).
- Avatar URL lỗi hoặc null → Hiển thị fallback: CircleAvatar với initials (chữ cái đầu) trên nền rgba(255,234,158,0.20).

---

## Yêu cầu UI/UX *(từ Figma)*

### Thành phần màn hình

| Thành phần | Mô tả | Tương tác |
|-----------|-------|-----------|
| B. Dropdown List | Container danh sách kết quả tìm kiếm | Scroll danh sách |
| B.1. Kết quả search 1 | Item kết quả đầu tiên (avatar + tên + đơn vị) | Bấm → Chọn người nhận |
| B.1.1. Avatar | Ảnh đại diện người dùng (hình tròn) | Chỉ hiển thị |
| B.1.2. Tên và đơn vị | Tên đầy đủ (bold) + Đơn vị/phòng ban (regular) | Chỉ hiển thị |
| B.3. Kết quả search 3 | Item kết quả thứ 3 (cùng layout B.1) | Bấm → Chọn người nhận |

### Luồng điều hướng

- **Từ**: Form gửi kudos (screenId: `PV7jBVZU1N`) — bấm input "Người nhận"
- **Đến**: Quay lại form gửi kudos với người nhận đã chọn
- **Triggers**: Gõ text tìm kiếm, bấm item kết quả, bấm ra ngoài

### Yêu cầu hình ảnh

- Dropdown overlay trên form — không phải full-screen
- Dark theme phù hợp với form parent
- Avatar hình tròn, fallback khi không có ảnh

### Accessibility (VoiceOver)

| Thành phần | Semantic Label | Trait |
|-----------|---------------|-------|
| Search input | "Tìm kiếm người nhận" | TextField |
| Dropdown list | "Danh sách người nhận. {Số kết quả} kết quả" | List |
| Result item | "{Tên}. {Đơn vị}" | Button |

> Chi tiết visual specs xem tại [design-style.md](design-style.md)

---

## Yêu cầu *(bắt buộc)*

### Yêu cầu chức năng

- **FR-001**: Dropdown PHẢI hỗ trợ tìm kiếm theo tên và đơn vị/phòng ban.
- **FR-002**: Kết quả tìm kiếm PHẢI hiển thị: avatar (36x36, tròn, có fallback), tên đầy đủ, đơn vị.
- **FR-003**: Bấm vào kết quả PHẢI đóng dropdown ngay lập tức và cập nhật trường "Người nhận" trên form.
- **FR-004**: Tìm kiếm PHẢI có debounce (300ms) để tránh gọi API quá nhiều.
- **FR-005**: Tìm kiếm PHẢI yêu cầu tối thiểu 2 ký tự trước khi gọi API.
- **FR-006**: KHÔNG cho phép chọn chính mình làm người nhận (validate ở bước submit, không chặn ở dropdown).
- **FR-007**: Hệ thống PHẢI hỗ trợ đa ngôn ngữ (VN/EN).
- **FR-008**: Input tìm kiếm PHẢI auto-focus khi dropdown mở.
- **FR-009**: PHẢI có icon clear (X) để xóa nhanh text search.

### Yêu cầu kỹ thuật

- **TR-001**: Search PHẢI gọi API với debounce 300ms.
- **TR-002**: Dropdown PHẢI là widget overlay (không phải navigate sang screen mới).
- **TR-003**: Avatar PHẢI có fallback (initials hoặc default icon) khi URL ảnh lỗi.
- **TR-004**: Asset paths PHẢI sử dụng `flutter_gen`.

### Thực thể chính

- **UserSummary**: id, name, avatar, department — item trong danh sách kết quả

---

## Quản lý trạng thái (State Management)

Dropdown người nhận sử dụng state từ `SendKudosState` (parent ViewModel):
- `searchResults: List<UserSummary>` — kết quả tìm kiếm hiện tại
- `isSearching: bool` — đang gọi API tìm kiếm
- `recipientId: String?` — ID người nhận đã chọn (null = chưa chọn)
- `recipientName: String?` — tên hiển thị

### Local State (dropdown widget)
- `searchQuery: String` — text tìm kiếm hiện tại (local, không lưu ViewModel)
- `debounceTimer: Timer?` — timer debounce 300ms

### Trạng thái Loading/Error

| Thành phần | Loading | Error | Empty |
|-----------|---------|-------|-------|
| Search Results | Shimmer placeholder (3 items) | "Đã xảy ra lỗi. Vui lòng thử lại." + nút retry | "Không tìm thấy kết quả." |
| Initial (chưa gõ) | N/A | N/A | Hint: "Nhập ít nhất 2 ký tự để tìm kiếm." |

---

## Phụ thuộc API

| Endpoint | Method | Mục đích | Trạng thái |
|----------|--------|----------|------------|
| `/api/v1/users/search` | GET | Tìm kiếm người nhận (query: name, department) | Dự đoán |

---

## Tiêu chí thành công *(bắt buộc)*

### Kết quả đo lường

- **SC-001**: Kết quả tìm kiếm hiển thị trong vòng 500ms sau khi debounce.
- **SC-002**: Dropdown mở trong vòng 200ms.
- **SC-003**: Hỗ trợ hiển thị đúng cả 2 ngôn ngữ VN và EN.

---

## Ngoài phạm vi

- Xem profile chi tiết người nhận từ dropdown.
- Chọn nhiều người nhận (chỉ 1 người/kudos).
- Filter theo phòng ban riêng biệt.

---

## Phụ thuộc

- [x] Constitution document tồn tại (`.momorph/constitution.md`)
- [x] Spec màn hình gửi kudos (`.momorph/specs/PV7jBVZU1N-ios-sun-kudos-gui-loi-chuc/spec.md`)

---

## Ghi chú

- Đây là overlay/modal state của form gửi kudos, không phải màn hình riêng biệt.
- Implement bằng `showModalBottomSheet` hoặc `OverlayEntry` với search input.
- Debounce 300ms cho search API call — sử dụng `Timer` hoặc `debounce` extension.
- Avatar sử dụng `CircleAvatar` với `NetworkImage` + fallback.
- Chỉ chọn được 1 người — bấm item → đóng dropdown ngay.
