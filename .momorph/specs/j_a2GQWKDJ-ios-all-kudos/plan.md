# Kế hoạch triển khai: [iOS] Sun*Kudos — All Kudos

**Frame**: `j_a2GQWKDJ-ios-all-kudos`
**Ngày**: 2026-04-15
**Spec**: `specs/j_a2GQWKDJ-ios-all-kudos/spec.md`

---

## Tóm tắt

Triển khai màn hình **All Kudos** — danh sách toàn bộ kudos với infinite scroll. Đây là **page index 1** trong `PageView` của `KudosScreen` hiện tại. Người dùng truy cập bằng cách tap "Xem tất cả" → `PageController.animateToPage(1)`. Nút back animate về page 0, **KHÔNG** dùng `Navigator.pop()`. Reuse widget `KudosCard` đã có, mở rộng `KudosState` với danh sách riêng cho All Kudos page, và thêm pagination logic vào `KudosViewModel`.

---

## Bối cảnh kỹ thuật

**Framework**: Flutter 3.41.3 / Dart ^3.11.1
**Phụ thuộc chính**: flutter_riverpod, go_router, supabase_flutter, freezed, google_fonts, flutter_svg, flutter_gen, slang
**Backend**: Supabase (PostgREST — đã có endpoint `GET /rest/v1/kudos` với pagination)
**Testing**: flutter_test + mocktail (TDD bắt buộc)
**State Management**: Riverpod — AsyncNotifier pattern (1 ViewModel per feature)

---

## Kiểm tra tuân thủ Constitution

| Yêu cầu | Quy tắc Constitution | Trạng thái |
|----------|----------------------|-----------|
| MVVM + Riverpod | Mở rộng `KudosViewModel` hiện tại, KHÔNG tạo ViewModel riêng | ✅ Tuân thủ |
| Feature-based module | Nằm trong `lib/features/kudos/` — cùng feature module | ✅ Tuân thủ |
| Freezed models | Mở rộng `KudosState` hiện tại (freezed) | ✅ Tuân thủ |
| Widget con = StatelessWidget | `AllKudosPageView` là StatelessWidget nhận data từ Screen | ✅ Tuân thủ |
| SVG icons, PNG images | Reuse icons hiện có + thêm `ic_chevron_left.svg` (CHƯA CÓ — cần thêm) | ✅ Tuân thủ |
| flutter_gen (Assets.xxx) | Không hardcode path | ✅ Tuân thủ |
| i18n (slang) VN/EN | Tất cả text mới qua `context.t.kudos.*` | ✅ Tuân thủ |
| TDD | Viết test trước → implement → refactor | ✅ Tuân thủ |
| Reuse components | Reuse `KudosCard`, `SectionHeaderWidget` | ✅ Tuân thủ |

**Vi phạm**: Không có.

---

## Quyết định kiến trúc

### Frontend

- **PageView Architecture**: `KudosScreen` hiện tại được wrap trong `PageView` với `NeverScrollableScrollPhysics()`. Page 0 = Kudos Feed hiện tại, Page 1 = All Kudos page mới.
- **PageController**: Khai báo trong `_KudosScreenState`, truyền `animateToPage` callbacks xuống widget con.
- **All Kudos Page**: Widget `AllKudosPageView` — một `StatelessWidget` chứa:
  - Custom AppBar với nút back (← animate về page 0)
  - `SectionHeaderWidget` (subtitle + divider + title "ALL KUDOS")
  - `ListView.separated` với `KudosCard(variant: feed)` — reuse 100%
  - Infinite scroll qua `ScrollController` listener
  - Pull-to-refresh qua `RefreshIndicator`
- **Background**: Reuse cùng pattern `Stack` + key visual bg từ Kudos screen — share cùng Stack layer.
- **Navigation**: Nút back trên AppBar gọi `PageController.animateToPage(0, duration: 300ms, curve: Curves.easeInOut)` — KHÔNG dùng `Navigator.pop()`.
- **Reuse**: `KudosCard` widget đã có hoàn chỉnh (variant `feed`) — không cần sửa đổi.
- **Time format**: `_formatTimeAgo()` hiện tại nằm trong `_KudosScreenState` — cần tách ra utility function trong `lib/core/utils/` hoặc truyền xuống `AllKudosPageView` qua callback. Spec yêu cầu format `HH:mm - MM/dd/yyyy`, cần xác nhận lại có cần thêm format mới hay reuse `_formatTimeAgo`.

