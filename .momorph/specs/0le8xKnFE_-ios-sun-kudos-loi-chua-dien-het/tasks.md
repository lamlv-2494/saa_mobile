# Tasks: [iOS] Sun*Kudos — Lỗi Chưa Điền Hết (Validation Error State)

**Frame**: `0le8xKnFE_-ios-sun-kudos-loi-chua-dien-het`
**Prerequisites**: plan.md, spec.md, design-style.md
**Parent screen**: `PV7jBVZU1N` — Gửi lời chúc Kudos

---

## Định dạng Task

```
- [ ] T### [P?] [Story?] Mô tả | đường/dẫn/file
```

- **[P]**: Có thể chạy song song
- **[Story]**: User story liên quan (US1–US3)
- **|**: File bị ảnh hưởng bởi task

---

## Phase 1: Setup (Chuẩn bị)

**Mục đích**: Cập nhật model, i18n cho validation error state

- [x] T001 [P] Thêm field `shakeKey` (int, default 0) vào `SendKudosState` để trigger shake animation mỗi lần validate fail | `lib/features/kudos/data/models/send_kudos_state.dart`
- [x] T002 [P] Thêm i18n key `sendKudos.validationBanner` ("Bạn cần điền đủ Người nhận, Lời nhắn gửi và Hashtag để gửi Kudos!") cho VN/EN — thay thế `validationRequired` hiện tại nếu text khác | `lib/i18n/strings_vi.i18n.json`, `lib/i18n/strings_en.i18n.json`
- [x] T003 Chạy `dart run build_runner build` + `dart run slang` để generate freezed + i18n | `lib/features/kudos/data/models/`, `lib/i18n/strings.g.dart`

**Checkpoint**: Model có `shakeKey`, i18n strings sẵn sàng.

---

## Phase 2: Foundation (ViewModel Logic — TDD)

**Mục đích**: Hoàn thiện validation logic — self-send, shakeKey, error dismiss timing

**QUAN TRỌNG**: TDD bắt buộc — viết test TRƯỚC, test FAIL, rồi mới implement

- [ ] T004 Viết test cho self-send validation: `recipientId == currentUserId` → set error `'recipient_self_send'`. Test `validate()` trả false khi self-send | `test/unit/viewmodels/send_kudos_viewmodel_test.dart`
- [x] T005 Viết test cho `shakeKey`: mỗi lần `validate()` fail → `shakeKey` tăng 1. Validate pass → `shakeKey` không đổi | `test/unit/viewmodels/send_kudos_viewmodel_test.dart`
- [x] T006 Viết test cho auto-dismiss: gọi `updateTitle()` khi `showErrorBanner == true` → `showErrorBanner` chuyển `false` | `test/unit/viewmodels/send_kudos_viewmodel_test.dart`
- [ ] T007 Implement self-send validation trong `validate()`: lấy `currentUserId` từ Supabase auth trong `build()`, so sánh với `recipientId` | `lib/features/kudos/presentation/viewmodels/send_kudos_viewmodel.dart`
- [x] T008 Implement `shakeKey` increment: trong `validate()` khi `errors.isNotEmpty` → tăng `shakeKey` | `lib/features/kudos/presentation/viewmodels/send_kudos_viewmodel.dart`
- [x] T009 Implement auto-dismiss error banner: trong `updateTitle()`, `updateMessage()`, `selectRecipient()`, `toggleHashtag()` → gọi `dismissErrorBanner()` nếu `showErrorBanner == true` | `lib/features/kudos/presentation/viewmodels/send_kudos_viewmodel.dart`
- [ ] T010 Chạy `flutter test test/unit/viewmodels/send_kudos_viewmodel_test.dart` — verify tất cả tests pass | `test/unit/`

**Checkpoint**: ViewModel validation hoàn chỉnh: self-send, shakeKey, auto-dismiss. Tests pass.

---

## Phase 3: US1 — Hiển thị lỗi tổng quát khi submit form thiếu

**Mục tiêu**: Error banner đỏ ở đầu form, shake animation khi submit lỗi nhiều lần

**Kiểm thử độc lập**: Bấm "Gửi đi" khi form rỗng → banner lỗi hiện → bấm lại → banner shake

- [ ] T011 Viết test cho `ErrorBannerWidget`: render text lỗi, hiển thị khi visible, ẩn khi not visible | `test/widget/kudos/error_banner_widget_test.dart`
- [x] T012 [US1] Cải thiện `ErrorBannerWidget` — convert sang `StatefulWidget` với `AnimationController` cho shake animation: `Transform.translate(offset: Offset(shakeOffset, 0))`, shake sequence `0 → -5 → 5 → 0`, duration 300ms. Nhận param `shakeKey` (int) — khi thay đổi trigger shake | `lib/features/kudos/presentation/widgets/error_banner_widget.dart`
- [x] T013 [US1] Cập nhật style error banner theo design: bg `rgba(212,39,29,0.15)`, border `1px #D4271D`, border-radius `8px`, padding `12px`, text `13px/500 white` | `lib/features/kudos/presentation/widgets/error_banner_widget.dart`
- [x] T014 [US1] Wire `shakeKey` từ state vào `ErrorBannerWidget` trong `SendKudosScreen` | `lib/features/kudos/presentation/screens/send_kudos_screen.dart`

