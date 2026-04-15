# Tasks: [iOS] Sun*Kudos — Viết Kudo (Trạng thái mặc định)

**Frame**: `7fFAb-K35a-ios-sun-kudos-viet-kudo-default`
**Prerequisites**: plan.md, spec.md, design-style.md
**Màn hình parent**: `PV7jBVZU1N` — Gửi lời chúc Kudos (đã implement)

> **Lưu ý**: Đây KHÔNG phải screen mới — là trạng thái rỗng ban đầu (initial state) của `SendKudosScreen` đã có. Phạm vi chủ yếu là **verify + test + polish nhỏ**.

---

## Định dạng Task

```
- [ ] T### [P?] [Story?] Mô tả | đường/dẫn/file
```

- **[P]**: Có thể chạy song song (file khác nhau, không phụ thuộc lẫn nhau)
- **[Story]**: User story liên quan (US1, US2)
- **|**: File bị ảnh hưởng bởi task

---

## Phase 0: Setup (Xác nhận trạng thái hiện tại)

**Mục đích**: Review lại implementation hiện có trước khi thêm tests + sửa nhỏ

- [x] T001 Review `SendKudosState` default values, `isFormValid` getter, `_SendButton` widget, `RecipientDropdownWidget` focus state — đối chiếu với spec checklist | `lib/features/kudos/presentation/screens/send_kudos_screen.dart`, `lib/features/kudos/data/models/send_kudos_state.dart`

**Checkpoint**: Hiểu rõ hiện trạng. Biết chính xác phần nào cần sửa/thêm.

---

## Phase 1: US1 — Hiển thị form rỗng với hướng dẫn (Ưu tiên: P1) 🎯 MVP

**Mục tiêu**: Đảm bảo initial state của `SendKudosState` đúng qua tests, animation button mượt

**Kiểm thử độc lập**: Chạy `flutter test test/unit/models/send_kudos_state_test.dart` và `flutter test test/widget/kudos/`

### Tests (viết trước — TDD)

- [x] T002 [P] [US1] Viết unit tests cho `SendKudosState` default values: `recipientId == null`, `title == ''`, `message == ''`, `hashtags == []`, `imagePreviews == []`, `isAnonymous == false`, `isDirty == false`, `showErrorBanner == false` | `test/unit/models/send_kudos_state_test.dart`
- [x] T003 [P] [US1] Viết unit tests cho `isFormValid` getter trả `false` trong 4 trường hợp: thiếu recipientId, thiếu title, thiếu message, thiếu hashtags | `test/unit/models/send_kudos_state_test.dart`
- [x] T004 [US1] Viết unit test cho `SendKudosViewModel.build()` trả về initial state rỗng (`availableHashtags` được load từ API, tất cả fields còn lại empty/null/false) | `test/unit/viewmodels/send_kudos_viewmodel_test.dart`
- [x] T005 [US1] Viết widget test cho `SendKudosScreen` trạng thái mặc định: tất cả placeholders hiển thị đúng theo i18n, toolbar tất cả inactive (màu `Color(0x99FFFFFF)`), send button disabled (opacity bg giảm), checkbox unchecked, chỉ có nút "+" cho Hashtag và Image | `test/widget/kudos/send_kudos_screen_default_state_test.dart`

### Implementation

- [x] T006 [US1] Implement animation `AnimatedContainer` 200ms ease-in-out cho `_SendButton` khi transition disabled→enabled | `lib/features/kudos/presentation/screens/send_kudos_screen.dart`
- [x] T007 [P] [US1] Fix `RecipientDropdownMenuWidget` focus state: `focusedBorder` chuyển sang `#FFEA9E` khi không có error | `lib/features/kudos/presentation/widgets/recipient_dropdown_menu_widget.dart`

### Xác minh

- [x] T008 [US1] Chạy `flutter test` — đảm bảo T002–T005 pass (Green phase TDD). Fix implementation nếu test fail | `test/`
- [x] T009 [N/A — Device] Visual verification trên iOS Simulator — skipped trong context CI/TDD | Simulator

