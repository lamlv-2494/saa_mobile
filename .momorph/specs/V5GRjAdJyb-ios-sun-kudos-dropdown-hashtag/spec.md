# Đặc tả tính năng: [iOS] Sun*Kudos_dropdown hashtag

**Frame ID**: `V5GRjAdJyb`
**Frame Name**: `[iOS] Sun*Kudos_dropdown hashtag`
**File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Ngày tạo**: 2026-04-14
**Trạng thái**: Draft

---

## Tổng quan

**Dropdown Hashtag** là overlay dropdown hiển thị danh sách hashtag để lọc Highlight Kudos trên màn hình chính Kudos. Khi người dùng bấm vào dropdown button "Hashtag" trên section Highlight, overlay này xuất hiện cho phép chọn 1 hashtag để lọc. Đây là overlay/popup trên cùng màn hình Kudos — KHÔNG phải màn hình riêng.

**Đối tượng sử dụng**: Nhân viên Sun* (Sunner) đã đăng nhập vào ứng dụng.

**Bối cảnh kinh doanh**: Cho phép Sunner lọc Highlight Kudos theo hashtag (chủ đề ghi nhận) để tìm kudos phù hợp với sở thích/quan tâm.

---

## Kịch bản người dùng & Kiểm thử *(bắt buộc)*

### User Story 1 - Xem danh sách Hashtag (Ưu tiên: P1)

Là một Sunner, tôi muốn xem danh sách các hashtag có sẵn để chọn lọc kudos theo chủ đề.

**Lý do ưu tiên**: Đây là chức năng chính của dropdown — hiển thị danh sách hashtag.

**Kiểm thử độc lập**: Có thể test bằng cách mở dropdown và verify danh sách hiển thị.

**Kịch bản chấp nhận**:

1. **Cho biết** người dùng bấm dropdown button "Hashtag" trên Highlight section, **Khi** dropdown mở, **Thì** hiển thị danh sách hashtag dạng tag pills (chip), bao gồm tùy chọn "Tất cả" (i18n) ở đầu danh sách.
2. **Cho biết** danh sách hashtag được load từ API, **Khi** hiển thị, **Thì** mỗi hashtag hiển thị dạng pill/chip (ví dụ: "#Teamwork", "#Dedicated", "#Inspiring").
3. **Cho biết** hashtag đang được chọn (filter active), **Khi** mở dropdown, **Thì** hashtag đang chọn được highlight (khác style so với tag chưa chọn).

---

### User Story 2 - Chọn Hashtag để lọc (Ưu tiên: P1)

Là một Sunner, tôi muốn chọn 1 hashtag để lọc Highlight Kudos.

**Lý do ưu tiên**: Đây là action chính — chọn filter.

**Kiểm thử độc lập**: Có thể test bằng cách chọn hashtag và verify filter được áp dụng.

**Kịch bản chấp nhận**:

1. **Cho biết** dropdown đang mở, **Khi** bấm vào 1 hashtag, **Thì** đóng dropdown, áp dụng filter, Highlight Kudos carousel chỉ hiển thị kudos có hashtag đã chọn, carousel reset về trang 1.
2. **Cho biết** đang có filter hashtag, **Khi** bấm "Tất cả" (hoặc chọn lại cùng hashtag đang active), **Thì** xóa filter, hiển thị tất cả kudos, dropdown đóng.
3. **Cho biết** đã chọn hashtag, **Khi** dropdown button hiển thị, **Thì** button hiển thị tên hashtag đã chọn thay cho placeholder "Hashtag".

---

### User Story 3 - Đóng Dropdown (Ưu tiên: P2)

Là một Sunner, tôi muốn đóng dropdown mà không chọn gì.

**Lý do ưu tiên**: Tương tác phụ nhưng cần thiết cho UX.

**Kiểm thử độc lập**: Có thể test bằng cách bấm ngoài dropdown và verify đóng.

**Kịch bản chấp nhận**:

1. **Cho biết** dropdown đang mở, **Khi** bấm vào vùng ngoài dropdown, **Thì** dropdown đóng và filter không thay đổi.

---

### User Story 4 - Tính loại trừ lẫn nhau với Dropdown Phòng ban (Ưu tiên: P2)

Là một Sunner, tôi muốn chỉ 1 dropdown được mở tại 1 thời điểm để giao diện không bị rối.

**Lý do ưu tiên**: UX cần thiết nhưng không ảnh hưởng core filter logic.

**Kiểm thử độc lập**: Có thể test bằng cách mở dropdown Hashtag khi dropdown Phòng ban đang mở.

**Kịch bản chấp nhận**:

1. **Cho biết** dropdown Phòng ban đang mở, **Khi** bấm dropdown button "Hashtag", **Thì** dropdown Phòng ban đóng trước, dropdown Hashtag mở.
2. **Cho biết** dropdown Hashtag đang mở, **Khi** bấm dropdown button "Phòng ban", **Thì** dropdown Hashtag đóng trước, dropdown Phòng ban mở.

