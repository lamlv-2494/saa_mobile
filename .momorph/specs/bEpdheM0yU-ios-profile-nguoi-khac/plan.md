# Kế hoạch Implementation: Profile Người Khác

**Frame**: `bEpdheM0yU-ios-profile-nguoi-khac`
**Spec**: `spec.md`
**Ngày**: 2026-04-17
**Plan chung**: `.momorph/specs/hSH7L8doXB-ios-profile-ban-than/plan.md` (shared infrastructure)

---

## Tóm tắt

Màn hình **Profile Người Khác** hiển thị thông tin của một đồng nghiệp (avatar, tên, team, danh hiệu), bộ sưu tập huy hiệu, nút CTA "Gửi lời cảm ơn", và danh sách kudos với dropdown filter (đã nhận/đã gửi) + infinite scroll. Feature đã được implement gần hoàn chỉnh với codebase hiện tại. Công việc còn lại gồm: **(1) fix ViewModel bug `isLoadingMoreKudos`** (không toggle loading state), **(2) fix `_handleSendKudos` thiếu pre-fill recipient** khi navigate sang SendKudosScreen, và **(3) verify test coverage**.

---

## Technical Context

**Language/Framework**: Dart / Flutter 3.41.3
**Primary Dependencies**: flutter_riverpod, freezed, go_router, google_fonts, flutter_svg, flutter_gen
**Database**: Supabase (PostgreSQL, truy vấn trực tiếp qua supabase_flutter SDK)
**Testing**: flutter_test + mockito
**State Management**: Riverpod — `FamilyAsyncNotifier<OtherProfileState, String>` (parameterized by userId)
**API Style**: Supabase direct table queries (không phải REST endpoint)

---

## Constitution Compliance Check

*GATE: Phải pass trước khi bắt đầu implementation*

- [x] Tuân thủ kiến trúc MVVM (1 ViewModel `OtherProfileViewModel` + 1 State `OtherProfileState` cho feature)
- [x] Widget con là StatelessWidget, nhận data qua constructor (`ProfileInfoWidget`, `BadgeCollectionWidget`, `SendKudosButtonWidget`, v.v.)
- [x] Screen là `ConsumerStatefulWidget` (cần `ScrollController` cho infinite scroll — justified)
- [x] Asset paths dùng `flutter_gen` (`Assets.xxx`) — không hardcode string
- [x] Icons dùng SVG (`flutter_svg`), backgrounds dùng PNG
- [x] i18n qua slang (`t.profile.*`) — không hardcode text
- [x] Model dùng `freezed` cho immutability (`OtherProfileState`, `UserProfile`, `Badge`)
- [x] Route nhận `userId` qua path parameter (`/profile/:userId`)
- [x] Self-redirect logic: `userId == currentUserId` → switch tab 4 + `context.pop()`
- [ ] **[CẦN FIX]** `OtherProfileViewModel.loadMoreKudos()` không toggle `isLoadingMoreKudos` → loading spinner cuối list không bao giờ hiện; thiếu guard chống double-trigger
- [ ] **[CẦN FIX]** `_handleSendKudos()` chỉ gọi `context.push('/send-kudos')` mà không truyền `userId`/`userName` extras → recipient không được pre-fill (vi phạm US2/FR-003)

**Vi phạm cần xử lý**:

| Vi phạm | Mô tả | Hành động |
|---------|-------|-----------|
| `OtherProfileViewModel.loadMoreKudos()` bug | Không set `isLoadingMoreKudos = true` trước khi call API, không set `false` sau khi xong. Không guard `if (isLoadingMoreKudos) return` → loading indicator không hiện + risk double-trigger khi scroll nhanh | Fix trong Phase 1 |
| `_handleSendKudos()` thiếu pre-fill | `context.push('/send-kudos')` không truyền extras chứa `userId`/`userName` → spec yêu cầu recipient pre-filled khi navigate từ CTA (US2, FR-003) | Fix trong Phase 2 (phụ thuộc SendKudosScreen hỗ trợ extras) |

---

## Architecture Decisions

### Frontend Approach

