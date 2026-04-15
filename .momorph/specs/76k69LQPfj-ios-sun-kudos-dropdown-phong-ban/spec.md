# Đặc tả tính năng: [iOS] Sun*Kudos_dropdown phòng ban

**Frame ID**: `76k69LQPfj`
**Frame Name**: `[iOS] Sun*Kudos_dropdown phòng ban`
**File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Ngày tạo**: 2026-04-14
**Trạng thái**: Draft

---

## Tổng quan

**Dropdown Phòng ban** là overlay dropdown hiển thị danh sách phòng ban (department) để lọc Highlight Kudos trên màn hình chính Kudos. Khi người dùng bấm vào dropdown button "Phòng ban" trên section Highlight, overlay này xuất hiện cho phép chọn 1 phòng ban để lọc. Đây là overlay/popup trên cùng màn hình Kudos — KHÔNG phải màn hình riêng.

**Đối tượng sử dụng**: Nhân viên Sun* (Sunner) đã đăng nhập vào ứng dụng.

**Bối cảnh kinh doanh**: Cho phép Sunner lọc Highlight Kudos theo phòng ban để xem kudos của đồng nghiệp trong đơn vị cụ thể.

---

## Kịch bản người dùng & Kiểm thử *(bắt buộc)*

### User Story 1 - Xem danh sách Phòng ban (Ưu tiên: P1)

Là một Sunner, tôi muốn xem danh sách phòng ban có sẵn để lọc kudos theo đơn vị.

**Lý do ưu tiên**: Đây là chức năng chính của dropdown.

**Kiểm thử độc lập**: Có thể test bằng cách mở dropdown và verify danh sách hiển thị.

**Kịch bản chấp nhận**:

1. **Cho biết** người dùng bấm dropdown button "Phòng ban" trên Highlight section, **Khi** dropdown mở, **Thì** hiển thị danh sách phòng ban dạng tag pills (chip), bao gồm tùy chọn "Tất cả" (i18n) ở đầu danh sách.
2. **Cho biết** danh sách phòng ban được load từ API, **Khi** hiển thị, **Thì** mỗi phòng ban hiển thị dạng pill/chip với tên viết tắt (ví dụ: "CEV", "CECV", "DCC", "HN1").
3. **Cho biết** phòng ban đang được chọn (filter active), **Khi** mở dropdown, **Thì** phòng ban đang chọn được highlight (style selected).

---

### User Story 2 - Chọn Phòng ban để lọc (Ưu tiên: P1)

Là một Sunner, tôi muốn chọn 1 phòng ban để lọc Highlight Kudos.

**Lý do ưu tiên**: Đây là action chính — chọn filter.

**Kiểm thử độc lập**: Có thể test bằng cách chọn phòng ban và verify filter áp dụng.

**Kịch bản chấp nhận**:

1. **Cho biết** dropdown đang mở, **Khi** bấm vào 1 phòng ban, **Thì** đóng dropdown, áp dụng filter, Highlight Kudos carousel chỉ hiển thị kudos thuộc phòng ban đã chọn, carousel reset về trang 1.
2. **Cho biết** đang có filter phòng ban, **Khi** bấm "Tất cả", **Thì** xóa filter, hiển thị tất cả kudos, dropdown đóng.
3. **Cho biết** đã chọn phòng ban, **Khi** dropdown button hiển thị, **Thì** button hiển thị tên phòng ban đã chọn thay cho placeholder "Phòng ban".

---

### User Story 3 - Đóng Dropdown (Ưu tiên: P2)

Là một Sunner, tôi muốn đóng dropdown mà không chọn gì.

**Lý do ưu tiên**: Tương tác phụ nhưng cần thiết cho UX.

**Kiểm thử độc lập**: Có thể test bằng cách bấm ngoài dropdown.

**Kịch bản chấp nhận**:

1. **Cho biết** dropdown đang mở, **Khi** bấm vào vùng ngoài dropdown, **Thì** dropdown đóng và filter không thay đổi.

---

### User Story 4 - Tính loại trừ lẫn nhau với Dropdown Hashtag (Ưu tiên: P2)

Là một Sunner, tôi muốn chỉ 1 dropdown được mở tại 1 thời điểm để giao diện không bị rối.

**Lý do ưu tiên**: UX cần thiết nhưng không ảnh hưởng core filter logic.

**Kiểm thử độc lập**: Có thể test bằng cách mở dropdown Phòng ban khi dropdown Hashtag đang mở.

**Kịch bản chấp nhận**:

1. **Cho biết** dropdown Hashtag đang mở, **Khi** bấm dropdown button "Phòng ban", **Thì** dropdown Hashtag đóng trước, dropdown Phòng ban mở.
2. **Cho biết** dropdown Phòng ban đang mở, **Khi** bấm dropdown button "Hashtag", **Thì** dropdown Phòng ban đóng trước, dropdown Hashtag mở.

---

### Trường hợp biên (Edge Cases)

