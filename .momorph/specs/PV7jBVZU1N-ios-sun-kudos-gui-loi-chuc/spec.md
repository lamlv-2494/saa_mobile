# Đặc tả tính năng: [iOS] Sun*Kudos - Gửi lời chúc Kudos

**Frame ID**: `PV7jBVZU1N`
**Frame Name**: `[iOS] Sun*Kudos_Gửi lời chúc Kudos`
**File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Ngày tạo**: 2026-04-14
**Trạng thái**: Bản nháp

---

## Tổng quan

Màn hình **Gửi lời chúc Kudos** là form tạo và gửi kudos mới trong hệ thống Sun* Annual Awards 2025. Đây là màn hình chính của luồng gửi kudos, cho phép Sunner soạn lời cảm ơn/ghi nhận đến đồng nghiệp với đầy đủ thông tin: người nhận, danh hiệu, nội dung (rich text), hashtag, hình ảnh đính kèm, và tùy chọn gửi ẩn danh.

**Đối tượng sử dụng**: Nhân viên Sun* (Sunner) đã đăng nhập vào ứng dụng.

**Bối cảnh kinh doanh**: Đây là action chính (primary CTA) của hệ thống Kudos — form gửi lời ghi nhận đến đồng nghiệp, là trái tim của chương trình Sun* Annual Awards 2025.

**Màn hình liên quan**:
- Trạng thái mặc định (chưa điền): `7fFAb-K35a`
- Dropdown hashtag: `aKWA2klsnt`
- Dropdown tên người nhận: `5MU728Tjck`
- Trạng thái lỗi validation: `0le8xKnFE_`

---

## Kịch bản người dùng & Kiểm thử *(bắt buộc)*

### User Story 1 - Điền thông tin và gửi Kudos (Ưu tiên: P1)

Là một Sunner, tôi muốn gửi lời cảm ơn/ghi nhận đến đồng nghiệp bằng cách điền đầy đủ thông tin form kudos.

**Lý do ưu tiên**: Đây là core flow duy nhất của màn hình — nếu không gửi được kudos thì toàn bộ tính năng mất ý nghĩa.

**Kiểm thử độc lập**: Có thể test bằng cách điền form với dữ liệu mock và verify submit thành công.

**Kịch bản chấp nhận**:

1. **Cho biết** người dùng mở màn hình gửi kudos, **Khi** màn hình hiển thị, **Thì** hiển thị form rỗng với header "Gửi lời cám ơn và ghi nhận đến đồng đội", các trường: Người nhận *, Danh hiệu *, Nội dung (rich text editor), Hashtag *, Image (tùy chọn), và checkbox gửi ẩn danh.
2. **Cho biết** người dùng đã điền đầy đủ Người nhận, Danh hiệu, Nội dung, và ít nhất 1 Hashtag, **Khi** bấm nút "Gửi đi", **Thì** hệ thống validate form → disable nút "Gửi đi" (chống bấm trùng) → hiển thị loading spinner trên nút → submit dữ liệu → điều hướng sang màn hình thành công.
3. **Cho biết** form đang được submit (isSubmitting = true), **Khi** người dùng bấm nút "Gửi đi" lần nữa, **Thì** không thực hiện submit lại (chống duplicate submit).
4. **Cho biết** form đang được submit, **Khi** server trả về lỗi, **Thì** hiển thị snackbar thông báo lỗi, enable lại nút "Gửi đi", và giữ nguyên form để người dùng thử lại.
5. **Cho biết** form gửi thành công, **Khi** điều hướng sang màn hình thành công, **Thì** refresh danh sách kudos ở màn hình chính (screenId: `fO0Kt19sZZ`).

---

### User Story 2 - Chọn người nhận Kudos (Ưu tiên: P1)

Là một Sunner, tôi muốn tìm kiếm và chọn đồng nghiệp làm người nhận kudos.

**Lý do ưu tiên**: Bắt buộc — không thể gửi kudos mà không có người nhận.