- **Component Structure**: Feature-based — toàn bộ UI nằm trong `lib/features/profile/presentation/`
- **Styling Strategy**: `AppColors` constants + `GoogleFonts.montserrat` — không hardcode
- **Data Fetching**: Đã hoàn chỉnh — `OtherProfileViewModel.build(userId)` gọi 4 Supabase queries song song (profile, badges, stats, kudos)
- **Infinite Scroll**: `ScrollController` trên `OtherProfileScreen` — trigger `loadMoreKudos()` khi còn 200px cuối. **Bug cần fix**: thiếu `isLoadingMoreKudos` toggle + guard
- **Self-redirect**: Trong `data` callback — so sánh `currentUserId == widget.userId` → redirect sang tab Profile (index 3) + pop. Đã dùng `addPostFrameCallback` để tránh setState during build.

### Backend Approach

- **Data Access**: Repository pattern hoàn chỉnh — `ProfileRepository` → `ProfileRemoteDatasource` → Supabase
- **Không cần thêm endpoint** — tất cả API calls đã được implement:
  - `getUserProfile(userId)` — table `users` JOIN `departments`
  - `getUserBadges(userId)` — table `user_badges` JOIN `badges`
  - `getUserStats(userId)` — table `user_stats`
  - `getKudosHistory(userId, filter, page, limit)` — table `kudos` filter by `sender_id` hoặc `recipient_id`
  - `likeKudos(kudosId)` / `unlikeKudos(kudosId)` — `kudos_reactions` table (delegate qua `KudosRepository`)

### Integration Points

- **Shared Components đã dùng**:
  - `ProfileInfoWidget` — avatar, tên, team code, hero tier badge
  - `BadgeCollectionWidget` — wrap layout badges (icon 44×44 + tên)
  - `SendKudosButtonWidget` — CTA full-width, outline style
  - `KudosSectionHeaderWidget` — banner decorative
  - `ProfileKudosFilterDropdown` — dropdown sent/received với counts
  - `ProfileKudosListWidget` — paginated kudos cards (reuse `KudosCard` từ kudos feature)
- **Navigation**:
  - Entry: `context.push('/profile/$userId')` từ bất kỳ kudos card avatar
  - `onSendKudos` → `/send-kudos` (cần thêm extras cho pre-fill)
  - `onAvatarTap(userId)` → `/profile/$userId` (push thêm màn hình)
  - `onViewDetail(kudosId)` → `/kudos/$kudosId`
  - Back → `context.pop()`
- **Khác biệt với Profile bản thân** (đã implement đúng):
  - KHÔNG có `PersonalStatsCard`
  - KHÔNG có "Mở Secret Box"
  - CÓ `SendKudosButtonWidget`
  - CÓ `BadgeCollectionWidget` (thay vì `IconCollectionWidget`)
  - Header: SliverAppBar transparent với back button (thay vì `HomeHeaderWidget`)

---

## Project Structure

### Source Code — Trạng thái hiện tại

```text
lib/features/profile/
├── data/
│   ├── models/
│   │   ├── other_profile_state.dart       ✅ Hoàn chỉnh (freezed)
│   │   ├── other_profile_state.freezed.dart ✅ Generated
│   │   ├── user_profile.dart              ✅ Hoàn chỉnh
│   │   ├── badge.dart                     ✅ Hoàn chỉnh
│   │   ├── kudos_filter_type.dart         ✅ Hoàn chỉnh
│   │   └── icon_badge.dart                ✅ Hoàn chỉnh (shared)
│   ├── repositories/
│   │   └── profile_repository.dart        ✅ Hoàn chỉnh
│   └── datasources/
│       └── profile_remote_datasource.dart ✅ Hoàn chỉnh
└── presentation/
    ├── screens/
    │   └── other_profile_screen.dart      ⚠️ CẦN FIX: _handleSendKudos thiếu pre-fill
    ├── viewmodels/
    │   └── other_profile_viewmodel.dart   ⚠️ CẦN FIX: loadMoreKudos() bug
    └── widgets/
        ├── profile_info_widget.dart        ✅ Hoàn chỉnh
        ├── badge_collection_widget.dart    ✅ Hoàn chỉnh
        ├── send_kudos_button_widget.dart   ✅ Hoàn chỉnh
        ├── kudos_section_header_widget.dart ✅ Hoàn chỉnh
        ├── profile_kudos_filter_dropdown.dart ✅ Hoàn chỉnh
        └── profile_kudos_list_widget.dart  ✅ Hoàn chỉnh

lib/app/
└── router.dart                            ✅ Route /profile/:userId đã cấu hình

test/
├── unit/viewmodels/
│   └── other_profile_viewmodel_test.dart  ✅ Đã có
├── widget/profile/
│   └── other_profile_screen_test.dart     ✅ Đã có
└── helpers/
    ├── profile_mocks.dart                 ✅ Đã có
    └── profile_test_helpers.dart          ✅ Đã có
```

