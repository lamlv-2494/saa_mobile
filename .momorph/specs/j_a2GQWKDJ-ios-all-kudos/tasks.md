# Tasks: [iOS] Sun*Kudos — All Kudos

**Frame**: `j_a2GQWKDJ-ios-all-kudos`
**Prerequisites**: plan.md ✅, spec.md ✅, design-style.md ✅

---

## Dinh dang Task

```
- [ ] T### [P?] [Story?] Mo ta | duong/dan/file
```

- **[P]**: Co the chay song song (file khac nhau, khong phu thuoc lan nhau)
- **[Story]**: User story lien quan (US1–US4)
- **|**: File bi anh huong boi task

---

## Phase 1: Setup (Chuan bi i18n & Assets)

**Muc dich**: Them i18n keys moi, icon back, chuan bi ha tang cho All Kudos page

- [x] T001 [P] Them i18n keys cho All Kudos page vao strings_vi.i18n.json: `allKudosNavbarTitle`, `allKudosSectionTitle`, `allKudosPullToRefresh`, `allKudosLoadingMore`, `allKudosEmpty`, `allKudosLoadError`, `allKudosRetry` | `lib/i18n/strings_vi.i18n.json`
- [x] T002 [P] Them i18n keys cho All Kudos page vao strings_en.i18n.json: cung keys nhu T001 voi ban dich tieng Anh | `lib/i18n/strings_en.i18n.json`
- [x] T003 [P] Them icon `ic_chevron_left.svg` vao assets/icons/ — icon back cho All Kudos navbar. Dung momorph tool `get_media_files` de download tu Figma | `assets/icons/ic_chevron_left.svg`
- [x] T004 Chay `dart run build_runner build` de regenerate flutter_gen assets + slang i18n strings | `lib/gen/`, `lib/i18n/strings.g.dart`

**Checkpoint**: Assets va i18n san sang. Chay `flutter analyze` dat 0 warnings.

---

## Phase 2: Foundation (Mo rong Data Layer — KudosState + ViewModel)

**Muc dich**: Mo rong KudosState voi fields pagination cho All Kudos page, them methods vao KudosViewModel

**⚠️ QUAN TRONG**: TDD bat buoc — viet test TRUOC khi implement

### Mo rong KudosState (freezed)

- [x] T005 Viet test cho KudosState mo rong: verify default values cua `allKudosPageList` (empty list), `allKudosCurrentPage` (0), `allKudosHasMore` (true), `allKudosIsLoadingMore` (false). Test copyWith hoat dong dung voi fields moi | `test/unit/models/kudos_state_test.dart`
- [x] T006 Mo rong `KudosState` (freezed) — them 3 fields: `List<Kudos> allKudosPageList` (default: []), `bool hasMoreAllKudosPage` (default: true), `bool isLoadingMoreAllKudos` (default: false) | `lib/features/kudos/data/models/kudos_state.dart`
- [x] T007 Chay `dart run build_runner build` de regenerate `.freezed.dart` cho KudosState | `lib/features/kudos/data/models/kudos_state.freezed.dart`

### Mo rong KudosViewModel