**Checkpoint**: Error banner hiển thị đúng style, shake animation hoạt động.

---

## Phase 4: US2 — Đánh dấu visual trường lỗi

**Mục tiêu**: Border đỏ trên trường thiếu, quay lại bình thường khi sửa

**Kiểm thử độc lập**: Submit form rỗng → tất cả trường có border đỏ → sửa 1 trường → border trường đó quay lại bình thường

- [ ] T015 [US2] Verify `_StyledTextField` đã xử lý `hasError` → border `#D4271D`. Verify animation border-color 150ms ease-in-out | `lib/features/kudos/presentation/screens/send_kudos_screen.dart`
- [ ] T016 [US2] Verify `RecipientDropdownWidget` đã xử lý `hasError` → border đỏ | `lib/features/kudos/presentation/widgets/recipient_dropdown_widget.dart`
- [ ] T017 [US2] Verify `HashtagChipGroupWidget` xử lý `hasError` → border nút "+" chuyển đỏ. Sửa nếu chưa có | `lib/features/kudos/presentation/widgets/hashtag_chip_group_widget.dart`
- [ ] T018 [US2] Verify localized error text hiển thị dưới trường lỗi qua `_ErrorText` widget + extension `localizedError()`. Thêm case `'recipient_self_send'` vào extension | `lib/features/kudos/presentation/screens/send_kudos_screen.dart`

**Checkpoint**: Border đỏ trên trường thiếu, quay lại bình thường khi sửa. Self-send error text hiển thị.

---

## Phase 5: US3 — Tự động scroll đến lỗi đầu tiên

**Mục tiêu**: Form auto-scroll đến error banner hoặc trường lỗi đầu tiên trong 300ms

**Kiểm thử độc lập**: Scroll xuống dưới form → bấm "Gửi đi" → form scroll lên error banner

- [x] T019 [US3] Thêm `ScrollController` vào `SendKudosScreen` (nếu chưa có). Thêm `GlobalKey` cho error banner container | `lib/features/kudos/presentation/screens/send_kudos_screen.dart`
- [x] T020 [US3] Implement auto-scroll logic: sau khi `validate()` fail và state rebuild → `WidgetsBinding.instance.addPostFrameCallback` → `Scrollable.ensureVisible(errorBannerKey.currentContext, duration: 300ms, curve: Curves.easeOut)`. Fallback: `scrollController.animateTo(0)` nếu context null | `lib/features/kudos/presentation/screens/send_kudos_screen.dart`

**Checkpoint**: Auto-scroll đến error banner hoạt động trong 300ms.

---

## Phase Final: Polish & Verify

- [ ] T021 [P] Chạy `flutter analyze` — đảm bảo 0 errors/warnings | Toàn bộ project
- [ ] T022 [P] Chạy `flutter test test/unit/` — tất cả unit tests pass | `test/unit/`
- [ ] T023 Verify trên simulator: form rỗng → "Gửi đi" → error banner + border đỏ → sửa 1 trường → banner ẩn + border quay lại → "Gửi đi" lại → shake animation | Device testing

**Checkpoint**: Validation error state hoàn chỉnh theo spec `0le8xKnFE_`.

---

## Phụ thuộc & Thứ tự thực thi

### Phụ thuộc giữa Phases

```
Phase 1 (Setup) ──────────────────────────┐
    │                                      │
    v                                      │
Phase 2 (Foundation — ViewModel Logic)     │
    │                                      │
    ├──> Phase 3 (US1: Error Banner)       │
    │                                      │
    ├──> Phase 4 (US2: Visual Indicators)  │
    │    (song song với Phase 3)           │
    │                                      │
    └──> Phase 5 (US3: Auto-scroll)        │
         (sau Phase 3 — cần banner key)    │
              │                            │
              v                            │
         Phase Final (Polish) ─────────────┘
```

### Song song trong mỗi Phase

- **Phase 1**: T001, T002 song song. T003 cuối (cần T001, T002)
- **Phase 2**: T004–T006 song song (tests). T007–T009 tuần tự (implementation). T010 cuối
- **Phase 3**: T011 trước T012–T014
- **Phase 4**: T015–T018 song song (verify/sửa từng widget độc lập)
- **Phase 5**: T019 trước T020

---

## Chiến lược triển khai

### MVP First (Khuyến nghị)

1. Phase 1 + 2 (Setup + ViewModel Logic)
2. Phase 3 (Error Banner) — **TEST**: bấm "Gửi đi" rỗng → banner hiện
3. Phase 4 (Visual Indicators) — **TEST**: border đỏ hiển thị đúng
4. Phase 5 (Auto-scroll)
5. Phase Final (Polish)

**Ước lượng**: ~1.5 ngày

---

## Ghi chú

- Đây là error state của `PV7jBVZU1N`, KHÔNG phải screen riêng
- TDD bắt buộc: Test → FAIL → Implement → PASS → Refactor
- Nút "Gửi đi" vẫn ENABLED ở error state (FR-006)
- Validation chạy local, không gọi API
- Commit sau mỗi phase hoặc nhóm logic
