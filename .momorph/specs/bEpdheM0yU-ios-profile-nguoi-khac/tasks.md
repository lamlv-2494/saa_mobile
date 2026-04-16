# Tasks: [iOS] Profile — Người khác

**Frame**: `bEpdheM0yU-ios-profile-nguoi-khac`
**Plan chung**: `.momorph/specs/hSH7L8doXB-ios-profile-ban-than/plan.md` (cover cả 2 screens)
**Tasks chung**: `.momorph/specs/hSH7L8doXB-ios-profile-ban-than/tasks.md` (shared infrastructure)

> **Quan trọng**: Shared infrastructure (models, datasource, repository, shared widgets) được quản lý trong `hSH7L8doXB-ios-profile-ban-than/tasks.md`. File này chỉ tập trung vào các tasks đặc thù cho màn hình **Profile người khác**.

---

## Điều kiện tiên quyết (từ hSH7L8doXB/tasks.md)

Trước khi bắt đầu, đảm bảo các tasks sau trong `hSH7L8doXB/tasks.md` đã hoàn thành:

| Task ID (shared) | Mô tả | Trạng thái |
|-----------------|-------|-----------|
| T001–T004 | Assets, colors, i18n, build_runner | ✅ Done |
| T005 | Seed data | ✅ Done |
| T006–T017 | Models: UserProfile, IconBadge, Badge, KudosFilterType, ProfileState, **OtherProfileState** | Cần hoàn thành |
| T018 | Test helpers | ✅ Done |
| T019–T022 | Datasource + Repository | ✅ Done |
| T027–T034 | Shared widgets: ProfileInfoWidget, KudosSectionHeaderWidget, ProfileKudosFilterDropdown, ProfileKudosListWidget | Cần hoàn thành |
| T043 | MainScaffold tích hợp ProfileScreen (tab 4) | Cần hoàn thành |

---

## Định dạng Task

```
- [ ] T### [P?] [Story?] Mô tả | đường/dẫn/file
```

- **[P]**: Có thể chạy song song (file khác nhau, không phụ thuộc lẫn nhau)
- **[Story]**: User story liên quan (US1–US8 — tham chiếu spec.md bEpdheM0yU)
- **|**: File bị ảnh hưởng bởi task

---

## Phase 1: ViewModel — Profile người khác (Blocking)

**Mục đích**: ViewModel là nền tảng cho toàn bộ UI màn hình người khác

**Kiểm thử độc lập**: `flutter test test/unit/viewmodels/other_profile_viewmodel_test.dart`

### Tests (viết trước — TDD)

- [x] T001 Viết unit test cho `OtherProfileViewModel.build(userId)`: fetch profile + badges + kudosList (filter received, page 1) + counts đồng thời; verify state được set đúng | `test/unit/viewmodels/other_profile_viewmodel_test.dart`
- [x] T002 [P] Viết unit test cho `OtherProfileViewModel.changeFilter(KudosFilterType)`: switch filter, reset về page 1, reload kudos list | `test/unit/viewmodels/other_profile_viewmodel_test.dart`
- [x] T003 [P] Viết unit test cho `OtherProfileViewModel.loadMoreKudos()`: append data trang tiếp theo, cập nhật `hasMoreKudos`, không gọi API khi `hasMoreKudos == false` | `test/unit/viewmodels/other_profile_viewmodel_test.dart`
- [x] T004 [P] Viết unit test cho `OtherProfileViewModel.toggleHeart(kudosId)`: optimistic update ngay lập tức, rollback khi API thất bại | `test/unit/viewmodels/other_profile_viewmodel_test.dart`
- [x] T005 [P] Viết unit test cho `OtherProfileViewModel.refresh()`: re-fetch toàn bộ data (profile + badges + kudos list + counts), giữ nguyên filter hiện tại | `test/unit/viewmodels/other_profile_viewmodel_test.dart`

### Implementation

- [x] T006 Tạo `OtherProfileViewModel extends FamilyAsyncNotifier<OtherProfileState, String>`: `build(userId)` parallel fetch profile + badges + kudosList (default: received) + counts; `changeFilter()`, `loadMoreKudos()`, `toggleHeart(kudosId)` (optimistic + delegate KudosRepository), `refresh()`. Đăng ký provider với `@riverpod` annotation | `lib/features/profile/presentation/viewmodels/other_profile_viewmodel.dart`