### Backend Integration

- **API**: Reuse endpoint `GET /rest/v1/kudos` đã có với pagination (`page`, `limit`).
- **Repository**: `KudosRepository.getKudos()` đã hỗ trợ pagination — không cần sửa.
- **Datasource**: `KudosRemoteDatasource.fetchKudos()` đã có — không cần sửa.

### Tích hợp hiện tại

- **`KudosScreen`** (`lib/features/kudos/presentation/screens/kudos_screen.dart`): SỬA ĐÁNG KỂ — wrap content hiện tại trong `PageView`, thêm `PageController`, thêm "Xem tất cả" action. Hiện tại `onTap` của "Xem tất cả" là `// TODO: Navigate to full kudos feed screen` — cần thay bằng `_pageController.animateToPage(1)`.
- **`KudosState`** (`lib/features/kudos/data/models/kudos_state.dart`): SỬA — thêm fields cho All Kudos page pagination (`allKudosPageList`, `allKudosCurrentPage`, `allKudosHasMore`, `allKudosIsLoadingMore`).
- **`KudosViewModel`** (`lib/features/kudos/presentation/viewmodels/kudos_viewmodel.dart`): SỬA — thêm methods `loadAllKudosPage()`, `loadMoreAllKudos()`, `refreshAllKudos()`. Cập nhật `_updateKudosInState()` để đồng bộ heart toggle qua cả 3 danh sách (`allKudos`, `allKudosPageList`, `highlightKudos`).
- **`AllKudosSectionHeader`** (`all_kudos_section_widget.dart`): Đã có — reuse cho header trong All Kudos page hoặc tạo widget riêng theo design.
- **i18n** (`strings_vi.i18n.json`, `strings_en.i18n.json`): SỬA — thêm keys mới cho All Kudos page.

---

## Cấu trúc Project

### Tài liệu

```text
.momorph/specs/j_a2GQWKDJ-ios-all-kudos/
├── spec.md              # Đặc tả tính năng ✅
├── design-style.md      # Đặc tả thiết kế ✅
├── plan.md              # File này ✅
└── tasks.md             # Phân chia task (bước tiếp theo)
```

### Source Code (ảnh hưởng)

```text
lib/
├── features/
│   └── kudos/
│       ├── data/
│       │   └── models/
│       │       └── kudos_state.dart               # SỬA: thêm fields cho All Kudos page
│       │
│       └── presentation/
│           ├── viewmodels/
│           │   └── kudos_viewmodel.dart            # SỬA: thêm methods All Kudos pagination + cập nhật _updateKudosInState
│           ├── screens/
│           │   └── kudos_screen.dart               # SỬA: wrap trong PageView + PageController
│           └── widgets/
│               ├── all_kudos_page_view.dart        # MỚI: Page 1 — All Kudos full list
│               └── all_kudos_section_widget.dart   # CÓ SẴN: reuse hoặc mở rộng
│
├── i18n/
│   ├── strings_vi.i18n.json                        # SỬA: thêm keys All Kudos
│   └── strings_en.i18n.json                        # SỬA: thêm keys All Kudos

assets/
└── icons/
    └── ic_chevron_left.svg                         # MỚI: icon back cho All Kudos navbar

test/
├── unit/
│   └── viewmodels/
│       └── kudos_viewmodel_all_kudos_test.dart     # MỚI: test pagination All Kudos
├── widget/
│   └── kudos/
│       ├── all_kudos_page_view_test.dart           # MỚI: widget test All Kudos page
│       └── kudos_screen_pageview_test.dart          # MỚI: test PageView navigation
└── helpers/
    └── kudos_test_helpers.dart                      # SỬA: thêm mock data cho All Kudos
```

### Dependencies mới

Không cần thêm package mới — tất cả đã có trong `pubspec.yaml`.

---

## Chiến lược triển khai

