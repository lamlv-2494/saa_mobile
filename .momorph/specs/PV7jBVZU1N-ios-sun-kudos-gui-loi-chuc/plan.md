# Kế hoạch triển khai: [iOS] Sun*Kudos — Gửi lời chúc Kudos

**Frame**: `PV7jBVZU1N-ios-sun-kudos-gui-loi-chuc`
**Ngày**: 2026-04-15
**Spec**: `specs/PV7jBVZU1N-ios-sun-kudos-gui-loi-chuc/spec.md`

**Specs liên quan**:
- `7fFAb-K35a` — Trạng thái mặc định (default empty state)
- `aKWA2klsnt` — Dropdown hashtag (multi-select, max 5)
- `5MU728Tjck` — Dropdown người nhận (search + debounce)
- `0le8xKnFE_` — Trạng thái lỗi validation

---

## Tóm tắt

Triển khai màn hình **Gửi lời chúc Kudos** — form tạo kudos mới với các thành phần: chọn người nhận (search dropdown), danh hiệu, nội dung rich text (toolbar formatting), hashtag (multi-select max 5), hình ảnh đính kèm (max 5, ≤5MB), toggle ẩn danh, và validation error state. Đây là route mới được push từ CTA button trên Kudos feed (`fO0Kt19sZZ`). Sau khi gửi thành công → pop back và refresh feed.

---

## Bối cảnh kỹ thuật

**Framework**: Flutter 3.41.3 / Dart ^3.11.1
**Phụ thuộc chính**: flutter_riverpod, go_router, supabase_flutter, freezed, google_fonts, flutter_svg, flutter_gen, slang
**Backend**: Supabase (PostgREST + Storage)
**Testing**: flutter_test + mocktail (TDD bắt buộc)
**State Management**: Riverpod — AsyncNotifier pattern (1 ViewModel per feature)
**Rich Text Editor**: Cần thêm package `flutter_quill` (justification: spec yêu cầu bold/italic/strikethrough/numbered list/link/quote — quá phức tạp để tự implement)

---

## Kiểm tra tuân thủ Constitution

| Yêu cầu | Quy tắc Constitution | Trạng thái |
|----------|----------------------|-----------|
| MVVM + Riverpod | 1 ViewModel (`SendKudosViewModel extends AsyncNotifier<SendKudosState>`) | ✅ Tuân thủ |
| Feature-based module | Thêm vào `lib/features/kudos/` (dùng chung feature, subfolder riêng cho send) | ✅ Tuân thủ |
| Freezed models | `SendKudosState` dùng freezed | ✅ Tuân thủ |
| Widget con = StatelessWidget | Screen dùng ConsumerWidget, widget con StatelessWidget | ✅ Tuân thủ |
| SVG icons, PNG images | Icons → `assets/icons/`, backgrounds → `assets/images/` | ✅ Tuân thủ |
| flutter_gen (Assets.xxx) | Không hardcode path | ✅ Tuân thủ |
| i18n (slang) VN/EN | Tất cả text qua `context.t.sendKudos.*` | ✅ Tuân thủ |
| TDD | Viết test trước → implement → refactor | ✅ Tuân thủ |
| Repository pattern | Tái sử dụng `KudosRepository` + thêm methods mới | ✅ Tuân thủ |

**Vi phạm**: Không có.

---

## Quyết định kiến trúc

### Frontend

- **Tổ chức code**: Đặt trong `lib/features/kudos/` — tái sử dụng data layer hiện tại, thêm `send_kudos/` subfolder cho presentation layer riêng (ViewModel + Screen + Widgets)
- **Route**: Thêm `/send-kudos` vào `router.dart` — `context.push('/send-kudos')` từ CTA button
- **Form architecture**: `SingleChildScrollView` + `Column` — form không dùng `CustomScrollView` vì không cần sliver
- **Rich text**: `flutter_quill` cho toolbar formatting (Bold/Italic/Strikethrough/Numbered List/Link/Quote). Lưu nội dung dạng Delta JSON, convert sang plain text + formatting khi submit
- **Dropdowns**: Dùng `showModalBottomSheet` — cả recipient search và hashtag dropdown đều là overlay, không phải route mới
- **Recipient search**: `TextField` + `Timer` debounce 300ms + minimum 2 ký tự → gọi API search
- **Image picker**: Dùng `image_picker` package (cần thêm) — chọn từ gallery, validate format (JPG/PNG/HEIC) + size (≤5MB), upload lên Supabase Storage
- **Validation**: Logic nằm hoàn toàn trong `SendKudosViewModel` — UI chỉ đọc `validationErrors` từ state
- **Anti-duplicate submit**: `isSubmitting` flag trong state → disable nút + hiển thị loading spinner
- **Cancel flow**: Kiểm tra `isDirty` → nếu true hiển thị `showDialog` xác nhận, nếu false pop ngay
- **WillPopScope / PopScope**: Bắt swipe back iOS → cùng logic với nút Hủy