**Kiểm thử độc lập**: Có thể test bằng cách bấm dropdown người nhận và verify danh sách hiển thị.

**Kịch bản chấp nhận**:

1. **Cho biết** trường "Người nhận" đang rỗng, **Khi** bấm vào input "Tìm kiếm", **Thì** mở dropdown danh sách người nhận (screenId: `5MU728Tjck`) với khả năng tìm kiếm theo tên hoặc đơn vị. Tìm kiếm PHẢI có debounce 300ms.
2. **Cho biết** dropdown đang mở, **Khi** chọn một người từ danh sách, **Thì** đóng dropdown và hiển thị tên người nhận đã chọn trong trường.
3. **Cho biết** đã chọn người nhận, **Khi** bấm lại input "Người nhận", **Thì** mở dropdown với tên đã chọn hiển thị, cho phép xóa và tìm lại.
4. **Cho biết** người dùng chọn chính mình làm người nhận, **Khi** submit form, **Thì** hiển thị lỗi "Bạn không thể gửi kudo cho chính mình."

---

### User Story 3 - Soạn nội dung Rich Text (Ưu tiên: P1)

Là một Sunner, tôi muốn viết nội dung kudos với các định dạng text phong phú để thể hiện lời cảm ơn một cách trọn vẹn.

**Lý do ưu tiên**: Nội dung là phần quan trọng nhất của kudos — rich text giúp thể hiện cảm xúc tốt hơn.

**Kiểm thử độc lập**: Có thể test bằng cách nhập text và sử dụng toolbar formatting.

**Kịch bản chấp nhận**:

1. **Cho biết** người dùng focus vào text area, **Khi** gõ text, **Thì** hiển thị nội dung và toolbar formatting phía trên với các nút: Bold (B), Italic (I), Strikethrough (S), Numbered list, Link, Quote.
2. **Cho biết** người dùng chọn text, **Khi** bấm nút Bold trên toolbar, **Thì** text được áp dụng định dạng bold và nút Bold chuyển sang trạng thái active.
3. **Cho biết** người dùng gõ "@" trong text area, **Khi** gõ thêm tên, **Thì** hiển thị gợi ý danh sách đồng nghiệp để mention.
4. **Cho biết** nội dung vượt quá 1000 ký tự, **Khi** người dùng tiếp tục gõ, **Thì** hiển thị lỗi "Đã đạt giới hạn ký tự. Vui lòng rút ngắn nội dung."

---

### User Story 4 - Thêm Hashtag (Ưu tiên: P1)

Là một Sunner, tôi muốn thêm hashtag vào kudos để phân loại và dễ tìm kiếm.

**Lý do ưu tiên**: Hashtag là trường bắt buộc và giúp phân loại kudos trong hệ thống.

**Kiểm thử độc lập**: Có thể test bằng cách bấm "+ Hashtag" và chọn/thêm hashtag.

**Kịch bản chấp nhận**:

1. **Cho biết** section Hashtag hiển thị, **Khi** bấm nút "+ Hashtag (Tối đa 5)", **Thì** mở dropdown/input để chọn hashtag (screenId: `aKWA2klsnt`).
2. **Cho biết** đã thêm 3 hashtag, **Khi** xem section, **Thì** hiển thị 3 chip/tag với nút "x" để xóa từng tag.
3. **Cho biết** đã có 5 hashtag, **Khi** thử thêm hashtag mới, **Thì** nút thêm bị disable/ẩn và hiển thị "Tối đa 5".
4. **Cho biết** không có hashtag nào khi submit, **Khi** bấm "Gửi đi", **Thì** hiển thị lỗi "Vui lòng thêm ít nhất một hashtag."

---

### User Story 5 - Đính kèm hình ảnh (Ưu tiên: P2)

Là một Sunner, tôi muốn đính kèm hình ảnh vào kudos để minh họa cho lời ghi nhận.

**Lý do ưu tiên**: Hình ảnh là tùy chọn, không bắt buộc cho core flow.

**Kiểm thử độc lập**: Có thể test bằng cách bấm "+ Image" và chọn ảnh.

