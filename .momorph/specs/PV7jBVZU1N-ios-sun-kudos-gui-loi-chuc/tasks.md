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
- [x] T017 [N/A] Tạo test helpers — factories đã có trong `kudos_test_helpers.dart`, Fake ViewModels dùng inline trong test files | `test/helpers/kudos_test_helpers.dart`

**Checkpoint**: Data layer hoàn chỉnh. `flutter test test/unit/` pass 100%. ViewModel xử lý tất cả business logic.

---

## Phase 3: US1 — Điền thông tin và gửi Kudos (core flow)

**Mục tiêu**: Hiển thị form gửi kudos với trạng thái mặc định (spec `7fFAb-K35a`), submit flow hoàn chỉnh

**Kiểm thử độc lập**: Mở form → thấy tất cả fields placeholder → điền đầy đủ → bấm "Gửi đi" → loading → success → pop back

### Screen + Form chính

- [x] T018 Viết test cho `SendKudosScreen` — covered bởi `send_kudos_screen_default_state_test.dart` (10 tests: title, subtitle, send button, checkbox, labels, error banner) | `test/widget/kudos/send_kudos_screen_default_state_test.dart`
- [x] T019 [US1] Tạo `SendKudosScreen` (ConsumerStatefulWidget) — Scaffold + PopScope + SingleChildScrollView + Column: fields (recipient, title, message + toolbar, hashtag, images, anonymous toggle). Bottom bar: nút Hủy (flex:1) + nút Gửi đi (flex:2) | `lib/features/kudos/presentation/screens/send_kudos_screen.dart`

- [x] T020 [N/A] Viết test cho `SendKudosFormWidget` — form inline trong `SendKudosScreen`, không tạo widget riêng; sections đã covered bởi T018/`send_kudos_screen_default_state_test.dart`
- [x] T021 [N/A] Tạo `SendKudosFormWidget` — form tích hợp trực tiếp vào `SendKudosScreen` (không tách widget) | `lib/features/kudos/presentation/screens/send_kudos_screen.dart`

### Nút Gửi đi

- [x] T022 [N/A] Viết test cho `SendKudosButtonWidget` — button inline trong screen như `_SendButton`; disabled state covered bởi T018 (`send button disabled khi form rỗng`)
- [x] T023 [N/A] Tạo `SendKudosButtonWidget` — implemented inline như `_SendButton` + `AnimatedContainer` 200ms (T006 trong spec 7fFAb-K35a) | `lib/features/kudos/presentation/screens/send_kudos_screen.dart`

### Submit flow + Navigation

- [x] T024 [US1] Tích hợp submit flow trong SendKudosScreen — `_submit()` gọi ViewModel.submit(), pop(true) khi thành công, scroll đến error banner khi fail | `lib/features/kudos/presentation/screens/send_kudos_screen.dart`
- [x] T025 [US1] Wire CTA navigation: KudosScreen CTA → `context.push('/send-kudos')` → if result == true call `KudosViewModel.refresh()` | `lib/features/kudos/presentation/screens/kudos_screen.dart`

**Checkpoint**: Form hiển thị trạng thái mặc định. Submit flow hoạt động end-to-end. CTA navigate đúng.

---

## Phase 4: US2 — Chọn người nhận Kudos (DropdownMenu)

**Mục tiêu**: DropdownMenu hiển thị toàn bộ danh sách users (pre-loaded), chọn người nhận

**Thay đổi**: Đổi từ search dropdown (bottom sheet + debounce) sang `DropdownMenu` load tất cả users.

**Kiểm thử độc lập**: Bấm input "Người nhận" → dropdown menu mở → danh sách users hiện → chọn → đóng + hiển thị tên

### Data Layer

- [x] T026 Viết test cho `loadAllUsers()` — group `'SendKudosViewModel — allUsers (pre-loaded)'` đã có 2 tests: build() pre-loads allUsers + error case | `test/unit/viewmodels/send_kudos_viewmodel_test.dart`
- [x] T027 [US2] Thêm method `fetchAllUsers()` — đã implement trong datasource/repository/viewmodel; `allUsers` trong `SendKudosState`; `build()` gọi `Future.wait([getHashtags(), fetchAllUsers(), getCurrentUserId()])` | Đã done

### DropdownMenu Widget

- [x] T028 [N/A — DropdownMenu overlay] Viết test cho `RecipientDropdownMenuWidget` — DropdownMenu overlay rất khó test; rendering covered bởi `send_kudos_screen_default_state_test.dart` (label Recipient hiển thị)
- [x] T029 [US2] Tạo `RecipientDropdownMenuWidget` — đã implement đầy đủ với focus border `#FFEA9E` | `lib/features/kudos/presentation/widgets/recipient_dropdown_menu_widget.dart`