- [x] T008 Viet test cho `KudosViewModel.loadAllKudosPage()`: verify goi repository dung params (page=0, limit=20), state cap nhat `allKudosPageList` dung, `allKudosCurrentPage` = 0. Test khi goi lan 2 khong reload neu da co data | `test/unit/viewmodels/kudos_viewmodel_all_kudos_test.dart`
- [x] T009 Viet test cho `KudosViewModel.loadMoreAllKudos()`: verify pagination increment (page+1), append data vao `allKudosPageList`, cap nhat `allKudosHasMore` = false khi tra ve < limit items. Test guard: khong goi khi `allKudosIsLoadingMore == true`. Test guard: khong goi khi `allKudosHasMore == false`. Test error: load fail → page counter rollback, state giu nguyen | `test/unit/viewmodels/kudos_viewmodel_all_kudos_test.dart`
- [x] T010 Viet test cho `KudosViewModel.refreshAllKudos()`: verify reset `allKudosCurrentPage` = 0, reload data tu dau, `allKudosPageList` duoc thay the (khong append) | `test/unit/viewmodels/kudos_viewmodel_all_kudos_test.dart`
- [x] T011 Viet test cho `_updateKudosInState()` dong bo 3 danh sach: khi toggleHeart, verify cap nhat heart count + isLikedByMe trong ca `allKudos`, `allKudosPageList`, va `highlightKudos` | `test/unit/viewmodels/kudos_viewmodel_all_kudos_test.dart`
- [x] T012 Implement `loadAllKudosPage()` trong KudosViewModel: goi `_repository.getKudos(page: 0, limit: 20)`, cap nhat state. Lazy load — chi goi khi `allKudosPageList` rong | `lib/features/kudos/presentation/viewmodels/kudos_viewmodel.dart`
- [x] T013 Implement `loadMoreAllKudos()` trong KudosViewModel: tang page, goi repository, append ket qua. Guard: skip neu `isLoadingMore` hoac `!hasMore`. Error: rollback page counter | `lib/features/kudos/presentation/viewmodels/kudos_viewmodel.dart`
- [x] T014 Implement `refreshAllKudos()` trong KudosViewModel: reset page = 0, `allKudosHasMore` = true, goi repository, thay the `allKudosPageList` | `lib/features/kudos/presentation/viewmodels/kudos_viewmodel.dart`
- [x] T015 Cap nhat `_updateKudosInState()` trong KudosViewModel: them logic update `allKudosPageList` khi heart toggle — dong bo ca 3 danh sach (`allKudos`, `allKudosPageList`, `highlightKudos`) | `lib/features/kudos/presentation/viewmodels/kudos_viewmodel.dart`
- [x] T016 Cap nhat test helpers: them mock data factories cho All Kudos page (list 20+ kudos de test pagination) | `test/helpers/kudos_test_helpers.dart`

**Checkpoint**: Data layer mo rong hoan chinh. `flutter test test/unit/` pass 100%. ViewModel co 3 methods moi + heart sync 3 lists.

---

## Phase 3: US2 — PageView Wrapper cho KudosScreen (P1)

**Muc dich**: Wrap KudosScreen hien tai trong PageView, ket noi "Xem tat ca" voi page 1

**Kiem thu doc lap**: Bam "Xem tat ca" → animate sang page 1. Bam back → animate ve page 0. Khong the swipe giua 2 pages.

- [ ] T017 Viet widget test cho KudosScreen PageView: verify PageView co 2 pages, `NeverScrollableScrollPhysics`, "Xem tat ca" tap → animate sang page 1, back button → animate ve page 0. Verify scroll position page 0 giu nguyen sau khi back | `test/widget/kudos/kudos_screen_pageview_test.dart`
- [x] T018 [US2] Sua `KudosScreen`: them `PageController _pageController` trong `_KudosScreenState`. Wrap content hien tai (Stack + RefreshIndicator) thanh page 0 trong `PageView(controller: _pageController, physics: NeverScrollableScrollPhysics(), children: [page0, page1])`. Page 1 = placeholder `AllKudosPageView` (tam thoi Container rong) | `lib/features/kudos/presentation/screens/kudos_screen.dart`
- [ ] T019 [US2] Ket noi "Xem tat ca" GestureDetector.onTap: thay `// TODO: Navigate to full kudos feed screen` bang `_pageController.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.easeInOut)`. Dong thoi goi `vm.loadAllKudosPage()` de lazy load data | `lib/features/kudos/presentation/screens/kudos_screen.dart`
- [ ] T020 [US2] Dispose `_pageController` trong `dispose()` method cua `_KudosScreenState` | `lib/features/kudos/presentation/screens/kudos_screen.dart`

**Checkpoint**: PageView navigation hoat dong. "Xem tat ca" animate sang page 1. Page 0 khong bi swipe.

---

## Phase 4: US1+US4 — All Kudos Page UI (P1)

**Muc dich**: Tao AllKudosPageView widget hoan chinh voi danh sach kudos, header, infinite scroll

**Kiem thu doc lap**: Trang All Kudos hien thi header "ALL KUDOS", danh sach KudosCard, infinite scroll load them, pull-to-refresh, empty state.

### Widget AllKudosPageView

