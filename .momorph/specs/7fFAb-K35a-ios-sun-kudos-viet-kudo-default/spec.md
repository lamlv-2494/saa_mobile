# Đặc tả tính năng: [iOS] Sun*Kudos - Viết Kudo (Trạng thái mặc định)

**Frame ID**: `7fFAb-K35a`
**Frame Name**: `[iOS] Sun*Kudos_Viết Kudo_default`
**File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Ngày tạo**: 2026-04-14
**Trạng thái**: Bản nháp

---

## Tổng quan

Màn hình **Viết Kudo (trạng thái mặc định)** là trạng thái ban đầu của form gửi kudos khi người dùng mới mở — tất cả các trường đều rỗng và sẵn sàng để nhập. Đây là variant hiển thị của màn hình chính "Gửi lời chúc Kudos" (screenId: `PV7jBVZU1N`).

**Đối tượng sử dụng**: Nhân viên Sun* (Sunner) đã đăng nhập vào ứng dụng.

**Bối cảnh kinh doanh**: Trạng thái mặc định đảm bảo form rõ ràng, dễ hiểu ngay lần đầu sử dụng — với placeholder text hướng dẫn người dùng ở mỗi trường.

**Màn hình chính (parent)**: `PV7jBVZU1N` — Gửi lời chúc Kudos

---

## Kịch bản người dùng & Kiểm thử *(bắt buộc)*

### User Story 1 - Hiển thị form rỗng với hướng dẫn (Ưu tiên: P1)

Là một Sunner, tôi muốn thấy form gửi kudos rõ ràng với placeholder hướng dẫn ở mỗi trường để biết cần điền gì.

**Lý do ưu tiên**: Đây là trải nghiệm đầu tiên khi mở form — quyết định người dùng có tiếp tục điền hay không.

**Kiểm thử độc lập**: Có thể test bằng cách mở form và verify tất cả placeholder hiển thị đúng.

**Kịch bản chấp nhận**:

1. **Cho biết** người dùng bấm nút CTA "Gửi kudos" từ màn hình chính, **Khi** form mở ra, **Thì** hiển thị:
   - Header: "Gửi lời cám ơn và ghi nhận đến đồng đội"
   - Trường "Người nhận *" với placeholder "Tìm kiếm"
   - Trường "Danh hiệu *" với placeholder "Danh tặng một danh hiệu cho..."
   - Link "Tiêu chuẩn cộng đồng"
   - Toolbar formatting (6 nút, tất cả inactive)
   - Textarea với placeholder "Hãy gửi gắm lời cám ơn và ghi nhận đến đồng đội tại đây nhé!"
   - Hint: "Bạn có thể '@ + tên' để nhắc tới đồng nghiệp khác"
   - Hashtag section với nút "+ Hashtag (Tối đa 5)"
   - Image section với nút "+ Image (Tối đa 5)"
   - Checkbox "Gửi ẩn danh" (tắt)
   - Nút "Hủy" và "Gửi đi"