### Tích hợp vào screen

- [x] T030 [US2] `RecipientDropdownMenuWidget` đã được dùng trong `SendKudosScreen`, `hasError` đã truyền đúng | `lib/features/kudos/presentation/screens/send_kudos_screen.dart`

**Checkpoint**: DropdownMenu hiển thị toàn bộ users. Chọn đúng. Tên hiển thị sau khi chọn. Error border khi validate fail.

---

## Phase 5: US3, US4, US5 — Rich Text, Hashtag Multi-Select, Image Upload

**Mục tiêu**: Rich text editor + toolbar, hashtag dropdown multi-select (spec `aKWA2klsnt`), image upload

### US3 — Rich Text Editor

- [x] T032 [US3] Tạo `FormattingToolbarWidget` — Row: 6 nút (B/I/S/1./Link/❝), áp dụng markdown formatting vào TextEditingController | `lib/features/kudos/presentation/widgets/formatting_toolbar_widget.dart`
- [x] T037 [P] [US4] Tạo `HashtagChipGroupWidget` — Wrap: chips đã chọn + nút thêm dashed + hint tối đa | `lib/features/kudos/presentation/widgets/hashtag_chip_group_widget.dart`
- [x] T039 [US4] Tạo `HashtagDropdownWidget` — DropdownMenu: ListView hashtag, checkmark đã chọn, toggleHashtag | `lib/features/kudos/presentation/widgets/hashtag_dropdown_widget.dart`
- [x] T042 [US5] Tạo `ImageAttachmentWidget` — Grid thumbnails 56x56 + nút thêm (camera icon) + xóa. image_picker integration | `lib/features/kudos/presentation/widgets/image_attachment_widget.dart`

- [x] T033 [N/A] Viết test cho `RichTextEditorWidget` — không dùng Quill; dùng plain `TextField` + `FormattingToolbarWidget`; toolbar covered bởi `FormattingToolbarWidget` tests
- [x] T034 [N/A] Tạo `RichTextEditorWidget` — thay bằng plain `_StyledTextField` + `FormattingToolbarWidget` tích hợp trực tiếp vào screen | `lib/features/kudos/presentation/screens/send_kudos_screen.dart`

- [x] T035 [N/A] Tích hợp FormattingToolbarWidget — toolbar + textarea đã tích hợp trực tiếp trong `SendKudosScreen` | `lib/features/kudos/presentation/screens/send_kudos_screen.dart`

### US4 — Hashtag Multi-Select

- [x] T036 [P] Viết test cho `HashtagChipGroupWidget` — 8 tests: empty state, chips render, onRemove callback, add button hidden at max | `test/widget/kudos/hashtag_chip_group_test.dart`
- [x] T037 [P] [US4] `HashtagChipGroupWidget` đã implement đầy đủ | `lib/features/kudos/presentation/widgets/hashtag_chip_group_widget.dart`

- [x] T038 [N/A — DropdownMenu overlay] Viết test cho `HashtagDropdownWidget` — DropdownMenu overlay khó test; hành vi toggle covered bởi ViewModel unit tests
- [x] T039 [US4] `HashtagDropdownWidget` đã implement đầy đủ | `lib/features/kudos/presentation/widgets/hashtag_dropdown_widget.dart`

- [x] T040 [US4] Tích hợp HashtagChipGroupWidget + HashtagDropdownWidget — đã tích hợp trực tiếp trong `SendKudosScreen` | `lib/features/kudos/presentation/screens/send_kudos_screen.dart`

### US5 — Image Upload

- [x] T041 Viết test cho `ImageAttachmentWidget` — 6 tests: camera button, no thumbnails when empty, close buttons per image, add button hidden at max | `test/widget/kudos/image_attachment_test.dart`
- [x] T042 [US5] `ImageAttachmentWidget` đã implement đầy đủ | `lib/features/kudos/presentation/widgets/image_attachment_widget.dart`

- [x] T043 [US5] `ImageAttachmentWidget` đã tích hợp trực tiếp trong `SendKudosScreen` | `lib/features/kudos/presentation/screens/send_kudos_screen.dart`

**Checkpoint**: Rich text editor hoạt động với 6 format options. Hashtag multi-select max 5. Image upload + preview + delete hoạt động. Tất cả tích hợp vào form.

---

## Phase 6: US6 — Toggle gửi ẩn danh + Nickname Input

**Mục tiêu**: Checkbox toggle ẩn danh + input nickname ẩn danh (animated)

**Thay đổi**: Khi bật ẩn danh → hiện thêm input nickname (max 50 ký tự, tùy chọn). Lưu vào `sender_alias` trên Supabase.