### Files Cần Sửa

| File | Thay đổi cụ thể | Priority |
|------|----------------|----------|
| `lib/features/profile/presentation/viewmodels/other_profile_viewmodel.dart` | `loadMoreKudos()`: (1) thêm guard `if (isLoadingMoreKudos) return`, (2) set `isLoadingMoreKudos: true` trước khi await, (3) set `false` sau khi xong (cả success và catch) | **P0** |
| `lib/features/profile/presentation/screens/other_profile_screen.dart` | `_handleSendKudos()`: truyền extras `{userId, userName}` khi push `/send-kudos` (phụ thuộc router + SendKudosScreen hỗ trợ extras) | **P1** |
| `test/unit/viewmodels/other_profile_viewmodel_test.dart` | Thêm/update test cases cho `isLoadingMoreKudos` toggle + guard | **P1** |

### Files KHÔNG Cần Tạo Mới

Tất cả files cần thiết đã tồn tại. Không cần tạo file mới.

---

## Implementation Strategy

### Tổng quan

Feature đã implement gần hoàn chỉnh (24/24 tasks trong tasks.md đã ✅). Công việc còn lại là **fix 2 bugs** và **verify test coverage**.

### Phase Breakdown

#### Phase 1: Fix ViewModel Bug — `loadMoreKudos()` (P0)

**File**: `lib/features/profile/presentation/viewmodels/other_profile_viewmodel.dart`

**Vấn đề hiện tại** (dòng 75–99):
- Không có guard `if (currentState.isLoadingMoreKudos) return` → risk double-trigger
- Không set `isLoadingMoreKudos: true` trước khi gọi API → loading spinner không hiện
- Không set `isLoadingMoreKudos: false` sau khi API trả về (cả success và error)

**Fix cần thiết**:

```dart
Future<void> loadMoreKudos() async {
  final currentState = state.valueOrNull;
  if (currentState == null || !currentState.hasMoreKudos || currentState.isLoadingMoreKudos) return;
  //                                                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  //                                                       THÊM guard chống double-trigger

  // Set loading = true trước khi gọi API
  state = AsyncValue.data(currentState.copyWith(isLoadingMoreKudos: true));

  final filterStr = currentState.kudosFilter == KudosFilterType.sent ? 'sent' : 'received';
  _currentPage++;
  try {
    final newKudos = await _profileRepo.getKudosHistory(
      userId: _userId,
      filter: filterStr,
      page: _currentPage,
      limit: _pageLimit,
    );
    state = AsyncValue.data(
      currentState.copyWith(
        kudosList: [...currentState.kudosList, ...newKudos],
        hasMoreKudos: newKudos.length >= _pageLimit,
        isLoadingMoreKudos: false,  // Reset sau khi xong
      ),
    );
  } catch (_) {
    _currentPage--;
    state = AsyncValue.data(currentState.copyWith(isLoadingMoreKudos: false));  // Reset khi lỗi
  }
}
```

> **Lý do P0**: `ProfileKudosListWidget` đã có `if (isLoadingMore) CircularProgressIndicator(...)` nhưng `isLoadingMoreKudos` không bao giờ được set `true` → loading spinner cuối list không bao giờ hiện. US7 acceptance criterion bị broken.

**TDD**: Viết/update test trước trong `other_profile_viewmodel_test.dart`:
- `loadMoreKudos() sets isLoadingMoreKudos=true then false`
- `loadMoreKudos() does not trigger when isLoadingMoreKudos=true`
- `loadMoreKudos() resets isLoadingMoreKudos on error`

#### Phase 2: Fix CTA pre-fill recipient (P1)

**File**: `lib/features/profile/presentation/screens/other_profile_screen.dart`

**Vấn đề hiện tại** (dòng 53–55):
```dart
void _handleSendKudos(String userId, String userName) {
  context.push('/send-kudos');  // ← Không truyền extras
}
```