**Kịch bản chấp nhận**:

1. **Cho biết** section Image hiển thị, **Khi** bấm nút "+ Image (Tối đa 5)", **Thì** mở file picker để chọn ảnh (chỉ hỗ trợ format: JPG, PNG, HEIC).
2. **Cho biết** đã chọn ảnh hợp lệ (dung lượng ≤ 5MB), **Khi** ảnh được upload, **Thì** hiển thị loading indicator trên thumbnail → upload lên Supabase Storage → hiển thị thumbnail preview với nút "x" để xóa.
3. **Cho biết** đã chọn ảnh quá lớn (> 5MB), **Khi** validate, **Thì** hiển thị snackbar lỗi "Ảnh quá lớn. Vui lòng chọn ảnh dưới 5MB." và không thêm ảnh.
4. **Cho biết** đã chọn file không phải ảnh, **Khi** validate, **Thì** hiển thị snackbar lỗi "Định dạng không hỗ trợ. Vui lòng chọn ảnh JPG, PNG hoặc HEIC."
5. **Cho biết** đã có 5 ảnh, **Khi** thử thêm ảnh, **Thì** nút "+ Image" bị ẩn.
6. **Cho biết** có ảnh đã thêm, **Khi** bấm "x" trên thumbnail, **Thì** xóa ảnh khỏi danh sách và xóa file trên Supabase Storage.
7. **Cho biết** đang upload ảnh, **Khi** mất kết nối mạng, **Thì** hiển thị snackbar lỗi "Upload thất bại. Vui lòng thử lại." và hiển thị retry icon trên thumbnail.

---

### User Story 6 - Gửi ẩn danh (Ưu tiên: P2)

Là một Sunner, tôi muốn gửi kudos ẩn danh để ghi nhận đồng nghiệp mà không tiết lộ danh tính.

**Lý do ưu tiên**: Tính năng bổ sung, không ảnh hưởng core flow.

**Kiểm thử độc lập**: Có thể test bằng cách toggle checkbox ẩn danh.

**Kịch bản chấp nhận**:

1. **Cho biết** checkbox "Gửi lời cám ơn và ghi nhận ẩn danh" hiển thị (mặc định: tắt), **Khi** bấm checkbox, **Thì** chuyển sang trạng thái bật (checked) — kudos sẽ được gửi ẩn danh.
2. **Cho biết** checkbox đang bật, **Khi** bấm lại, **Thì** chuyển về trạng thái tắt — tên người gửi sẽ hiển thị.

---

### User Story 7 - Hủy tạo Kudos (Ưu tiên: P2)

Là một Sunner, tôi muốn hủy form tạo kudos và quay lại màn hình trước.

**Lý do ưu tiên**: Cần thiết cho UX nhưng không phải core action.

**Kiểm thử độc lập**: Có thể test bằng cách bấm nút "Hủy".

**Kịch bản chấp nhận**:

1. **Cho biết** form trống (chưa điền gì), **Khi** bấm nút "Hủy" (icon X), **Thì** đóng form ngay lập tức và quay lại màn hình trước — không hiển thị dialog xác nhận.
2. **Cho biết** form đã có nội dung chưa lưu (bất kỳ trường nào đã thay đổi), **Khi** bấm "Hủy", **Thì** hiển thị dialog xác nhận: tiêu đề "Hủy tạo Kudos?", nội dung "Nội dung bạn đã nhập sẽ bị mất.", 2 nút: "Tiếp tục soạn" (secondary) và "Hủy bỏ" (primary).
3. **Cho biết** dialog xác nhận đang hiển thị, **Khi** bấm "Hủy bỏ", **Thì** đóng form và quay lại màn hình trước.
4. **Cho biết** dialog xác nhận đang hiển thị, **Khi** bấm "Tiếp tục soạn", **Thì** đóng dialog và giữ nguyên form.
5. **Cho biết** form đã có nội dung, **Khi** bấm nút Back hệ thống (swipe back trên iOS), **Thì** hiển thị dialog xác nhận giống khi bấm "Hủy".

