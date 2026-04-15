# Tasks: [iOS] Sun*Kudos — Gửi lời chúc Kudos

**Frame**: `PV7jBVZU1N-ios-sun-kudos-gui-loi-chuc`
**Prerequisites**: plan.md, spec.md, design-style.md

**Specs liên quan**:
- `PV7jBVZU1N` — Gửi lời chúc Kudos (main)
- `7fFAb-K35a` — Trạng thái mặc định (default empty state)
- `aKWA2klsnt` — Dropdown hashtag (multi-select, max 5)
- `5MU728Tjck` — ~~Dropdown người nhận~~ (THAY THẾ bằng DropdownMenu — không cần search)
- `0le8xKnFE_` — Trạng thái lỗi validation

---

## Định dạng Task

```
- [ ] T### [P?] [Story?] Mô tả | đường/dẫn/file
```

- **[P]**: Có thể chạy song song (file khác nhau, không phụ thuộc lẫn nhau)
- **[Story]**: User story liên quan (US1–US7)
- **|**: File bị ảnh hưởng bởi task

---

## Phase 1: Setup (Chuẩn bị hạ tầng)

**Mục đích**: Thêm dependencies, assets, i18n, route, Supabase Storage bucket, theme colors

- [x] T001 [P] Thêm packages `image_picker`, `url_launcher` vào pubspec.yaml | `pubspec.yaml`
- [x] T002 [P] Download SVG icons cho toolbar formatting và form buttons từ Figma (ic_bold, ic_italic, ic_strikethrough, ic_numbered_list, ic_link_insert, ic_quote, ic_close, ic_close_lg, ic_send, ic_camera, ic_plus, ic_close_circle, ic_chevron_down) vào `assets/icons/`. Dùng momorph tool `get_media_files` | `assets/icons/`
- [x] T003 [P] Bổ sung colors mới vào `AppColors`: `errorRed` (#D4271D), `sendButtonDisabledBg` (rgba(255,234,158,0.40)), `sendButtonDisabledText` (rgba(0,16,26,0.50)), `errorBannerBg`, `toolbarBg` (rgba(46,57,64,0.5)), `toolbarActive` (#FFEA9E), `toolbarInactive` (rgba(255,255,255,0.6)), `chipBg` (rgba(255,234,158,0.15)), `chipBorder` (#998C5F), `cancelButtonBg` (#2E3940) | `lib/app/theme/app_colors.dart`
- [x] T004 [P] Thêm i18n strings cho section `sendKudos` vào cả VN và EN (~50 strings). Bao gồm: labels (Người nhận, Danh hiệu, Hashtag, Image, nội dung), placeholders (Tìm kiếm, Danh tặng một danh hiệu cho..., textarea hint, @mention hint), buttons (Gửi đi, Hủy, + Hashtag (Tối đa 5), + Image (Tối đa 5)), errors (validation messages, network errors, upload errors, rate limit, timeout, self-send), dialog (Hủy tạo Kudos?, Nội dung bạn đã nhập sẽ bị mất., Tiếp tục soạn, Hủy bỏ), links (Tiêu chuẩn cộng đồng), header text, anonymous label | `lib/i18n/strings_vi.i18n.json`, `lib/i18n/strings_en.i18n.json`
- [x] T005 [P] Thêm route `/send-kudos` → `SendKudosScreen()` vào router.dart. CTA button trên KudosScreen push route này | `lib/app/router.dart`
- [x] T006 [P] Append Supabase Storage bucket `kudos-photos` + RLS policy cho authenticated upload/delete vào `supabase/seed.sql` (ON CONFLICT DO NOTHING). Chạy seed bằng `psql` | `supabase/seed.sql`
- [x] T007 Chạy `dart run build_runner build` để generate flutter_gen assets + slang strings | `lib/gen/`, `lib/i18n/strings.g.dart`

**Checkpoint**: Assets, colors, i18n, route, storage bucket sẵn sàng. `flutter analyze` đạt 0 warnings.

---

## Phase 2: Foundation (Data Layer — Models, Datasource, Repository, ViewModel)

**Mục đích**: Xây dựng nền data layer cho toàn bộ send kudos flow

**QUAN TRỌNG**: TDD bắt buộc — viết test TRƯỚC, test FAIL, rồi mới implement

### Model (freezed)

- [x] T008 [P] Viết test cho `SendKudosState` model (default values, copyWith, isDirty, isFormValid computed, validationErrors) | `test/unit/models/send_kudos_state_test.dart`
- [x] T009 [P] Tạo `SendKudosState` model (freezed): recipientId, recipientName, recipientAvatar, title, message, hashtags (List<Hashtag>), imagePreviews (List<String>), isAnonymous (bool), isSubmitting (bool), isDirty (bool), availableHashtags (List<Hashtag>), searchResults (List<UserSummary>), isSearching (bool), validationErrors (Map<String, String>), showErrorBanner (bool) | `lib/features/kudos/data/models/send_kudos_state.dart`
- [x] T010 Chạy `dart run build_runner build` để generate `.freezed.dart` cho SendKudosState | `lib/features/kudos/data/models/`

### Datasource (thêm methods vào KudosRemoteDatasource)

- [x] T011 Viết test cho 4 methods mới trong `KudosRemoteDatasource`: searchUsers(query), createKudos({recipientId, title, message, hashtagIds, imageUrls, isAnonymous}), uploadKudosImage(filePath), deleteKudosImage(imageUrl). Mock Supabase client | `test/unit/datasources/send_kudos_datasource_test.dart`
- [x] T012 Thêm 4 methods vào `KudosRemoteDatasource`: searchUsers (PostgREST ilike, select id/name/avatar_url/hero_tier_url/department, limit 20), createKudos (insert kudos + kudos_hashtags + kudos_photos), uploadKudosImageBytes (Supabase Storage bucket kudos-photos), deleteKudosImage (remove from bucket) | `lib/features/kudos/data/datasources/kudos_remote_datasource.dart`

### Repository (thêm methods vào KudosRepository)

- [x] T013 Viết test cho 4 methods mới trong `KudosRepository`: searchUsers, createKudos, uploadImage, deleteImage. Mock datasource, test error handling + mapping | `test/unit/repositories/send_kudos_repository_test.dart`
- [x] T014 Thêm 4 methods vào `KudosRepository`: searchUsers, createKudos, uploadKudosImage, deleteKudosImage — wrap datasource methods với try/catch, error mapping | `lib/features/kudos/data/repositories/kudos_repository.dart`

### ViewModel

- [x] T015 Viết test cho `SendKudosViewModel` — test build() (pre-load hashtags), selectRecipient, clearRecipient, updateTitle, updateMessage, searchRecipients, toggleHashtag, toggleAnonymous, validate (tất cả trường hợp), submit (success/error/invalid), searchRecipients (debounce, empty query) | `test/unit/viewmodels/send_kudos_viewmodel_test.dart`
- [x] T016 Tạo `SendKudosViewModel extends AsyncNotifier<SendKudosState>` — implement build(), selectRecipient, clearRecipient, updateTitle, updateMessage, searchRecipients, toggleHashtag, addImage, removeImage, toggleAnonymous, validate, submit, dismissErrorBanner, clearFieldError | `lib/features/kudos/presentation/viewmodels/send_kudos_viewmodel.dart`
- [ ] T017 Tạo test helpers: mock factories cho SendKudosState, fake data cho form testing | `test/helpers/send_kudos_test_helpers.dart`

**Checkpoint**: Data layer hoàn chỉnh. `flutter test test/unit/` pass 100%. ViewModel xử lý tất cả business logic.

---

## Phase 3: US1 — Điền thông tin và gửi Kudos (core flow)

**Mục tiêu**: Hiển thị form gửi kudos với trạng thái mặc định (spec `7fFAb-K35a`), submit flow hoàn chỉnh

**Kiểm thử độc lập**: Mở form → thấy tất cả fields placeholder → điền đầy đủ → bấm "Gửi đi" → loading → success → pop back

### Screen + Form chính

- [ ] T018 Viết test cho `SendKudosScreen` (render header text, form body, bottom action bar, PopScope bắt swipe back) | `test/widget/kudos/send_kudos_screen_test.dart`
- [x] T019 [US1] Tạo `SendKudosScreen` (ConsumerStatefulWidget) — Scaffold + PopScope + SingleChildScrollView + Column: fields (recipient, title, message + toolbar, hashtag, images, anonymous toggle). Bottom bar: nút Hủy (flex:1) + nút Gửi đi (flex:2) | `lib/features/kudos/presentation/screens/send_kudos_screen.dart`

- [ ] T020 Viết test cho `SendKudosFormWidget` (render tất cả sections: recipient, title, content, hashtag, image, anonymous toggle; verify label text, placeholder text) | `test/widget/kudos/send_kudos_form_test.dart`
- [ ] T021 [US1] Tạo `SendKudosFormWidget` (StatelessWidget) — Column (gap: 16px, padding: 0 20px): Section Người nhận (label + dropdown trigger), Section Danh hiệu (label + input max 100 + link "Tiêu chuẩn cộng đồng"), Section Nội dung (label + toolbar placeholder + textarea placeholder), Section Hashtag (label + chip group placeholder), Section Image (label + thumbnail grid placeholder), Checkbox ẩn danh | `lib/features/kudos/presentation/widgets/send_kudos_form_widget.dart`

### Nút Gửi đi

- [ ] T022 Viết test cho `SendKudosButtonWidget` (3 trạng thái: disabled/enabled/loading, verify onPressed callback, loading spinner) | `test/widget/kudos/send_kudos_button_test.dart`
- [ ] T023 [US1] Tạo `SendKudosButtonWidget` (StatelessWidget) — 3 states: disabled (bg: rgba(255,234,158,0.4), text: rgba(0,16,26,0.5)), enabled (bg: #FFEA9E, text: #00101A, font: 14px/700), loading (bg: #FFEA9E, CircularProgressIndicator thay text). Icon ic_send. Animation opacity 150ms. Flex: 2, h: 48px, r: 8px | `lib/features/kudos/presentation/widgets/send_kudos_button_widget.dart`

### Submit flow + Navigation

- [ ] T024 [US1] Tích hợp submit flow trong SendKudosScreen: bấm "Gửi đi" → ViewModel.submit() → loading spinner → success: context.pop(true) → KudosScreen kiểm tra result và gọi refresh(). Error: snackbar thông báo (500, 429, network, timeout 10s) + enable lại nút | `lib/features/kudos/presentation/screens/send_kudos_screen.dart`
- [x] T025 [US1] Wire CTA navigation: KudosScreen CTA → `context.push('/send-kudos')` → if result == true call `KudosViewModel.refresh()` | `lib/features/kudos/presentation/screens/kudos_screen.dart`

**Checkpoint**: Form hiển thị trạng thái mặc định. Submit flow hoạt động end-to-end. CTA navigate đúng.

---

## Phase 4: US2 — Chọn người nhận Kudos (DropdownMenu)

**Mục tiêu**: DropdownMenu hiển thị toàn bộ danh sách users (pre-loaded), chọn người nhận

**Thay đổi**: Đổi từ search dropdown (bottom sheet + debounce) sang `DropdownMenu` load tất cả users.

**Kiểm thử độc lập**: Bấm input "Người nhận" → dropdown menu mở → danh sách users hiện → chọn → đóng + hiển thị tên

### Data Layer

- [ ] T026 Viết test cho `loadAllUsers()` trong ViewModel: build() pre-load tất cả users vào `allUsers`. Test error case → allUsers rỗng | `test/unit/viewmodels/send_kudos_viewmodel_test.dart`
- [ ] T027 [US2] Thêm method `fetchAllUsers()` vào datasource/repository: `users.select('id, name, avatar_url, department:departments(name)').isFilter('deleted_at', null)`. Thêm `allUsers` + `isLoadingUsers` vào `SendKudosState`. Trong `build()` gọi `fetchAllUsers()` song song với `getHashtags()` | `lib/features/kudos/data/datasources/kudos_remote_datasource.dart`, `lib/features/kudos/data/repositories/kudos_repository.dart`, `lib/features/kudos/presentation/viewmodels/send_kudos_viewmodel.dart`

### DropdownMenu Widget

- [ ] T028 Viết test cho `RecipientDropdownMenuWidget`: render trigger button, mở dropdown hiển thị list users, chọn → callback, hiển thị tên khi đã chọn | `test/widget/kudos/recipient_dropdown_menu_test.dart`
- [ ] T029 [US2] Tạo `RecipientDropdownMenuWidget` (ConsumerWidget) — `DropdownMenu<UserSummary>`: trigger là Container (h:44, bg: #FFEA9E/10%, border: #998C5F, r:4, icon chevron-down). Mỗi DropdownMenuEntry: leadingIcon avatar (36x36 circle, fallback initials) + label tên (14px/600 white) + trailingIcon department (12px/400 #999). Item đã chọn có bg `rgba(255,234,158,0.08)`. onSelected → `ViewModel.selectRecipient()`. menuStyle maxHeight: 300 | `lib/features/kudos/presentation/widgets/recipient_dropdown_menu_widget.dart`

### Tích hợp vào screen

- [ ] T030 [US2] Thay `RecipientPopupMenuWidget` bằng `RecipientDropdownMenuWidget` trong `SendKudosScreen`. Truyền `hasError` prop cho error border | `lib/features/kudos/presentation/screens/send_kudos_screen.dart`

**Checkpoint**: DropdownMenu hiển thị toàn bộ users. Chọn đúng. Tên hiển thị sau khi chọn. Error border khi validate fail.

---

## Phase 5: US3, US4, US5 — Rich Text, Hashtag Multi-Select, Image Upload

**Mục tiêu**: Rich text editor + toolbar, hashtag dropdown multi-select (spec `aKWA2klsnt`), image upload

### US3 — Rich Text Editor

- [x] T032 [US3] Tạo `FormattingToolbarWidget` — Row: 6 nút (B/I/S/1./Link/❝), áp dụng markdown formatting vào TextEditingController | `lib/features/kudos/presentation/widgets/formatting_toolbar_widget.dart`
- [x] T037 [P] [US4] Tạo `HashtagChipGroupWidget` — Wrap: chips đã chọn + nút thêm dashed + hint tối đa | `lib/features/kudos/presentation/widgets/hashtag_chip_group_widget.dart`
- [x] T039 [US4] Tạo `HashtagDropdownWidget` — DropdownMenu: ListView hashtag, checkmark đã chọn, toggleHashtag | `lib/features/kudos/presentation/widgets/hashtag_dropdown_widget.dart`
- [x] T042 [US5] Tạo `ImageAttachmentWidget` — Grid thumbnails 56x56 + nút thêm (camera icon) + xóa. image_picker integration | `lib/features/kudos/presentation/widgets/image_attachment_widget.dart`

- [ ] T033 Viết test cho `RichTextEditorWidget` (render QuillEditor, max 1000 ký tự, placeholder, hint @mention, sync với ViewModel) | `test/widget/kudos/rich_text_editor_test.dart`
- [ ] T034 [US3] Tạo `RichTextEditorWidget` — Wrapper cho flutter_quill QuillEditor: min-height 120px, bg: rgba(255,234,158,0.10), border: 1px #998C5F (focus: #FFEA9E, error: #D4271D), r: 4px. Placeholder: "Hãy gửi gắm lời cám ơn và ghi nhận đến đồng đội tại đây nhé!". Hint bên dưới: "Bạn có thể '@ + tên' để nhắc tới đồng nghiệp khác" (12px/400, #999). Max 1000 ký tự với counter. Sync nội dung với ViewModel.updateMessage | `lib/features/kudos/presentation/widgets/rich_text_editor_widget.dart`

- [ ] T035 [US3] Tích hợp FormattingToolbarWidget + RichTextEditorWidget vào SendKudosFormWidget — Toolbar hiển thị phía trên textarea. Toolbar điều khiển QuillController formatting | `lib/features/kudos/presentation/widgets/send_kudos_form_widget.dart`

### US4 — Hashtag Multi-Select

- [ ] T036 [P] Viết test cho `HashtagChipGroupWidget` (render chips đã chọn, nút "+" thêm, nút "x" xóa, ẩn nút khi đạt max 5) | `test/widget/kudos/hashtag_chip_group_test.dart`
- [ ] T037 [P] [US4] Tạo `HashtagChipGroupWidget` (StatelessWidget) — Wrap (gap: 8px): mỗi chip (h: 28px, bg: rgba(255,234,158,0.15), border: 1px #998C5F, r: 16px, padding: 4px 12px, text: 12px/500 #FFEA9E + nút x 12x12 #999). Nút "+ Hashtag (Tối đa 5)" (h: 28px, border: dashed #998C5F, r: 16px, text: #999). Ẩn nút khi đã 5 tags | `lib/features/kudos/presentation/widgets/hashtag_chip_group_widget.dart`

- [ ] T038 Viết test cho `HashtagDropdownWidget` (render danh sách hashtag, check mark cho đã chọn, disable khi đã 5, toggle chọn/bỏ) | `test/widget/kudos/hashtag_dropdown_test.dart`
- [ ] T039 [US4] Tạo `HashtagDropdownWidget` — DropdownMenu<Hashtag>: danh sách tất cả hashtag từ availableHashtags. Mỗi DropdownMenuEntry: tên hashtag + trailingIcon check nếu đã chọn. Đã chọn 5 → các entry chưa chọn disabled (opacity: 0.4). Bấm entry → ViewModel.toggleHashtag. Bấm ra ngoài → đóng menu | `lib/features/kudos/presentation/widgets/hashtag_dropdown_widget.dart`

- [ ] T040 [US4] Tích hợp HashtagChipGroupWidget + HashtagDropdownWidget vào SendKudosFormWidget — Bấm nút "+" → mở HashtagDropdownWidget. Chips hiển thị hashtag đã chọn, bấm "x" → ViewModel.toggleHashtag(remove) | `lib/features/kudos/presentation/widgets/send_kudos_form_widget.dart`

### US5 — Image Upload

- [ ] T041 Viết test cho `ImageAttachmentWidget` (render grid thumbnails, nút thêm ẩn khi 5 ảnh, nút xóa, loading indicator, retry icon khi fail) | `test/widget/kudos/image_attachment_test.dart`
- [ ] T042 [US5] Tạo `ImageAttachmentWidget` (StatelessWidget) — Row (gap: 8px): thumbnail previews (56x56, r: 8px, fit: cover) + nút "x" xóa (16x16, positioned top-right) + loading indicator khi upload + retry icon khi fail. Nút "+ Image" (56x56, border: dashed #998C5F, r: 8px, icon ic_plus 20px #999). Ẩn nút khi 5 ảnh. Bấm → ImagePicker → validate format (JPG/PNG/HEIC) + size (≤5MB) → ViewModel.addImage. Errors: snackbar cho ảnh quá lớn / sai format / upload fail | `lib/features/kudos/presentation/widgets/image_attachment_widget.dart`

- [ ] T043 [US5] Tích hợp ImageAttachmentWidget vào SendKudosFormWidget | `lib/features/kudos/presentation/widgets/send_kudos_form_widget.dart`

**Checkpoint**: Rich text editor hoạt động với 6 format options. Hashtag multi-select max 5. Image upload + preview + delete hoạt động. Tất cả tích hợp vào form.

---

## Phase 6: US6 — Toggle gửi ẩn danh + Nickname Input

**Mục tiêu**: Checkbox toggle ẩn danh + input nickname ẩn danh (animated)

**Thay đổi**: Khi bật ẩn danh → hiện thêm input nickname (max 50 ký tự, tùy chọn). Lưu vào `sender_alias` trên Supabase.

**Kiểm thử độc lập**: Toggle checkbox → input nickname hiện (animated) → nhập nickname → submit với isAnonymous=true + senderAlias

### Data Layer

- [ ] T044a Thêm field `senderAlias` (String?, default null) vào `SendKudosState`. Thêm method `updateSenderAlias(String)` vào ViewModel. Cập nhật `createKudos()` trong datasource/repository: gửi `sender_alias` khi submit. Rebuild freezed | `lib/features/kudos/data/models/send_kudos_state.dart`, `lib/features/kudos/presentation/viewmodels/send_kudos_viewmodel.dart`, `lib/features/kudos/data/datasources/kudos_remote_datasource.dart`
- [ ] T044b Viết test cho `updateSenderAlias()`, verify `toggleAnonymous()` reset senderAlias = null khi tắt, verify `submit()` gửi senderAlias | `test/unit/viewmodels/send_kudos_viewmodel_test.dart`
- [ ] T044c Thêm i18n keys: `sendKudos.anonymousNicknamePlaceholder` ("Nhập nickname ẩn danh (tùy chọn)"), `sendKudos.anonymousNicknameHint` ("Để trống sẽ hiển thị 'Người gửi ẩn danh'") cho VN/EN. Chạy `dart run slang` | `lib/i18n/strings_vi.i18n.json`, `lib/i18n/strings_en.i18n.json`

### UI

- [ ] T044d Viết test cho anonymous toggle + nickname: checkbox OFF → chỉ checkbox + label. Checkbox ON → thêm nickname input hiện (animated). Nhập nickname → state cập nhật. Toggle OFF → nickname input ẩn + clear | `test/widget/kudos/anonymous_toggle_test.dart`
- [ ] T045 [US6] Sửa `_AnonymousToggle` widget trong SendKudosScreen: Thêm `AnimatedCrossFade` bên dưới checkbox row → khi `isAnonymous=true` hiển thị `_StyledTextField` (h:44, placeholder: "Nhập nickname ẩn danh (tùy chọn)", maxLength: 50). Dưới input: hint text "Để trống sẽ hiển thị 'Người gửi ẩn danh'" (12px/400, #999). TextEditingController local + listener → `ViewModel.updateSenderAlias()`. `toggleAnonymous()` clear senderAlias + reset controller | `lib/features/kudos/presentation/screens/send_kudos_screen.dart`

**Checkpoint**: Toggle ẩn danh + nickname input hoạt động. Animated slide-down/up. Submit gửi senderAlias đúng.

---

## Phase 7: US7 — Hủy/Discard + Validation Error State

**Mục tiêu**: Nút Hủy + dialog xác nhận + validation error state (spec `0le8xKnFE_`)

### Cancel/Discard

- [x] T047 [US7] Tạo `CancelConfirmationDialog` — AlertDialog: title, content, nút Tiếp tục soạn + nút Hủy bỏ. Tất cả text qua i18n | `lib/features/kudos/presentation/widgets/cancel_confirmation_dialog.dart`
- [x] T050 [US7] Tạo `ErrorBannerWidget` — AnimatedSwitcher: banner lỗi với icon + text + nút dismiss. Nền errorBannerBg, border errorRed | `lib/features/kudos/presentation/widgets/error_banner_widget.dart`

- [ ] T048 [US7] Tích hợp cancel logic vào SendKudosScreen — Nút "Hủy" (flex:1, h:48, bg: #2E3940, r:8, icon ic_close + text "Hủy" 14px/500 white): form trống → pop ngay, form dirty → showDialog CancelConfirmationDialog. PopScope: swipe back cùng logic. Disabled khi isSubmitting | `lib/features/kudos/presentation/screens/send_kudos_screen.dart`

### Error Banner + Validation Visual

- [ ] T049 Viết test cho `ErrorBannerWidget` (hiển thị text lỗi, shake animation, tự ẩn khi không còn lỗi) | `test/widget/kudos/error_banner_test.dart`
- [ ] T050 [US7] Tạo `ErrorBannerWidget` (StatelessWidget + animation) — Text: "Bạn cần điền đủ Người nhận, Lời nhắn gửi và Hashtag để gửi Kudos!" (i18n). Nền đỏ nổi bật. Shake animation khi bấm "Gửi đi" nhiều lần (translateX: 0→-5→5→0, 300ms). Tự ẩn khi showErrorBanner = false | `lib/features/kudos/presentation/widgets/error_banner_widget.dart`

- [ ] T051 [US7] Tích hợp ErrorBannerWidget vào SendKudosScreen + visual validation indicators trên form fields — Error banner hiển thị khi showErrorBanner = true. Input border: default #998C5F → error #D4271D. Khi sửa trường → clearFieldError → border quay lại. Auto-scroll đến error banner (300ms) | `lib/features/kudos/presentation/screens/send_kudos_screen.dart`, `lib/features/kudos/presentation/widgets/send_kudos_form_widget.dart`

**Checkpoint**: Cancel + dialog xác nhận hoạt động. Swipe back iOS cùng logic. Error banner + validation visual indicators hoạt động.

---

## Phase Final: Polish & Cross-cutting Concerns

**Mục đích**: Accessibility, animations, keyboard handling, @mention, error boundary, performance

- [ ] T052 [P] Thêm `Semantics` widgets cho tất cả interactive elements theo bảng VoiceOver trong spec: Recipient Dropdown ("Chọn người nhận"), Danh hiệu Input, Link tiêu chuẩn, Toolbar buttons, Message Textarea ("Nhập nội dung kudos"), Tag Group, Add Image, Anonymous Toggle ("Gửi ẩn danh"), Cancel Button ("Hủy tạo kudos"), Send Button ("Gửi kudos") | `lib/features/kudos/presentation/widgets/*.dart`
- [ ] T053 [P] Keyboard handling — Form auto-scroll khi keyboard hiện lên → input hiện tại luôn visible. SingleChildScrollView + `Scrollable.ensureVisible` khi focus | `lib/features/kudos/presentation/screens/send_kudos_screen.dart`
- [ ] T054 [P] Animations — Screen slide-up 300ms ease-out khi mở, slide-down 200ms ease-in khi đóng. Toolbar button bg-color 150ms. Input border-color 150ms. Chip scale+fade 200ms add / 150ms remove. Submit button opacity 150ms | `lib/features/kudos/presentation/widgets/*.dart`
- [ ] T055 [P] Link "Tiêu chuẩn cộng đồng" (12px/500, #FFEA9E, underline) → bấm mở external URL qua url_launcher | `lib/features/kudos/presentation/widgets/send_kudos_form_widget.dart`
- [ ] T056 [P] @mention feature — Gõ "@" trong textarea → hiển thị gợi ý danh sách đồng nghiệp (tái sử dụng searchUsers API). Chọn → insert mention vào rich text | `lib/features/kudos/presentation/widgets/rich_text_editor_widget.dart`
- [ ] T057 [P] Error boundary: 401 → redirect login (tích hợp auth redirect trong router.dart). Network error → snackbar + retry. Timeout 10s → snackbar + enable lại nút | `lib/features/kudos/data/datasources/kudos_remote_datasource.dart`, `lib/features/kudos/presentation/screens/send_kudos_screen.dart`
- [ ] T058 [P] Disable nút "Gửi đi" khi có ảnh đang upload (imageUploadingIndex != null) — chống race condition upload + submit | `lib/features/kudos/presentation/widgets/send_kudos_button_widget.dart`
- [ ] T059 Performance audit trên device thật — profile rich text editor + image upload + form interactions. Kiểm tra FPS ≥ 30fps | Device testing
- [ ] T060 Chạy `flutter analyze` + `dart format` — đảm bảo 0 warnings, 0 lint errors | Toàn bộ project
- [ ] T061 Chạy toàn bộ test suite: `flutter test` — đảm bảo tất cả tests pass, coverage ≥ 80% cho ViewModel + Repository, ≥ 70% cho widget tests | `test/`

**Checkpoint**: Feature hoàn chỉnh. Tất cả tests pass. Lint clean. Accessibility OK. Performance OK trên device thật.

---

## Phụ thuộc & Thứ tự thực thi

### Phụ thuộc giữa Phases

```
Phase 1 (Setup) ─────────────────────────────────────────┐
    │                                                      │
    v                                                      │
Phase 2 (Foundation/Data Layer) ──────────────────────┐   │
    │                                                   │   │
    v                                                   │   │
Phase 3 (US1: Core Form + Submit) ──── MVP            │   │
    │                                                   │   │
    ├──> Phase 4 (US2: Recipient DropdownMenu) ─── P1     │   │
    │                                                   │   │
    ├──> Phase 5 (US3+US4+US5: RichText + Hashtag +    │   │
    │            Image) ─── P1/P2                       │   │
    │                                                   │   │
    ├──> Phase 6 (US6: Anonymous Toggle) ─── P2        │   │
    │    (có thể song song với Phase 4, 5)              │   │
    │                                                   │   │
    └──> Phase 7 (US7: Cancel + Validation Error) ──┘   │
         │                                               │
         v                                               │
    Phase Final (Polish) ────────────────────────────────┘
```

### Song song trong mỗi Phase

- **Phase 1**: T001–T006 song song (files khác nhau). T007 cuối cùng (cần T001, T002, T004)
- **Phase 2**: T008–T009 song song. T011–T014 tuần tự (datasource → repo). T015–T016 sau repo
- **Phase 3**: T018–T023 có thể song song phần nào (widgets độc lập). T024–T025 cuối (tích hợp)
- **Phase 4**: T026 trước T027 (data layer trước UI). T028–T029 sau. T030 cuối (tích hợp)
- **Phase 5**: US3 (T031–T035), US4 (T036–T040), US5 (T041–T043) song song giữa nhóm
- **Phase 6**: Có thể song song với Phase 4, 5
- **Phase 7**: Sau Phase 3 (cần form cơ bản). T046–T048 và T049–T051 song song
- **Phase Final**: T052–T058 song song. T059–T061 cuối cùng

### Trong mỗi User Story

1. Test PHẢI viết trước và FAIL (Red)
2. Implement để test PASS (Green)
3. Refactor nếu cần
4. Widgets trước screen integration
5. Core implementation trước tích hợp

---

## Chiến lược triển khai

### MVP First (Khuyến nghị)

1. Hoàn thành Phase 1 + 2 (Setup + Foundation)
2. Hoàn thành Phase 3 (Core Form + Submit)
3. **DỪNG và KIỂM TRA**: Test form trên device
4. Tiếp tục Phase 4 + 5 (Recipient + Hashtag + Image + RichText)
5. Phase 6 + 7 (Anonymous + Cancel/Validation)
6. Phase Final (Polish)

### Incremental Delivery

1. Setup + Foundation (Phase 1+2)
2. Core Form + Submit → Test → Deploy (MVP)
3. Recipient + Hashtag + RichText + Image → Test → Deploy
4. Anonymous + Cancel + Validation → Test → Deploy
5. Polish → Final test → Deploy

---

## Ghi chú

- Commit sau mỗi task hoặc nhóm logic
- Chạy `flutter test` trước khi chuyển phase
- Cập nhật spec.md nếu requirements thay đổi trong quá trình implement
- Đánh dấu task hoàn thành: `[x]`
- TDD bắt buộc: Viết test → Test FAIL (Red) → Implement → Test PASS (Green) → Refactor
- Tái sử dụng models hiện có: `Hashtag`, `UserSummary` — KHÔNG tạo mới
- Tái sử dụng `KudosRemoteDatasource` + `KudosRepository` — chỉ THÊM methods
- `SendKudosViewModel` là ViewModel RIÊNG (tách khỏi `KudosViewModel`)
- @mention feature (T056) phức tạp cao — có thể defer sang sprint sau nếu cần
- Tất cả text PHẢI qua i18n (slang), không hardcode string
- Assets PHẢI qua flutter_gen (Assets.xxx), không hardcode path
- **THAY ĐỔI**: Tất cả dropdown dùng `DropdownMenu` (KHÔNG dùng bottom sheet hay PopupMenuButton)
- **THAY ĐỔI**: Recipient dùng `DropdownMenu<UserSummary>` (load tất cả users), KHÔNG dùng search dropdown
- **THAY ĐỔI**: Hashtag dùng `DropdownMenu<Hashtag>` (multi-select), KHÔNG dùng showModalBottomSheet
- **THAY ĐỔI**: Anonymous toggle thêm input nickname (max 50 chars), lưu `sender_alias` trên Supabase
- **OBSOLETE**: `RecipientDropdownWidget` (bottom sheet search) + `RecipientShimmerWidget` + `RecipientPopupMenuWidget` (PopupMenuButton) không còn cần cho flow chính. File vẫn giữ lại nếu cần tái sử dụng
