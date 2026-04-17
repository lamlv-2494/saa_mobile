# Kế hoạch triển khai: [iOS] Sun*Kudos — Màn hình chính Kudos

**Frame**: `fO0Kt19sZZ-ios-sun-kudos`
**Ngày**: 2026-04-13
**Spec**: `specs/fO0Kt19sZZ-ios-sun-kudos/spec.md`

---

## Tóm tắt

Triển khai màn hình chính Sun*Kudos — feed kudos với 5 section: Hero Banner + CTA, Highlight Kudos carousel (filter hashtag/phòng ban), Spotlight Board (floating names canvas), All Kudos feed (infinite scroll), và Personal Stats + Top 10. Thay thế `_PlaceholderTab(title: 'Kudos')` ở tab index 2 trong `MainScaffold`.

---

## Bối cảnh kỹ thuật

**Framework**: Flutter 3.41.3 / Dart ^3.11.1
**Phụ thuộc chính**: flutter_riverpod, go_router, supabase_flutter, freezed, google_fonts, flutter_svg, flutter_gen, slang
**Backend**: Supabase (17 API endpoints — xem `BACKEND_API_TESTCASES.md`)
**Testing**: flutter_test + mocktail (TDD bắt buộc)
**State Management**: Riverpod — AsyncNotifier pattern (1 ViewModel per feature)
**API Style**: REST (Supabase Edge Functions / PostgREST)

---

## Kiểm tra tuân thủ Constitution

| Yêu cầu | Quy tắc Constitution | Trạng thái |
|----------|----------------------|-----------|
| MVVM + Riverpod | 1 ViewModel (`KudosViewModel extends AsyncNotifier<KudosState>`) | ✅ Tuân thủ |
| Feature-based module | `lib/features/kudos/` với data/presentation/domain | ✅ Tuân thủ |
| Freezed models | Tất cả state + model dùng freezed | ✅ Tuân thủ |
| Widget con = StatelessWidget | Screen dùng ConsumerWidget, widget con StatelessWidget | ✅ Tuân thủ |
| Widget `build()` ≤ 80 dòng | Nếu vượt quá 80 dòng PHẢI tách widget con | ✅ Tuân thủ |
| SVG icons, PNG images | Icons → `assets/icons/`, backgrounds → `assets/images/` | ✅ Tuân thủ |
| flutter_gen (Assets.xxx) | Không hardcode path | ✅ Tuân thủ |
| i18n (slang) VN/EN | Tất cả text qua `context.t.kudos.*` | ✅ Tuân thủ |
| TDD | Viết test trước → implement → refactor | ✅ Tuân thủ |
| Repository pattern | `KudosRepository` → `KudosRemoteDatasource` | ✅ Tuân thủ |
| Không ConsumerWidget ở widget con | Chỉ Screen được dùng ConsumerWidget | ✅ Tuân thủ (tất cả widget con đã là StatelessWidget) |

**Vi phạm hiện tại**: `spotlight_section_widget.dart` dùng `Image.asset` thay vì `Stack của Positioned(Text)` trong `InteractiveViewer` — xem Bug #1 ở phần Công việc còn lại.

---

## Quyết định kiến trúc

### Frontend

- **Component Structure**: Feature-based (`lib/features/kudos/`) theo constitution
- **Scroll Architecture**: `CustomScrollView` + `SliverAppBar` (floating, transparent) + các `SliverToBoxAdapter` cho mỗi section + `SliverList` cho All Kudos feed
- **Carousel**: `PageView` + gradient overlay + custom `PageIndicator`
- **Floating Names Canvas (Spotlight)**: `InteractiveViewer` + `Stack của Positioned(Text)` — render tên của những người vừa gửi kudos, dedup theo userId; KHÔNG dùng CustomPainter hay nodes/edges
- **Reusable**: `SectionHeaderWidget` đã có trong `shared/widgets/` → kiểm tra và extend nếu cần (thêm optional action button "Xem tất cả"), `KudosContentCard` (dùng cho cả Highlight card và Feed card), `FilterDropdownButton` (dựa trên pattern `OutlineButton` đã có), `HeartButton` (toggle)

### Backend Integration