**Checkpoint**: Unit + widget tests pass. Send button animation mượt. Focus border hoạt động đúng.

---

## Phase 2: US2 — Hiển thị nhãn bắt buộc (Ưu tiên: P1)

**Mục tiêu**: Xác nhận các trường bắt buộc có dấu "*" hiển thị đúng

**Kiểm thử độc lập**: Verify widget test pass + visual check

### Tests (viết trước — TDD)

- [x] T010 [P] [US2] Viết widget tests xác nhận labels bắt buộc có dấu "*": `"Recipient *"`, `"Title *"`, `"Hashtag *"` — và `"Attach image"` KHÔNG có "*" (test dùng EN locale mặc định) | `test/widget/kudos/send_kudos_screen_default_state_test.dart`

### Xác minh

- [x] T011 [US2] Chạy `flutter test test/widget/kudos/send_kudos_screen_default_state_test.dart` — pass 100% (10/10) | `test/widget/kudos/`

**Checkpoint**: Tất cả label bắt buộc đúng. Tests pass.

---

## Phase 3: Polish

**Mục đích**: Code quality + đảm bảo không có regression

- [x] T012 [P] Chạy `flutter analyze` — 0 warnings, 0 lint errors | Toàn bộ project
- [x] T013 [P] Chạy `dart format .` — đảm bảo formatting đúng | Toàn bộ project
- [x] T014 Chạy toàn bộ test suite `flutter test` — 6 pre-existing failures trong kudos_card highlight variant, không có regression mới | `test/`

**Checkpoint**: Feature hoàn chỉnh. Lint clean. 0 regression.

---

## Phụ thuộc & Thứ tự thực thi

```
Phase 0 (Review) ──────────┐
                            |
                            v
Phase 1 (US1 — Tests) ─────┐ T002, T003, T004, T005 song song
                            |
                            v
Phase 1 (US1 — Impl) ──────┐ T006, T007 song song (sau khi tests fail xác nhận Red)
                            |
                            v
Phase 1 (US1 — Verify) ────┐ T008, T009 tuần tự
                            |
                            v
Phase 2 (US2) ─────────────┐ T010, T011
                            |
                            v
Phase 3 (Polish) ───────────┘ T012, T013 song song; T014 cuối
```

### Song song trong mỗi Phase

- **Phase 1 Tests**: T002, T003, T004, T005 — song song (cùng test class nhưng logic độc lập)
- **Phase 1 Impl**: T006, T007 — song song (file khác nhau)
- **Phase 3**: T012, T013 — song song

---

## Chiến lược triển khai

### Thứ tự khuyến nghị

1. T001 — Review hiện trạng
2. T002–T005 — Viết tests (RED phase)
3. T006–T007 — Implement (GREEN phase)
4. T008–T009 — Verify
5. T010–T011 — Label tests
6. T012–T014 — Polish

---

## Tổng kết

| Phase | Số tasks | Loại |
|-------|---------|------|
| Phase 0: Setup | 1 | Review |
| Phase 1: US1 | 8 | Tests + Impl + Verify |
| Phase 2: US2 | 2 | Tests + Verify |
| Phase 3: Polish | 3 | Quality |
| **Tổng** | **14** | |

---

## Ghi chú

- TDD bắt buộc: Viết test → Test FAIL (Red) → Implement → Test PASS (Green) → Refactor
- Đây là trạng thái rỗng của `PV7jBVZU1N` — KHÔNG tạo widget mới, chỉ verify + sửa nhỏ
- Tất cả placeholder/label text PHẢI dùng i18n (slang), không hardcode
- Asset paths PHẢI dùng `flutter_gen` (`Assets.xxx`), không hardcode string
- Ước lượng effort: ~0.5 ngày (chủ yếu test + animation + verify)
- Danh dấu task hoàn thành: `[x]`
