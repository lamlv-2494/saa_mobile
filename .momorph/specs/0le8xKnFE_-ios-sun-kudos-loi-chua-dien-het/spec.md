# Đặc tả tính năng: [iOS] Sun*Kudos - Lỗi Chưa Điền Hết

**Frame ID**: `0le8xKnFE_`
**Frame Name**: `[iOS] Sun*Kudos_Lỗi chưa điền hết`
**File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Ngày tạo**: 2026-04-14
**Trạng thái**: Bản nháp

---

## Tổng quan

Màn hình **Lỗi chưa điền hết** là trạng thái validation error của form gửi kudos khi người dùng bấm "Gửi đi" mà chưa điền đầy đủ các trường bắt buộc. Hiển thị thông báo lỗi tổng quát ở đầu form và đánh dấu các trường thiếu bằng visual indicator (border đỏ, text lỗi).

**Đối tượng sử dụng**: Nhân viên Sun* (Sunner) đang soạn kudos nhưng chưa điền đủ thông tin.

**Bối cảnh kinh doanh**: Trạng thái lỗi giúp hướng dẫn người dùng điền đúng và đủ — tránh submit form không hợp lệ, đảm bảo chất lượng kudos.

**Màn hình chính (parent)**: `PV7jBVZU1N` — Gửi lời chúc Kudos

---

## Kịch bản người dùng & Kiểm thử *(bắt buộc)*

### User Story 1 - Hiển thị lỗi tổng quát khi submit form thiếu (Ưu tiên: P1)

Là một Sunner, tôi muốn biết rõ ràng tại sao form không gửi được để sửa lỗi nhanh chóng.

**Lý do ưu tiên**: Trải nghiệm lỗi tốt quyết định người dùng có tiếp tục gửi kudos hay bỏ cuộc.

**Kiểm thử độc lập**: Có thể test bằng cách bấm "Gửi đi" khi form rỗng.

**Kịch bản chấp nhận**:

1. **Cho biết** form chưa điền Người nhận, Nội dung, và Hashtag, **Khi** bấm nút "Gửi đi", **Thì** hiển thị thông báo lỗi tổng quát: "Bạn cần điền đủ Người nhận, Lời nhắn gửi và Hashtag để gửi Kudos!" (banner lỗi đỏ ở đầu form).
2. **Cho biết** thông báo lỗi đang hiển thị, **Khi** người dùng bắt đầu sửa form (điền bất kỳ trường nào), **Thì** thông báo lỗi tổng quát tự ẩn đi.
3. **Cho biết** chỉ thiếu Hashtag (đã điền Người nhận + Nội dung), **Khi** bấm "Gửi đi", **Thì** vẫn hiển thị thông báo lỗi và scroll đến section Hashtag.

---

### User Story 2 - Đánh dấu visual trường lỗi (Ưu tiên: P1)

Là một Sunner, tôi muốn thấy rõ trường nào cần sửa để sửa nhanh.

**Lý do ưu tiên**: Visual feedback giúp người dùng nhận biết lỗi ngay lập tức.

**Kiểm thử độc lập**: Verify border đỏ xuất hiện trên trường thiếu.

**Kịch bản chấp nhận**:

1. **Cho biết** trường "Người nhận" bị trống khi validate, **Khi** lỗi hiển thị, **Thì** input "Người nhận" có border đổi sang màu đỏ (#D4271D).
2. **Cho biết** trường Textarea nội dung bị trống, **Khi** lỗi hiển thị, **Thì** textarea có border đỏ.
3. **Cho biết** section Hashtag trống (0 tag), **Khi** lỗi hiển thị, **Thì** section Hashtag có indicator lỗi.
4. **Cho biết** người dùng sửa trường bị lỗi (ví dụ: chọn người nhận), **Khi** trường được điền, **Thì** border trường đó quay lại trạng thái bình thường (#998C5F).

---

### User Story 3 - Tự động scroll đến lỗi đầu tiên (Ưu tiên: P2)

Là một Sunner, tôi muốn form tự scroll đến trường lỗi đầu tiên để sửa ngay.

**Lý do ưu tiên**: Cải thiện UX nhưng không blocking.

**Kiểm thử độc lập**: Verify scroll position khi validate fail.

**Kịch bản chấp nhận**:

1. **Cho biết** form dài (đã scroll xuống dưới), **Khi** validate fail, **Thì** form tự scroll lên thông báo lỗi tổng quát hoặc trường lỗi đầu tiên.

---

### Trường hợp biên (Edge Cases)

- Tất cả trường bắt buộc đều trống → Hiển thị thông báo tổng quát + tất cả 4 trường (Người nhận, Danh hiệu, Nội dung, Hashtag) có border đỏ.
- Chỉ 1 trường thiếu → Hiển thị thông báo tổng quát nhưng chỉ trường đó có border đỏ.
- Người dùng bấm "Gửi đi" nhiều lần liên tiếp (vẫn lỗi) → Error banner hiển thị animation shake (translateX: 0→-5→5→0, 300ms), không tạo thêm banner mới.
- Danh hiệu rỗng khi submit → Border input Danh hiệu đổi sang đỏ (#D4271D).
- Nội dung chỉ có khoảng trắng → Coi như rỗng, hiển thị border đỏ.
- Người dùng chọn chính mình làm người nhận → Khi validate hiển thị lỗi riêng bên dưới input "Người nhận": "Bạn không thể gửi kudo cho chính mình."
- Sửa 1 trường (không phải tất cả) rồi submit lại → Error banner vẫn hiển thị, chỉ trường đã sửa hết border đỏ.

---

## Yêu cầu UI/UX *(từ Figma)*

### Thành phần màn hình

| Thành phần | Mô tả | Tương tác |
|-----------|-------|-----------|
| 1. Error Banner | Thông báo lỗi tổng quát: "Bạn cần điền đủ Người nhận, Lời nhắn gửi và Hashtag để gửi Kudos!" — banner nền đỏ ở đầu form | Tự ẩn khi người dùng sửa form |
| Các trường bị lỗi | Input/Section có border đổi sang đỏ (#D4271D) | Border quay lại bình thường khi sửa |

> Các thành phần form khác giống với `PV7jBVZU1N`. Xem [spec.md của PV7jBVZU1N](../PV7jBVZU1N-ios-sun-kudos-gui-loi-chuc/spec.md).

### Luồng điều hướng

- **Từ**: Bấm "Gửi đi" khi form chưa đầy đủ
- **Đến**: Giữ nguyên form — người dùng sửa lỗi rồi submit lại
- **Triggers**: Bấm nút "Gửi đi", sửa trường lỗi

### Yêu cầu hình ảnh

- Width: 375px, Height: 989px (dài hơn default do error banner thêm vào)
- Error banner nổi bật trên nền tối

### Accessibility (VoiceOver)

| Thành phần | Semantic Label | Trait |
|-----------|---------------|-------|
| Error Banner | "Lỗi. Bạn cần điền đủ Người nhận, Lời nhắn gửi và Hashtag để gửi Kudos" | StaticText, Error |
| Input lỗi | "{Label}. Lỗi. {Thông báo lỗi}" | TextField, Error |

> Chi tiết visual specs xem tại [design-style.md](design-style.md)

---

## Yêu cầu *(bắt buộc)*

### Yêu cầu chức năng

- **FR-001**: Khi validate fail, hệ thống PHẢI hiển thị thông báo lỗi tổng quát: "Bạn cần điền đủ Người nhận, Lời nhắn gửi và Hashtag để gửi Kudos!"
- **FR-002**: Các trường bắt buộc bị trống PHẢI có border đổi sang màu đỏ (#D4271D): Người nhận, Danh hiệu, Nội dung, Hashtag.
- **FR-003**: Thông báo lỗi tổng quát PHẢI tự ẩn khi người dùng bắt đầu sửa bất kỳ trường nào.
- **FR-004**: Khi trường lỗi được sửa (có giá trị hợp lệ), border trường đó PHẢI quay lại bình thường (#998C5F) ngay lập tức.
- **FR-005**: Form PHẢI tự scroll đến error banner hoặc trường lỗi đầu tiên trong vòng 300ms.
- **FR-006**: Nút "Gửi đi" KHÔNG bị disable khi có lỗi — cho phép submit lại sau khi sửa.
- **FR-007**: Hệ thống PHẢI hỗ trợ đa ngôn ngữ (VN/EN) cho thông báo lỗi.
- **FR-008**: Bấm "Gửi đi" nhiều lần liên tiếp khi vẫn lỗi → Error banner shake animation, KHÔNG tạo banner mới.

### Quy tắc validation chi tiết

| Trường | Quy tắc | Thông báo lỗi (field-level) |
|--------|---------|----------------------------|
| Người nhận (recipientId) | Không được null | Border đỏ (không có text lỗi riêng) |
| Người nhận (self-send) | recipientId != currentUserId | "Bạn không thể gửi kudo cho chính mình." |
| Danh hiệu (title) | Không rỗng, không chỉ whitespace, max 100 ký tự | Border đỏ (không có text lỗi riêng) |
| Nội dung (message) | Không rỗng, không chỉ whitespace, max 1000 ký tự | Border đỏ (không có text lỗi riêng) |
| Hashtag (hashtags) | Ít nhất 1, tối đa 5 | Border đỏ trên nút "+ Hashtag" |

### Yêu cầu kỹ thuật

- **TR-001**: Validation logic nằm trong `SendKudosViewModel` — không validate ở UI layer.
- **TR-002**: Error state lưu trong `SendKudosState.validationErrors`.
- **TR-003**: Thông báo lỗi PHẢI sử dụng i18n (slang), không hardcode.
- **TR-004**: Asset paths PHẢI sử dụng `flutter_gen`.

### Thực thể chính

- **ValidationError**: field (String), message (String) — lỗi theo từng trường

---

## Phụ thuộc API

> Không có API call riêng — validation chạy local trên client.

---

## Tiêu chí thành công *(bắt buộc)*

### Kết quả đo lường

- **SC-001**: Thông báo lỗi hiển thị trong vòng 100ms sau khi bấm "Gửi đi".
- **SC-002**: Auto-scroll đến lỗi đầu tiên hoàn thành trong 300ms.
- **SC-003**: Hỗ trợ hiển thị đúng cả 2 ngôn ngữ VN và EN.
- **SC-004**: 100% trường bắt buộc bị trống PHẢI được đánh dấu lỗi visual.

---

## Ngoài phạm vi

- Server-side validation errors (network error, duplicate, etc.).
- Inline validation real-time (validate khi typing — chỉ validate khi submit).

---

## Phụ thuộc

- [x] Constitution document tồn tại (`.momorph/constitution.md`)
- [x] Spec màn hình gửi kudos (`.momorph/specs/PV7jBVZU1N-ios-sun-kudos-gui-loi-chuc/spec.md`)

---

## Ghi chú

- Đây là trạng thái (validation error state) của cùng màn hình `PV7jBVZU1N`, không phải màn hình riêng.
- Text lỗi tổng quát từ Figma: "Bạn cần điền đủ Người nhận, Lời nhắn gửi và Hashtag để gửi Kudos!"
- Error banner nổi bật bằng nền đỏ/border đỏ trên nền tối — rất dễ nhận biết.
- Height 989px (dài hơn 941px bình thường) vì error banner thêm vào đầu form.
- Validation chạy local, không gọi API — phản hồi tức thì.