**Checkpoint**: `flutter test test/unit/viewmodels/other_profile_viewmodel_test.dart` pass 100%.

---

## Phase 2: US2 — CTA "Gửi lời cảm ơn" (Ưu tiên: P1)

**Mục tiêu**: Nút CTA primary action — điều hướng sang form gửi kudos với recipient pre-filled

**Kiểm thử độc lập**: Widget test riêng biệt, không cần màn hình hoàn chỉnh

### Tests (viết trước — TDD)

- [x] T007 [P] Viết widget test cho `SendKudosButtonWidget`: hiển thị đúng text (i18n), icon edit SVG, border #998C5F; tap → navigate sang `/kudos/send` với userId + userName pre-filled dưới dạng route params hoặc extra | `test/widget/profile/send_kudos_button_widget_test.dart`

### Implementation

- [x] T008 [P] Tạo `SendKudosButtonWidget` (StatelessWidget): CTA full-width (h: 44px, bg: rgba(255,234,158,0.10), border: 1px #998C5F, radius: 4px); text `t.profile.sendKudosButton` (Montserrat 14px SemiBold, #FFEA9E) + `Assets.icons.icEdit.svg()` bên trái; tap → `context.push('/kudos/send', extra: {userId, userName})`. Nhận `userId`, `userName` | `lib/features/profile/presentation/widgets/send_kudos_button_widget.dart`

**Checkpoint**: `SendKudosButtonWidget` render đúng, tap navigate đúng route.

---

## Phase 3: US3 — Bộ sưu tập huy hiệu (Ưu tiên: P2)

**Mục tiêu**: Hiển thị badge collection với icon + tên (khác Profile ban thân chỉ có icon)

**Kiểm thử độc lập**: Widget test với mock badge list

### Tests (viết trước — TDD)

- [x] T009 [P] Viết widget test cho `BadgeCollectionWidget`: Wrap layout hiển thị đúng số badge; mỗi badge có icon (44x44, circle, bg #1A1A2E) + tên (10px Regular, trắng); empty state → ẩn section | `test/widget/profile/badge_collection_widget_test.dart`

### Implementation

- [x] T010 [P] Tạo `BadgeCollectionWidget` (StatelessWidget): Column gồm label "Bộ sưu tập icon của tôi" (14px Medium, #FFEA9E, i18n) + `Wrap(spacing: 12, runSpacing: 12)` các `BadgeItemWidget` (Column: icon 44x44 circle dark bg + tên 10px Regular trắng, gap: 4px). Nhận `List<Badge>`. Empty: ẩn toàn bộ section | `lib/features/profile/presentation/widgets/badge_collection_widget.dart`

**Checkpoint**: `BadgeCollectionWidget` render đúng layout, đúng style, empty state hoạt động.

---

## Phase 4: US1 + US4 + US6 — Màn hình chính Profile người khác (Ưu tiên: P1) 🎯 MVP

**Mục tiêu**: Màn hình hoàn chỉnh với navigation back, header, badge collection, CTA, kudos list + filter

**Kiểm thử độc lập**: Widget test `OtherProfileScreen` với mock ViewModel

### Tests (viết trước — TDD)

- [x] T011 Viết widget test cho `OtherProfileScreen`: xác nhận sections render đúng thứ tự (header back, ProfileInfoWidget, BadgeCollectionWidget, SendKudosButtonWidget, KudosSectionHeaderWidget, ProfileKudosFilterDropdown, ProfileKudosListWidget); KHÔNG có StatisticsContainerWidget; KHÔNG có "Mở Secret Box"; back button hiển thị; self-redirect khi userId == currentUserId (redirect sang tab 4) | `test/widget/profile/other_profile_screen_test.dart`
- [x] T012 [P] Viết widget test cho error state "Không tìm thấy người dùng" khi userId không tồn tại (404) + nut "Quay lại" | `test/widget/profile/other_profile_screen_test.dart`

### Implementation

- [x] T013 Tạo `OtherProfileScreen` (ConsumerWidget) nhận `userId` từ route param:
  - AppBar transparent, height 44px, back icon (`Assets.icons.icBack.svg()`, trắng)
  - `Scaffold(backgroundColor: Color(0xFF00101A))`
  - `RefreshIndicator` → `viewModel.refresh()`
  - `CustomScrollView` + `SliverList`: `ProfileInfoWidget` → `BadgeCollectionWidget` → `SendKudosButtonWidget` → `KudosSectionHeaderWidget` → `ProfileKudosFilterDropdown` → `ProfileKudosListWidget`
  - `ScrollController` cho infinite scroll (→ `viewModel.loadMoreKudos()` khi scroll đến cuối)
  - Self-redirect: khi `userId == authState.user.id` → `ref.read(currentTabIndexProvider.notifier).state = 3; context.pop()`
  - Loading: shimmer placeholders
  - Error: "Không tìm thấy người dùng" (i18n) + nut "Quay lại"
  - Bottom nav: tất cả tabs inactive (màn hình push, không phải tab chính)
  | `lib/features/profile/presentation/screens/other_profile_screen.dart`

**Checkpoint**: `OtherProfileScreen` render đúng. Back hoạt động. CTA navigate. Self-redirect. Filter + scroll.

---

## Phase 5: US5 — Tương tác Kudos Cards (Ưu tiên: P2)

**Mục tiêu**: Heart toggle, copy link, avatar navigation, xem chi tiết — trong context Profile người khác

**Kiểm thử độc lập**: Mỗi interaction có thể test độc lập trên 1 kudos card mock

- [x] T014 [US5] Tích hợp heart toggle: `HeartButton` (REUSE `lib/features/kudos/presentation/widgets/heart_button.dart`) trong `ProfileKudosListWidget` → `viewModel.toggleHeart(kudosId)`. Optimistic update. Verify hoạt động trong context `OtherProfileScreen` | `lib/features/profile/presentation/widgets/profile_kudos_list_widget.dart`
- [x] T015 [P] [US5] Tích hợp copy link: tap icon copy → `Clipboard.setData(kudos.shareUrl)` + `ScaffoldMessenger.showSnackBar(t.kudos.linkCopied, duration: 2s)` — verify i18n key | `lib/features/profile/presentation/widgets/profile_kudos_list_widget.dart`
- [x] T016 [P] [US5] Tích hợp avatar tap: `GestureDetector` trên avatar trong kudos card → `context.push('/profile/$senderId')`. Nếu `senderId == currentUserId` → redirect tab 4 | `lib/features/profile/presentation/widgets/profile_kudos_list_widget.dart`
- [x] T017 [P] [US5] Tích hợp "Xem chi tiết": tap → navigate sang màn hình chi tiết kudos (placeholder route `/kudos/:id` nếu chưa build) | `lib/features/profile/presentation/widgets/profile_kudos_list_widget.dart`

**Checkpoint**: Tất cả interactions hoạt động. Heart, copy link, avatar nav, xem chi tiết.

---

## Phase 6: US7 + US8 — Infinite Scroll + Pull-to-Refresh (Ưu tiên: P2)

**Mục tiêu**: Pagination và refresh để xử lý dữ liệu lớn

- [x] T018 [US7] Verify `ScrollController` trong `OtherProfileScreen` trigger `loadMoreKudos()` đúng khi scroll đến cuối (pixels >= maxScrollExtent - 200px threshold). Loading indicator hiển thị ở cuối list khi đang tải | `lib/features/profile/presentation/screens/other_profile_screen.dart`
- [x] T019 [US8] Verify `RefreshIndicator` trong `OtherProfileScreen` trigger `refresh()` đúng khi pull-to-refresh. Kiểm tra: data mới nhất được load, giữ nguyên filter, hiển thị lỗi khi mất mạng | `lib/features/profile/presentation/screens/other_profile_screen.dart`

**Checkpoint**: Infinite scroll append đúng. Pull-to-refresh reload đúng.

---

## Phase 7: Polish & Cross-Cutting Concerns (Ưu tiên: P2)

**Mục đích**: Accessibility, animations, error boundary, lint

### Accessibility

- [x] T020 [P] Thêm `Semantics` widgets theo bảng VoiceOver trong spec: Back button "Quay lại", Avatar "Ảnh đại diện của {tên}", Badge "{danh hiệu}", Badge Collection item "Huy hiệu {tên huy hiệu}", Button CTA "Gửi lời cảm ơn cho {tên}", Dropdown "Lọc kudos. {giá trị hiện tại}", Heart "{count} lượt thích. {Đã thích / Chưa thích}", Copy Link "Sao chép liên kết", "Xem chi tiết" "Xem chi tiết kudos", Nav tabs "{Tab name}. Tab {index} trên 4" | `lib/features/profile/presentation/screens/other_profile_screen.dart`, `lib/features/profile/presentation/widgets/*.dart`

### Animations

- [x] T021 [P] Fine-tune animations trong màn hình người khác: dropdown overlay open/close (200ms ease-out), heart scale (150ms ease-in-out), push transition slide-from-right (300ms ease-in-out) | `lib/features/profile/presentation/widgets/*.dart`

### Error Boundary

- [x] T022 [P] Xử lý edge case: 401 → auth redirect; userId không tồn tại (404) → hiển thị "Không tìm thấy người dùng" với nut "Quay lại"; mất mạng → error toast + giữ data cũ | `lib/features/profile/presentation/screens/other_profile_screen.dart`

### Quality

- [x] T023 Chạy `flutter test` — pass 100% cho tất cả tests liên quan Profile người khác. Coverage >= 80% cho `OtherProfileViewModel` + `OtherProfileScreen` | `test/`
- [x] T024 [P] Chạy `flutter analyze` + `dart format .` — 0 warnings, 0 lint errors | Toàn bộ project

**Checkpoint**: Feature hoàn chỉnh. Accessibility OK. Animations mượt. Tests pass. Lint clean.

---

## Phụ thuộc & Thứ tự thực thi

### Phụ thuộc giữa Phases

```
[hSH7L8doXB tasks - shared infra] ─────────────────────────┐
  (T001-T034: models, datasource, repo, shared widgets)      |
                                                             v
Phase 1 (OtherProfileViewModel) ─────────────────────────── |
    |                                                        |
    v                                                        |
Phase 2 (SendKudosButtonWidget) ──── Phase 3 (BadgeCollect) |
    |                                        |               |
    └────────────────────┬───────────────────┘               |
                         v                                   |
              Phase 4 (OtherProfileScreen — MVP) ───────────┘
                         |
              ┌──────────┴──────────┐
              v                     v
         Phase 5                Phase 6
      (Interactions)        (Scroll + Refresh)
              |                     |
              └─────────┬───────────┘
                        v
                   Phase 7 (Polish)
```

### Song song trong mỗi Phase

- **Phase 1 Tests**: T001–T005 song song (cùng test file, logic độc lập)
- **Phase 2+3**: T007+T009 song song (test), T008+T010 song song (impl)
- **Phase 5**: T014–T017 song song (cùng file nhưng logic độc lập)
- **Phase 7**: T020, T021, T022, T024 song song

---

## Tổng kết

| Phase | Số tasks | Story | Ưu tiên |
|-------|---------|-------|---------|
| Phase 1: OtherProfileViewModel | 6 | - | Nền tảng |
| Phase 2: CTA Button | 2 | US2 | P1 |
| Phase 3: Badge Collection | 2 | US3 | P2 |
| Phase 4: Màn hình chính | 3 | US1+US4+US6 | P1 |
| Phase 5: Interactions | 4 | US5 | P2 |
| Phase 6: Scroll + Refresh | 2 | US7+US8 | P2 |
| Phase 7: Polish | 5 | - | P2 |
| **Tổng** | **24** | | |

### MVP Scope

1. Hoàn thành prerequisite tasks trong `hSH7L8doXB/tasks.md`
2. Phase 1 (ViewModel) + Phase 2 (CTA) + Phase 4 (Screen) → **DỪNG và KIỂM TRA**
3. Phase 3, 5, 6, 7 sau đó

---

## Ghi chú

- TDD bắt buộc: Viết test → Test FAIL (Red) → Implement → Test PASS (Green) → Refactor
- REUSE: `KudosCard`, `HeartButton` từ `lib/features/kudos/`; `ProfileInfoWidget`, `KudosSectionHeaderWidget`, `ProfileKudosFilterDropdown`, `ProfileKudosListWidget` từ shared widgets (được tạo trong hSH7L8doXB)
- Tất cả text PHẢI dùng i18n (slang), không hardcode
- Asset paths PHẢI dùng `flutter_gen` (`Assets.xxx`), không hardcode
- `FamilyAsyncNotifier` với `userId` parameter — Riverpod cache per userId
- Self-redirect logic: so sánh `userId` với `ref.read(authProvider).user.id`
- Danh dấu task hoàn thành: `[x]`