---

### Trường hợp biên (Edge Cases)

- Không có hashtag nào trong hệ thống → Hiển thị dropdown rỗng với text "Chưa có hashtag nào" (i18n).
- Mất kết nối khi load hashtag → Hiển thị thông báo lỗi "Không thể tải danh sách hashtag" (i18n) trong dropdown với nút retry.
- Đang tải danh sách hashtag → Hiển thị loading indicator (spinner) trong dropdown container.
- Hashtag được chọn nhưng không còn kudos nào match → Carousel hiển thị empty state "Không tìm thấy Kudos phù hợp." (i18n).
- Danh sách hashtag quá nhiều → Wrap layout tự xuống dòng, dropdown có max-height và scroll nếu cần.

---

## Yêu cầu UI/UX *(từ Figma)*

### Thành phần màn hình

| Thành phần | Mã | Mô tả | Tương tác |
|-----------|-----|-------|-----------|
| Dropdown Container | A | Container chứa danh sách hashtag dạng tag pills | Overlay trên Kudos feed |
| Tag 1 | A.1 | Hashtag pill dạng selected (ví dụ: "#Teamwork") | Bấm → chọn/bỏ chọn |
| Tag 2 | A.2 | Hashtag pill dạng unselected (ví dụ: "#Dedicated") | Bấm → chọn |

### Luồng điều hướng

- **Từ**: Bấm dropdown button "Hashtag" trên Kudos feed (screenId: `fO0Kt19sZZ`)
- **Đến**: Không có — chỉ đóng overlay và áp dụng filter
- **Triggers**: Bấm tag, bấm ngoài dropdown

### Accessibility (VoiceOver)

| Thành phần | Semantic Label | Trait |
|-----------|---------------|-------|
| Dropdown Container | "Danh sách hashtag. Chọn hashtag để lọc" | Group |
| Tag pill (selected) | "{hashtag name}. Đang chọn" | Button, Selected |
| Tag pill (unselected) | "{hashtag name}" | Button |

> Chi tiết visual specs xem tại [design-style.md](design-style.md)

---

## Yêu cầu *(bắt buộc)*

### Yêu cầu chức năng

- **FR-001**: Dropdown PHẢI hiển thị danh sách hashtag dạng tag pills/chips (wrap layout).
- **FR-002**: PHẢI có tùy chọn "Tất cả" (i18n) để xóa filter.
- **FR-003**: Chỉ cho phép chọn 1 hashtag tại 1 thời điểm (single-select).
- **FR-004**: Chọn hashtag PHẢI đóng dropdown và áp dụng filter ngay lập tức.
- **FR-005**: Hashtag đang chọn PHẢI có visual state khác (selected vs unselected).
- **FR-006**: Filter kết hợp với Dropdown Phòng ban (`76k69LQPfj`) theo logic AND.
- **FR-007**: Hệ thống PHẢI hỗ trợ đa ngôn ngữ (VN/EN) cho "Tất cả" và các text UI.

### Yêu cầu kỹ thuật

- **TR-001**: Danh sách hashtag PHẢI được cache sau lần load đầu tiên.
- **TR-002**: Dropdown PHẢI render dạng overlay/popup (không phải navigation).
- **TR-003**: Asset paths PHẢI sử dụng `flutter_gen` (`Assets.xxx`).
- **TR-004**: State filter hashtag PHẢI quản lý bởi `KudosViewModel`.

### Thực thể chính

- **Hashtag**: id, name (ví dụ: "#Teamwork", "#Dedicated", "#Inspiring")

---

## Phụ thuộc API

| Endpoint | Method | Mục đích | Trạng thái |
|----------|--------|----------|------------|
| `/api/v1/hashtags` | GET | Lấy danh sách hashtag | Dự đoán |

---

## Tiêu chí thành công *(bắt buộc)*

### Kết quả đo lường

- **SC-001**: Dropdown mở và hiển thị danh sách trong vòng 0.3 giây (từ cache).
- **SC-002**: Hỗ trợ hiển thị đúng cả 2 ngôn ngữ VN và EN.

---

## Ngoài phạm vi

- Tìm kiếm trong danh sách hashtag (chưa có trong thiết kế).
- Tạo hashtag mới.
- Multi-select hashtag.

---

## Phụ thuộc

- [x] Constitution document tồn tại (`.momorph/constitution.md`)
- [x] Spec Kudos feed (`.momorph/specs/fO0Kt19sZZ-ios-sun-kudos/spec.md`)

---

## Ghi chú

- Dropdown Hashtag (`V5GRjAdJyb`) và Dropdown Phòng ban (`76k69LQPfj`) có layout tương tự nhưng dữ liệu khác — nên implement dạng generic dropdown widget nhận danh sách items.
- Tất cả text PHẢI hỗ trợ đa ngôn ngữ VN/EN thông qua i18n (slang).
- "Tất cả", "Hashtag" PHẢI được khai báo trong i18n, không hardcode.