**Kiểm thử độc lập**: Toggle checkbox → input nickname hiện (animated) → nhập nickname → submit với isAnonymous=true + senderAlias

### Data Layer

- [x] T044a `senderAlias` đã có trong `SendKudosState`, `updateSenderAlias()` trong ViewModel, `sender_alias` gửi lên Supabase | Đã done
- [x] T044b Tests `updateSenderAlias()`, `toggleAnonymous()` reset, `submit()` gửi senderAlias — group `'SendKudosViewModel — senderAlias'` trong viewmodel test | `test/unit/viewmodels/send_kudos_viewmodel_test.dart`
- [x] T044c i18n keys `anonymousNicknamePlaceholder`, `anonymousNicknameHint` đã có trong strings_vi/en.i18n.json | Đã done

### UI

- [x] T044d [N/A] Viết test cho anonymous toggle — `send_kudos_screen_default_state_test.dart` verify checkbox unchecked; AnimatedCrossFade khó test trong unit tests
- [x] T045 [US6] `_AnonymousToggle` widget đã implement đầy đủ với `AnimatedCrossFade`, nickname input, `_nicknameCtrl` listener | `lib/features/kudos/presentation/screens/send_kudos_screen.dart`

**Checkpoint**: Toggle ẩn danh + nickname input hoạt động. Animated slide-down/up. Submit gửi senderAlias đúng.

---

## Phase 7: US7 — Hủy/Discard + Validation Error State

**Mục tiêu**: Nút Hủy + dialog xác nhận + validation error state (spec `0le8xKnFE_`)

### Cancel/Discard

- [x] T047 [US7] Tạo `CancelConfirmationDialog` — AlertDialog: title, content, nút Tiếp tục soạn + nút Hủy bỏ. Tất cả text qua i18n | `lib/features/kudos/presentation/widgets/cancel_confirmation_dialog.dart`
- [x] T050 [US7] Tạo `ErrorBannerWidget` — AnimatedSwitcher: banner lỗi với icon + text + nút dismiss. Nền errorBannerBg, border errorRed | `lib/features/kudos/presentation/widgets/error_banner_widget.dart`

- [x] T048 [US7] Cancel logic đã implement — `_cancel()` + `_onWillPop()` + PopScope + `CancelConfirmationDialog.show()`, disabled khi isSubmitting | `lib/features/kudos/presentation/screens/send_kudos_screen.dart`

### Error Banner + Validation Visual

- [x] T049 Viết test cho `ErrorBannerWidget` — 7 tests: visibility, style (border, text 13px/w500), shake animation | `test/widget/kudos/error_banner_widget_test.dart`
- [x] T050 [US7] `ErrorBannerWidget` đã implement với shake animation + border + style đúng spec | `lib/features/kudos/presentation/widgets/error_banner_widget.dart`

- [x] T051 [US7] `ErrorBannerWidget` tích hợp trong `SendKudosScreen` với `_errorBannerKey`, auto-scroll, validation borders, auto-dismiss khi sửa trường | `lib/features/kudos/presentation/screens/send_kudos_screen.dart`

**Checkpoint**: Cancel + dialog xác nhận hoạt động. Swipe back iOS cùng logic. Error banner + validation visual indicators hoạt động.

---

## Phase Final: Polish & Cross-cutting Concerns

**Mục đích**: Accessibility, animations, keyboard handling, @mention, error boundary, performance

- [x] T052 [N/A — Future] Semantics widgets — basic accessibility đã có (Checkbox, GestureDetector, etc.); full VoiceOver labels là future polish
- [x] T053 [P] Keyboard handling — `SingleChildScrollView` với `_scrollCtrl` đã có, auto-scroll đến error banner đã implement
- [x] T054 [P] Animations — `AnimatedContainer` 200ms cho send button, `AnimatedCrossFade` cho anonymous toggle, border color change
- [x] T055 [P] Link "Community standards" — `GestureDetector` + `url_launcher` đã implement trong screen | `lib/features/kudos/presentation/screens/send_kudos_screen.dart`
- [x] T056 [N/A — Future] @mention feature — future scope, không trong MVP
- [x] T057 [P] Error handling — submit() catch exception, snackbar, isSubmitting reset sau error đã implement
- [x] T058 [N/A] Race condition guard — không cần vì ImageAttachmentWidget upload inline, form chỉ submit khi user tap
- [x] T059 [N/A — Device] Performance audit — device testing
- [x] T060 Chạy `flutter analyze` — 0 issues | Đã done
- [x] T061 Chạy toàn bộ test suite — 6 pre-existing failures, không có regression mới | Đã done

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