### Backend Integration

- **Tái sử dụng**: `KudosRemoteDatasource` + `KudosRepository` đã có
- **API mới cần thêm vào datasource/repository**:
  - `POST kudos` — tạo kudos mới (insert vào bảng `kudos` + `kudos_hashtags` + `kudos_photos`)
  - `GET users/search` — tìm kiếm user theo tên/đơn vị (PostgREST: `users.select().ilike('name', '%query%')`)
  - `POST supabase.storage.upload` — upload ảnh lên bucket `kudos-photos`
- **API tái sử dụng**:
  - `GET hashtags` — đã có `fetchHashtags()` trong datasource
- **Supabase Storage**: Bucket `kudos-photos` — cần tạo bucket + RLS policy cho authenticated upload/delete

### Tích hợp hiện tại

- **`router.dart`**: Thêm route `/send-kudos` → `SendKudosScreen()`
- **`KudosViewModel`**: Thêm method `refresh()` — đã có, sẽ được gọi sau khi pop back từ send thành công
- **`KudosRemoteDatasource`**: Thêm 3 methods mới (`createKudos`, `searchUsers`, `uploadImage`, `deleteImage`)
- **`KudosRepository`**: Thêm 3 methods mới tương ứng
- **Models tái sử dụng**: `Hashtag`, `UserSummary` — đã có, không cần tạo mới
- **i18n**: Thêm section `sendKudos` vào `strings_vi.i18n.json` + `strings_en.i18n.json`
- **`AppColors`**: Thêm `errorRed` (#D4271D) nếu chưa có, `sendButtonDisabledBg` (rgba(255,234,158,0.40)), `sendButtonDisabledText` (rgba(0,16,26,0.50))

---

## Cấu trúc Project

### Tài liệu

```text
.momorph/specs/PV7jBVZU1N-ios-sun-kudos-gui-loi-chuc/
├── spec.md              # Đặc tả tính năng ✅
├── design-style.md      # Đặc tả thiết kế ✅
├── plan.md              # File này ✅
└── tasks.md             # Phân chia task (bước tiếp theo)
```

### Source Code (ảnh hưởng)

```text
lib/
├── app/
│   ├── router.dart                         # SỬA: thêm route /send-kudos
│   └── theme/
│       └── app_colors.dart                 # SỬA: thêm errorRed, sendButtonDisabled colors
│
├── features/
│   └── kudos/
│       ├── data/
│       │   ├── models/
│       │   │   ├── send_kudos_state.dart            # MỚI: SendKudosState (freezed)
│       │   │   ├── hashtag.dart                     # CÓ SẴN ✅
│       │   │   └── user_summary.dart                # CÓ SẴN ✅
│       │   ├── datasources/
│       │   │   └── kudos_remote_datasource.dart     # SỬA: thêm createKudos, searchUsers, uploadImage, deleteImage
│       │   └── repositories/
│       │       └── kudos_repository.dart             # SỬA: thêm methods tương ứng
│       │
│       └── presentation/
│           ├── viewmodels/
│           │   └── send_kudos_viewmodel.dart         # MỚI: AsyncNotifier<SendKudosState>
│           ├── screens/
│           │   └── send_kudos_screen.dart             # MỚI: Form screen (ConsumerWidget)
│           └── widgets/
│               ├── send_kudos_form_widget.dart         # MỚI: Body form chính
│               ├── recipient_dropdown_widget.dart      # MỚI: Bottom sheet search người nhận
│               ├── recipient_search_item.dart          # MỚI: Item kết quả (avatar + tên + đơn vị)
│               ├── hashtag_dropdown_widget.dart         # MỚI: Bottom sheet multi-select hashtag
│               ├── hashtag_chip_group_widget.dart       # MỚI: Hiển thị chips đã chọn + nút "+"
│               ├── image_attachment_widget.dart         # MỚI: Grid thumbnail + nút thêm ảnh
│               ├── rich_text_editor_widget.dart         # MỚI: Quill editor + toolbar
│               ├── formatting_toolbar_widget.dart       # MỚI: 6 nút formatting (B/I/S/OL/Link/Quote)
│               ├── error_banner_widget.dart             # MỚI: Banner lỗi validation (đỏ, shake animation)
│               ├── send_kudos_button_widget.dart        # MỚI: Nút "Gửi đi" (enabled/disabled/loading)
│               └── cancel_confirmation_dialog.dart      # MỚI: Dialog xác nhận hủy
│
├── i18n/
│   ├── strings_vi.i18n.json                # SỬA: thêm sendKudos section (~50 strings)
│   └── strings_en.i18n.json                # SỬA: thêm sendKudos section (~50 strings)
│
└── gen/                                    # Auto-generated (flutter_gen)

assets/
├── icons/
│   ├── ic_bold.svg                         # MỚI (nếu chưa có)
│   ├── ic_italic.svg                       # MỚI (nếu chưa có)
│   ├── ic_strikethrough.svg                # MỚI (nếu chưa có)
│   ├── ic_numbered_list.svg                # MỚI (nếu chưa có)
│   ├── ic_link_insert.svg                  # MỚI (nếu chưa có)
│   ├── ic_quote.svg                        # MỚI (nếu chưa có)
│   ├── ic_close.svg                        # MỚI (nếu chưa có — nút Hủy)
│   ├── ic_send.svg                         # MỚI (nếu chưa có — nút Gửi đi)
│   ├── ic_camera.svg                       # MỚI (nếu chưa có — nút thêm ảnh)
│   └── ic_chevron_down.svg                 # MỚI (nếu chưa có — dropdown indicator)
└── images/
    # Không cần thêm images cho send screen

test/
├── unit/
│   ├── viewmodels/
│   │   └── send_kudos_viewmodel_test.dart       # MỚI
│   ├── repositories/
│   │   └── send_kudos_repository_test.dart      # MỚI (test methods mới trong KudosRepository)
│   └── models/
│       └── send_kudos_state_test.dart            # MỚI
├── widget/
│   └── kudos/
│       ├── send_kudos_screen_test.dart           # MỚI
│       ├── recipient_dropdown_test.dart          # MỚI
│       ├── hashtag_dropdown_test.dart            # MỚI
│       ├── image_attachment_test.dart            # MỚI
│       ├── error_banner_test.dart                # MỚI
│       ├── rich_text_editor_test.dart            # MỚI
│       └── send_kudos_button_test.dart           # MỚI
└── helpers/
    └── send_kudos_test_helpers.dart              # MỚI: Mock data, fakes
```

### Dependencies mới

| Package | Justification | Phiên bản |
|---------|--------------|-----------|
| `flutter_quill` | Rich text editor với toolbar (Bold/Italic/Strikethrough/OL/Link/Quote) — spec yêu cầu 6 formatting options, quá phức tạp để tự implement | latest stable |
| `image_picker` | Chọn ảnh từ gallery — Flutter standard, không có giải pháp native đơn giản hơn | latest stable |
| `url_launcher` | Mở link "Tiêu chuẩn cộng đồng" (external URL) từ form — Phase 5 navigation | latest stable |

---

## Chiến lược triển khai

### Phase 0: Chuẩn bị (Assets, Theme, i18n, Route, Dependencies, Supabase)

- Thêm `flutter_quill`, `image_picker`, và `url_launcher` vào `pubspec.yaml`
- Download SVG icons cho toolbar formatting và form buttons vào `assets/icons/`
- Chạy `dart run build_runner build` để generate flutter_gen assets
- Bổ sung colors mới vào `AppColors`:
  - `errorRed` = `#D4271D` — border lỗi validation
  - `sendButtonDisabledBg` = `rgba(255,234,158,0.40)` — nút gửi disabled
  - `sendButtonDisabledText` = `rgba(0,16,26,0.50)` — text nút gửi disabled
  - `errorBannerBg` = màu nền banner lỗi (từ design-style)
- Thêm route `/send-kudos` → `SendKudosScreen()` trong `router.dart`
- Thêm i18n strings cho section `sendKudos` (VN + EN, ~50 strings):
  - Labels: "Người nhận", "Danh hiệu", "Hashtag", "Image"
  - Placeholders: "Tìm kiếm", "Danh tặng một danh hiệu cho...", textarea hint
  - Buttons: "Gửi đi", "Hủy", "+ Hashtag (Tối đa 5)", "+ Image (Tối đa 5)"
  - Errors: validation messages, network errors, upload errors
  - Dialog: "Hủy tạo Kudos?", "Nội dung bạn đã nhập sẽ bị mất.", "Tiếp tục soạn", "Hủy bỏ"

#### Supabase Mock Data & Storage (BẮT BUỘC)

> **Quy tắc**: KHÔNG ĐƯỢC dùng `supabase db reset`. Chỉ APPEND vào `supabase/seed.sql` với `ON CONFLICT DO NOTHING`.
> Chạy seed: `psql -h localhost -p 54322 -U postgres -d postgres -f supabase/seed.sql`

- **Tạo Storage bucket** — APPEND vào cuối `supabase/seed.sql`:
  ```sql
  -- ==========================================
  -- STORAGE BUCKET: kudos-photos
  -- ==========================================
  INSERT INTO storage.buckets (id, name, public)
  VALUES ('kudos-photos', 'kudos-photos', true)
  ON CONFLICT (id) DO NOTHING;
  ```
- **RLS policy**: Thêm policy cho authenticated users upload/delete own files (append vào seed.sql)
- **Dữ liệu seed hiện tại**: Đã có 15 users, 10 hashtags, 48 kudos — đủ cho test search recipients và chọn hashtag. KHÔNG cần thêm seed data mới cho users/hashtags
- **Kiểm tra**: Sau khi chạy seed, verify bucket tồn tại:
  ```sql
  SELECT id, name, public FROM storage.buckets WHERE id = 'kudos-photos';
  ```

### Phase 1: Data Layer (Models + API + Repository)

**Ưu tiên**: Xây dựng nền data layer trước.

1. **Model (freezed)**: `SendKudosState`
   ```
   SendKudosState:
     - recipientId: String?
     - recipientName: String?
     - recipientAvatar: String?
     - title: String (default: '')
     - message: String (default: '')
     - hashtags: List<Hashtag> (default: [])
     - imageIds: List<String> (default: [])
     - imagePreviews: List<String> (default: [])
     - imageUploadingIndex: int? (default: null)
     - isAnonymous: bool (default: false)
     - isSubmitting: bool (default: false)
     - isDirty: bool (default: false)
     - availableHashtags: List<Hashtag> (default: [])
     - searchResults: List<UserSummary> (default: [])
     - isSearching: bool (default: false)
     - validationErrors: Map<String, String> (default: {})
     - showErrorBanner: bool (default: false)
   ```

2. **Datasource** (thêm vào `KudosRemoteDatasource`):
   - `searchUsers(String query)` — `users.select('id, name, avatar_url, hero_tier_url, department:departments(name)').ilike('name', '%$query%').limit(20)`
   - `createKudos({recipientId, title, message, hashtagIds, imageUrls, isAnonymous})` — insert vào `kudos` + `kudos_hashtags` + `kudos_photos`
   - `uploadKudosImage(String filePath)` — upload lên bucket `kudos-photos`, return public URL
   - `deleteKudosImage(String imageUrl)` — xóa file từ bucket

3. **Repository** (thêm vào `KudosRepository`):
   - `searchUsers(String query)` — error handling + mapping
   - `createKudos(...)` — error handling + validation
   - `uploadImage(String filePath)` — error handling + return URL
   - `deleteImage(String imageUrl)` — error handling

4. **ViewModel**: `SendKudosViewModel extends AsyncNotifier<SendKudosState>`
   - `build()` — load `availableHashtags` từ repository (pre-load)
   - `selectRecipient(UserSummary user)` — set recipientId/name/avatar + isDirty
   - `clearRecipient()` — reset recipient fields
   - `updateTitle(String value)` — set title + isDirty
   - `updateMessage(String value)` — set message + isDirty
   - `searchRecipients(String query)` — gọi repository.searchUsers (ViewModel không quản lý debounce — debounce xử lý ở UI layer với `Timer`)
   - `toggleHashtag(Hashtag hashtag)` — add/remove từ list + isDirty
   - `addImage(String filePath)` — validate format/size → upload → thêm vào list + isDirty
   - `removeImage(int index)` — xóa từ storage + list
   - `toggleAnonymous()` — toggle isAnonymous + isDirty
   - `validate()` — kiểm tra required fields, return bool, set validationErrors + showErrorBanner
   - `submit()` — validate → disable button → gọi createKudos → return success/failure
   - `clearFieldError(String fieldName)` — xóa error cho field cụ thể + ẩn banner nếu không còn error
   - Computed getter `isFormValid` — recipientId != null && title.trim().isNotEmpty && message.trim().isNotEmpty && hashtags.isNotEmpty && !isSubmitting

### Phase 2: Core UI — Form Screen + Dropdowns (US1 + US2 + US4 + US7)

**Ưu tiên P1**: Hiển thị form, chọn người nhận, chọn hashtag, nút hủy.

> **Nguyên tắc TDD**: Mỗi widget PHẢI viết test trước khi implement. Loading/error/empty state ngay từ đầu.

1. **`SendKudosScreen`** — `ConsumerWidget` + `PopScope` (bắt swipe back) + `SingleChildScrollView` + `Column`
   - Header text: "Gửi lời cám ơn và ghi nhận đến đồng đội"
   - Form body: delegate cho `SendKudosFormWidget`
   - Bottom bar: nút "Hủy" (trái) + nút "Gửi đi" (phải)

2. **`SendKudosFormWidget`** — `StatelessWidget`, body chính của form:
   - Section Người nhận: label + dropdown trigger
   - Section Danh hiệu: label + text input (max 100) + link "Tiêu chuẩn cộng đồng"
   - Section Nội dung: rich text editor + toolbar
   - Section Hashtag: label + chip group
   - Section Image: label + grid thumbnails
   - Checkbox ẩn danh

3. **`RecipientDropdownWidget`** — Bottom sheet overlay:
   - `TextField` auto-focus + icon clear (X)
   - `Timer` debounce 300ms — chỉ gọi ViewModel.searchRecipients khi ≥ 2 ký tự
   - Danh sách kết quả: `RecipientSearchItem` (avatar + tên + đơn vị)
   - States: initial hint ("Nhập ít nhất 2 ký tự"), loading (shimmer 3 items), empty ("Không tìm thấy kết quả"), error + retry
   - Bấm item → gọi ViewModel.selectRecipient → đóng bottom sheet

4. **`RecipientSearchItem`** — `StatelessWidget`:
   - `CircleAvatar` (36x36) + fallback initials
   - Tên đầy đủ (bold) + đơn vị/phòng ban (lighter)

5. **`HashtagDropdownWidget`** — Bottom sheet overlay:
   - Danh sách tất cả hashtag từ `availableHashtags`
   - Mỗi item: tên hashtag + icon check nếu đã chọn
   - Đã chọn 5 → các item chưa chọn disabled (opacity: 0.4)
   - Bấm item → toggle ViewModel.toggleHashtag
   - Bấm ra ngoài → đóng bottom sheet

6. **`HashtagChipGroupWidget`** — `StatelessWidget`:
   - Hiển thị `Wrap` các chip đã chọn (tên + nút "x" xóa)
   - Nút "+ Hashtag (Tối đa 5)" — bấm → mở `HashtagDropdownWidget`
   - Ẩn nút khi đã 5 tags

7. **`CancelConfirmationDialog`** — `AlertDialog`:
   - Tiêu đề: "Hủy tạo Kudos?"
   - Nội dung: "Nội dung bạn đã nhập sẽ bị mất."
   - Nút "Tiếp tục soạn" (secondary) + "Hủy bỏ" (primary)

8. **`SendKudosButtonWidget`** — `StatelessWidget`:
   - 3 trạng thái: disabled (opacity giảm), enabled (bg: #FFEA9E), loading (spinner)
   - Enabled khi `isFormValid == true`
   - Animation opacity 200ms khi chuyển state

### Phase 3: Rich Text Editor + Image Upload (US3 + US5)

1. **`RichTextEditorWidget`** — Wrapper cho `flutter_quill` QuillEditor:
   - Max 1000 ký tự
   - Hint: "Hãy gửi gắm lời cám ơn và ghi nhận đến đồng đội tại đây nhé!"
   - Sub-hint: "Bạn có thể '@ + tên' để nhắc tới đồng nghiệp khác"
   - Sync nội dung với ViewModel.updateMessage

2. **`FormattingToolbarWidget`** — `StatelessWidget`:
   - 6 nút: Bold (B), Italic (I), Strikethrough (S), Numbered List, Link, Quote
   - Toggle active/inactive state
   - Link button → mở dialog nhập URL
   - Hiển thị khi textarea được focus

3. **`ImageAttachmentWidget`** — `StatelessWidget`:
   - Grid layout hiển thị thumbnails đã chọn (max 5)
   - Mỗi thumbnail: preview ảnh + nút "x" xóa + loading indicator khi upload
   - Nút "+ Image (Tối đa 5)" — ẩn khi đã 5 ảnh
   - Bấm → gọi `ImagePicker` → validate format (JPG/PNG/HEIC) + size (≤5MB) → ViewModel.addImage
   - Error: snackbar cho ảnh quá lớn / sai format / upload thất bại
   - Retry icon khi upload fail

### Phase 4: Validation + Error State (spec `0le8xKnFE_`)

1. **`ErrorBannerWidget`** — `StatelessWidget` + animation:
   - Text: "Bạn cần điền đủ Người nhận, Lời nhắn gửi và Hashtag để gửi Kudos!"
   - Nền đỏ, nổi bật trên dark theme
   - Shake animation khi bấm "Gửi đi" nhiều lần (translateX: 0→-5→5→0, 300ms)
   - Tự ẩn khi người dùng sửa bất kỳ trường nào (ViewModel.clearFieldError)

2. **Validation logic trong ViewModel** (`validate()` method):
   - `recipientId == null` → error 'recipient'
   - `recipientId == currentUserId` → error 'recipient' + message "Bạn không thể gửi kudo cho chính mình."
   - `title.trim().isEmpty` → error 'title'
   - `message.trim().isEmpty` → error 'message'
   - `hashtags.isEmpty` → error 'hashtags'
   - Nếu có lỗi → set `showErrorBanner = true` + scroll đến error banner

3. **Visual indicators trên form fields**:
   - Input border: default `#998C5F` → error `#D4271D`
   - Khi sửa trường → gọi `clearFieldError(fieldName)` → border quay lại bình thường
   - Auto-scroll đến error banner hoặc trường lỗi đầu tiên (300ms)

### Phase 5: Submit Flow + Navigation (US1 hoàn chỉnh)

1. **Submit flow**:
   - Bấm "Gửi đi" → `validate()` → nếu pass → `isSubmitting = true` → disable nút + loading spinner
   - Gọi `repository.createKudos(...)` → timeout 10 giây
   - Thành công → pop back + gọi `KudosViewModel.refresh()` để reload feed
   - Lỗi server → snackbar thông báo (500, 429, network error) + enable lại nút
   - Double-tap protection: nút disabled ngay khi `isSubmitting = true`

2. **Navigation tích hợp**:
   - CTA button trên `KudosScreen` → `context.push('/send-kudos')`
   - Pop back: `context.pop(true)` khi thành công → `KudosScreen` kiểm tra result và refresh
   - Link "Tiêu chuẩn cộng đồng" → external URL qua `url_launcher` (đã thêm vào dependencies)

3. **Toggle ẩn danh** (US6):
   - Checkbox mặc định tắt
   - Toggle → `ViewModel.toggleAnonymous()`
   - Khi submit: pass `isAnonymous` vào API

### Phase 6: Polish & Cross-cutting Concerns

1. **Accessibility**: Thêm `Semantics` cho tất cả interactive elements theo bảng VoiceOver trong specs
2. **Keyboard handling**: Form auto-scroll khi keyboard hiện → input hiện tại luôn visible
3. **Animation**: Slide-in từ dưới khi mở form, fade-out khi đóng, button opacity transition 200ms, error shake 300ms
4. **@mention**: Gõ "@" trong textarea → hiển thị gợi ý danh sách đồng nghiệp (tái sử dụng `searchUsers` API)
5. **Error boundary**: 401 → redirect login, network error → snackbar + retry
6. **Performance**: Profile image upload + form interactions trên device thật

---

## Đánh giá rủi ro

| Rủi ro | Xác suất | Ảnh hưởng | Giảm thiểu |
|--------|----------|-----------|-----------|
| `flutter_quill` integration phức tạp | Trung bình | Cao | Prototype sớm trong Phase 0. Nếu quá phức tạp, fallback về `TextField` với markdown syntax |
| Image upload chậm / fail | Trung bình | Trung bình | Upload ngay khi chọn ảnh (không chờ submit), hiển thị loading per-thumbnail, retry mechanism |
| @mention feature phức tạp | Cao | Thấp | Đặt ở Phase 6 (P3 priority). Nếu quá phức tạp, bỏ qua cho MVP |
| API search users chưa sẵn sàng | Thấp | Trung bình | Mock data layer + PostgREST ilike query đã prove với spotlight search |
| Rich text Delta → plain text conversion | Trung bình | Trung bình | Nếu backend chưa hỗ trợ Delta format, convert sang plain text + markdown khi submit |
| Race condition upload + submit | Thấp | Cao | Disable nút "Gửi đi" khi có ảnh đang upload (`imageUploadingIndex != null`) |
| Storage bucket `kudos-photos` chưa tồn tại trên production | Thấp | Cao | Phase 0 tạo bucket qua seed.sql. Verify bằng query `storage.buckets` trước khi test upload |

### Độ phức tạp ước tính

- **Frontend**: **Cao** (rich text editor, image upload, 2 dropdowns, validation, anti-duplicate)
- **Backend**: **Thấp** (PostgREST insert + Supabase Storage upload)
- **Testing**: **Trung bình-Cao** (ViewModel methods nhiều, widget tests cho dropdowns + validation)

---

## Chiến lược kiểm thử tích hợp

### Phạm vi kiểm thử

- [x] **Tương tác component/module**: ViewModel ↔ Repository ↔ Datasource
- [x] **Phụ thuộc bên ngoài**: Supabase API (search, create, upload)
- [ ] **Data layer**: Không có local DB (chỉ in-memory state)
- [x] **Luồng người dùng**: Search → Select → Fill form → Validate → Submit → Refresh feed

### Phân loại kiểm thử

| Loại | Áp dụng? | Kịch bản chính |
|------|----------|----------------|
| UI ↔ Logic | Có | Form input → ViewModel state update; Validate → Error display; Submit → Loading → Success |
| Service ↔ Service | Có | Repository → Datasource → Supabase (create + upload) |
| App ↔ External API | Có | Search users, Create kudos, Upload image, Get hashtags |
| Cross-platform | Không | iOS-only trong phase này |

### Môi trường kiểm thử

- **Loại**: Flutter Test (unit + widget), Emulator (integration)
- **Test data**: Mock factories tạo `SendKudosState`, `UserSummary`, `Hashtag`
- **Cô lập**: Riverpod `overrideWith` cho mỗi test — không dùng real API

### Chiến lược Mock

| Loại dependency | Chiến lược | Lý do |
|-----------------|-----------|-------|
| Repository | Mock (mocktail) | Unit test ViewModel không cần real API |
| Datasource | Mock (mocktail) | Unit test Repository không cần real HTTP |
| Supabase client | Mock | Tránh phụ thuộc network trong CI |
| ImagePicker | Mock | Widget test cho image upload |
| go_router | Mock | Widget test cho navigation (pop back) |
| flutter_quill | Mock controller | Widget test cho rich text editor |

### Kịch bản kiểm thử

1. **Happy Path**
   - [x] Mở form → hiển thị trạng thái mặc định (tất cả placeholder, nút disabled)
   - [x] Search người nhận → debounce 300ms → hiển thị kết quả → chọn → form cập nhật
   - [x] Điền danh hiệu + nội dung + chọn hashtag → nút "Gửi đi" enable
   - [x] Bấm "Gửi đi" → loading → success → pop back
   - [x] Upload ảnh → loading thumbnail → preview hiển thị
   - [x] Toggle ẩn danh → state cập nhật

2. **Validation**
   - [x] Submit form rỗng → error banner + border đỏ tất cả required fields
   - [x] Submit thiếu 1 field → error banner + chỉ field đó border đỏ
   - [x] Chọn chính mình → error "Bạn không thể gửi kudo cho chính mình"
   - [x] Sửa field → border quay lại bình thường, banner ẩn khi hết lỗi
   - [x] Danh hiệu > 100 ký tự → maxLength chặn
   - [x] Nội dung > 1000 ký tự → maxLength chặn + thông báo

3. **Error Handling**
   - [x] Submit → server lỗi 500 → snackbar + enable lại nút
   - [x] Submit → timeout > 10s → snackbar + enable lại nút
   - [x] Submit → lỗi 429 → snackbar rate limit
   - [x] Upload ảnh > 5MB → snackbar lỗi
   - [x] Upload ảnh sai format → snackbar lỗi
   - [x] Search users → network error → hiển thị error + retry

4. **Edge Cases**
   - [x] Double-tap "Gửi đi" → chỉ submit 1 lần (isSubmitting flag)
   - [x] Bấm "Hủy" form rỗng → đóng ngay
   - [x] Bấm "Hủy" form dirty → dialog xác nhận
   - [x] Swipe back iOS form dirty → dialog xác nhận
   - [x] Search < 2 ký tự → không gọi API, hiển thị hint
   - [x] Hashtag đã chọn 5 → các item chưa chọn disabled
   - [x] Ảnh đã có 5 → nút thêm ẩn
   - [x] Bấm "Gửi đi" khi đang upload ảnh → chờ upload hoàn tất hoặc chặn

### Công cụ & Framework

- **Test framework**: `flutter_test` + `mocktail`
- **CI**: `flutter test` trong pipeline
- **Coverage target**: ≥ 80% cho ViewModel + Repository

### Mục tiêu Coverage

| Khu vực | Mục tiêu | Ưu tiên |
|---------|---------|---------|
| ViewModel (SendKudosViewModel) | 90%+ | Cao |
| Repository (methods mới) | 85%+ | Cao |
| Widget tests (dropdowns, validation, form) | 70%+ | Trung bình |
| Model serialization (SendKudosState) | 100% | Cao |

---

## Phụ thuộc & Điều kiện tiên quyết

### Yêu cầu trước khi bắt đầu

- [x] `constitution.md` đã review
- [x] `spec.md` (5 screens) đã review
- [x] Kudos feed feature đã triển khai (`fO0Kt19sZZ`) — CTA button sẽ navigate tới send screen
- [x] Models tái sử dụng đã có: `Hashtag`, `UserSummary`, `KudosRemoteDatasource`, `KudosRepository`
- [ ] SVG icons cho toolbar formatting đã download từ Figma
- [ ] Supabase Storage bucket `kudos-photos` đã tạo + RLS policy
- [ ] Package `flutter_quill` + `image_picker` + `url_launcher` đã approve và thêm vào pubspec

### Phụ thuộc bên ngoài

- Supabase PostgREST (create kudos, search users) — PostgREST đã hoạt động với feature Kudos hiện tại
- Supabase Storage (upload ảnh) — cần tạo bucket mới
- Figma assets (SVG icons cho toolbar) — cần download trước Phase 0

---

## Ghi chú

- Feature gửi kudos tái sử dụng tối đa data layer hiện tại trong `lib/features/kudos/` — chỉ thêm methods mới vào datasource/repository
- `SendKudosViewModel` là ViewModel riêng (tách khỏi `KudosViewModel`) vì quản lý state form khác biệt hoàn toàn so với feed state
- Rich text editor (`flutter_quill`) là dependency mới duy nhất có size đáng kể — cần prototype sớm để đảm bảo tương thích
- @mention feature (US3.3) được đặt ở Phase 6 do phức tạp cao, có thể defer sang sprint sau nếu cần
- Tất cả `.md` đều viết bằng tiếng Việt theo yêu cầu project
- Khi backend deploy Edge Functions, cần refactor datasource từ PostgREST → functions.invoke() (giống ghi chú trong plan Kudos feed)