### Phase 0: Xác nhận dữ liệu Supabase & Chuẩn bị

**Kiểm tra seed data hiện có**:
- 6 departments, 10 hashtags, 15 users, 48 kudos, reactions, photos — **đủ cho All Kudos** (48 records > 2 pages với `limit=20`).
- **Không cần thêm seed data mới** — dữ liệu hiện tại đã đáp ứng:
  - Pagination: 48 kudos cho 2+ pages
  - Đa dạng sender/receiver: 15 users trải đều 6 departments
  - Hashtags: 10 hashtags đã gán cho kudos
  - Badges/Hero tiers: users có nhiều tier khác nhau

**Lưu ý**: Nếu cần thêm data trong tương lai, chỉ APPEND vào `supabase/seed.sql` với `INSERT ... ON CONFLICT DO NOTHING`. KHÔNG BAO GIỜ dùng `supabase db reset`. Chạy seed qua:
```bash
psql -h localhost -p 54322 -U postgres -d postgres -f supabase/seed.sql
```

### Phase 1: Chuẩn bị i18n & Assets

- Thêm i18n keys mới cho All Kudos page (VN + EN):
  - `allKudosNavbarTitle`: "All Kudos" / "All Kudos"
  - `allKudosSectionTitle`: "ALL KUDOS" / "ALL KUDOS"
  - `allKudosPullToRefresh`: "Kéo để làm mới" / "Pull to refresh"
  - `allKudosLoadingMore`: "Đang tải thêm..." / "Loading more..."
  - `allKudosEmpty`: "Chưa có kudos nào" / "No kudos yet"
  - `allKudosLoadError`: "Không thể tải kudos" / "Cannot load kudos"
  - `allKudosRetry`: "Thử lại" / "Retry"
- Thêm icon `ic_chevron_left.svg` vào `assets/icons/` — hiện tại **CHƯA CÓ** icon back nào phù hợp trong assets (chỉ có `ic_arrow_down`, `ic_arrow_open`, `ic_arrow_right`)
- Chạy `dart run build_runner build` để regenerate flutter_gen + freezed

### Phase 2: Mở rộng Data Layer (KudosState + ViewModel)

**TDD**: Viết test trước cho ViewModel methods.

1. **Mở rộng `KudosState`** (freezed):
   - Thêm `List<Kudos> allKudosPageList` — danh sách kudos cho page All Kudos (tách biệt `allKudos` feed trên page 0 chỉ hiển thị max 10)
   - Thêm `int allKudosCurrentPage` (default: 0) — trang hiện tại pagination
   - Thêm `bool allKudosHasMore` (default: true) — còn data để load
   - Thêm `bool allKudosIsLoadingMore` (default: false) — đang load thêm
2. **Mở rộng `KudosViewModel`**:
   - `loadAllKudosPage()`: Load trang đầu tiên cho All Kudos (gọi khi user navigate sang page 1 lần đầu)
   - `loadMoreAllKudos()`: Pagination — load page tiếp theo, append vào `allKudosPageList`
   - `refreshAllKudos()`: Pull-to-refresh — reset page, load lại từ đầu
   - Reuse `_repository.getKudos(page, limit)` đã có — KHÔNG cần sửa Repository/Datasource
   - **Cập nhật `_updateKudosInState()`**: Thêm logic update `allKudosPageList` khi heart toggle — đảm bảo đồng bộ 3 danh sách (`allKudos`, `allKudosPageList`, `highlightKudos`)
3. **Chạy `dart run build_runner build`** để regenerate freezed code

### Phase 3: PageView Wrapper cho KudosScreen

**TDD**: Viết widget test cho PageView navigation.

1. **Sửa `KudosScreen`**:
   - Thêm `PageController _pageController` trong `_KudosScreenState`
   - Wrap `Stack` content hiện tại (background + RefreshIndicator) thành page 0 trong `PageView(controller: _pageController, physics: NeverScrollableScrollPhysics(), children: [page0, page1])`
   - Page 0 = toàn bộ content hiện tại (Stack + RefreshIndicator + CustomScrollView)
   - Page 1 = `AllKudosPageView` widget mới
   - Thay `// TODO: Navigate to full kudos feed screen` trong "Xem tất cả" `GestureDetector.onTap` → `_pageController.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.easeInOut)`
   - Truyền callback `onBackToFeed: () => _pageController.animateToPage(0, ...)` xuống `AllKudosPageView`
