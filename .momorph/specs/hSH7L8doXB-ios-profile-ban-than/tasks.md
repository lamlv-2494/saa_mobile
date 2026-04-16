# Tasks: Profile Bản Thân

**Frame**: `hSH7L8doXB-ios-profile-ban-than`
**Prerequisites**: plan.md ✅, spec.md ✅, design-style.md ✅

---

## Task Format

```
- [ ] T### [P?] [Story?] Description | file/path.dart
```

- **[P]**: Có thể chạy song song (file khác nhau, không phụ thuộc lẫn nhau)
- **[Story]**: User story tương ứng (US1–US8)
- **|**: File bị ảnh hưởng

---

## Phase 1: Setup (Chuẩn bị)

**Mục đích**: Tạo SVG asset + test infrastructure dùng chung cho tất cả user stories

- [ ] T001 Tạo file SVG ic_chevron_down.svg (16×16 viewBox, path mũi tên xuống, stroke: currentColor) | assets/icons/ic_chevron_down.svg
- [ ] T002 Chạy `dart run build_runner build` để regenerate flutter_gen — verify `Assets.icons.icChevronDown` xuất hiện | lib/gen/assets.gen.dart
- [ ] T003 [P] Tạo test helpers: MockProfileRepository, MockKudosRepository, factory makeUserProfile(), makePersonalStats(), makeIconBadge(), makeKudos() | test/helpers/profile_test_helpers.dart

---

## Phase 2: Foundation (Bug Fix P0 — bắt buộc trước US7)

**Mục đích**: Fix ViewModel bug `isLoadingMoreKudos` — bộ loading spinner cuối Kudos list không bao giờ hiện

**⚠️ CRITICAL**: US7 (infinite scroll loading indicator) bị broken cho đến khi phase này xong

- [ ] T004 Fix `loadMoreKudos()`: thêm early-return khi `isLoadingMoreKudos=true`; set `isLoadingMoreKudos: true` trước await; set `false` trong cả try-success và catch | lib/features/profile/presentation/viewmodels/profile_viewmodel.dart
- [ ] T005 [P] Áp dụng fix `isLoadingMoreKudos` tương tự cho `OtherProfileViewModel.loadMoreKudos()` | lib/features/profile/presentation/viewmodels/other_profile_viewmodel.dart

**Checkpoint**: `isLoadingMoreKudos` được toggle đúng — Phase 8 (US7) có thể tiến hành

---

## Phase 3: US1 — Xem thông tin profile cá nhân (Priority: P1) 🎯 MVP

**Goal**: Avatar 72×72, border 1.911px, tên vàng 18px Bold, team code trắng 14px Regular, gap 24px khớp Figma

**Independent Test**: `flutter test test/widget/profile/profile_info_widget_test.dart` pass toàn bộ

### Tests (TDD — viết trước implementation, sẽ FAIL với code hiện tại)

- [ ] T006 [P] Viết widget test: avatar container 72×72px + border width 1.911px | test/widget/profile/profile_info_widget_test.dart
- [ ] T007 [P] Viết widget test: username color=AppColors.textAccent (vàng) + fontSize=18 + fontWeight=w700 | test/widget/profile/profile_info_widget_test.dart
- [ ] T008 [P] Viết widget test: teamCode color=AppColors.textWhite + fontSize=14 + fontWeight=w400 | test/widget/profile/profile_info_widget_test.dart
- [ ] T009 [P] Viết widget test: SizedBox height=24 giữa avatar và name group | test/widget/profile/profile_info_widget_test.dart
- [ ] T010 [P] Viết widget test: heroTier='none' → không render hình danh hiệu | test/widget/profile/profile_info_widget_test.dart
- [ ] T011 [P] Viết widget test: avatarUrl null → hiển thị placeholder chữ cái đầu tên | test/widget/profile/profile_info_widget_test.dart
- [ ] T012 [P] Viết unit test: `build()` trả về state có profile + stats + badges + kudosList đầy đủ | test/unit/viewmodels/profile_viewmodel_test.dart
- [ ] T013 [P] Viết unit test: `build()` sets `kudosFilter = KudosFilterType.sent` (default filter) | test/unit/viewmodels/profile_viewmodel_test.dart