- [ ] T021 Viet widget test cho `AllKudosPageView`: verify render danh sach KudosCard dung, back button goi callback, empty state khi list rong, loading more indicator khi `isLoadingMore == true`, header hien thi "ALL KUDOS" | `test/widget/kudos/all_kudos_page_view_test.dart`
- [ ] T022 Viet widget test cho infinite scroll trong `AllKudosPageView`: simulate scroll gan cuoi (200px threshold) → verify goi `onLoadMore` callback | `test/widget/kudos/all_kudos_page_view_test.dart`
- [ ] T023 Viet widget test cho pull-to-refresh trong `AllKudosPageView`: verify trigger `onRefresh` callback | `test/widget/kudos/all_kudos_page_view_test.dart`
- [ ] T024 [US1] [US4] Tao `AllKudosPageView` widget (`StatelessWidget`). Nhan params: `List<Kudos> kudosList`, `bool hasMore`, `bool isLoadingMore`, `VoidCallback onBackToFeed`, `VoidCallback onLoadMore`, `Future<void> Function() onRefresh`, `void Function(String) onHeartTap`, `void Function(String) onAvatarTap`, `String Function(DateTime) formatTimeAgo`. Layout: Stack → RefreshIndicator → CustomScrollView voi SliverAppBar (gradient bg, leading: back icon `Assets.icons.icChevronLeft.svg()`, title: `t.kudos.allKudosNavbarTitle`) + SliverToBoxAdapter (SectionHeaderWidget: subtitle "Sun* Annual Awards 2025" + divider + title "ALL KUDOS") + SliverPadding chua SliverList.separated (KudosCard variant: feed) + loading indicator cuoi list + bottom spacing | `lib/features/kudos/presentation/widgets/all_kudos_page_view.dart`
- [ ] T025 [US1] Implement infinite scroll: `ScrollController` listener trong AllKudosPageView — khi `scrollPosition.pixels >= scrollPosition.maxScrollExtent - 200` va `hasMore` va `!isLoadingMore` → goi `onLoadMore` | `lib/features/kudos/presentation/widgets/all_kudos_page_view.dart`
- [ ] T026 [US1] Implement empty state: khi `kudosList.isEmpty` va `!isLoadingMore` → hien thi text `t.kudos.allKudosEmpty` (center, style phu hop) | `lib/features/kudos/presentation/widgets/all_kudos_page_view.dart`

### Tich hop vao KudosScreen

- [ ] T027 [US1] Thay placeholder AllKudosPageView (Container rong tu T018) bang widget that. Truyen data tu KudosState: `allKudosPageList`, `allKudosHasMore`, `allKudosIsLoadingMore`. Truyen callbacks: `onBackToFeed` → animate page 0, `onLoadMore` → `vm.loadMoreAllKudos()`, `onRefresh` → `vm.refreshAllKudos()`, `onHeartTap` → `vm.toggleHeart()`, `onAvatarTap` → navigate profile | `lib/features/kudos/presentation/screens/kudos_screen.dart`

**Checkpoint**: All Kudos page hien thi danh sach day du. Infinite scroll + pull-to-refresh hoat dong. Header "ALL KUDOS" dung. Empty state khi khong co data.

---

## Phase 5: US3 — Tuong tac voi the Kudos (P2)

**Muc dich**: Heart toggle dong bo, copy link, xem chi tiet, avatar tap tren All Kudos page

**Kiem thu doc lap**: Bam heart tren All Kudos → count cap nhat ca 2 pages. Copy link → snackbar. Avatar → profile.

- [ ] T028 Viet test xac nhan heart toggle dong bo giua page 0 va page 1: toggleHeart tren 1 kudos → verify `allKudos`, `allKudosPageList`, `highlightKudos` deu cap nhat | `test/unit/viewmodels/kudos_viewmodel_all_kudos_test.dart`
- [ ] T029 [US3] Xac nhan KudosCard reuse trong AllKudosPageView: verify heart button, copy link, "Xem chi tiet" hoat dong dung. Heart → `vm.toggleHeart()`. Copy link → clipboard + snackbar. "Xem chi tiet" → placeholder navigation. Avatar tap → profile navigation | `lib/features/kudos/presentation/widgets/all_kudos_page_view.dart`