- Không có phòng ban nào → Hiển thị dropdown rỗng với text "Chưa có phòng ban nào" (i18n).
- Mất kết nối khi load phòng ban → Hiển thị thông báo lỗi "Không thể tải danh sách phòng ban" (i18n) trong dropdown với nút retry.
- Đang tải danh sách phòng ban → Hiển thị loading indicator (spinner) trong dropdown container.
- Phòng ban được chọn nhưng không còn kudos nào match → Carousel hiển thị empty state "Không tìm thấy Kudos phù hợp." (i18n).
- Danh sách phòng ban quá nhiều → Wrap layout tự động xuống dòng, dropdown có max-height (200px) và scroll nếu cần.

---

## Yêu cầu UI/UX *(từ Figma)*

### Thành phần màn hình

| Thành phần | Mã | Mô tả | Tương tác |
|-----------|-----|-------|-----------|
| Dropdown Container | A | Container chứa danh sách phòng ban dạng tag pills | Overlay trên Kudos feed |
| Phòng ban 1 | A.1 | Tag pill dạng selected (ví dụ: "CEV") | Bấm → chọn/bỏ chọn |
| Phòng ban 2 | A.2 | Tag pill dạng unselected (ví dụ: "CECV") | Bấm → chọn |

### Luồng điều hướng

- **Từ**: Bấm dropdown button "Phòng ban" trên Kudos feed (screenId: `fO0Kt19sZZ`)
- **Đến**: Không có — chỉ đóng overlay và áp dụng filter
- **Triggers**: Bấm tag, bấm ngoài dropdown

### Accessibility (VoiceOver)

| Thành phần | Semantic Label | Trait |
|-----------|---------------|-------|
| Dropdown Container | "Danh sách phòng ban. Chọn phòng ban để lọc" | Group |
| Tag pill (selected) | "{department name}. Đang chọn" | Button, Selected |
| Tag pill (unselected) | "{department name}" | Button |

> Chi tiết visual specs xem tại [design-style.md](design-style.md)

---

## Yêu cầu *(bắt buộc)*

### Yêu cầu chức năng

- **FR-001**: Dropdown PHẢI hiển thị danh sách phòng ban dạng tag pills/chips (wrap layout).
- **FR-002**: PHẢI có tùy chọn "Tất cả" (i18n) để xóa filter.
- **FR-003**: Chỉ cho phép chọn 1 phòng ban tại 1 thời điểm (single-select).
- **FR-004**: Chọn phòng ban PHẢI đóng dropdown và áp dụng filter ngay lập tức.
- **FR-005**: Phòng ban đang chọn PHẢI có visual state khác (selected vs unselected).
- **FR-006**: Filter kết hợp với Dropdown Hashtag (`V5GRjAdJyb`) theo logic AND.
- **FR-007**: Hệ thống PHẢI hỗ trợ đa ngôn ngữ (VN/EN) cho "Tất cả", "Phòng ban".

### Yêu cầu kỹ thuật

- **TR-001**: Danh sách phòng ban PHẢI được cache sau lần load đầu tiên.
- **TR-002**: Dropdown PHẢI render dạng overlay/popup (không phải navigation).
- **TR-003**: Asset paths PHẢI sử dụng `flutter_gen` (`Assets.xxx`).
- **TR-004**: State filter phòng ban PHẢI quản lý bởi `KudosViewModel`.
- **TR-005**: Dropdown Hashtag và Dropdown Phòng ban NÊN dùng chung 1 generic dropdown widget.

### Thực thể chính

- **Department**: id, name (ví dụ: "CEV", "CECV", "DCC", "HN1", "HCM1")

---

## Phụ thuộc API

| Endpoint | Method | Mục đích | Trạng thái |
|----------|--------|----------|------------|
| `/api/v1/departments` | GET | Lấy danh sách phòng ban | Dự đoán |

---

## Tiêu chí thành công *(bắt buộc)*

### Kết quả đo lường

- **SC-001**: Dropdown mở và hiển thị danh sách trong vòng 0.3 giây (từ cache).
- **SC-002**: Hỗ trợ hiển thị đúng cả 2 ngôn ngữ VN và EN.

---

## Ngoài phạm vi

- Tìm kiếm trong danh sách phòng ban.
- Multi-select phòng ban.
- Hiển thị số lượng kudos theo phòng ban.

---

## Phụ thuộc

- [x] Constitution document tồn tại (`.momorph/constitution.md`)
- [x] Spec Kudos feed (`.momorph/specs/fO0Kt19sZZ-ios-sun-kudos/spec.md`)
- [x] Spec Dropdown Hashtag (`.momorph/specs/V5GRjAdJyb-ios-sun-kudos-dropdown-hashtag/spec.md`)

---

## Ghi chú

- Dropdown Phòng ban (`76k69LQPfj`) và Dropdown Hashtag (`V5GRjAdJyb`) có layout/behavior gần như giống nhau. Nên implement dạng generic `FilterDropdown` widget nhận `List<FilterItem>`.
- Tất cả text PHẢI hỗ trợ đa ngôn ngữ VN/EN thông qua i18n (slang).
- "Tất cả", "Phòng ban" PHẢI được khai báo trong i18n, không hardcode.
- Chỉ 1 dropdown được mở tại 1 thời điểm — mở dropdown Phòng ban sẽ đóng dropdown Hashtag (nếu đang mở) và ngược lại.