### Implementation (US1)

- [ ] T014 [US1] Fix profile_info_widget.dart — 5 thay đổi: (1) avatar `width/height: 64`→`72`, `Border.all(width: 0.865)`→`width: 1.911`; (2) username `fontSize: 16`→`18`, `color: AppColors.textWhite`→`AppColors.textAccent`; (3) teamCode `fontSize: 12, w500, textSecondary`→`14, w400, textWhite`; (4) SizedBox after `_buildAvatar()`: `height: 8`→`height: 24` | lib/features/profile/presentation/widgets/profile_info_widget.dart

**Checkpoint**: US1 complete — T006–T011 tests pass ✅

---

## Phase 4: US3 + US4 — Thống kê cá nhân & Mở Secret Box (Priority: P1)

**Goal**: 5 stat rows đúng giá trị + màu; nút "Mở Secret Box" enabled/disabled đúng trạng thái; disabled text opacity 40%

**Independent Test**: `flutter test test/widget/profile/personal_stats_card_test.dart` pass toàn bộ

### Tests (TDD — viết trước)

- [ ] T015 [P] [US3] Viết widget test: PersonalStatsCard hiển thị đủ 5 stat labels + giá trị màu AppColors.textAccent | test/widget/profile/personal_stats_card_test.dart
- [ ] T016 [P] [US3] Viết widget test: Divider color=Color(0xFF2E3940) xuất hiện giữa nhóm Kudos/Hearts và Secret Box | test/widget/profile/personal_stats_card_test.dart
- [ ] T017 [P] [US4] Viết widget test: `secretBoxesUnopened > 0` → PrimaryButton enabled (opacity 1.0, bg=AppColors.buttonBg) | test/widget/profile/personal_stats_card_test.dart
- [ ] T018 [P] [US4] Viết widget test: `secretBoxesUnopened == 0` → PrimaryButton disabled (text withAlpha(102) ≈ 40%) — **sẽ FAIL** với code hiện tại (128≠102) | test/widget/profile/personal_stats_card_test.dart
- [ ] T019 [P] [US4] Viết widget test: tap PrimaryButton enabled → `onOpenSecretBox` callback được gọi | test/widget/profile/personal_stats_card_test.dart
- [ ] T020 [P] [US4] Viết widget test: tap PrimaryButton disabled → `onOpenSecretBox` callback KHÔNG được gọi | test/widget/profile/personal_stats_card_test.dart

### Implementation (US3+US4)

- [ ] T021 [US4] Fix primary_button.dart: disabled text `AppColors.buttonText.withAlpha(128)` → `AppColors.buttonText.withAlpha(102)` (40% opacity per design-style) | lib/shared/widgets/primary_button.dart

**Checkpoint**: US3+US4 complete — T015–T020 tests pass ✅

---

## Phase 5: US5 — Xem danh sách Kudos theo filter (Priority: P1)