- **API Client**: `supabase_flutter` SDK — **KHÔNG dùng `dio` hay REST** (xem thay đổi #16)
- **Data Source**: `KudosRemoteDatasource` gọi Supabase PostgREST trực tiếp
- **Repository**: `KudosRepository` xử lý error handling, mapping

> ⚠️ **Lưu ý quan trọng**: `BACKEND_API_TESTCASES.md` mô tả REST endpoints (`/api/v1/kudos`, v.v.) nhưng **implementation thực tế dùng Supabase PostgREST** (xem thay đổi #16). BACKEND_API_TESTCASES.md vẫn hữu ích để tham khảo data contracts và edge cases, nhưng KHÔNG dùng làm hướng dẫn call API.

**Mapping từ REST endpoints → Supabase SDK (datasource methods):**

| REST endpoint (BACKEND_API_TESTCASES.md) | Datasource method | Supabase table/view |
|------------------------------------------|------------------|---------------------|
| `GET /kudos` | `fetchKudos(page, limit)` | `kudos` + joins |
| `GET /kudos/highlight` | `fetchHighlightKudos({hashtagId?, deptName?})` | `kudos` (client-side filter + sort) |
| `GET /kudos/{id}` | `getKudosDetail(kudosId)` | `kudos` + joins |
| `POST /kudos/{id}/reactions` | `likeKudos(kudosId)` | `kudos_reactions` INSERT |
| `DELETE /kudos/{id}/reactions` | `unlikeKudos(kudosId)` | `kudos_reactions` DELETE |
| `GET /kudos/spotlight` | `fetchSpotlight()` | `kudos` JOIN `users` (unique senders + recentActivity cho live feed) |
| `GET /kudos/spotlight/search` | `searchUsers(query)` | `users` ilike |
| `GET /kudos/stats/total` | `fetchTotalKudosCount()` | `kudos` COUNT |
| `GET /users/me/stats` | `fetchPersonalStats()` | `user_stats` VIEW |
| `GET /kudos/top-recipients` | `fetchTopRecipients()` | `kudos` + `users` dedup |
| `GET /hashtags` | `fetchHashtags()` | `hashtags` |
| `GET /departments` | `fetchDepartments()` | `departments` |
| `GET /users/me/secret-boxes/next` | `getNextSecretBox()` *(chưa implement)* | `secret_boxes` SELECT |
| `POST /users/me/secret-boxes/{boxId}/open` | `openSecretBox(boxId)` *(chưa implement)* | `secret_boxes` UPDATE |
| `GET /config/bonus` | Không cần — `isBonusActive` có trong `user_stats` VIEW | — |

> **Discrepancy với BACKEND_API_TESTCASES.md**: Flow 3 Step 3 mô tả `GET /kudos?hashtag_id=1` sẽ filter ALL kudos. Nhưng **implementation chỉ filter `highlightKudos`**, không filter `allKudos` (giới hạn PostgREST ORDER BY count). Đây là thiết kế có chủ ý — xem spec US3 để biết lý do.

### Tích hợp hiện tại

- **`MainScaffold`** (`lib/app/main_scaffold.dart`): Thay thế `_PlaceholderTab(title: 'Kudos')` tại index 2 bằng `KudosScreen()`
- **`AppColors`** (`lib/app/theme/app_colors.dart`): Đã có nhiều colors cần thiết (`bgDark`, `textAccent`, `outlineBtnBg`, `outlineBtnBorder`, `divider`, `notificationBadge`). Cần thêm: `surfaceCard`, `textSecondary`, `heart`, `surfaceDark`
- **`BottomNavBar`** (`lib/shared/widgets/bottom_nav_bar.dart`): Đã có, không cần sửa
- **`SectionHeaderWidget`** (`lib/shared/widgets/section_header_widget.dart`): Đã có → review nếu phù hợp hoặc extend cho pattern 3 lần (subtitle + divider + title + optional action)
- **`OutlineButton`** (`lib/shared/widgets/outline_button.dart`): Đã có → reuse style cho CTA button và filter dropdown
- **`PrimaryButton`** (`lib/shared/widgets/primary_button.dart`): Đã có → reference cho button patterns
- **`LanguageDropdown`** (`lib/shared/widgets/language_dropdown.dart`): Đã có → reference cho dropdown pattern
- **Router** (`lib/app/router.dart`): Có thể cần thêm route cho kudos detail, send kudos — nhưng nằm ngoài scope nếu dùng `IndexedStack` + navigation push
- **Home feature** (`lib/features/home/`): Reference pattern chính cho ViewModel + Repository + Datasource. Đặc biệt `HomeRemoteDatasource` có locale-aware queries → cần áp dụng tương tự cho kudos
- **i18n** (`lib/i18n/strings_vi.i18n.json`, `strings_en.i18n.json`): Đã có structure → thêm section `kudos` vào cả 2 file

---

## Cấu trúc Project

### Tài liệu

```text
.momorph/specs/fO0Kt19sZZ-ios-sun-kudos/
├── spec.md              # Đặc tả tính năng ✅
├── design-style.md      # Đặc tả thiết kế ✅
├── plan.md              # File này ✅
├── tasks.md             # Phân chia task (bước tiếp theo)
└── assets/
    └── frame-image-url.txt
```

### Source Code (ảnh hưởng)

```text
lib/
├── app/
│   ├── main_scaffold.dart              # SỬA: thay _PlaceholderTab → KudosScreen
│   └── theme/
│       └── app_colors.dart             # SỬA: thêm colors mới
│
├── features/
│   └── kudos/                          # MỚI: toàn bộ feature
│       ├── data/
│       │   ├── models/
│       │   │   ├── kudos.dart                    # Kudos model (freezed) — bao gồm sender/receiver User info
│       │   │   ├── kudos_state.dart               # KudosState (freezed)
│       │   │   ├── user_summary.dart              # UserSummary model (freezed) — id, name, avatar, department, badgeLevel
│       │   │   ├── personal_stats.dart            # PersonalStats model (freezed) — incl. isBonusActive, starBadgeLevel
│       │   │   ├── spotlight_data.dart             # SpotlightData/SpotlightEntry/SpotlightActivity (freezed) — entries, totalKudos, recentActivity
│       │   │   ├── gift_recipient_ranking.dart     # GiftRecipientRanking (freezed)
│       │   │   ├── hashtag.dart                   # Hashtag model (freezed)
│       │   │   └── department.dart                # Department model (freezed)
│       │   ├── datasources/
│       │   │   └── kudos_remote_datasource.dart   # API calls (12 endpoints)
│       │   └── repositories/
│       │       └── kudos_repository.dart           # Repository + error handling
│       │
│       └── presentation/
│           ├── viewmodels/
│           │   └── kudos_viewmodel.dart            # AsyncNotifier<KudosState>
│           ├── screens/
│           │   └── kudos_screen.dart               # Main screen (ConsumerWidget)
│           └── widgets/                            # Tất cả StatelessWidget
│               ├── kudos_hero_banner_widget.dart    # A. Hero + CTA (CTA dùng OutlineButtonWidget từ shared/)
│               ├── highlight_section_widget.dart    # B. Highlight container
│               ├── kudos_card.dart                   # B.3/C.3 Unified card (KudosCardVariant: highlight/feed) — thay highlight_kudos_card + kudos_feed_card
│               ├── highlight_carousel_widget.dart   # B.2 PageView + overlay
│               ├── page_indicator_widget.dart       # B.5 Slide indicator
│               ├── spotlight_section_widget.dart    # B.6+B.7 Spotlight
│               ├── all_kudos_page_view.dart          # Màn hình All Kudos riêng (j_a2GQWKDJ) — PageView page 1
│               ├── all_kudos_section_widget.dart    # C. Header + feed
│               ├── kudos_content_card.dart          # C.3.5 Content card (reusable)
│               ├── top_gift_recipients_card.dart    # D.3 10 Sunner nhận quà mới nhất
│               ├── filter_dropdown_button.dart      # Reusable dropdown button (ref: OutlineButton pattern)
│               └── heart_button.dart                # Heart toggle
│
├── shared/
│   └── widgets/
│       ├── bottom_nav_bar.dart         # Đã có ✅
│       └── personal_stats_card.dart    # D.1 Stats block — đặt trong shared vì có thể reuse
│
├── i18n/
│   ├── strings_vi.i18n.json            # SỬA: thêm kudos section
│   └── strings_en.i18n.json            # SỬA: thêm kudos section
│
└── gen/                                # Auto-generated (flutter_gen)

assets/
├── icons/
│   ├── ic_pencil.svg                   # MỚI
│   ├── ic_heart_outlined.svg           # MỚI
│   ├── ic_heart_filled.svg             # MỚI
│   ├── ic_copy_link.svg                # MỚI
│   ├── ic_sent.svg                     # MỚI
│   ├── ic_fire.svg                     # MỚI
│   ├── ic_gift_box.svg                 # MỚI
│   ├── ic_next.svg                     # MỚI
│   └── ic_prev.svg                     # MỚI
└── images/
    └── kudos/
        └── key_visual_bg.png           # MỚI: Hero banner background

test/
├── unit/
│   ├── viewmodels/
│   │   ├── kudos_viewmodel_test.dart              # ✅ Đã có
│   │   └── kudos_viewmodel_all_kudos_test.dart    # ✅ Đã có (test loadAllKudosPage)
│   ├── repositories/
│   │   └── kudos_repository_test.dart             # ✅ Đã có
│   └── models/
│       ├── kudos_test.dart                        # ✅ Đã có
│       └── kudos_state_test.dart                  # ✅ Đã có
├── widget/
│   └── kudos/
│       ├── kudos_screen_test.dart                 # ✅ (kudos_screen_pageview_test.dart)
│       ├── kudos_screen_avatar_navigation_test.dart # ✅ Đã có — avatar tap → profile
│       ├── highlight_carousel_test.dart            # ✅ Đã có
│       ├── kudos_card_test.dart                   # ✅ Đã có (unified — highlight + feed variant)
│       ├── filter_dropdown_button_test.dart        # ✅ Đã có
│       ├── heart_button_test.dart                 # ✅ Đã có
│       ├── personal_stats_card_test.dart          # ✅ Đã có
│       ├── page_indicator_test.dart               # ✅ Đã có
│       ├── all_kudos_page_view_test.dart          # ✅ Đã có
│       ├── top_gift_recipients_card_test.dart     # ✅ Đã có — rewardName + onUserTap tap→profile
│       └── spotlight_section_widget_test.dart     # 🔄 Đã có nhưng cần cập nhật cho approach mới (Bug #1 fix)
└── helpers/
    └── kudos_test_helpers.dart                    # ✅ Đã có
```

### Dependencies mới

Không cần thêm package mới — tất cả đã có trong `pubspec.yaml`:
- `flutter_riverpod`, `freezed`, `json_serializable`, `flutter_svg`, `google_fonts`, `flutter_gen_runner`, `slang`, `mocktail`

---

## Chiến lược triển khai

### Phase 0: Chuẩn bị Assets & Theme (Nền tảng)

- Download SVG icons từ Figma (pencil, heart, copy, sent, fire, gift, nav arrows) vào `assets/icons/`
- Download hero banner background vào `assets/images/`
- Chạy `dart run build_runner build` để generate flutter_gen assets
- Bổ sung colors mới vào `AppColors` (chỉ thêm những chưa có):
  - `surfaceCard` = `#FFF8E1` — **MỚI**
  - `surfaceDark` = `#00070C` — **MỚI**
  - `textSecondary` = `#999999` — **MỚI**
  - `heart` = `#F17676` — **MỚI**
  - *(Không thêm `border` — đã có `outlineBtnBorder` = `#998C5F` cùng giá trị)*
  - *(Không thêm `primary10` — đã có `outlineBtnBg` = `rgba(255,234,158,0.10)` cùng giá trị)*
  - `primary15` = `rgba(255,234,158,0.15)` — **MỚI** (pressed state, khác `outlineBtnPressedBg` = 0.20)
- Thêm i18n strings cho kudos section (VN + EN)

### Phase 1: Data Layer (Models + API + Repository)

**Ưu tiên**: Xây dựng nền data layer trước để tất cả phases sau dùng được.

1. **Models (freezed)**: `Kudos`, `UserSummary`, `KudosState`, `PersonalStats`, `SpotlightData`, `SpotlightEntry`, `SpotlightActivity`, `GiftRecipientRanking`, `Hashtag`, `Department`
   - `Kudos` chứa `UserSummary sender` + `UserSummary receiver` (embedded)
   - `PersonalStats` chứa `isBonusActive`, `starBadgeLevel` (từ API `/users/me/stats`)
2. **Datasource**: `KudosRemoteDatasource` — 12 methods tương ứng 12 endpoints
3. **Repository**: `KudosRepository` — error handling, mapping
4. **ViewModel**: `KudosViewModel extends AsyncNotifier<KudosState>` — methods: `build()`, `refresh()`, `loadMoreKudos()`, `toggleHeart()`, `setHashtagFilter()`, `setDepartmentFilter()`, `clearFilters()`

### Phase 2: Core UI — Skeleton Screen (US1 + US5)

**Ưu tiên P1**: Hiển thị được màn hình với dữ liệu.

> **Nguyên tắc TDD**: Mỗi widget trong phase này PHẢI có loading/error/empty state ngay từ đầu (không để Phase 5). Mỗi widget PHẢI viết test trước khi implement.

1. **`KudosScreen`** — `CustomScrollView` + `SliverAppBar` + `RefreshIndicator` (pull-to-refresh từ đầu) + sections
2. **Extend `SectionHeaderWidget`** — Thêm optional `trailing` widget (để truyền "Xem tất cả →" cho All Kudos header). Sửa trực tiếp `lib/shared/widgets/section_header_widget.dart` vì là backward-compatible change.
3. **`KudosHeroBanner`** — Hero banner + tagline + logo (dùng `Assets.images.kudosKeyVisualBg`)
4. **Reuse `OutlineButtonWidget`** cho CTA button — KHÔNG tạo `kudos_cta_button.dart` mới. Truyền `icon` (pencil SVG) + `label` + `onPressed`. Nếu cần customization vượt quá OutlineButtonWidget, mới tạo widget riêng.
5. **`HighlightCarousel`** + **`KudosCard(variant: highlight)`** — PageView + cards + gradient overlays + shimmer loading + empty state (variant: KudosCardVariant.highlight)
6. **`PageIndicator`** — "2/5" format + arrow buttons (disabled state ở boundary)
7. **`KudosContentCard`** — Reusable content card (bg: `#FFF8E1`) — dùng cho cả Highlight và Feed
8. **`KudosCard(variant: feed)`** — Sender → Receiver header (avatar tap → profile navigation `bEpdheM0yU`) + time + content card (variant: KudosCardVariant.feed); unified với highlight card
9. **Infinite scroll** cho All Kudos — `ScrollController` listener ngay từ Phase 2, không để Phase 5
10. **Tích hợp `MainScaffold`** — Thay `_PlaceholderTab(title: 'Kudos')` → `KudosScreen()`

> **Thứ tự sections trong ALL KUDOS area** (theo spec cập nhật 2026-04-13):
> 1. ALL KUDOS header + "Xem tất cả" link
> 2. **D.1 Personal Stats** (kudos nhận/gửi, hearts, secret boxes)
> 3. **D.3 Top 10 Sunner nhận quà mới nhất**
> 4. **C.3 Kudos Feed** (infinite scroll)
> 5. CTA button bottom
>
> Lưu ý: Stats và Top 10 widget được tạo ở Phase 3, nhưng khi tích hợp vào KudosScreen phải đặt TRƯỚC feed list.

### Phase 3: Tính năng mở rộng (US2 + US3 + US6 + US7)

1. **`FilterDropdownButton`** — 2 instances (Hashtag, Phòng ban) + bottom sheet overlay
2. **Filter logic trong ViewModel** — `setHashtagFilter()`, `setDepartmentFilter()` → refetch highlight + reset carousel
3. **`PersonalStatsCard`** — Stats block + D.2 button "Mở hộp bí mật"
4. **`TopGiftRecipientsCard`** — 10 Sunner nhận quà mới nhất (sort by recency)
5. **`HeartButton`** — Toggle like/unlike + optimistic update + animation (scale spring)
6. **Copy link** — `Clipboard.setData` + snackbar "Đã sao chép liên kết" 2 giây (FR-011 hoàn chỉnh)
7. **CTA navigation** — go_router push tới màn hình gửi kudos (placeholder route nếu chưa build)

### Phase 4: Spotlight Board (US4)

**Tách riêng — render tên người vừa gửi kudos dưới dạng floating text labels trong InteractiveViewer. KHÔNG dùng CustomPainter hay network graph.**

1. **Models**: `SpotlightData` (entries, totalKudos, recentActivity), `SpotlightEntry` (userId, name, x, y), `SpotlightActivity` (timestamp, receiverName)
2. **`fetchSpotlight()`** — Query `kudos` JOIN `users` (as receiver): dedup theo `sender_id`, assign random x/y coords (0–700, 0–110), trả 10 entries gần nhất + `recentActivity` (timestamp + receiverName của kudos mới nhất)
3. **`SpotlightSectionWidget`** — Container height 159px + header + loading/error/empty states
4. **Render engine**: Outer `Stack` → `InteractiveViewer(panEnabled: true)` + inner `SizedBox(width: 700, height: 130)` + inner `Stack` → mỗi `SpotlightEntry` = `Positioned(left: entry.x, top: entry.y, child: Text(entry.name))`
5. **Fixed overlays** (nằm ngoài InteractiveViewer, là siblings trong outer Stack):
   - Search input (top: 8, left: 7) — `TextField` → cập nhật `_highlightedUserId` (local widget state)
   - KUDOS count label (top: 11, left: 18) — format "388 KUDOS", data từ `SpotlightData.totalKudos`
   - Live feed (top: 124, left: 14) — format "{timestamp} {receiverName} đã nhận được một Kudos mới"
6. **Highlight state**: `_highlightedUserId != null` → entry đó fontSize 10, color `#FFEA9E`; các entry khác fontSize 8, opacity 70%
7. **Empty state**: `entries.isEmpty` → text "Chưa có dữ liệu Spotlight."
8. **Xóa**: `spotlight_chart_painter.dart`, loại bỏ import `SpotlightNetwork`/`SpotlightNode`/`SpotlightEdge`

### Phase 5: Polish & Cross-cutting Concerns

> **Ghi chú**: Loading/error/empty states đã được build trong mỗi phase (Phase 2-4) theo TDD. Phase 5 chỉ xử lý các concerns chung chưa cover.

1. **Accessibility**: Thêm `Semantics` widgets theo bảng VoiceOver trong spec cho TẤT CẢ interactive elements
2. **Animation**: Fine-tune carousel slide (300ms ease-in-out), heart scale (200ms spring), dropdown (200ms ease-out)
3. **Error boundary**: Xử lý 401 → redirect login (tích hợp auth redirect flow hiện tại trong `router.dart`)
4. **Avatar tap → Profile**: Verify tất cả avatar trong feed cards và highlight cards → `context.push('/profile/{userId}')` hoặc navigation callback
6. **Performance audit**: Profile trên device thật — kiểm tra carousel + gradient + infinite scroll

---

## Đánh giá rủi ro

| Rủi ro | Xác suất | Ảnh hưởng | Giảm thiểu |
|--------|----------|-----------|-----------|
| API chưa sẵn sàng | Trung bình | Trung bình | Mock data layer với Riverpod override. Datasource trả mock data ban đầu |
| Carousel performance (5 cards + gradients) | Thấp | Trung bình | `PageView` tự quản lý lazy rendering. Profile trên device thật |
| Infinite scroll pagination edge cases | Thấp | Thấp | Test kỹ boundary: empty next page, concurrent requests, fast scroll |

### Độ phức tạp ước tính

- **Frontend**: **Cao** (nhiều widgets, carousel, floating names canvas, infinite scroll)
- **Backend**: **Thấp** (chỉ gọi API, không tự build backend)
- **Testing**: **Trung bình** (ViewModel + Repository + Widget tests)

---

## Chiến lược kiểm thử tích hợp

### Phạm vi kiểm thử

- [x] **Tương tác component/module**: ViewModel ↔ Repository ↔ Datasource
- [x] **Phụ thuộc bên ngoài**: Supabase API (12 endpoints)
- [ ] **Data layer**: Không có local DB (chỉ in-memory state)
- [x] **Luồng người dùng**: Filter → Carousel reload, Like/Unlike → count update, Infinite scroll

### Phân loại kiểm thử

| Loại | Áp dụng? | Kịch bản chính |
|------|----------|----------------|
| UI ↔ Logic | Có | Filter dropdown → ViewModel → carousel reset; Heart tap → optimistic update |
| Service ↔ Service | Có | Repository chaining: loadHighlight + loadAllKudos parallel |
| App ↔ External API | Có | 12 endpoints (ref: BACKEND_API_TESTCASES.md — 107 test cases) |
| Cross-platform | Không | iOS-only trong phase này |

### Môi trường kiểm thử

- **Loại**: Flutter Test (unit + widget), Emulator (integration)
- **Test data**: Mock factories tạo `Kudos`, `PersonalStats`, v.v.
- **Cô lập**: Riverpod `overrideWith` cho mỗi test — không dùng real API

### Chiến lược Mock

| Loại dependency | Chiến lược | Lý do |
|-----------------|-----------|-------|
| Repository | Mock (mocktail) | Unit test ViewModel không cần real API |
| Datasource | Mock (mocktail) | Unit test Repository không cần real HTTP |
| Supabase client | Mock | Tránh phụ thuộc network trong CI |
| Clipboard | Mock | Widget test cho copy link |
| go_router | Mock | Widget test cho navigation |

### Kịch bản kiểm thử

1. **Happy Path**
   - [x] Load màn hình → hiển thị highlight + all kudos + stats
   - [x] Bấm heart → count tăng, icon thay đổi
   - [x] Chọn filter hashtag → carousel reload với data mới
   - [x] Scroll xuống → load thêm kudos (infinite scroll)
   - [x] Bấm CTA → navigate tới send kudos

2. **Error Handling**
   - [x] API trả 401 → redirect login
   - [x] API trả 500 → hiển thị error + retry button
   - [x] Network timeout → hiển thị error state

3. **Edge Cases**
   - [x] 0 highlight kudos → empty state carousel
   - [x] Filter trả 0 results → empty state message "Không tìm thấy Kudos phù hợp." (TC_FUN_030)
   - [x] Like own kudos → canLike=false, heart disabled
   - [x] Double tap heart (race condition) → debounce/ignore
   - [x] `clearFilters()` → selectedHashtag=null, selectedDepartment=null, carousel reset về page 0, re-fetch highlights (không ảnh hưởng allKudos)
   - [x] `loadAllKudosPage()` (tab All Kudos j_a2GQWKDJ) → populate `allKudosPageList` độc lập với `allKudos`
   - [x] `loadMoreAllKudos()` → append vào `allKudosPageList`, không ảnh hưởng `allKudos`
   - [x] `secret_boxes_unopened = 0` → button "Mở hộp bí mật" disabled, không gọi được
   - [x] `getNextSecretBox()` trả null → không trigger `openSecretBox()`, không navigate
   - [x] x2 bonus active → `toggleHeart()` optimistic update thêm/bớt 2 (không phải 1)
   - [x] Spotlight `entries.isEmpty` → empty state text, KHÔNG render `Image.asset`, `CustomPaint`, hoặc network chart

### Công cụ & Framework

- **Test framework**: `flutter_test` + `mocktail`
- **CI**: `flutter test` trong pipeline
- **Coverage target**: ≥ 80% cho ViewModel + Repository

### Mục tiêu Coverage

| Khu vực | Mục tiêu | Ưu tiên |
|---------|---------|---------|
| ViewModel (KudosViewModel) | 90%+ | Cao |
| Repository (KudosRepository) | 85%+ | Cao |
| Widget tests (key interactions) | 70%+ | Trung bình |
| Model serialization | 100% | Cao |

---

## Phụ thuộc & Điều kiện tiên quyết

### Yêu cầu trước khi bắt đầu

- [x] `constitution.md` đã review
- [x] `spec.md` đã review và approved
- [x] `design-style.md` đã review
- [x] `BACKEND_API_TESTCASES.md` đã review (17 endpoints, 107 test cases)
- [ ] API server sẵn sàng (hoặc mock data layer)
- [ ] SVG icons từ Figma đã download

### Phụ thuộc bên ngoài

- **Supabase local** (PostgREST, đã hoạt động) — Edge Functions không cần cho implementation hiện tại
- **Secret box route** — Cần verify `router.dart` có route `/secret-box/:boxId` không
- **Seed data** — `secret_boxes` table cần có data để test Feature #2
- Figma assets (icons SVG, hero banner PNG) — ✅ Đã download (xem Thay đổi #26)

---

## Trạng thái triển khai (cập nhật 2026-04-13)

**Trạng thái**: ĐÃ TRIỂN KHAI — tất cả phases hoàn thành, đang ở giai đoạn fine-tune UI theo Figma.

### Thay đổi so với plan gốc (post-implementation)

| # | Thay đổi | Lý do |
|---|---------|-------|
| 1 | **D.3**: "Top 10 nhận quà nhiều nhất" → "10 Sunner nhận quà mới nhất" | Figma design hiển thị avatar + tên + tên quà, không có rank/count |
| 2 | **D.3 row**: Bỏ rank number, bỏ department, bỏ giftCount → chỉ avatar + tên + rewardName | Match Figma |
| 3 | **D.3 container**: Thêm dark card container (bg: #00070C, border: #998C5F) bao quanh | Match Figma (cùng style Stats card) |
| 4 | **Feed list**: unlimited → **max 10 items** trên màn hình chính | Figma chỉ hiển thị ~3-4 cards, "View all" cho phần còn lại |
| 5 | **CTA bottom**: Bỏ OutlineButtonWidget → thay bằng "View all Kudos" + `ic_arrow_open` (GestureDetector, centered) | Match Figma design |
| 6 | **Background image**: Di chuyển từ `KudosHeroBannerWidget` lên `KudosScreen` Stack level | Background trải dài từ AppBar xuống hero, không chỉ trong hero widget |
| 7 | **Datasource**: Bỏ RPC `get_highlight_kudos` (không tồn tại) → direct query + client-side sort by heartCount | Supabase không có Edge Functions |
| 8 | **Datasource**: `fetchPersonalStats` dùng `_tryGetCurrentUserId()` (null-safe) thay `_getCurrentUserId()` | Tránh crash khi user chưa có profile |
| 9 | **ViewModel**: `build()` dùng `_safeFetch()` per call thay `.wait` | Tránh ParallelWaitError khi 1 API fail |
| 10 | **Auth flow**: Thêm `ensureUserProfile()` sau login thành công | Tự động tạo user profile trong bảng `users` từ Google metadata |
| 11 | **RLS**: Thêm `users_insert` policy | Cho phép authenticated user tạo profile lần đầu |
| 12 | **PageIndicator**: Tách text thành 2 màu (currentPage: textAccent, /total: textSecondary) | Match Figma |
| 13 | **i18n**: Tất cả hardcoded strings → `t.kudos.*` (43 strings) | Constitution rule: không hardcode text |
| 14 | **Section order**: Stats → Top 10 → Feed (plan gốc: Stats → Feed → Top 10) | Match Figma layout |
| 15 | **Model**: `GiftRecipientRanking` thêm field `rewardName` | D.3 hiển thị tên quà nhận được |
| 16 | **PostgREST**: Toàn bộ datasource dùng PostgREST thay Edge Functions | Backend chưa có Edge Functions |
| 17 | **Unified KudosCard**: Gộp `HighlightKudosCard` + `KudosFeedCard` → 1 widget `KudosCard` với `KudosCardVariant` enum (highlight/feed) | Giảm trùng lặp code, cả 2 variant dùng chung `_SenderReceiverRow` + `_UserAvatar` |
| 18 | **Xóa files**: `highlight_kudos_card.dart`, `kudos_feed_card.dart` | Thay bằng `kudos_card.dart` unified |
| 19 | **Hero tier system**: Thêm `hero_tier_url` column vào bảng `users` + Supabase Storage bucket `hero-tiers` + upload 4 badge PNGs (legend_hero, new_hero, rising_hero, super_hero) | Hiển thị badge "danh hiệu" bên cạnh tên user trong KudosCard |
| 20 | **UserSummary model**: Thêm field `heroTierUrl` (String, default '') | Map từ `hero_tier_url` column trong DB |
| 21 | **_UserAvatar widget**: Hiển thị hero tier image (Image.network) + dot separator dưới department. URL = `${EnvConfig.supabaseUrl}$heroTierUrl` | Match Figma design B.3.2 — badge danh hiệu bên cạnh thông tin user |
| 22 | **_mapUserSummary**: Thêm mapping `hero_tier_url` → `heroTierUrl`. Cập nhật tất cả select queries (sender, recipient, searchSpotlight, topGiftRecipients) thêm `hero_tier_url` | Data flow end-to-end: DB → API → Model → UI |
| 23 | **Kudos model**: Thêm fields `awardTitle` (nullable String) và `imageUrls` (List<String>) | Hỗ trợ hiển thị award title + photos trên card |
| 24 | **PersonalStatsCard fire icon**: Đổi từ SVG (`ic_fire.svg` + ColorFilter monochrome) → PNG multi-color (`Assets.images.kudosFire`) | Match Figma — icon lửa gradient cam/đỏ, không phải monochrome vàng |
| 25 | **Theme colors mới**: `textRed` (#FFD4271D), `awardMessageContent` (#FFFFEA9E) | Dùng cho award title text và message background |
| 26 | **Assets mới**: `ic_dot.svg` (dot separator), `ic_media.svg` (sender→receiver icon), `ic_link.svg`, badge PNGs trong `assets/images/` | Icons UI mới + hero tier badge images |
| 27 | **Migration**: `20260413000001_add_kudos_award_title_image.sql` (award_title column) + `20260413000002_add_hero_tier_url.sql` (hero_tier_url + storage bucket) | DB schema updates |
| 28 | **Seed data**: Cập nhật `seed.sql` — badges image_url → Supabase Storage paths, users có `hero_tier_url`, kudos có `award_title` | Mock data phản ánh schema mới |
| 29 | **TopGiftRecipientsCard**: Thêm `rewardName` display + `onUserTap` callback → `context.push('/profile/$userId')` | Match spec US7 FR-007; Figma D.3.2 tap → profile |

### Files đã tạo/sửa (final — cập nhật 2026-04-13 lần 2)

**Tạo mới**: 41 files trong `lib/features/kudos/` (models + generated + datasource + repository + viewmodel + screen + 13 widgets — sau khi gộp 2 card widgets)
**Widget gộp**: `highlight_kudos_card.dart` + `kudos_feed_card.dart` → `kudos_card.dart` (unified với enum variant)
**Sửa**: `main_scaffold.dart`, `app_colors.dart`, `section_header_widget.dart`, `pubspec.yaml`, `strings_vi.i18n.json`, `strings_en.i18n.json`, `auth_remote_datasource.dart`, `auth_repository.dart`, `auth_viewmodel.dart`, `kudos_remote_datasource.dart`, `personal_stats_card.dart`, `highlight_carousel_widget.dart`, `kudos_screen.dart`
**Migrations**: `20260413000000_add_users_insert_policy.sql`, `20260413000001_add_kudos_award_title_image.sql`, `20260413000002_add_hero_tier_url.sql`
**Assets mới**: `ic_dot.svg`, `ic_media.svg`, `ic_link.svg`, `assets/images/kudos_fire.png`, `assets/images/badges/*.png` (4 files)
**Seed data**: `seed.sql` (cập nhật hero_tier_url + award_title)

---

## Công việc còn lại (Cập nhật 2026-04-16)

*Phát hiện trong quá trình review spec. Cần implement trước khi coi feature là hoàn chỉnh.*

### Bug #1: Spotlight Board dùng Image.asset thay vì floating text labels [CRITICAL — TR-002]

**File**: `lib/features/kudos/presentation/widgets/spotlight_section_widget.dart`

**Hiện trạng**: Widget đang render `Image.asset(Assets.images.kudosSpotlight.path, fit: BoxFit.cover)` bất kể có dữ liệu hay không. Cần thay bằng floating text labels của những người vừa gửi kudos.

**Giải pháp**: Viết lại toàn bộ render logic:

```dart
// HIỆN TẠI (SAI):
return Image.asset(Assets.images.kudosSpotlight.path, fit: BoxFit.cover);

// CẦN ĐỔI THÀNH:
if (data == null || data.entries.isEmpty) {
  return SizedBox(
    height: 159,
    child: Center(child: Text(t.kudos.emptySpotlight)),
  );
}
return ClipRRect(
  borderRadius: BorderRadius.circular(8),
  child: Container(
    height: 159,
    color: const Color(0xFF00101A),
    child: Stack(
      children: [
        // Layer 1: Panning name labels
        InteractiveViewer(
          panEnabled: true,
          scaleEnabled: false,
          child: SizedBox(
            width: 700,
            height: 130,
            child: Stack(
              children: [
                for (final entry in data.entries)
                  Positioned(
                    left: entry.x,
                    top: entry.y,
                    child: Text(
                      entry.name,
                      style: TextStyle(
                        fontSize: _highlightedUserId == entry.userId ? 10 : 8,
                        fontWeight: FontWeight.w700,
                        color: _highlightedUserId == entry.userId
                            ? const Color(0xFFFFEA9E)
                            : Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        // Layer 2: Fixed search input (top: 8, left: 7)
        Positioned(top: 8, left: 7, child: /* Search input B.7.3 */),
        // Layer 3: Fixed KUDOS count (top: 11, left: 18)
        Positioned(top: 11, left: 18, child: Text('${data.totalKudos} KUDOS', ...)),
        // Layer 4: Fixed live feed (top: 124, left: 14)
        if (data.recentActivity != null)
          Positioned(top: 124, left: 14, child: Text('${data.recentActivity!.timestamp} ${data.recentActivity!.receiverName} đã nhận được một Kudos mới', ...)),
      ],
    ),
  ),
);
```

**Lưu ý**: `_highlightedUserId` là local state trong `SpotlightSectionWidget` — KHÔNG add vào `KudosState`. `SpotlightNetwork`, `SpotlightNode`, `SpotlightEdge` và `SpotlightChartPainter` cần được XÓA hoàn toàn.

**Quy trình TDD**:
1. Viết `test/widget/kudos/spotlight_section_widget_test.dart` trước:
   - Test: `entries.isEmpty` → hiển thị empty state text, KHÔNG render `InteractiveViewer`
   - Test: `entries.isNotEmpty` → render `InteractiveViewer` + tên từng entry, KHÔNG render `Image.asset`
   - Test: `_highlightedUserId != null` → entry đó có style khác (fontSize 10, color #FFEA9E)
   - Test: search input thay đổi → `_highlightedUserId` cập nhật
   - Test: KUDOS count label hiển thị đúng `totalKudos` từ data
   - Test: live feed hiển thị đúng format receiverName + timestamp
2. Sửa widget — xóa import `SpotlightChartPainter`, `SpotlightNetwork`
3. Xóa file `spotlight_chart_painter.dart`
4. Đổi model prop từ `SpotlightNetwork? network` → `SpotlightData? data` trong widget
5. Verify all tests pass
6. Grep toàn codebase cho `kudosSpotlight` và xóa nếu không còn dùng ở nơi nào khác

---

### Feature #2: Secret Box Flow [US6 Scenario 3 — FR-014]

**Trạng thái**: Chưa implement — datasource có comment `// Secret Box (chưa implement)`

> **Lưu ý từ BACKEND_API_TESTCASES.md**: Secret Box flow cần **2 calls riêng biệt** — không thể gộp thành 1:
> - `SBOX_NEXT_01`: `GET /users/me/secret-boxes/next` → trả về boxId của hộp chưa mở tiếp theo
> - `SBOX_OPEN_01`: `POST /users/me/secret-boxes/{boxId}/open` → mở hộp, trả về reward
> - `SBOX_NEXT_02`: Khi không còn hộp → `204 No Content` (không crash — trả `null`)
> - `SBOX_OPEN_02`: Mở hộp đã mở → `400 BOX_ALREADY_OPENED` (idempotent safe)

**Cần thêm vào `KudosRemoteDatasource`** (2 methods):
```dart
// Call 1: SELECT next unopened box
// SELECT * FROM secret_boxes WHERE user_id = me AND is_opened = false
// ORDER BY created_at ASC LIMIT 1
Future<SecretBox?> getNextSecretBox() async { ... }

// Call 2: Open the box
// UPDATE secret_boxes SET is_opened = true, opened_at = now()
// WHERE id = boxId AND user_id = me
Future<SecretBox> openSecretBox(String boxId) async { ... }
```

**Cần thêm vào `KudosViewModel`**:
```dart
bool _isOpeningBox = false; // double-tap guard (TC_FUN_025)

Future<void> openNextSecretBox() async {
  if (_isOpeningBox) return;
  _isOpeningBox = true;
  try {
    // Step 1: Get next box
    final nextBox = await _repository.getNextSecretBox();
    if (nextBox == null) return; // no unopened boxes

    // Step 2: Open it
    final openedBox = await _repository.openSecretBox(nextBox.id);

    // Step 3: Update local stats (opened+1, unopened-1)
    final currentState = state.valueOrNull;
    if (currentState?.personalStats != null) {
      final stats = currentState!.personalStats!;
      state = AsyncValue.data(currentState.copyWith(
        personalStats: stats.copyWith(
          secretBoxesOpened: stats.secretBoxesOpened + 1,
          secretBoxesUnopened: stats.secretBoxesUnopened - 1,
        ),
      ));
    }

    // Step 4: Navigate to Open Secret Box screen
    // Navigation handled by caller (Screen) via callback or go_router
  } finally {
    _isOpeningBox = false;
  }
}
```

> **Navigation strategy**: ViewModel không gọi go_router trực tiếp. Screen lắng nghe state change (có thể dùng `ref.listen`) hoặc ViewModel expose `openedBox` kết quả qua một `AsyncValue<SecretBox?>` state riêng để Screen navigate.

**Cần kiểm tra trong `router.dart`**: Route `/secret-box/:boxId` (screenId: `kQk65hSYF2`) đã tồn tại chưa. Nếu chưa, cần thêm trước khi implement flow này.

**Quy trình TDD**:
1. Viết unit test trong `kudos_viewmodel_test.dart` trước:
   - Test: `getNextSecretBox()` trả non-null + `openSecretBox()` thành công → stats cập nhật
   - Test: `getNextSecretBox()` trả `null` → không gọi `openSecretBox()`, state không thay đổi
   - Test: double-tap → `_isOpeningBox` guard chỉ cho 1 lần call
   - Test: `secret_boxes_unopened = 0` → PersonalStatsCard không enable button (widget test)
   - Test: `openSecretBox()` throw exception → state rollback, `_isOpeningBox` reset về `false`
2. Implement datasource methods
3. Wire up ViewModel + Screen callback
4. Verify tất cả test pass

---

### ~~Verify #3: TopGiftRecipientsCard hiển thị rewardName~~ [✅ ĐÃ HOÀN THÀNH — 2026-04-16]

**File**: `lib/features/kudos/presentation/widgets/top_gift_recipients_card.dart`

**Kết quả**: Widget đã hiển thị `rewardName` đúng theo spec + `onUserTap` callback → `context.push('/profile/$userId')` đã được wire.
**Test**: `test/widget/kudos/top_gift_recipients_card_test.dart` — 4 tests bao gồm rewardName display, no rewardName when empty, tap callback, tap with null callback. Tất cả pass.

---

## Đánh giá rủi ro (Cập nhật)

| Rủi ro | Xác suất | Ảnh hưởng | Biện pháp xử lý |
|--------|---------|----------|-----------------|
| Spotlight `Positioned` labels bị overflow khi x/y gần boundary | Thấp | Thấp | Clamp x/y values trong `fetchSpotlight()`: x ∈ [0, 660], y ∈ [0, 110]; test với mock data boundary |
| `Assets.images.kudosSpotlight` vẫn còn dùng ở nơi khác | Thấp | Thấp | Grep `kudosSpotlight` toàn codebase trước khi xóa; nếu không dùng → xóa asset + pubspec entry |
| Secret box route chưa tồn tại trong `router.dart` | Trung bình | Cao | Kiểm tra `router.dart` trước khi implement Feature #2; thêm route `/secret-box/:boxId` nếu thiếu |
| Secret box race condition giữa 2 calls (getNext + open) | Thấp | Trung bình | `_isOpeningBox` flag block second call; server trả `400 BOX_ALREADY_OPENED` (idempotent) — handle gracefully, không crash |
| **x2 Fire Bonus — optimistic heart update sai** | Trung bình | Trung bình | Khi `isBonusActive = true`, `toggleHeart()` cần thêm/bớt 2 thay vì 1. Fix: `final delta = state.valueOrNull?.personalStats?.isBonusActive == true ? 2 : 1;` trong `toggleHeart()` trước khi implement secret box |

---

## Ghi chú

- Feature đã triển khai và hoạt động với Supabase local (PostgREST) — trừ Spotlight Board (bug) và Secret Box flow (chưa implement)
- Khi backend deploy Edge Functions, cần refactor datasource từ PostgREST → functions.invoke()
- Spotlight Board dùng `Stack của Positioned(Text)` trong `InteractiveViewer` — KHÔNG dùng CustomPainter hay network graph library; approach này match đúng Figma design
- Tất cả `.md` đều viết bằng tiếng Việt theo yêu cầu project
- Sau khi fix Spotlight: grep `kudosSpotlight` toàn codebase, nếu không còn dùng → xóa `assets/images/kudos_spotlight.png` + pubspec entry + regenerate flutter_gen