---

### Trường hợp biên (Edge Cases)

- Form rỗng khi submit → Hiển thị thông báo lỗi validation (screenId: `0le8xKnFE_`): "Bạn cần điền đủ Người nhận, Lời nhắn gửi và Hashtag để gửi Kudos!"
- Mất kết nối mạng khi submit → Hiển thị snackbar lỗi mạng "Không thể gửi Kudos. Vui lòng kiểm tra kết nối mạng." + enable lại nút "Gửi đi".
- Danh hiệu vượt 100 ký tự → Input không cho nhập thêm (maxLength: 100) và hiển thị counter "100/100".
- Nội dung vượt 1000 ký tự → Input không cho nhập thêm (maxLength: 1000) và hiển thị lỗi "Đã đạt giới hạn ký tự. Vui lòng rút ngắn nội dung."
- Nội dung chỉ có khoảng trắng → Hiển thị lỗi "Nội dung không được để trống."
- Upload ảnh quá lớn (> 5MB) → Hiển thị snackbar lỗi "Ảnh quá lớn. Vui lòng chọn ảnh dưới 5MB." và không thêm ảnh.
- Upload ảnh sai format → Hiển thị snackbar lỗi "Định dạng không hỗ trợ. Vui lòng chọn ảnh JPG, PNG hoặc HEIC."
- Danh sách người nhận rỗng (không load được) → Dropdown hiển thị empty state "Không tìm thấy kết quả".
- Người dùng bấm Back (system) khi đang soạn → Cùng hành vi với nút "Hủy" (dialog xác nhận nếu có nội dung).
- Double-tap nút "Gửi đi" → Nút bị disable ngay sau lần bấm đầu tiên (chống duplicate submit).
- Server trả lỗi 429 (rate limit) → Hiển thị snackbar "Bạn đã gửi quá nhiều yêu cầu. Vui lòng thử lại sau."
- Server trả lỗi 500 → Hiển thị snackbar "Đã xảy ra lỗi. Vui lòng thử lại sau."
- Timeout khi submit (> 10 giây) → Hiển thị snackbar "Yêu cầu quá lâu. Vui lòng thử lại." + enable lại nút.

---

## Yêu cầu UI/UX *(từ Figma)*

### Thành phần màn hình