2. **Dispose `_pageController`** trong `dispose()`
3. **Trigger data load**: Khi animate sang page 1, gọi `vm.loadAllKudosPage()` (lazy load — chỉ load khi cần)
4. **Lưu ý**: `Scaffold.body` hiện tại dùng `asyncState.when(data: (state) => Stack(...))` — cần giữ nguyên structure, chỉ wrap `Stack` thành page 0 trong `PageView`

### Phase 4: All Kudos Page UI

**TDD**: Viết widget test cho layout, back button, scroll behavior.

1. **Tạo `AllKudosPageView`** (`lib/features/kudos/presentation/widgets/all_kudos_page_view.dart`):
   - Nhận params: `List<Kudos> kudosList`, `bool hasMore`, `bool isLoadingMore`, `VoidCallback onBackToFeed`, `VoidCallback onLoadMore`, `Future<void> Function() onRefresh`, `void Function(String) onHeartTap`, `void Function(String) onAvatarTap`, `String Function(DateTime) formatTimeAgo`
   - Layout:
     ```
     Stack(
       children: [
         // Background (reuse key visual pattern)
         // Scrollable content
         RefreshIndicator(
           child: CustomScrollView(
             slivers: [
               SliverAppBar (gradient bg, leading: back button, title: "All Kudos"),
               SliverToBoxAdapter (header: subtitle + divider + "ALL KUDOS"),
               SliverPadding (
                 SliverList.separated (KudosCard x N)
               ),
               if (isLoadingMore) SliverToBoxAdapter (loading indicator),
               SliverToBoxAdapter (bottom spacing),
             ]
           )
         )
       ]
     )
     ```
   - **Back button**: `IconButton(icon: Assets.icons.icChevronLeft.svg(...), onPressed: onBackToFeed)`
   - **Infinite scroll**: `ScrollController` listener → khi gần cuối (200px threshold) → gọi `onLoadMore`
   - **Empty state**: Khi `kudosList.isEmpty` && `!isLoadingMore` → hiển thị text trống
   - **Loading more indicator**: `CircularProgressIndicator` ở cuối list khi đang load thêm

2. **Reuse `KudosCard(variant: KudosCardVariant.feed)`** — không cần sửa widget này

3. **Reuse `SectionHeaderWidget`** cho header "Sun* Annual Awards 2025" + divider + "ALL KUDOS"

### Phase 5: Tương tác & Polish

1. **Heart toggle**: Reuse `vm.toggleHeart()` đã có — cập nhật `_updateKudosInState` trong ViewModel để update cả `allKudosPageList` (ngoài `allKudos` + `highlightKudos` đã có)
2. **Copy link**: Reuse logic hiện có trong `KudosContentCard`
3. **Xem chi tiết**: Placeholder navigation (hoặc tích hợp nếu màn chi tiết đã có)
4. **Avatar tap → Profile**: Placeholder navigation callback
5. **Animation**: Fine-tune PageView transition (300ms ease-in-out), verify scroll dọc trong page 1 không conflict với PageView
6. **Accessibility**: Thêm `Semantics` cho back button, list items theo spec
7. **Pull-to-refresh**: Gọi `vm.refreshAllKudos()` → reset list + load từ page 1
8. **Error handling**:
   - Mất kết nối khi load → hiển thị error state + retry button
   - Load more thất bại → hiển thị "Thử lại" ở cuối danh sách, giữ nguyên data đã load
   - Nội dung kudos quá dài → truncate max 3 dòng (reuse từ `KudosCard`)
   - Hashtag quá nhiều → truncate max 2 dòng (reuse từ `KudosCard`)

### Phase 6: Testing & Verification