2. **Cho biết** form ở trạng thái mặc định, **Khi** chưa điền gì, **Thì** nút "Gửi đi" ở trạng thái disabled (opacity giảm: bg rgba(255,234,158,0.40), text rgba(0,16,26,0.50)).
3. **Cho biết** form ở trạng thái mặc định, **Khi** bấm vào bất kỳ trường nào, **Thì** trường đó được focus với border chuyển sang màu accent (#FFEA9E).
4. **Cho biết** người dùng đã điền đủ 4 trường bắt buộc (Người nhận + Danh hiệu + Nội dung + ít nhất 1 Hashtag), **Khi** trường cuối cùng được điền, **Thì** nút "Gửi đi" chuyển sang trạng thái enabled (bg: #FFEA9E, text: #00101A) với animation opacity 200ms.

---

### User Story 2 - Hiển thị các label bắt buộc (Ưu tiên: P1)

Là một Sunner, tôi muốn biết trường nào bắt buộc để không bỏ sót thông tin quan trọng.

**Lý do ưu tiên**: Hướng dẫn người dùng điền đúng và đủ.

**Kiểm thử độc lập**: Verify các label có dấu "*" hiển thị đúng.

**Kịch bản chấp nhận**:

1. **Cho biết** form hiển thị, **Khi** xem các label, **Thì** các trường bắt buộc có dấu "*": "Người nhận *", "Danh hiệu *", "Hashtag *".
2. **Cho biết** trường "Image" hiển thị, **Khi** xem label, **Thì** KHÔNG có dấu "*" (trường tùy chọn).

---

### Trường hợp biên (Edge Cases)

- Keyboard hiện che input → Form auto-scroll để input hiện tại luôn visible.
- Xoay màn hình → Không hỗ trợ (portrait only).
- Form mở khi mất mạng → Vẫn hiển thị form, lỗi chỉ khi submit hoặc search người nhận.

---

## Yêu cầu UI/UX *(từ Figma)*

### Thành phần màn hình

> Các thành phần giống với màn hình chính `PV7jBVZU1N`. Xem chi tiết tại [spec.md của PV7jBVZU1N](../PV7jBVZU1N-ios-sun-kudos-gui-loi-chuc/spec.md).

**Điểm khác biệt so với trạng thái đã điền:**

| Thành phần | Trạng thái mặc định | Trạng thái đã điền (PV7jBVZU1N) |
|-----------|---------------------|--------------------------------|
| B.2. Recipient Dropdown | Placeholder "Tìm kiếm" | Hiển thị tên người nhận |
| B.4. Danh hiệu Input | Placeholder "Danh tặng một danh hiệu cho..." | Hiển thị danh hiệu đã nhập |
| C. Toolbar | Tất cả nút inactive | Một số nút có thể active |
| D. Textarea | Placeholder dài | Hiển thị nội dung đã nhập |
| E.2. Tag Group | Chỉ có nút "+ Hashtag" | Có chips + nút "+" |
| F. Thumbnails | Không có thumbnail | Có thumbnails ảnh đã chọn |
| G. Checkbox | Unchecked | Checked hoặc Unchecked |
| I. Send Button | Disabled | Enabled |

### Luồng điều hướng

- **Từ**: Màn hình chính Sun*Kudos (screenId: `fO0Kt19sZZ`) — bấm nút CTA
- **Đến**: Các trạng thái khác của form khi người dùng bắt đầu điền
- **Triggers**: Bấm vào input → focus → bắt đầu nhập

### Yêu cầu hình ảnh

- Width: 375px, Height: 812px (không scroll — nội dung vừa 1 màn hình ở trạng thái mặc định)
- Dark theme background: `#00101A`

### Accessibility (VoiceOver)

> Giống với màn hình `PV7jBVZU1N`. Xem chi tiết tại [spec.md của PV7jBVZU1N](../PV7jBVZU1N-ios-sun-kudos-gui-loi-chuc/spec.md).

> Chi tiết visual specs xem tại [design-style.md](design-style.md)

---

## Yêu cầu *(bắt buộc)*

### Yêu cầu chức năng

- **FR-001**: Form PHẢI hiển thị tất cả placeholder text hướng dẫn khi ở trạng thái mặc định.
- **FR-002**: Nút "Gửi đi" PHẢI ở trạng thái disabled khi chưa điền trường bắt buộc nào.
- **FR-003**: Các label bắt buộc PHẢI có dấu "*" rõ ràng.
- **FR-004**: Toolbar formatting PHẢI hiển thị với tất cả nút ở trạng thái inactive.
- **FR-005**: Checkbox ẩn danh PHẢI mặc định ở trạng thái tắt (unchecked).
- **FR-006**: Hệ thống PHẢI hỗ trợ đa ngôn ngữ (VN/EN) cho tất cả placeholder, label, và hint.

### Yêu cầu kỹ thuật

- **TR-001**: Trạng thái mặc định là initial state của `SendKudosState` trong ViewModel.
- **TR-002**: Placeholder text PHẢI sử dụng i18n (slang), không hardcode.
- **TR-003**: Asset paths PHẢI sử dụng `flutter_gen` (`Assets.xxx`).

### Thực thể chính

> Giống với màn hình `PV7jBVZU1N`.

---

## Quản lý trạng thái (State Management)

### Initial State (SendKudosState — freezed)

Trạng thái mặc định là giá trị khởi tạo khi `SendKudosViewModel.build()` được gọi:

```
SendKudosState (initial):
  - recipientId: null
  - recipientName: null
  - recipientAvatar: null
  - title: ""
  - message: ""
  - hashtags: []                       # Rỗng → nút "Gửi đi" disabled
  - imageIds: []
  - imagePreviews: []
  - imageUploadingIndex: null
  - isAnonymous: false                 # Mặc định: tắt
  - isSubmitting: false
  - isDirty: false                     # Form chưa thay đổi → bấm "Hủy" đóng ngay
  - availableHashtags: []              # Sẽ được load từ API
  - searchResults: []
  - isSearching: false
  - validationErrors: {}               # Không có lỗi
  - showErrorBanner: false
```

### Điều kiện enable nút "Gửi đi"

Nút "Gửi đi" PHẢI ở trạng thái **enabled** khi TẤT CẢ các điều kiện sau đều đúng:
- `recipientId != null`
- `title.trim().isNotEmpty`
- `message.trim().isNotEmpty`
- `hashtags.isNotEmpty`
- `isSubmitting == false`

Nếu bất kỳ điều kiện nào không thỏa → nút ở trạng thái **disabled**.

---

## Phụ thuộc API

| Endpoint | Method | Mục đích | Trạng thái |
|----------|--------|----------|------------|
| `/api/v1/hashtags` | GET | Pre-load danh sách hashtag khi mở form | Dự đoán |

---

## Tiêu chí thành công *(bắt buộc)*

### Kết quả đo lường

- **SC-001**: Form mặc định load trong vòng 500ms (không cần fetch data ngoài hashtags).
- **SC-002**: Tất cả placeholder text hiển thị đúng ngôn ngữ theo cài đặt user.
- **SC-003**: Nút "Gửi đi" disabled rõ ràng (visual distinction so với enabled state).

---

## Ngoài phạm vi

- Logic validation (xem màn hình `0le8xKnFE_`).
- Dropdown overlay (xem `aKWA2klsnt` và `5MU728Tjck`).
- Submit logic (xem `PV7jBVZU1N`).

---

## Phụ thuộc

- [x] Constitution document tồn tại (`.momorph/constitution.md`)
- [x] Spec màn hình gửi kudos (`.momorph/specs/PV7jBVZU1N-ios-sun-kudos-gui-loi-chuc/spec.md`)

---

## Ghi chú

- Đây là trạng thái (state variant) của cùng một màn hình `PV7jBVZU1N`, không phải màn hình riêng biệt.
- Khi implement, chỉ cần xử lý initial state của `SendKudosState` — không cần widget riêng.
- Trạng thái mặc định PHẢI là trạng thái đầu tiên khi `SendKudosViewModel.build()` được gọi.
- Height 812px (vừa 1 màn hình iPhone) cho thấy form không cần scroll ở trạng thái rỗng.