| Thành phần | Mô tả | Tương tác |
|-----------|-------|-----------|
| A. Header Text | Text "Gửi lời cám ơn và ghi nhận đến đồng đội" — mô tả mục đích form | Chỉ hiển thị |
| B.1. Label "Người nhận *" | Label bắt buộc cho trường người nhận | Chỉ hiển thị |
| B.2. Recipient Dropdown | Input dropdown "Tìm kiếm" với icon chevron down | Bấm → Mở dropdown danh sách người nhận (screenId: `5MU728Tjck`) |
| B.3. Label "Danh hiệu *" | Label bắt buộc cho trường danh hiệu | Chỉ hiển thị |
| B.4. Danh hiệu Input | Text input "Danh tặng một danh hiệu cho..." (max 100 ký tự) | Bấm → Focus input, hiển thị keyboard |
| B.5. Link "Tiêu chuẩn cộng đồng" | Text link dẫn tới trang tiêu chuẩn cộng đồng/giải thưởng | Bấm → Mở trang tiêu chuẩn cộng đồng |
| B.7. Label section nội dung | Label cho phần nhập nội dung | Chỉ hiển thị |
| B.8. Input ẩn danh | Input liên quan đến chế độ ẩn danh | Bấm → Toggle |
| C. Formatting Toolbar | Thanh công cụ định dạng: Bold, Italic, Strikethrough, Numbered List, Link, Quote | Bấm từng nút → Toggle formatting |
| C.1. Bold | Nút "B" — bật/tắt bold | Bấm → Toggle bold |
| C.2. Italic | Nút "I" — bật/tắt italic | Bấm → Toggle italic |
| C.3. Strikethrough | Nút gạch ngang — bật/tắt strikethrough | Bấm → Toggle strikethrough |
| C.4. Numbered List | Nút danh sách số — bật/tắt numbered list | Bấm → Toggle numbered list |
| C.5. Link | Nút link — chèn hyperlink | Bấm → Mở dialog nhập URL |
| C.6. Quote | Nút trích dẫn — bật/tắt blockquote | Bấm → Toggle blockquote |
| D. Message Textarea | Textarea chính để soạn nội dung kudos (rich text, max 1000 ký tự) | Bấm → Focus, hiển thị keyboard, hỗ trợ @mention |
| D.1. Hint Label | Text gợi ý: "Bạn có thể '@ + tên' để nhắc tới đồng nghiệp khác" | Chỉ hiển thị |
| E. Hashtag Section | Container cho phần hashtag | Layout container |
| E.1. Label "Hashtag *" | Label bắt buộc cho hashtag | Chỉ hiển thị |
| E.2. Tag Group | Khu vực hiển thị chips/tags + nút "+ Hashtag (Tối đa 5)" | Bấm "+" → Mở input/dropdown hashtag (screenId: `aKWA2klsnt`); Bấm "x" trên chip → Xóa tag |
| F. Image Section | Container cho phần đính kèm hình ảnh | Layout container |
| F.1. Label "Image" | Label cho phần hình ảnh | Chỉ hiển thị |
| F.2-F.5. Image Thumbnails | Thumbnail preview ảnh đã chọn (tối đa 5) với nút "x" xóa | Bấm "x" → Xóa ảnh |
| F.5. Add Image Button | Nút "+ Image (Tối đa 5)" — thêm ảnh mới | Bấm → Mở file picker |
| G. Anonymous Toggle | Checkbox "Gửi lời cám ơn và ghi nhận ẩn danh" (mặc định: tắt) | Bấm → Toggle on/off |
| H. Cancel Button | Nút "Hủy" (icon X) — hủy form | Bấm → Đóng form (có xác nhận nếu có nội dung) |
| I. Send Button | Nút "Gửi đi" (icon send, nền vàng/gold) — submit form | Bấm → Validate & Submit |

### Luồng điều hướng

- **Từ**: Màn hình chính Sun*Kudos (screenId: `fO0Kt19sZZ`) — bấm nút CTA "Hôm nay, bạn muốn gửi kudos đến ai?"
- **Đến**:
  - Dropdown người nhận (screenId: `5MU728Tjck`)
  - Dropdown hashtag (screenId: `aKWA2klsnt`)
  - Tiêu chuẩn cộng đồng (external/overlay)
  - Màn hình thành công (sau khi submit)
  - Quay lại màn hình trước (khi hủy)
- **Triggers**: Bấm input, bấm nút, bấm checkbox, bấm submit/cancel

### Yêu cầu hình ảnh

- Ứng dụng chỉ dành cho mobile (iOS) — width: 375px
- Animations/Transitions: Slide-in từ dưới khi mở form, fade-out khi đóng

### Accessibility (VoiceOver)

| Thành phần | Semantic Label | Trait |
|-----------|---------------|-------|
| B.2. Recipient Dropdown | "Chọn người nhận. {Tên đã chọn hoặc 'Chưa chọn'}" | Button |
| B.4. Danh hiệu Input | "Nhập danh hiệu. {Nội dung hiện tại}" | TextField |
| B.5. Link tiêu chuẩn | "Xem tiêu chuẩn cộng đồng" | Link |
| C.1-C.6. Toolbar buttons | "{Tên format}. {Đang bật / Đang tắt}" | Button, toggle |
| D. Message Textarea | "Nhập nội dung kudos. {Số ký tự}/1000" | TextField, multiline |
| E.2. Tag Group | "Hashtag. {Số tag hiện tại}/5" | Adjustable |
| F.5. Add Image | "Thêm hình ảnh. {Số ảnh}/5" | Button |
| G. Anonymous Toggle | "Gửi ẩn danh. {Đang bật / Đang tắt}" | Switch |
| H. Cancel Button | "Hủy tạo kudos" | Button |
| I. Send Button | "Gửi kudos" | Button |