1. **Unit tests** (ViewModel):
   - `loadAllKudosPage()` — verify gọi repository đúng params, state cập nhật đúng
   - `loadMoreAllKudos()` — verify pagination increment, append data, `hasMore` flag
   - `loadMoreAllKudos()` khi `allKudosIsLoadingMore == true` — verify không gọi trùng (race condition guard)
   - `loadMoreAllKudos()` khi `allKudosHasMore == false` — verify không gọi thêm
   - `refreshAllKudos()` — verify reset page, reload data
   - `toggleHeart()` — verify update cả 3 danh sách: `allKudos`, `allKudosPageList`, `highlightKudos`
   - Error handling: load fail → state giữ nguyên, page counter rollback

2. **Widget tests**:
   - `AllKudosPageView` — render list đúng, back button, empty state, loading more indicator
   - `KudosScreen` PageView — navigate page 0 ↔ page 1, `NeverScrollableScrollPhysics`
   - Scroll behavior — infinite scroll trigger gần cuối list
   - Pull-to-refresh — trigger `onRefresh` callback

3. **Integration verification**:
   - Toàn flow: Kudos Feed → "Xem tất cả" → All Kudos → scroll → load more → back → Kudos Feed
   - Heart toggle sync giữa page 0 và page 1 (cả `allKudos` lẫn `allKudosPageList`)
   - Back button animate (không pop), scroll position page 0 giữ nguyên sau khi back

---

## Mapping User Stories → Phases

| User Story | Mô tả | Phase triển khai |
|-----------|-------|-----------------|
| US-1: Xem danh sách tất cả Kudos (P1) | Danh sách scrollable + infinite scroll + pagination | Phase 2 (ViewModel) + Phase 4 (UI) |
| US-2: Quay lại Kudos Feed (P1) | Nút back animate PageView về page 0 | Phase 3 (PageView) + Phase 4 (back button) |
| US-3: Tương tác với thẻ Kudos (P2) | Heart toggle, copy link, xem chi tiết, avatar tap | Phase 5 (Tương tác) |
| US-4: Header hiển thị context (P3) | Subtitle + divider + "ALL KUDOS" title | Phase 4 (SectionHeaderWidget reuse) |

### Edge Cases → Phase mapping

| Edge Case | Phase xử lý |
|-----------|-------------|
| Mất kết nối khi load | Phase 5 (Error handling) |
| Load thêm thất bại | Phase 5 (Error handling) |
| Nội dung kudos quá dài | Phase 4 (reuse từ KudosCard — đã xử lý truncate) |
| Hashtag quá nhiều | Phase 4 (reuse từ KudosCard — đã xử lý truncate) |
| Heart toggle khi offline | Phase 5 (optimistic update + rollback — đã có trong ViewModel) |
| Pull-to-refresh | Phase 5 (RefreshIndicator + refreshAllKudos) |
| Tên quá dài | Phase 4 (reuse từ KudosCard — đã xử lý truncate ~109px) |
| Không có badge | Phase 4 (reuse từ KudosCard — đã xử lý ẩn badge) |
| PageView không cho swipe | Phase 3 (NeverScrollableScrollPhysics) |

---

## Đánh giá rủi ro

| Rủi ro | Xác suất | Ảnh hưởng | Giảm thiểu |
|--------|----------|-----------|-----------|
| PageView + CustomScrollView nested scroll conflict | Trung bình | Cao | `NeverScrollableScrollPhysics` trên PageView ngăn swipe gesture. Scroll dọc trong mỗi page hoạt động độc lập. Test trên device thật |
| Refactor KudosScreen lớn (wrap PageView) — `asyncState.when` structure phức tạp | Trung bình | Trung bình | Tách content page 0 thành method `_buildFeedPage()` trước khi wrap. Keep backward compatibility. Test kỹ loading/error states vẫn hoạt động |
| Heart toggle desync giữa 3 danh sách | Trung bình | Trung bình | `_updateKudosInState` cập nhật cả `allKudos` + `allKudosPageList` + `highlightKudos`. Unit test cover đủ 3 lists |
| Icon `ic_chevron_left.svg` chưa có | Thấp | Thấp | Thêm SVG icon ở Phase 1. Nếu không có designer, dùng Material icon tạm rồi thay sau |
| Infinite scroll edge cases (race condition) | Thấp | Thấp | Flag `allKudosIsLoadingMore` ngăn concurrent requests. Test boundary conditions |
| Performance với nhiều KudosCard | Thấp | Thấp | `SliverList` lazy rendering. Profile trên device thật nếu cần |