**Goal**: Dropdown filter đúng style Figma (overlay bg #00070C, selected bg 10% gold, option text trắng, chevron SVG)

**Independent Test**: `flutter test test/widget/profile/profile_kudos_filter_dropdown_test.dart` pass toàn bộ

### Tests (TDD — viết trước, sẽ FAIL với code hiện tại)

- [ ] T022 [P] [US5] Viết unit test: `changeFilter(received)` → repo được gọi với `filter='received'`, page reset về 1 | test/unit/viewmodels/profile_viewmodel_test.dart
- [ ] T023 [P] [US5] Viết widget test: dropdown button hiển thị label + icon (Chevron SVG sau fix) | test/widget/profile/profile_kudos_filter_dropdown_test.dart
- [ ] T024 [P] [US5] Viết widget test: tap dropdown → overlay xuất hiện với bg=AppColors.surfaceDark (#00070C) | test/widget/profile/profile_kudos_filter_dropdown_test.dart
- [ ] T025 [P] [US5] Viết widget test: option đang selected có bg=Color(0x1AFFEA9E); option còn lại bg=transparent | test/widget/profile/profile_kudos_filter_dropdown_test.dart
- [ ] T026 [P] [US5] Viết widget test: option text color=AppColors.textWhite (trắng, không phải vàng) | test/widget/profile/profile_kudos_filter_dropdown_test.dart
- [ ] T027 [P] [US5] Viết widget test: tap option → overlay đóng + `onChanged` callback được gọi với filter đúng | test/widget/profile/profile_kudos_filter_dropdown_test.dart

### Implementation (US5)

- [ ] T028 [US5] Fix profile_kudos_filter_dropdown.dart — 4 thay đổi: (1) overlay bg `AppColors.bgDark`→`AppColors.surfaceDark`; (2) selected item bg `AppColors.outlineBtnBg`→`const Color(0x1AFFEA9E)`; (3) option text `AppColors.textAccent`→`AppColors.textWhite`; (4) chevron `Icons.keyboard_arrow_up/down`→`Assets.icons.icChevronDown.svg(width: 16, height: 16, colorFilter: const ColorFilter.mode(AppColors.textAccent, BlendMode.srcIn))` | lib/features/profile/presentation/widgets/profile_kudos_filter_dropdown.dart

**Checkpoint**: US5 complete — T022–T027 tests pass ✅

---

## Phase 6: US2 — Xem bộ sưu tập icon (Priority: P2)

**Goal**: Icon badge 32×32px tròn, gap 14px, section label 12px trắng; ẩn hoàn toàn khi rỗng

**Independent Test**: `flutter test test/widget/profile/icon_collection_widget_test.dart` pass toàn bộ

### Tests (TDD — viết trước, sẽ FAIL với code hiện tại)

- [ ] T029 [P] [US2] Viết widget test: icon badge slot 32×32px + shape circle + bg AppColors.iconDark (#1A1A2E) | test/widget/profile/icon_collection_widget_test.dart
- [ ] T030 [P] [US2] Viết widget test: gap giữa slots = EdgeInsets.only(right: 14) | test/widget/profile/icon_collection_widget_test.dart
- [ ] T031 [P] [US2] Viết widget test: section label fontSize=12, fontWeight=w400, color=AppColors.textWhite | test/widget/profile/icon_collection_widget_test.dart
- [ ] T032 [P] [US2] Viết widget test: iconBadges=[] → widget return SizedBox.shrink (không render) | test/widget/profile/icon_collection_widget_test.dart

### Implementation (US2)

- [ ] T033 [US2] Fix icon_collection_widget.dart — 3 thay đổi: (1) section label `fontSize: 14, w500, textAccent`→`12, w400, textWhite`; (2) icon slot `width/height: 44`→`32`; (3) slot gap `padding right: 8`→`14` | lib/features/profile/presentation/widgets/icon_collection_widget.dart

**Checkpoint**: US2 complete — T029–T032 tests pass ✅

---

## Phase 7: US6 — Tương tác với Kudos card (Priority: P2)

**Goal**: Heart toggle dùng optimistic update + rollback đúng; copy link + view detail callbacks hoạt động

**Independent Test**: Unit tests T034–T036 pass; `ProfileKudosListWidget` đã có callbacks — không cần sửa implementation

### Tests (TDD — US6)

- [ ] T034 [P] [US6] Viết unit test: `toggleHeart(like)` → state.isLikedByMe=true, heartCount+1 ngay lập tức (optimistic) | test/unit/viewmodels/profile_viewmodel_test.dart
- [ ] T035 [P] [US6] Viết unit test: `toggleHeart(like)` → repo throw → rollback isLikedByMe=false, heartCount trở về ban đầu | test/unit/viewmodels/profile_viewmodel_test.dart
- [ ] T036 [P] [US6] Viết unit test: `toggleHeart(unlike)` → state.isLikedByMe=false, heartCount-1 ngay lập tức | test/unit/viewmodels/profile_viewmodel_test.dart

*`ProfileKudosListWidget` đã có đầy đủ onHeartTap/onCopyLink/onViewDetail/onAvatarTap — không cần sửa implementation.*

**Checkpoint**: US6 complete — T034–T036 tests pass ✅

---

## Phase 8: US7 — Tải thêm Kudos - Infinite Scroll (Priority: P2)

**Goal**: Loading spinner cuối list hiện khi đang tải; pagination append đúng; guard chống double-trigger; card gap 24px

**Independent Test**: Unit tests T037–T041 pass; widget test T042–T043 pass

### Tests (TDD — US7)

- [ ] T037 [P] [US7] Viết unit test: `loadMoreKudos()` → `state.isLoadingMoreKudos=true` ngay khi gọi, `false` sau khi hoàn tất | test/unit/viewmodels/profile_viewmodel_test.dart
- [ ] T038 [P] [US7] Viết unit test: `loadMoreKudos()` → kudosList được append + page tăng lên | test/unit/viewmodels/profile_viewmodel_test.dart
- [ ] T039 [P] [US7] Viết unit test: `loadMoreKudos()` khi `hasMoreKudos=false` → repo KHÔNG được gọi | test/unit/viewmodels/profile_viewmodel_test.dart
- [ ] T040 [P] [US7] Viết unit test: `loadMoreKudos()` khi `isLoadingMoreKudos=true` → repo KHÔNG được gọi (guard double-trigger) | test/unit/viewmodels/profile_viewmodel_test.dart
- [ ] T041 [P] [US7] Viết unit test: `loadMoreKudos()` → repo throw → page decrement, `isLoadingMoreKudos=false` | test/unit/viewmodels/profile_viewmodel_test.dart
- [ ] T042 [P] [US7] Viết widget test: ProfileKudosListWidget `isLoadingMore=true` → CircularProgressIndicator visible ở cuối list | test/widget/profile/profile_screen_test.dart
- [ ] T043 [P] [US7] Viết widget test: ProfileKudosListWidget `kudosList=[]` + `isLoadingMore=false` → text "Chưa có Kudos nào." visible | test/widget/profile/profile_screen_test.dart

### Implementation (US7)

- [ ] T044 [US7] Fix profile_kudos_list_widget.dart: card gap `Padding(padding: const EdgeInsets.only(bottom: 8))`→`EdgeInsets.only(bottom: 24)` | lib/features/profile/presentation/widgets/profile_kudos_list_widget.dart

*Bug fix `isLoadingMoreKudos` đã được xử lý trong Phase 2 (T004).*

**Checkpoint**: US7 complete — T037–T043 tests pass, loading indicator hoạt động ✅

---

## Phase 9: US8 — Pull-to-refresh (Priority: P2)

**Goal**: Kéo xuống reload toàn bộ dữ liệu profile; error state có retry

**Independent Test**: Unit test T045 pass; widget test T046 pass

### Tests (TDD — US8)

- [ ] T045 [P] [US8] Viết unit test: `refresh()` → state chuyển AsyncLoading → AsyncData với dữ liệu mới | test/unit/viewmodels/profile_viewmodel_test.dart
- [ ] T046 [P] [US8] Viết widget test: ProfileScreen error state → tap retry text → `profileViewModelProvider.notifier.refresh()` được gọi | test/widget/profile/profile_screen_test.dart

*`ProfileScreen.RefreshIndicator` đã gọi `ProfileViewModel.refresh()` — không cần sửa implementation.*

**Checkpoint**: US8 complete — T045–T046 tests pass ✅

---

## Phase 10: Polish & Cross-Cutting Concerns

**Mục đích**: Hoàn thiện ProfileScreen widget tests, lint, format, manual verification

- [ ] T047 [P] Viết widget test: ProfileScreen state=loading → CircularProgressIndicator visible | test/widget/profile/profile_screen_test.dart
- [ ] T048 [P] Viết widget test: ProfileScreen state=error → error text visible | test/widget/profile/profile_screen_test.dart
- [ ] T049 Run `dart format lib/features/profile test/` trên tất cả files đã thay đổi
- [ ] T050 Run `flutter analyze` → fix tất cả warnings về 0 warnings
- [ ] T051 Test trên iOS simulator: verify tất cả visual fixes khớp Figma design (avatar, typography, dropdown, icon collection, card gap)

---

## Dependencies & Execution Order

### Phase Dependencies

```
Phase 1 (Setup)
  ├── T001-T002 (SVG + build_runner) → BLOCKS Phase 5 (US5, cần Assets.icons.icChevronDown)
  └── T003 (test helpers) → BLOCKS tất cả test phases

Phase 2 (Foundation)
  └── T004-T005 (bug fix) → BLOCKS US7 tests (Phase 8)

Phase 3 (US1): Độc lập sau Phase 1
Phase 4 (US3+US4): Độc lập sau Phase 1
Phase 5 (US5): Phụ thuộc T002 (cần Assets.icons.icChevronDown)
Phase 6 (US2): Độc lập sau Phase 1
Phase 7 (US6): Độc lập sau Phase 1 (chỉ unit tests)
Phase 8 (US7): Phụ thuộc Phase 2 (T004)
Phase 9 (US8): Độc lập sau Phase 1
Phase 10 (Polish): Phụ thuộc tất cả phases trước
```

### TDD Order Trong Mỗi User Story

1. **Viết test** → test FAIL hoặc PASS (document expected behavior)
2. **Sửa code** → test PASS
3. **Run `flutter analyze`** → 0 warnings
4. **Commit** logical group

### Parallel Execution (Sau Phase 1 + 2)

```
Thread A │ T006-T014 │ US1 — ProfileInfoWidget
Thread B │ T015-T021 │ US3+US4 — PersonalStatsCard + PrimaryButton
Thread C │ T022-T028 │ US5 — ProfileKudosFilterDropdown
Thread D │ T029-T033 │ US2 — IconCollectionWidget
Thread E │ T034-T036 │ US6 — Unit tests toggleHeart (không cần wait US7)
```

Phase 8 (US7) bắt đầu sau Phase 2 (T004+T005) xong.

---

## Implementation Strategy

### MVP Scope (P1 Stories — Phase 3+4+5)

1. Phase 1 (Setup) → Phase 2 (Bug Fix)
2. Phase 3 + Phase 4 + Phase 5 (song song)
3. **STOP và VALIDATE**: Visual match Figma, filter hoạt động → ship MVP
4. Tiếp tục Phase 6–9 (P2 stories)

### Incremental Delivery

1. Phase 1+2 → Commit "setup: add ic_chevron_down asset + fix loadMoreKudos bug"
2. Phase 3 (US1) → Commit "fix: profile info widget visual discrepancies"
3. Phase 4 (US3+US4) → Commit "fix: primary button disabled opacity"
4. Phase 5 (US5) → Commit "fix: kudos filter dropdown visual fixes"
5. Phase 6 (US2) → Commit "fix: icon collection widget visual fixes"
6. Phase 7+8 (US6+US7) → Commit "feat: kudos interactions + scroll indicator"
7. Phase 9 (US8) → Commit "test: add refresh + pull-to-refresh tests"
8. Phase 10 → Commit "chore: lint, format, final polish"

---

## Summary

| Metric | Giá trị |
|--------|---------|
| Tổng số tasks | 51 |
| Tasks tạo file mới | T001, T003, T006–T013, T015–T020, T022–T027, T029–T032, T034–T036, T037–T043, T045–T048 |
| Tasks sửa file | T004, T005, T014, T021, T028, T033, T044 |
| Tasks implementation | 7 (fix code) |
| Tasks tests | 39 (unit + widget) |
| Tasks tooling | 5 (build_runner, format, analyze, simulator) |
| P1 stories | US1, US3, US4, US5 |
| P2 stories | US2, US6, US7, US8 |
| Parallel opportunities | 5 threads sau Phase 1+2 |
| MVP scope | Phase 1–5 (US1 + US3 + US4 + US5) |

---

## Notes

- **TDD nghiêm ngặt per constitution**: Test phải viết TRƯỚC implementation trong cùng user story
- Test cho visual fixes (T006–T011, T023–T026, T029–T031, T042–T043) sẽ **FAIL** với code hiện tại — đây là expected
- Test cho logic đã work (T012–T013, T022, T034–T036, T045) sẽ **PASS** ngay — vẫn quan trọng để document behavior và bảo vệ khỏi regression
- `primary_button.dart` là shared widget — kiểm tra tất cả usages (`PersonalStatsCard`, `send_kudos`) trước khi commit T021
- Mark tasks complete khi xong: `- [x] T###`