> Chi tiết visual specs xem tại [design-style.md](design-style.md)

---

## Yêu cầu *(bắt buộc)*

### Yêu cầu chức năng

- **FR-001**: Form PHẢI có các trường bắt buộc: Người nhận, Danh hiệu (max 100 ký tự), Nội dung (max 1000 ký tự), Hashtag (1-5 tags).
- **FR-002**: Form PHẢI hỗ trợ rich text editing với toolbar: Bold, Italic, Strikethrough, Numbered List, Link, Quote.
- **FR-003**: Nội dung PHẢI hỗ trợ @mention đồng nghiệp bằng cách gõ "@ + tên".
- **FR-004**: Hashtag PHẢI cho phép thêm 1-5 tags, hiển thị dạng chip với nút xóa.
- **FR-005**: Hình ảnh đính kèm PHẢI cho phép tối đa 5 ảnh (mỗi ảnh ≤ 5MB, format: JPG/PNG/HEIC), hiển thị thumbnail preview.
- **FR-006**: Checkbox ẩn danh PHẢI toggle giữa gửi công khai và ẩn danh (mặc định: tắt).
- **FR-007**: Nút "Gửi đi" PHẢI validate tất cả trường bắt buộc trước khi submit.
- **FR-008**: Nút "Hủy" PHẢI hiển thị dialog xác nhận nếu form có nội dung chưa lưu. Form trống thì đóng ngay.
- **FR-009**: Hệ thống PHẢI hiển thị thông báo lỗi rõ ràng khi validation fail (screenId: `0le8xKnFE_`).
- **FR-010**: Hệ thống PHẢI hỗ trợ đa ngôn ngữ (VN/EN) cho tất cả text, label, placeholder, và thông báo lỗi.
- **FR-011**: Hệ thống PHẢI chống duplicate submit — nút "Gửi đi" bị disable và hiển thị loading spinner khi đang submit.
- **FR-012**: KHÔNG cho phép chọn chính mình làm người nhận — hiển thị lỗi khi validate.
- **FR-013**: Tìm kiếm người nhận PHẢI có debounce 300ms để tránh gọi API quá nhiều.
- **FR-014**: Nút Back hệ thống (swipe back) PHẢI có cùng hành vi với nút "Hủy".

### Yêu cầu kỹ thuật

- **TR-001**: Kiến trúc PHẢI tuân theo MVVM pattern — form state quản lý trong `SendKudosViewModel extends AsyncNotifier<SendKudosState>`.
- **TR-002**: Asset paths PHẢI sử dụng `flutter_gen` (`Assets.xxx`), không hardcode string.
- **TR-003**: Tất cả text hiển thị PHẢI sử dụng i18n (slang), không hardcode string.
- **TR-004**: Rich text editor PHẢI lưu nội dung dạng formatted text (markdown hoặc HTML).
- **TR-005**: Upload ảnh PHẢI sử dụng Supabase Storage.
- **TR-006**: Icons PHẢI sử dụng format SVG.

### Thực thể chính

- **SendKudosForm**: recipientId, title, message (rich text), hashtags (List<String>), imageIds (List<String>), isAnonymous (bool)
- **User (Sunner)**: id, name, avatar, department — dùng cho dropdown người nhận
- **Hashtag**: id, name — dùng cho dropdown hashtag

---

## Quản lý trạng thái (State Management)

### State Model (SendKudosState — freezed)