**Fix cần thiết**:
```dart
void _handleSendKudos(String userId, String userName) {
  context.push('/send-kudos', extra: {'userId': userId, 'userName': userName});
}
```

**Phụ thuộc**: `SendKudosScreen` và router cần hỗ trợ đọc `GoRouterState.extra` để pre-fill recipient. Nếu `SendKudosScreen` chưa hỗ trợ, cần sửa thêm:
1. Router: `GoRoute` cho `/send-kudos` cần truyền `extra` xuống screen
2. `SendKudosScreen`: Đọc `extra` từ constructor hoặc `GoRouterState` và pre-fill ô recipient

> **Lưu ý**: Fix này có thể scope ra ngoài nếu `SendKudosScreen` chưa sẵn sàng nhận extras. Trong trường hợp đó, tạo TODO ticket và ghi nhận dependency.

#### Phase 3: Verify & Update Tests (P1)

**Mục tiêu**: Đảm bảo test coverage >= 80% cho `OtherProfileViewModel` + `OtherProfileScreen`

| Test file | Cần kiểm tra |
|-----------|-------------|
| `test/unit/viewmodels/other_profile_viewmodel_test.dart` | Thêm test cases cho `isLoadingMoreKudos` toggle + guard (Phase 1 fix) |
| `test/widget/profile/other_profile_screen_test.dart` | Verify test cho loading state, error state, self-redirect, back button |

#### Phase 4: Quality Check

- Chạy `flutter test` — pass 100% cho tất cả tests liên quan Profile người khác
- Chạy `flutter analyze` + `dart format .` — 0 warnings, 0 lint errors
- Verify i18n keys (`t.profile.*`) đủ cho mọi text hiển thị

---

## Kiểm tra tuân thủ Spec — Trạng thái hiện tại

### User Stories

| User Story | Mô tả | Trạng thái |
|------------|-------|-----------|
| US1 | Xem thông tin người khác (avatar, tên, team, badge) | ✅ Đã implement |
| US2 | Gửi kudos qua CTA "Gửi lời cảm ơn" | ⚠️ Navigate OK nhưng thiếu pre-fill recipient |
| US3 | Xem bộ sưu tập huy hiệu | ✅ Đã implement |
| US4 | Xem lịch sử kudos + filter dropdown | ✅ Đã implement |
| US5 | Tương tác kudos card (heart, copy, detail) | ✅ Đã implement |
| US6 | Quay lại màn hình trước | ✅ Đã implement |
| US7 | Infinite scroll | ⚠️ Logic OK nhưng loading indicator không hiện (bug isLoadingMoreKudos) |
| US8 | Pull-to-refresh | ✅ Đã implement |

### Functional Requirements

| FR | Mô tả | Trạng thái |
|----|-------|-----------|
| FR-001 | Hiển thị profile: avatar, tên, team, badge | ✅ |
| FR-002 | Bộ sưu tập huy hiệu | ✅ |
| FR-003 | CTA navigate với recipient pre-fill | ⚠️ Thiếu pre-fill |
| FR-004 | Dropdown filter sent/received | ✅ |
| FR-005 | Kudos cards đầy đủ thông tin | ✅ |
| FR-006 | Heart toggle, copy link, xem chi tiết | ✅ |
| FR-007 | Đa ngôn ngữ VN/EN | ✅ |
| FR-008 | Back navigation | ✅ |
| FR-009 | Self-redirect nếu xem chính mình | ✅ |
| FR-010 | Dropdown label cập nhật count | ✅ |
| FR-011 | Pull-to-refresh | ✅ |
| FR-012 | Infinite scroll pagination | ⚠️ Bug loading indicator |

### Technical Requirements

| TR | Mô tả | Trạng thái |
|----|-------|-----------|
| TR-001 | MVVM + FamilyAsyncNotifier | ✅ |
| TR-002 | flutter_gen asset paths | ✅ |
| TR-003 | SVG via flutter_svg | ✅ |
| TR-004 | i18n via slang | ✅ |
| TR-005 | freezed models | ✅ |
| TR-006 | userId từ route param | ✅ |
| TR-007 | Cache trong ViewModel state | ✅ |

---

## Risk Assessment

