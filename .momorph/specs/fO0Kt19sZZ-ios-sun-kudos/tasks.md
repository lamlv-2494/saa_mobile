# Tasks: [iOS] Sun*Kudos — Màn hình chính Kudos

**Frame**: `fO0Kt19sZZ-ios-sun-kudos`
**Prerequisites**: plan.md ✅, spec.md ✅, design-style.md ✅

---

## Định dạng Task

```
- [ ] T### [P?] [Story?] Mô tả | đường/dẫn/file
```
1
- **[P]**: Có thể chạy song song (file khác nhau, không phụ thuộc lẫn nhau)
- **[Story]**: User story liên quan (US1–US7)
- **|**: File bị ảnh hưởng bởi task

---

## Phase 1: Setup (Chuẩn bị hạ tầng)

**Mục đích**: Chuẩn bị assets, theme colors, i18n, cấu trúc thư mục feature

- [x] T001 Tạo cấu trúc thư mục `lib/features/kudos/` theo plan (data/models, data/datasources, data/repositories, presentation/viewmodels, presentation/screens, presentation/widgets) | `lib/features/kudos/`
- [x] T000 [P] Download SVG icons từ Figma (ic_pencil, ic_heart_outlined, ic_heart_filled, ic_copy_link, ic_sent, ic_fire, ic_gift_box, ic_next, ic_prev) vào `assets/icons/`. Dùng momorph tool `get_media_files` | `assets/icons/`
- [x] T000 [P] Download hero banner background PNG từ Figma vào `assets/images/kudos/key_visual_bg.png`. Dùng momorph tool `get_media_files` | `assets/images/kudos/`
- [x] T000 [P] Bổ sung colors mới vào `AppColors`: `surfaceCard` (#FFF8E1), `surfaceDark` (#00070C), `textSecondary` (#999999), `heart` (#F17676), `primary15` (rgba(255,234,158,0.15)) | `lib/app/theme/app_colors.dart`
- [x] T000 [P] Thêm i18n strings cho kudos section vào cả VN và EN. Bao gồm: section titles, CTA text, empty states, error messages, stats labels, filter labels, accessibility labels | `lib/i18n/strings_vi.i18n.json`, `lib/i18n/strings_en.i18n.json`
- [x] T000 Chạy `dart run build_runner build` để generate flutter_gen assets + slang strings | `lib/gen/`, `lib/i18n/strings.g.dart`
- [x] T000 Đăng ký asset folders mới trong pubspec.yaml nếu chưa có: `assets/images/kudos/` | `pubspec.yaml`

**Checkpoint**: Assets, colors, i18n sẵn sàng. Chạy `flutter analyze` đạt 0 warnings.

---

## Phase 2: Foundation (Data Layer — chặn tất cả user stories)

**Mục đích**: Models, datasource, repository, ViewModel — nền tảng data cho tất cả phases sau

**⚠️ QUAN TRỌNG**: Không thể bắt đầu user story nào cho đến khi phase này hoàn thành

### Models (freezed)

- [x] T008 [P] Viết test cho `UserSummary` model (serialization, equality) | `test/unit/models/user_summary_test.dart`
- [x] T009 [P] Tạo `UserSummary` model (freezed + json_serializable): id, name, avatar, department, badgeLevel | `lib/features/kudos/data/models/user_summary.dart`
- [x] T010 [P] Viết test cho `Hashtag` model (serialization) | `test/unit/models/hashtag_test.dart`
- [x] T011 [P] Tạo `Hashtag` model (freezed): id, name | `lib/features/kudos/data/models/hashtag.dart`
- [x] T012 [P] Viết test cho `Department` model (serialization) | `test/unit/models/department_test.dart`
- [x] T013 [P] Tạo `Department` model (freezed): id, name | `lib/features/kudos/data/models/department.dart`
- [x] T014 [P] Viết test cho `Kudos` model (serialization, embedded sender/receiver UserSummary, hashtags list, isLikedByMe, canLike) | `test/unit/models/kudos_test.dart`
- [x] T015 [P] Tạo `Kudos` model (freezed): id, sender (UserSummary), receiver (UserSummary), content, hashtags (List<Hashtag>), heartCount, createdAt, isHighlight, isAnonymous, isLikedByMe, canLike, shareUrl | `lib/features/kudos/data/models/kudos.dart`
- [x] T016 [P] Viết test cho `PersonalStats` model | `test/unit/models/personal_stats_test.dart`
- [x] T017 [P] Tạo `PersonalStats` model (freezed): kudosReceived, kudosSent, heartsReceived, secretBoxesOpened, secretBoxesUnopened, starBadgeLevel, isBonusActive | `lib/features/kudos/data/models/personal_stats.dart`
- [x] T018 [P] Viết test cho `SpotlightNetwork` model | `test/unit/models/spotlight_network_test.dart`
- [x] T019 [P] Tạo `SpotlightNetwork` model (freezed): nodes (List<SpotlightNode>), edges (List<SpotlightEdge>), totalKudos. SpotlightNode: userId, name, avatar, x, y. SpotlightEdge: fromUserId, toUserId, weight | `lib/features/kudos/data/models/spotlight_network.dart`
- [x] T020 [P] Viết test cho `GiftRecipientRanking` model | `test/unit/models/gift_recipient_ranking_test.dart`
- [x] T021 [P] Tạo `GiftRecipientRanking` model (freezed): rank, user (UserSummary), giftCount | `lib/features/kudos/data/models/gift_recipient_ranking.dart`
- [x] T022 Viết test cho `KudosState` model (default values, copyWith) | `test/unit/models/kudos_state_test.dart`
- [x] T023 Tạo `KudosState` model (freezed): highlightKudos, allKudos, personalStats, topGiftRecipients, spotlightData, selectedHashtag, selectedDepartment, currentHighlightPage, hasMoreKudos, availableHashtags, availableDepartments | `lib/features/kudos/data/models/kudos_state.dart`
- [x] T024 Chạy `dart run build_runner build` để generate `.freezed.dart` + `.g.dart` cho tất cả models | `lib/features/kudos/data/models/`

### Datasource

- [x] T025 Viết test cho `KudosRemoteDatasource` (mock Supabase client, test 12 methods) | `test/unit/datasources/kudos_remote_datasource_test.dart`
- [x] T026 Tạo `KudosRemoteDatasource` với 12 methods: fetchKudos(page, limit, hashtagId?, departmentId?), fetchHighlightKudos(hashtagId?, departmentId?), fetchKudosDetail(kudosId), likeKudos(kudosId), unlikeKudos(kudosId), fetchSpotlight(), searchSpotlight(query), fetchTotalKudosCount(), fetchPersonalStats(), fetchTopRecipients(), fetchHashtags(), fetchDepartments() | `lib/features/kudos/data/datasources/kudos_remote_datasource.dart`

### Repository

- [x] T027 Viết test cho `KudosRepository` (mock datasource, test error handling, mapping) | `test/unit/repositories/kudos_repository_test.dart`
- [x] T028 Tạo `KudosRepository` — wrap datasource methods với try/catch, error mapping, và Riverpod provider | `lib/features/kudos/data/repositories/kudos_repository.dart`

### ViewModel

- [x] T029 Viết test cho `KudosViewModel` — test build(), refresh(), loadMoreKudos(), toggleHeart(), setHashtagFilter(), setDepartmentFilter(), clearFilters() | `test/unit/viewmodels/kudos_viewmodel_test.dart`
- [x] T030 Tạo `KudosViewModel extends AsyncNotifier<KudosState>` — implement build() (parallel fetch highlight + allKudos + stats + spotlight + topRecipients + hashtags + departments), refresh(), loadMoreKudos() (pagination append), toggleHeart() (optimistic update + API call + rollback on error), setHashtagFilter(), setDepartmentFilter(), clearFilters() | `lib/features/kudos/presentation/viewmodels/kudos_viewmodel.dart`
- [x] T031 Tạo test helpers: mock factories cho Kudos, UserSummary, PersonalStats, SpotlightNetwork, etc. | `test/helpers/kudos_test_helpers.dart`

**Checkpoint**: Data layer hoàn chỉnh. `flutter test test/unit/` pass 100%. Có thể bắt đầu UI.

---

## Phase 3: User Story 1+5 — Xem Highlight Kudos + All Kudos Feed (P1) 🎯 MVP

**Mục tiêu**: Hiển thị màn hình Kudos với highlight carousel và feed — đây là MVP.

**Kiểm thử độc lập**: Mở app → tab Kudos → thấy highlight carousel (swipe được) + all kudos feed (scroll được). Loading shimmer khi đang fetch. Empty state khi không có data.

### Shared Widgets (dùng chung)

- [x] T032 Viết test cho `SectionHeaderWidget` mở rộng (test trailing parameter backward-compatible) | `test/widget/shared/section_header_widget_test.dart`
- [x] T033 Extend `SectionHeaderWidget` — thêm optional `Widget? trailing` parameter (ví dụ: "Xem tất cả →"). Backward-compatible, không break existing usages | `lib/shared/widgets/section_header_widget.dart`
- [x] T034 [P] Viết test cho `KudosContentCard` (hiển thị nội dung, hashtags, actions row) | `test/widget/kudos/kudos_content_card_test.dart`
- [x] T035 [P] [US1] Tạo `KudosContentCard` — reusable card (bg: #FFF8E1, border: 1px #FFEA9E, r: 4px, padding: 8px 12px). Chứa: message text, hashtag chips, action row (heart + copy link + "Xem chi tiết"). Dùng cho cả Highlight card và Feed card | `lib/features/kudos/presentation/widgets/kudos_content_card.dart`

### Highlight Carousel (US1)

- [x] T036 [P] Viết test cho `HighlightKudosCard` (hiển thị sender/receiver info, content card) | `test/widget/kudos/highlight_kudos_card_test.dart`
- [x] T037 [P] [US1] Tạo `HighlightKudosCard` — sender/receiver row (avatar + name + badge → arrow → avatar + name + badge) + divider (#FFEA9E) + KudosContentCard. Bg: #FFF8E1, border: 1px #FFEA9E, padding: 8px 12px | `lib/features/kudos/presentation/widgets/highlight_kudos_card.dart`
- [x] T038 Viết test cho `PageIndicatorWidget` (hiển thị "2/5", arrow disable ở boundary) | `test/widget/kudos/page_indicator_test.dart`
- [x] T039 [US1] Tạo `PageIndicatorWidget` — Row: [arrow left 24x24] + "currentPage/totalPages" (14px/700, white) + [arrow right 24x24]. Gap: 32px. Arrows disabled/hidden khi ở boundary (page 1 hoặc page cuối) | `lib/features/kudos/presentation/widgets/page_indicator_widget.dart`
- [x] T040 Viết test cho `HighlightCarouselWidget` (PageView page change, gradient overlays, empty state) | `test/widget/kudos/highlight_carousel_test.dart`
- [x] T041 [US1] Tạo `HighlightCarouselWidget` — PageView (335x256) + gradient overlay trái/phải (79px, linear-gradient) + PageIndicator. Empty state: "Hiện tại chưa có Kudos nào." Loading: shimmer 3 card placeholders | `lib/features/kudos/presentation/widgets/highlight_carousel_widget.dart`

### All Kudos Feed (US5)

- [x] T042 [P] Viết test cho `KudosFeedCard` (hiển thị sender → receiver, time, content card, avatar tap callback) | `test/widget/kudos/kudos_feed_card_test.dart`
- [x] T043 [P] [US5] Tạo `KudosFeedCard` — Header: [Avatar (32px circle, tap → profile)] [Name + Badge] → [icon_sent] → [Avatar] [Name + Badge]. Time: 12px/400 #999. Content: KudosContentCard. Gap giữa cards: 20px | `lib/features/kudos/presentation/widgets/kudos_feed_card.dart`
- [x] T044 [P] [US5] Tạo `AllKudosSectionWidget` — SectionHeader("Sun* Annual Awards 2025", "ALL KUDOS", trailing: "Xem tất cả →" link #FFEA9E) + list of KudosFeedCard. Empty state: "Chưa có Kudos nào được gửi." | `lib/features/kudos/presentation/widgets/all_kudos_section_widget.dart`

### Hero Banner

- [x] T045 [P] [US1] Tạo `KudosHeroBannerWidget` — Stack: background image (Assets.images.kudos.keyVisualBg) + gradient shadows (left + bottom) + Column: tagline "Hệ thống ghi nhận và cảm ơn" (14px/500 #FFEA9E) + KUDOS logo (221x39) | `lib/features/kudos/presentation/widgets/kudos_hero_banner_widget.dart`

### Highlight Section Container

- [x] T046 [US1] Tạo `HighlightSectionWidget` — Column (gap: 24): SectionHeader("Sun* Annual Awards 2025", "HIGHLIGHT KUDOS") + placeholder cho filters (Phase 4) + HighlightCarouselWidget | `lib/features/kudos/presentation/widgets/highlight_section_widget.dart`

### Main Screen

- [x] T047 Viết test cho `KudosScreen` (verify sections render, pull-to-refresh, scroll behavior) | `test/widget/kudos/kudos_screen_test.dart`
- [x] T048 [US1] Tạo `KudosScreen` (ConsumerWidget) — Scaffold(bg: #00101A) + CustomScrollView: SliverAppBar (floating, transparent, gradient, 104px — logo + actions) + SliverToBoxAdapter(HeroBanner + CTA button dùng OutlineButtonWidget) + SliverToBoxAdapter(HighlightSection) + SliverToBoxAdapter(placeholder Spotlight) + SliverToBoxAdapter(AllKudosSection header) + SliverList(KudosFeedCard items + infinite scroll via ScrollController) + RefreshIndicator cho pull-to-refresh | `lib/features/kudos/presentation/screens/kudos_screen.dart`
- [x] T049 Tích hợp `MainScaffold` — Thay `_PlaceholderTab(title: 'Kudos')` tại index 2 bằng `KudosScreen()`. Import kudos_screen.dart | `lib/app/main_scaffold.dart`

**Checkpoint**: MVP hoàn chỉnh. Tab Kudos hiển thị highlight carousel + all kudos feed với data thật (hoặc mock). Pull-to-refresh + infinite scroll hoạt động. `flutter test` pass.

---

## Phase 4: User Story 2 — Gửi Kudos CTA (P1)

**Mục tiêu**: Người dùng bấm CTA → navigate tới màn hình gửi kudos.

**Kiểm thử độc lập**: Bấm nút "Hôm nay, bạn muốn gửi kudos đến ai?" → navigate tới route gửi kudos (hoặc placeholder).

- [x] T050 [US2] Thêm CTA button navigation logic — OutlineButtonWidget onPressed → `context.push('/kudos/send')` hoặc placeholder route. CTA xuất hiện 2 lần: hero banner (đã có T048) + cuối feed. Thêm route placeholder vào router nếu chưa build màn hình gửi kudos | `lib/features/kudos/presentation/screens/kudos_screen.dart`, `lib/app/router.dart`

**Checkpoint**: Bấm CTA → navigate thành công.

---

## Phase 5: User Story 3 — Lọc Highlight Kudos (P2)

**Mục tiêu**: Lọc highlight carousel theo hashtag và/hoặc phòng ban.

**Kiểm thử độc lập**: Bấm dropdown "Hashtag" → chọn → carousel reload. Bấm dropdown "Phòng ban" → chọn → carousel reload. Cả 2 filter → AND logic. Clear → reset.

### Filter Dropdown

- [x] T051 Viết test cho `FilterDropdownButton` (tap → callback, label thay đổi khi selected, icon dropdown) | `test/widget/kudos/filter_dropdown_button_test.dart`
- [x] T052 [US3] Tạo `FilterDropdownButton` — Dựa trên OutlineButtonWidget pattern. Props: label, selectedValue?, onTap, width?. Style: bg rgba(255,234,158,0.10), border 1px #998C5F, r: 4px, h: 40px. Icon dropdown 24x24. Khi selectedValue != null → hiển thị tên thay label | `lib/features/kudos/presentation/widgets/filter_dropdown_button.dart`

### Bottom Sheet cho filter options

- [x] T053 [US3] Tích hợp filter dropdowns vào HighlightSectionWidget — 2 FilterDropdownButton (Hashtag w:129px + Phòng ban w:auto) trong Row (gap:8). Tap → showModalBottomSheet với danh sách options từ ViewModel (availableHashtags / availableDepartments). Chọn → ViewModel.setHashtagFilter() / setDepartmentFilter() → carousel reset về page 0. Clear button nếu filter đang active | `lib/features/kudos/presentation/widgets/highlight_section_widget.dart`

**Checkpoint**: Filters hoạt động. Carousel reload khi filter thay đổi. AND logic correct.

---

## Phase 6: User Story 6 — Xem thống kê cá nhân (P2)

**Mục tiêu**: Hiển thị block thống kê cá nhân + nút mở hộp bí mật.

**Kiểm thử độc lập**: Scroll đến section stats → thấy 5 chỉ số + badge x2 fire + nút "Mở hộp bí mật".

- [x] T054 Viết test cho `PersonalStatsCard` (hiển thị 5 stats, x2 badge, button, empty state) | `test/widget/kudos/personal_stats_card_test.dart`
- [x] T055 [US6] Tạo `PersonalStatsCard` — Container (bg: #00070C, border: 0.794px #998C5F, r: 8px, p: 12px). 5 stat rows (Row space-between: label 14px/400 white + value 14px/700 #FFEA9E). Divider sau hearts row. x2 Fire badge (icon_fire) khi isBonusActive. Button "Mở hộp bí mật" (OutlineButtonWidget + icon_gift_box, onTap → navigate kQk65hSYF2 hoặc placeholder). Empty: tất cả giá trị = 0 | `lib/features/kudos/presentation/widgets/personal_stats_card.dart`
- [x] T056 [US6] Tích hợp PersonalStatsCard vào KudosScreen — Chèn vào All Kudos content area (trước danh sách kudos cards, sau header) | `lib/features/kudos/presentation/screens/kudos_screen.dart`

**Checkpoint**: Stats block hiển thị đúng. Nút "Mở hộp bí mật" navigate được.

---

## Phase 7: User Story 7 — Top 10 Sunner nhận quà (P3)

**Mục tiêu**: Hiển thị bảng xếp hạng top 10 ở cuối feed.

**Kiểm thử độc lập**: Scroll đến cuối → thấy Top 10 list với rank, avatar, tên, phòng ban, số quà.

- [x] T057 Viết test cho `TopGiftRecipientsCard` (hiển thị 10 rows, empty state) | `test/widget/kudos/top_gift_recipients_card_test.dart`
- [x] T058 [US7] Tạo `TopGiftRecipientsCard` — Column (gap: 12px). Title: 14px/700 #FFEA9E. 10 rows: Row space-between — rank (14px/700 #FFEA9E) + avatar (circle 24-32px) + name (14px/400 white) + dept (12px/400 #999) + count (14px/700 #FFEA9E). Empty: "Chưa có dữ liệu xếp hạng." | `lib/features/kudos/presentation/widgets/top_gift_recipients_card.dart`
- [x] T059 [US7] Tích hợp TopGiftRecipientsCard vào KudosScreen — Chèn sau kudos feed cards, trước CTA button cuối | `lib/features/kudos/presentation/screens/kudos_screen.dart`

**Checkpoint**: Top 10 hiển thị đúng với ranking.

---

## Phase 8: User Story 4 — Spotlight Board (P2)

**Mục tiêu**: Hiển thị mạng lưới kết nối kudos dạng interactive network chart.

**Kiểm thử độc lập**: Scroll đến Spotlight → thấy network graph (pan/zoom), "388 KUDOS" label, ô tìm kiếm.

- [x] T060 Viết test cho `SpotlightChartPainter` (render nodes, edges, hit test) | `test/widget/kudos/spotlight_chart_painter_test.dart`
- [x] T061 [US4] Tạo `SpotlightChartPainter` extends CustomPainter — render nodes (circles với avatar placeholder), edges (lines với weight → thickness), highlight matched node. Input: SpotlightNetwork data | `lib/features/kudos/presentation/widgets/spotlight_chart_painter.dart`
- [x] T062 Viết test cho `SpotlightSectionWidget` (loading, error, empty, search input) | `test/widget/kudos/spotlight_section_test.dart`
- [x] T063 [US4] Tạo `SpotlightSectionWidget` — SectionHeader("Sun* Annual Awards 2025", "SPOTLIGHT BOARD") + Container (h: 159, border: 0.29px #998C5F, overflow hidden): InteractiveViewer wrapping CustomPaint(SpotlightChartPainter). Overlay: search input (top-left, dựa trên OutlineButtonWidget mini) + "388 KUDOS" label (bottom-left, 10px/400 white). Empty: "Chưa có dữ liệu." | `lib/features/kudos/presentation/widgets/spotlight_section_widget.dart`
- [x] T064 [US4] Tích hợp SpotlightSectionWidget vào KudosScreen — Thay placeholder Spotlight bằng widget thực | `lib/features/kudos/presentation/screens/kudos_screen.dart`

**Checkpoint**: Spotlight Board hiển thị network graph. Pan/zoom hoạt động. Total kudos count đúng.

---

## Phase 9: Tính năng tương tác (Cross-story)

**Mục đích**: Heart toggle, copy link, avatar navigation — ảnh hưởng nhiều stories

### Heart Button

- [x] T065 Viết test cho `HeartButton` (toggle state, optimistic update, disabled khi canLike=false, animation) | `test/widget/kudos/heart_button_test.dart`
- [x] T066 [P] Tạo `HeartButton` — Toggle widget: outlined heart (#999) ↔ filled heart (#F17676). Props: heartCount, isLiked, canLike, onToggle. Animation: scale 1.0→1.3→1.0 (200ms spring). Disabled (opacity 0.5) khi canLike=false. Hiển thị count bên cạnh icon | `lib/features/kudos/presentation/widgets/heart_button.dart`
- [x] T067 Tích hợp HeartButton vào KudosContentCard — Thay placeholder heart trong action row bằng HeartButton. onToggle → ViewModel.toggleHeart(kudosId) | `lib/features/kudos/presentation/widgets/kudos_content_card.dart`

### Copy Link

- [x] T068 [P] Tích hợp copy link vào KudosContentCard — Tap icon_copy_link → Clipboard.setData(kudos.shareUrl) + ScaffoldMessenger.showSnackBar("Đã sao chép liên kết", duration: 2s) | `lib/features/kudos/presentation/widgets/kudos_content_card.dart`

### Avatar → Profile Navigation

- [x] T069 [P] Tích hợp avatar tap → profile navigation trong KudosFeedCard và HighlightKudosCard — GestureDetector trên avatar → callback onUserTap(userId) → context.push('/profile/$userId') hoặc placeholder | `lib/features/kudos/presentation/widgets/kudos_feed_card.dart`, `lib/features/kudos/presentation/widgets/highlight_kudos_card.dart`

**Checkpoint**: Heart like/unlike hoạt động với optimistic update. Copy link copy vào clipboard + snackbar. Avatar tap navigate.

---

## Phase 10: Polish & Cross-cutting Concerns

**Mục đích**: Accessibility, animations, performance, error boundary

- [x] T070 [P] Thêm `Semantics` widgets cho tất cả interactive elements theo bảng VoiceOver trong spec: CTA button, dropdown buttons, highlight cards, slide indicator arrows, heart button, copy link, "Xem chi tiết", "Mở hộp bí mật", nav bar tabs | `lib/features/kudos/presentation/widgets/*.dart`
- [x] T071 [P] Fine-tune animations: carousel slide (300ms ease-in-out), heart scale (200ms spring), dropdown bottom sheet (200ms ease-out), CTA button tap (150ms opacity) | `lib/features/kudos/presentation/widgets/*.dart`
- [x] T072 [P] Xử lý 401 error → verify auth redirect flow hoạt động khi token expired (tích hợp với existing auth redirect trong router.dart) | `lib/features/kudos/data/datasources/kudos_remote_datasource.dart`
- [x] T073 Performance audit trên device thật — profile carousel + gradient overlays + infinite scroll. Kiểm tra FPS ≥ 30fps khi pan/zoom spotlight | Device testing
- [x] T074 Chạy `flutter analyze` + `dart format` — đảm bảo 0 warnings, 0 lint errors | Toàn bộ project
- [x] T075 Chạy toàn bộ test suite: `flutter test` — đảm bảo tất cả tests pass, coverage ≥ 80% cho ViewModel + Repository | `test/`

**Checkpoint**: Feature hoàn chỉnh. Tất cả tests pass. Lint clean. Performance OK trên device thật.

---

## Phụ thuộc & Thứ tự thực thi

### Phụ thuộc giữa Phases

```
Phase 1 (Setup) ─────────────────────────────────────────────────────┐
    │                                                                 │
    v                                                                 │
Phase 2 (Foundation/Data Layer) ──────────────────────────┐          │
    │                                                      │          │
    v                                                      │          │
Phase 3 (US1+US5: Highlight + Feed) ──── MVP 🎯          │          │
    │                                                      │          │
    ├──> Phase 4 (US2: CTA Nav) ──── nhanh, ít code       │          │
    │                                                      │          │
    ├──> Phase 5 (US3: Filters) ─────────────────────────┘          │
    │                                                                 │
    ├──> Phase 6 (US6: Stats) ────── song song với Phase 5,7,8      │
    │                                                                 │
    ├──> Phase 7 (US7: Top 10) ──── song song với Phase 5,6,8       │
    │                                                                 │
    ├──> Phase 8 (US4: Spotlight) ── phức tạp nhất, song song       │
    │                                                                 │
    └──> Phase 9 (Interactions) ──── sau Phase 3 (cần KudosContent) │
         │                                                            │
         v                                                            │
    Phase 10 (Polish) ────────────────────────────────────────────────┘
```

### Song song trong mỗi Phase

- **Phase 1**: T002, T003, T004, T005 song song (files khác nhau)
- **Phase 2**: Tất cả model tests + implementations (T008–T021) song song. T025–T030 tuần tự (datasource → repo → viewmodel)
- **Phase 3**: T034/T036/T042/T045 song song (widgets độc lập). T048 cuối cùng (tích hợp)
- **Phase 5–8**: CÓ THỂ chạy song song nếu đủ resources (files khác nhau, không phụ thuộc lẫn nhau)
- **Phase 9**: T066, T068, T069 song song

### Trong mỗi User Story

1. Test PHẢI viết trước và FAIL
2. Models trước services
3. Widgets trước screen integration
4. Core implementation trước tích hợp

---

## Chiến lược triển khai

### MVP First (Khuyến nghị)

1. Hoàn thành Phase 1 + 2
2. Hoàn thành Phase 3 (US1 + US5)
3. **DỪNG và KIỂM TRA**: Test độc lập trên device
4. Deploy nếu sẵn sàng

### Incremental Delivery

1. Setup + Foundation (Phase 1+2)
2. US1+US5 → Test → Deploy (MVP)
3. US2+US3 → Test → Deploy (Filters + CTA)
4. US6+US7 → Test → Deploy (Stats + Top 10)
5. US4 → Test → Deploy (Spotlight)
6. Polish → Final test → Deploy

---

## Ghi chú

- Commit sau mỗi task hoặc nhóm logic
- Chạy `flutter test` trước khi chuyển phase
- Cập nhật spec.md nếu requirements thay đổi trong quá trình implement
- Đánh dấu task hoàn thành: `[x]`
- TDD bắt buộc: Viết test → Test FAIL (Red) → Implement → Test PASS (Green) → Refactor
- `SectionHeaderWidget` và `OutlineButtonWidget` đã có trong shared/ → REUSE, không tạo mới

---

## Post-implementation Changes (2026-04-13)

Các thay đổi được thực hiện SAU khi hoàn thành 75 tasks gốc, trong quá trình fine-tune UI theo Figma:

- [x] P001 D.3 đổi logic: ranked by count → sorted by recency (mới nhất) | `kudos_remote_datasource.dart`
- [x] P002 D.3 UI: bỏ rank number, bỏ department column, bỏ gift icon → chỉ avatar + tên + rewardName | `top_gift_recipients_card.dart`
- [x] P003 D.3 container: thêm dark card với border vàng bao quanh | `top_gift_recipients_card.dart`
- [x] P004 Model GiftRecipientRanking: thêm field `rewardName` + regenerate freezed | `gift_recipient_ranking.dart`
- [x] P005 Feed list: giới hạn max 10 items | `kudos_screen.dart`
- [x] P006 CTA bottom: thay OutlineButtonWidget → "View all Kudos" + ic_arrow_open centered | `kudos_screen.dart`
- [x] P007 Background image: di chuyển lên Stack level (bao phủ AppBar + Hero) | `kudos_screen.dart`, `kudos_hero_banner_widget.dart`
- [x] P008 Datasource: bỏ RPC, dùng PostgREST trực tiếp cho tất cả queries | `kudos_remote_datasource.dart`
- [x] P009 Datasource: null-safe `_tryGetCurrentUserId()` | `kudos_remote_datasource.dart`
- [x] P010 ViewModel: `_safeFetch()` per call thay `.wait` | `kudos_viewmodel.dart`
- [x] P011 Auth: `ensureUserProfile()` sau login | `auth_remote_datasource.dart`, `auth_repository.dart`, `auth_viewmodel.dart`
- [x] P012 RLS: thêm `users_insert` policy + migration | `20260413000000_add_users_insert_policy.sql`
- [x] P013 PageIndicator: tách text 2 màu | `page_indicator_widget.dart`
- [x] P014 i18n: 43 hardcoded strings → `t.kudos.*` | 10 widget files
- [x] P015 Section order: Stats → Top10 → Feed | `kudos_screen.dart`
- [x] P016 Mock data: 15 users, 28+ kudos, 109 reactions, stats cho user 20 | `seed_kudos_mock.sql`
- [x] P017 Gộp `HighlightKudosCard` + `KudosFeedCard` → `KudosCard` unified với `KudosCardVariant` enum | `kudos_card.dart` (mới), xóa `highlight_kudos_card.dart` + `kudos_feed_card.dart`
- [x] P018 Thêm `awardTitle` (nullable String) + `imageUrls` (List<String>) vào Kudos model + migration | `kudos.dart`, `20260413000001_add_kudos_award_title_image.sql`
- [x] P019 DB: Thêm `hero_tier_url` column vào users + Supabase Storage bucket `hero-tiers` + public read policy | `20260413000002_add_hero_tier_url.sql`
- [x] P020 Upload 4 hero tier badge PNGs lên Supabase Storage (legend_hero, new_hero, rising_hero, super_hero) | `assets/images/kudos/badges/*.png`
- [x] P021 Thêm `heroTierUrl` field vào UserSummary model + regenerate freezed | `user_summary.dart`
- [x] P022 Cập nhật `_mapUserSummary` + tất cả select queries thêm `hero_tier_url` | `kudos_remote_datasource.dart`
- [x] P023 `_UserAvatar`: hiển thị department + dot + hero tier image (Image.network) dưới name | `kudos_card.dart`
- [x] P024 PersonalStatsCard fire icon: SVG monochrome → PNG multi-color gradient | `personal_stats_card.dart`, `assets/images/kudos/ic_fire.png`
- [x] P025 Theme colors: thêm `textRed`, `awardMessageContent` + assets `ic_dot.svg`, `ic_media.svg`, `ic_link.svg` | `app_colors.dart`, `assets/icons/`
- [x] P026 Seed data: cập nhật badges image_url, users hero_tier_url, kudos award_title | `seed.sql`