```
SendKudosState:
  - recipientId: String?               # ID người nhận đã chọn
  - recipientName: String?             # Tên người nhận (hiển thị)
  - recipientAvatar: String?           # Avatar URL người nhận (hiển thị)
  - title: String                      # Danh hiệu (max 100 ký tự)
  - message: String                    # Nội dung rich text (max 1000 ký tự)
  - hashtags: List<Hashtag>            # Danh sách hashtag đã chọn (min 1, max 5)
  - imageIds: List<String>             # Danh sách ID ảnh đã upload (max 5)
  - imagePreviews: List<String>        # Danh sách URL preview ảnh
  - imageUploadingIndex: int?          # Index ảnh đang upload (null = không upload)
  - isAnonymous: bool                  # Gửi ẩn danh (default: false)
  - isSubmitting: bool                 # Đang submit (chống duplicate)
  - isDirty: bool                      # Form đã thay đổi (dùng cho dialog xác nhận hủy)
  - availableHashtags: List<Hashtag>   # Danh sách hashtag có sẵn (pre-loaded)
  - searchResults: List<UserSummary>   # Kết quả tìm kiếm người nhận
  - isSearching: bool                  # Đang tìm kiếm người nhận
  - validationErrors: Map<String, String>  # Lỗi validation theo field
  - showErrorBanner: bool              # Hiển thị error banner tổng quát
```

### Local State (không thuộc ViewModel)

- **TextEditingController** cho title input và message textarea.
- **FocusNode** cho từng input field.
- **ScrollController** cho form scrolling.

### Trạng thái Loading/Error

| Thành phần | Loading | Error | Empty |
|-----------|---------|-------|-------|
| Recipient Dropdown | Shimmer placeholder | "Không thể tải danh sách" | "Không tìm thấy kết quả" |
| Hashtag Dropdown | Shimmer placeholder | "Không thể tải hashtag" | "Không tìm thấy hashtag" |
| Submit | Loading spinner trên nút "Gửi đi" | Snackbar lỗi | N/A |
| Image Upload | Loading indicator trên thumbnail | Snackbar lỗi upload | N/A |

---

## Phụ thuộc API

| Endpoint | Method | Mục đích | Trạng thái |
|----------|--------|----------|------------|
| `/api/v1/kudos` | POST | Gửi kudos mới | Dự đoán |
| `/api/v1/users/search` | GET | Tìm kiếm người nhận (query: name, department) | Dự đoán |
| `/api/v1/hashtags` | GET | Lấy danh sách hashtag có sẵn | Dự đoán |
| `/api/v1/storage/upload` | POST | Upload ảnh đính kèm | Dự đoán |

---

## Tiêu chí thành công *(bắt buộc)*

### Kết quả đo lường

- **SC-001**: Thời gian submit kudos (từ bấm "Gửi đi" đến confirmation) dưới 3 giây.
- **SC-002**: Tỷ lệ gửi kudos thành công (không bị lỗi validation) >= 90%.
- **SC-003**: Hỗ trợ hiển thị đúng cả 2 ngôn ngữ VN và EN.
- **SC-004**: Tất cả trường validation hoạt động chính xác với thông báo lỗi rõ ràng.

---

## Ngoài phạm vi

- Chỉnh sửa kudos đã gửi (flow riêng).
- Preview kudos trước khi gửi (không có trong design).
- Draft/lưu nháp kudos (không có trong design).
- Scheduled send (gửi theo lịch).
- Đính kèm file khác ngoài hình ảnh (video, document).

---

## Phụ thuộc

- [x] Constitution document tồn tại (`.momorph/constitution.md`)
- [x] Spec màn hình chính Kudos (`.momorph/specs/fO0Kt19sZZ-ios-sun-kudos/spec.md`)
- [ ] API specifications (`.momorph/contexts/api-docs.yaml`)
- [ ] Database design (`.momorph/database.sql`)

---

## Ghi chú

- Tất cả text PHẢI hỗ trợ đa ngôn ngữ VN/EN thông qua hệ thống i18n (slang).
- Form sử dụng cùng dark theme (#00101A) với màn hình chính Kudos.
- Nút "Gửi đi" có nền vàng/gold (#FFEA9E) — primary action.
- Nút "Hủy" có nền tối — secondary action.
- Toolbar formatting nằm ngay trên textarea, luôn hiển thị khi textarea được focus.
- Hint label "@mention" luôn hiển thị bên dưới textarea.
- Danh hiệu có link "Tiêu chuẩn cộng đồng" bên dưới input để hướng dẫn người dùng.