### Độ phức tạp ước tính

- **Frontend**: **Trung bình** (PageView wrapper + 1 widget mới + ViewModel extension)
- **Backend**: **Thấp** (reuse API endpoint hiện có, không cần sửa)
- **Testing**: **Trung bình** (ViewModel pagination tests + widget tests + navigation tests)

---

## Chiến lược kiểm thử tích hợp

### Phạm vi kiểm thử

- [x] **Tương tác component**: ViewModel ↔ Repository (pagination All Kudos)
- [x] **Navigation**: PageView page 0 ↔ page 1 (animate, not pop)
- [x] **State sync**: Heart toggle sync giữa Feed (page 0) và All Kudos (page 1) qua 3 danh sách
- [x] **Luồng người dùng**: "Xem tất cả" → scroll → load more → back

### Phân loại kiểm thử

| Loại | Áp dụng? | Kịch bản chính |
|------|----------|----------------|
| UI ↔ Logic | Có | Infinite scroll → ViewModel.loadMoreAllKudos() → list append |
| Navigation | Có | PageView animate page 0 ↔ 1, back button không dùng pop |
| State sync | Có | toggleHeart → update allKudos + allKudosPageList + highlightKudos |
| Error handling | Có | Load fail → error state + retry |
| Pull-to-refresh | Có | RefreshIndicator → refreshAllKudos → reset + reload |

### Chiến lược Mock

| Loại dependency | Chiến lược | Lý do |
|-----------------|-----------|-------|
| Repository | Mock (mocktail) | Unit test ViewModel không cần real API |
| PageController | Verify animate calls | Widget test navigation |
| ScrollController | Simulate scroll events | Widget test infinite scroll |

### Mục tiêu Coverage

| Khu vực | Mục tiêu | Ưu tiên |
|---------|---------|---------|
| ViewModel (All Kudos methods) | 90%+ | Cao |
| ViewModel (_updateKudosInState 3-list sync) | 100% | Cao |
| AllKudosPageView widget | 80%+ | Cao |
| KudosScreen PageView integration | 70%+ | Trung bình |
| Navigation (animate page) | 90%+ | Cao |

---

## Phụ thuộc & Điều kiện tiên quyết

### Yêu cầu trước khi bắt đầu

- [x] `constitution.md` đã review
- [x] `spec.md` đã review
- [x] `design-style.md` đã review
- [x] Kudos feature code đã có (`lib/features/kudos/`)
- [x] `KudosCard` widget đã có và hoạt động
- [x] `KudosViewModel` + `KudosRepository` đã có
- [x] API endpoint `GET /rest/v1/kudos` hỗ trợ pagination
- [x] Seed data đủ cho testing (48 kudos, 15 users, 10 hashtags, 6 departments)
- [ ] Icon `ic_chevron_left.svg` SVG — **CHƯA CÓ**, cần thêm vào `assets/icons/`

### Phụ thuộc bên ngoài

- Không có — toàn bộ reuse infrastructure hiện tại

---

## Ghi chú

- Feature này là **page view page** (page 1 trong PageView), KHÔNG phải route riêng — không ảnh hưởng `go_router`.
- `allKudos` hiện tại trong `KudosState` dùng cho feed trên page 0 (max 10 items hiển thị). `allKudosPageList` mới dùng cho page 1 (unlimited, paginated).
- Khi seed data cho testing, chỉ **thêm mới** — KHÔNG xóa data hiện có trong DB. Hiện tại **không cần thêm seed data**.
- Tất cả text mới PHẢI hỗ trợ đa ngôn ngữ (VN/EN) qua i18n slang.
- `_formatTimeAgo()` đã có trong `KudosScreen` — cần tách ra utility hoặc truyền xuống `AllKudosPageView` để reuse.
- `"Xem tất cả"` GestureDetector hiện tại có `onTap` rỗng (`// TODO`) — Phase 3 sẽ kết nối với `PageController`.