| Risk | Xác suất | Tác động | Mitigation |
|------|----------|---------|------------|
| `SendKudosScreen` chưa hỗ trợ extras → pre-fill không implement được | High | Medium | Kiểm tra `SendKudosScreen` trước khi fix; nếu chưa sẵn sàng, tạo dependency ticket |
| `loadMoreKudos` double-trigger khi scroll nhanh | Medium | Low | Guard `if (isLoadingMoreKudos) return` trong Phase 1 |
| Test coverage giảm sau fix | Low | Low | Viết test trước (TDD) — verify coverage sau |
| Bug self-redirect loop nếu auth state chưa loaded | Low | Medium | Đã guard `if (currentUserId != null && ...)` — safe |

---

## Integration Testing Strategy

### Test Scope

- [x] **UI ↔ ViewModel**: OtherProfileScreen watch OtherProfileViewModel, render đúng state
- [x] **ViewModel ↔ Repository**: Repository calls đúng datasource methods
- [ ] **App ↔ Supabase**: Nằm ngoài unit tests — cần manual/e2e test
- [x] **User workflows**: Load profile → filter kudos → toggle heart → scroll load more

### Mocking Strategy

| Dependency | Strategy | Lý do |
|------------|----------|-------|
| `ProfileRepository` | Mock (mockito) | Tránh gọi Supabase trong test, fast & isolated |
| `KudosRepository` | Mock (mockito) | Tương tự |
| `GoRouter` / navigation | Stub | Widget test chỉ cần kiểm tra callback, không test navigation |
| `AuthViewModel` | Mock | Cần cho self-redirect test |

### Coverage Goals

| Area | Target | Priority |
|------|--------|----------|
| OtherProfileViewModel methods | 100% | High |
| Widget render states | 80%+ | High |
| Error/edge cases | 90%+ | High |
| Navigation callbacks | 70%+ | Medium |

---

## Dependencies & Prerequisites

### Đã hoàn thành

- [x] `constitution.md` đã review (v1.3.1)
- [x] `spec.md` đã hoàn chỉnh
- [x] `design-style.md` đã hoàn chỉnh
- [x] `tasks.md` đã có (24 tasks, tất cả đã ✅)
- [x] Shared infrastructure từ `hSH7L8doXB/tasks.md` (models, datasource, repo, widgets)
- [x] Route `/profile/:userId` đã cấu hình trong `router.dart`
- [x] Tầng data implement hoàn chỉnh (Repository, Datasource, ViewModel, State)
- [x] Widget shared implement hoàn chỉnh
- [x] Tests cơ bản đã có (unit + widget)

### External Dependencies

- Supabase project running (cho manual test / e2e)
- Figma assets đã có trong `assets/` (icons SVG, images PNG)

---

## Next Steps

1. **Bắt đầu Phase 1**: Fix `loadMoreKudos()` bug — viết test trước (TDD), sau đó fix code
2. **Phase 2**: Đánh giá `SendKudosScreen` có hỗ trợ extras không → fix `_handleSendKudos` nếu sẵn sàng
3. **Phase 3–4**: Verify tests + quality check

**Ước tính độ phức tạp**:
- Phase 1 (ViewModel bug): **Low** — fix đơn giản, thêm 3 dòng code + guard
- Phase 2 (Pre-fill): **Medium** — phụ thuộc `SendKudosScreen` hỗ trợ extras
- Phase 3–4 (Tests + Quality): **Low** — tests đã có sẵn, chỉ cần verify/update

---

## Ghi chú

- **ViewModel bug là P0** — `loadMoreKudos()` không bao giờ set `isLoadingMoreKudos = true`, phải fix để US7 acceptance criterion pass
- **FR-014 (self-redirect) ĐÃ IMPLEMENT** — `OtherProfileScreen` (dòng 98–108) đã kiểm tra `currentUserId == widget.userId` và redirect sang tab Profile
- **CTA pre-fill phụ thuộc ngoài scope** — `SendKudosScreen` hiện không nhận extras, cần sửa ở cả router lẫn screen đích
- TDD bắt buộc: Viết test → Test FAIL (Red) → Implement → Test PASS (Green)
- Tất cả text PHẢI dùng i18n (slang), không hardcode
- Asset paths PHẢI dùng `flutter_gen` (`Assets.xxx`), không hardcode