**Checkpoint**: Tat ca tuong tac KudosCard hoat dong tren All Kudos page. Heart sync giua 2 pages.

---

## Phase 6: Polish & Cross-cutting Concerns

**Muc dich**: Error handling, accessibility, animation fine-tune, performance

- [ ] T030 [P] Xu ly error state: load All Kudos that bai → hien thi error message `t.kudos.allKudosLoadError` + nut retry `t.kudos.allKudosRetry`. Load more that bai → hien thi "Thu lai" o cuoi danh sach, giu nguyen data da load | `lib/features/kudos/presentation/widgets/all_kudos_page_view.dart`
- [ ] T031 [P] Them `Semantics` widgets cho back button, list items, loading indicator theo spec accessibility | `lib/features/kudos/presentation/widgets/all_kudos_page_view.dart`
- [ ] T032 [P] Fine-tune PageView transition animation: 300ms ease-in-out. Verify scroll doc trong page 1 khong conflict voi PageView (NeverScrollableScrollPhysics) | `lib/features/kudos/presentation/screens/kudos_screen.dart`
- [ ] T033 [P] Tach `_formatTimeAgo()` tu `_KudosScreenState` ra utility function trong `lib/core/utils/` de reuse cho AllKudosPageView. Hoac truyen xuong qua callback (chon phuong an phu hop nhat) | `lib/core/utils/time_utils.dart` hoac `lib/features/kudos/presentation/screens/kudos_screen.dart`
- [ ] T034 Chay `flutter analyze` + `dart format` — dam bao 0 warnings, 0 lint errors | Toan bo project
- [ ] T035 Chay toan bo test suite: `flutter test` — dam bao tat ca tests pass, coverage >= 80% cho ViewModel All Kudos methods | `test/`

**Checkpoint**: Feature All Kudos hoan chinh. Tat ca tests pass. Lint clean. Error handling day du.

---

## Phu thuoc & Thu tu thuc thi

### Phu thuoc giua Phases

```
Phase 1 (Setup: i18n + Assets) ──────────────────────────┐
    │                                                      │
    v                                                      │
Phase 2 (Foundation: KudosState + ViewModel) ─────────────┤
    │                                                      │
    v                                                      │
Phase 3 (US2: PageView Wrapper) ──────────────────────────┤
    │                                                      │
    v                                                      │
Phase 4 (US1+US4: All Kudos Page UI) ─────────────────────┤
    │                                                      │
    v                                                      │
Phase 5 (US3: Tuong tac) ────────────────────────────────┤
    │                                                      │
    v                                                      │
Phase 6 (Polish) ─────────────────────────────────────────┘
```

### Song song trong moi Phase

- **Phase 1**: T001, T002, T003 song song (files khac nhau)
- **Phase 2**: T005 (test) truoc T006 (implement). T008–T011 (tests) song song, truoc T012–T015 (implement)
- **Phase 4**: T021–T023 (tests) song song, truoc T024–T026 (implement). T027 cuoi cung (tich hop)
- **Phase 6**: T030, T031, T032, T033 song song

### Trong moi task

1. Test PHAI viet truoc va FAIL (TDD)
2. Implement chi du de pass test
3. Khong overengineering

---

## Ghi chu

- Feature nay la **page view page** (page 1 trong PageView), KHONG phai route rieng — khong anh huong `go_router`
- `allKudos` hien tai trong KudosState dung cho feed tren page 0 (max 10 items). `allKudosPageList` moi dung cho page 1 (unlimited, paginated)
- Reuse `KudosCard(variant: KudosCardVariant.feed)` 100% — khong can sua widget nay
- Reuse `SectionHeaderWidget` cho header "Sun* Annual Awards 2025" + "ALL KUDOS"
- Reuse `KudosRepository.getKudos()` da co — khong can sua Repository/Datasource
- Khong can them seed data moi — 48 kudos hien tai du cho 2+ pages voi limit=20
- Tat ca text moi PHAI ho tro da ngon ngu (VN/EN) qua i18n slang
- Commit sau moi task hoac nhom logic
- Chay `flutter test` truoc khi chuyen phase
- TDD bat buoc: Viet test → Test FAIL (Red) → Implement → Test PASS (Green) → Refactor
