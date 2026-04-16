# Tasks: [iOS] Profile — Ban than & Nguoi khac

**Frame**: `hSH7L8doXB-ios-profile-ban-than` + `bEpdheM0yU-ios-profile-nguoi-khac`
**Prerequisites**: plan.md, spec.md (ban than), spec.md (nguoi khac), design-style.md

---

## Dinh dang Task

```
- [ ] T### [P?] [Story?] Mo ta | duong/dan/file
```

- **[P]**: Co the chay song song (file khac nhau, khong phu thuoc lan nhau)
- **[Story]**: User story lien quan (US1–US8 ban than, US1–US8 nguoi khac)
- **|**: File bi anh huong boi task

---

## Phase 0: Setup (Chuan bi assets, theme, i18n, seed data)

**Muc dich**: Chuan bi nen tang truoc khi code — assets, colors, i18n strings, mock data

### Assets & Theme

- [x] T001 [P] Kiem tra SVG icons da co chua (`ic_back.svg`, `ic_edit.svg`) — download tu Figma neu thieu. Dung momorph tool `get_media_files` | `assets/icons/`
- [x] T002 [P] Bo sung colors moi vao `AppColors`: `iconDark` (#1A1A2E), `spam` (#FF8C00) — chi them nhung chua co | `lib/app/theme/app_colors.dart`
- [x] T003 [P] Them i18n strings cho profile section vao ca VN va EN: `profile.myIconCollection`, `profile.kudosReceived`, `profile.kudosSent`, `profile.heartsReceived`, `profile.secretBoxOpened`, `profile.secretBoxUnopened`, `profile.openSecretBox`, `profile.filterSent`, `profile.filterReceived`, `profile.sendKudosButton`, `profile.noKudos`, `profile.noBadges`, `profile.userNotFound`, `profile.errorRetry`, `profile.saaAwards`, `profile.kudosTitle` va cac string tuong ung tieng Anh | `lib/i18n/strings_vi.i18n.json`, `lib/i18n/strings_en.i18n.json`
- [x] T004 Chay `dart run build_runner build` de generate flutter_gen assets + slang strings | `lib/gen/`, `lib/i18n/strings.g.dart`

### Seed Data (APPEND vao seed.sql)

- [x] T005 Append mock data vao cuoi `supabase/seed.sql`: them `user_badges` cho users 6-15 (17 entries) va `secret_boxes` cho users 2-5 (8 entries) voi ON CONFLICT DO NOTHING. Sau do chay `psql -h localhost -p 54322 -U postgres -d postgres -f supabase/seed.sql` | `supabase/seed.sql`

**Checkpoint**: Assets, colors, i18n, seed data san sang. `flutter analyze` dat 0 warnings.

---

## Phase 1: Data Layer — Models (freezed)

**Muc dich**: Tao tat ca models can thiet cho Profile feature. REUSE `Kudos`, `PersonalStats`, `UserSummary` tu `lib/features/kudos/data/models/`

### UserProfile model

- [x] T006 [P] Viet test cho `UserProfile` model (serialization, equality, copyWith) | `test/unit/models/user_profile_test.dart`
- [x] T007 [P] Tao `UserProfile` model (freezed + json_serializable): id, name, avatar, team, badgeTitle, heroTierUrl — mo rong tu UserSummary voi them thong tin | `lib/features/profile/data/models/user_profile.dart`

### IconBadge model

- [x] T008 [P] Viet test cho `IconBadge` model (serialization, equality) | `test/unit/models/icon_badge_test.dart`
- [x] T009 [P] Tao `IconBadge` model (freezed + json_serializable): id, name, imageUrl, earnedAt | `lib/features/profile/data/models/icon_badge.dart`

### Badge model

- [x] T010 [P] Viet test cho `Badge` model (serialization, equality) | `test/unit/models/badge_test.dart`
- [x] T011 [P] Tao `Badge` model (freezed + json_serializable): id, name, imageUrl, type | `lib/features/profile/data/models/badge.dart`

### KudosFilterType enum

- [x] T012 [P] Tao `KudosFilterType` enum: `received`, `sent` | `lib/features/profile/data/models/kudos_filter_type.dart`

### ProfileState model

- [x] T013 Viet test cho `ProfileState` model (default values, copyWith) | `test/unit/models/profile_state_test.dart`
- [x] T014 Tao `ProfileState` model (freezed): userProfile, iconCollection (List<IconBadge>), personalStats (PersonalStats — reuse tu kudos), kudosList (List<Kudos> — reuse tu kudos), kudosFilter (KudosFilterType), kudosReceivedCount, kudosSentCount, hasMoreKudos | `lib/features/profile/data/models/profile_state.dart`

### OtherProfileState model

- [x] T015 Viet test cho `OtherProfileState` model (default values, copyWith) | `test/unit/models/other_profile_state_test.dart`
- [x] T016 Tao `OtherProfileState` model (freezed): userProfile, badgeCollection (List<Badge>), kudosList (List<Kudos> — reuse tu kudos), kudosFilter (KudosFilterType), kudosReceivedCount, kudosSentCount, hasMoreKudos | `lib/features/profile/data/models/other_profile_state.dart`

- [x] T017 Chay `dart run build_runner build` de generate `.freezed.dart` + `.g.dart` cho tat ca models | `lib/features/profile/data/models/`

### Test helpers

- [x] T018 Tao test helpers: mock factories cho UserProfile, IconBadge, Badge, ProfileState, OtherProfileState | `test/helpers/profile_test_helpers.dart`

**Checkpoint**: Models hoan chinh. `flutter test test/unit/models/` pass 100%.

---

## Phase 2: Data Layer — Datasource + Repository + ViewModels

**Muc dich**: API layer + business logic — nen tang cho tat ca UI phases

### Datasource

- [x] T019 Viet test cho `ProfileRemoteDatasource` (mock Supabase client, test 7 methods: fetchMyProfile, fetchUserProfile, fetchMyIcons, fetchUserBadges, fetchUserKudos, fetchUserKudosCount, fetchMyStats) | `test/unit/datasources/profile_remote_datasource_test.dart`
- [x] T020 Tao `ProfileRemoteDatasource` voi 7 methods: fetchMyProfile(), fetchUserProfile(userId), fetchMyIcons(), fetchUserBadges(userId), fetchUserKudos(userId, filter, page, limit), fetchUserKudosCount(userId), fetchMyStats() — delegate/reuse logic tu KudosRemoteDatasource khi co the | `lib/features/profile/data/datasources/profile_remote_datasource.dart`

### Repository

- [x] T021 Viet test cho `ProfileRepository` (mock datasource, test error handling, mapping, pagination logic) | `test/unit/repositories/profile_repository_test.dart`
- [x] T022 Tao `ProfileRepository` — inject ProfileRemoteDatasource + KudosRepository (cho heart toggle). Methods: getMyProfile(), getUserProfile(userId), getMyIcons(), getUserBadges(userId), getUserKudos(userId, filter, page, limit), getUserKudosCount(userId), getMyStats() | `lib/features/profile/data/repositories/profile_repository.dart`

### ViewModel — Profile ban than

- [x] T023 Viet test cho `ProfileViewModel` — test build(), changeFilter(), loadMoreKudos(), toggleHeart() (optimistic update + rollback), refresh() | `test/unit/viewmodels/profile_viewmodel_test.dart`
- [x] T024 Tao `ProfileViewModel extends AsyncNotifier<ProfileState>` — build() parallel fetch profile + icons + stats + kudos list (default: sent) + counts. changeFilter(KudosFilterType), loadMoreKudos(), toggleHeart(kudosId) (optimistic update + delegate KudosRepository), refresh() | `lib/features/profile/presentation/viewmodels/profile_viewmodel.dart`

### ViewModel — Profile nguoi khac

- [x] T025 Viet test cho `OtherProfileViewModel` — test build(userId), changeFilter(), loadMoreKudos(), toggleHeart(), refresh() | `test/unit/viewmodels/other_profile_viewmodel_test.dart`
- [x] T026 Tao `OtherProfileViewModel extends FamilyAsyncNotifier<OtherProfileState, String>` — build(userId) parallel fetch profile + badges + kudos list (default: received) + counts. changeFilter(KudosFilterType), loadMoreKudos(), toggleHeart(kudosId), refresh() | `lib/features/profile/presentation/viewmodels/other_profile_viewmodel.dart`

**Checkpoint**: Data layer hoan chinh. `flutter test test/unit/` pass 100%. Co the bat dau UI.

---

## Phase 3: Core UI — Profile ban than (US1 + US2 + US3 + US4 + US6) — MVP

**Muc tieu**: Hien thi man hinh Profile ban than day du voi data — tab 4 trong bottom nav.

**User stories**: US1 (thong tin ca nhan), US2 (bo suu tap icon), US3 (thong ke), US4 (lich su kudos + filter), US6 (bottom navigation).

### Shared Widgets (dung chung cho ca 2 man hinh)

- [x] T027 [P] Viet test cho `ProfileInfoWidget` (hien thi avatar, ten, team, badge; fallback avatar khi khong co anh) | `test/widget/profile/profile_info_widget_test.dart`
- [x] T028 [P] [US1] Tao `ProfileInfoWidget` (StatelessWidget) — Column center: avatar (CircleAvatar 64px, border trang 0.865px, fallback chu cai dau), ten (Montserrat 16px Bold, trang), team code (12px Medium, #999), badge title (12px Medium, #FFEA9E). Nhan `UserProfile` | `lib/features/profile/presentation/widgets/profile_info_widget.dart`

- [x] T029 [P] Viet test cho `KudosSectionHeaderWidget` (hien thi banner va tieu de "KUDOS") | `test/widget/profile/kudos_section_header_widget_test.dart`
- [x] T030 [P] [US4] Tao `KudosSectionHeaderWidget` (StatelessWidget) — banner trang tri + subtitle "Sun* Annual Awards 2025" (12px Regular, trang) + title "KUDOS" (22px Medium, #FFEA9E). Dung i18n keys | `lib/features/profile/presentation/widgets/kudos_section_header_widget.dart`

- [x] T031 [P] Viet test cho `ProfileKudosFilterDropdown` (tap mo overlay, chon filter, hien thi count) | `test/widget/profile/profile_kudos_filter_dropdown_test.dart`
- [x] T032 [P] [US4] Tao `ProfileKudosFilterDropdown` (StatelessWidget) — dropdown button "Da gui (N)" / "Da nhan (N)" (bg: primary-10, border: #998C5F, radius: 4px, font: 14px Medium, #FFEA9E, icon chevron_down SVG). Tap -> overlay 2 pill options tren nen toi (#00101A, border: #998C5F). Nhan currentFilter, sentCount, receivedCount, onChanged. Animation open/close 200ms ease-out | `lib/features/profile/presentation/widgets/profile_kudos_filter_dropdown.dart`

- [x] T033 [P] Viet test cho `ProfileKudosListWidget` (hien thi list kudos cards, empty state, loading indicator) | `test/widget/profile/profile_kudos_list_widget_test.dart`
- [x] T034 [P] [US4] Tao `ProfileKudosListWidget` (StatelessWidget) — danh sach kudos cards REUSE `KudosCard` tu `lib/features/kudos/presentation/widgets/kudos_card.dart`. Nhan List<Kudos>, isLoading, isEmpty. Empty state: "Chua co Kudos nao." (i18n). Loading indicator o cuoi danh sach | `lib/features/profile/presentation/widgets/profile_kudos_list_widget.dart`

### Widgets chi cho Profile ban than

- [x] T035 [P] Viet test cho `IconCollectionWidget` (hien thi hang icon badges, empty state an section) | `test/widget/profile/icon_collection_widget_test.dart`
- [x] T036 [P] [US2] Tao `IconCollectionWidget` (StatelessWidget) — Column: label "Bo suu tap icon cua toi" (14px Medium, #FFEA9E) + Row (gap: 8px) cac icon badges (44x44, circle, dark bg #1A1A2E). Chi hien thi icon, khong co ten. Nhan List<IconBadge>. Empty: an section | `lib/features/profile/presentation/widgets/icon_collection_widget.dart`

- [x] T037 [P] Viet test cho `StatRowWidget` (hien thi label va value) | `test/widget/profile/stat_row_widget_test.dart`
- [x] T038 [P] [US3] Tao `StatRowWidget` (StatelessWidget) — Row space-between: label (12px Regular, trang) + value (14px Bold, #FFEA9E). Nhan label va value (String/int) | `lib/features/profile/presentation/widgets/stat_row_widget.dart`

- [x] T039 Viet test cho `StatisticsContainerWidget` (hien thi 5 stat rows, divider, button Mo Secret Box, empty state gia tri 0, button disabled khi unopened = 0) | `test/widget/profile/statistics_container_widget_test.dart`
- [x] T040 [US3] Tao `StatisticsContainerWidget` (StatelessWidget) — dark panel (bg: #00070C, border: 0.794px #998C5F, radius: 8px, padding: 12px, margin: 20px horizontal). Chua 5 StatRowWidget (kudos nhan, kudos gui, hearts nhan, divider #2E3940, secret box da mo, secret box chua mo) + Button "Mo Secret Box" (reuse OutlineButtonWidget, bg: primary-10, border: #998C5F, font: 14px Medium, #FFEA9E). Button disabled khi unopenedSecretBoxes = 0. Nhan PersonalStats | `lib/features/profile/presentation/widgets/statistics_container_widget.dart`

### Man hinh Profile ban than

- [x] T041 Viet test cho `ProfileScreen` (verify sections render dung thu tu, pull-to-refresh goi refresh, infinite scroll goi loadMoreKudos, filter change goi changeFilter) | `test/widget/profile/profile_screen_test.dart`
- [x] T042 [US1+US2+US3+US4+US6] Tao `ProfileScreen` (ConsumerWidget) — Scaffold(bg: #00101A) + RefreshIndicator (pull-to-refresh -> viewModel.refresh()) + CustomScrollView: ProfileInfoWidget + IconCollectionWidget + StatisticsContainerWidget + KudosSectionHeaderWidget + ProfileKudosFilterDropdown + ProfileKudosListWidget (SliverList, reuse KudosCard). ScrollController cho infinite scroll (loadMoreKudos khi scroll den cuoi). Loading: shimmer placeholders. Error: thong bao loi + nut retry | `lib/features/profile/presentation/screens/profile_screen.dart`

### Tich hop MainScaffold

- [x] T043 [US6] Thay `_PlaceholderTab(title: 'Profile')` tai index 3 trong `MainScaffold` bang `ProfileScreen()`. Xoa class `_PlaceholderTab` neu khong con su dung | `lib/app/main_scaffold.dart`

**Checkpoint**: Profile ban than hien thi day du. Tab Profile active. Pull-to-refresh + infinite scroll + filter hoat dong. `flutter test` pass.

---

## Phase 4: Core UI — Profile nguoi khac (US1–US8 nguoi khac)

**Muc tieu**: Man hinh Profile nguoi khac day du chuc nang — push route `/profile/:userId`

### Widgets chi cho Profile nguoi khac

- [x] T044 [P] Viet test cho `BadgeCollectionWidget` (hien thi Wrap layout badges voi icon + ten, empty state an section) | `test/widget/profile/badge_collection_widget_test.dart`
- [x] T045 [P] [US3-other] Tao `BadgeCollectionWidget` (StatelessWidget) — Wrap layout (gap: 12px), moi badge la Column: icon (44x44, circle, dark bg) + ten (10px Regular, trang). Nhan List<Badge>. Empty: an section | `lib/features/profile/presentation/widgets/badge_collection_widget.dart`

- [x] T046 [P] Viet test cho `SendKudosButtonWidget` (hien thi CTA, tap callback navigate) | `test/widget/profile/send_kudos_button_widget_test.dart`
- [x] T047 [P] [US2-other] Tao `SendKudosButtonWidget` (StatelessWidget) — CTA button "Gui loi cam on" (full width, bg: primary-10, border: #998C5F, radius: 4px, font: 14px Medium, #FFEA9E). Co icon edit SVG. Tap -> navigate sang man hinh gui kudos (screenId: `PV7jBVZU1N`) voi nguoi nhan pre-fill. Nhan userId va userName | `lib/features/profile/presentation/widgets/send_kudos_button_widget.dart`

### Man hinh Profile nguoi khac

- [x] T048 Viet test cho `OtherProfileScreen` (verify sections render, khong co stats panel, co CTA button, back button, self-redirect khi userId = currentUser, error state user not found) | `test/widget/profile/other_profile_screen_test.dart`
- [x] T049 [US1-8-other] Tao `OtherProfileScreen` (ConsumerWidget) nhan `userId` tu route param — AppBar transparent voi nut back + Scaffold(bg: #00101A) + RefreshIndicator + CustomScrollView: ProfileInfoWidget + BadgeCollectionWidget + SendKudosButtonWidget + KudosSectionHeaderWidget + ProfileKudosFilterDropdown + ProfileKudosListWidget (SliverList). ScrollController cho infinite scroll. Self-redirect: neu userId == currentUserId -> set currentTabIndexProvider = 3 va context.pop(). Error: "Khong tim thay nguoi dung" (i18n) voi nut quay lai. Bottom nav: tat ca tabs inactive | `lib/features/profile/presentation/screens/other_profile_screen.dart`

### Tich hop Router

- [x] T050 Them route `/profile/:userId` trong `router.dart` — GoRoute builder tao `OtherProfileScreen(userId: state.pathParameters['userId']!)`. Them placeholder route cho send kudos (`/kudos/send`) va open secret box neu chua co | `lib/app/router.dart`

**Checkpoint**: Profile nguoi khac hien thi day du. Back button hoat dong. CTA "Gui loi cam on" navigate. Self-redirect correct. `flutter test` pass.

---

## Phase 5: Tuong tac & Tinh nang mo rong (US5 + US7 + US8 — ca 2 man hinh)

**Muc dich**: Heart toggle, copy link, avatar navigation, spam label — ap dung cho ca 2 man hinh Profile

### Heart toggle

- [x] T051 [US5] Tich hop HeartButton (REUSE tu `lib/features/kudos/presentation/widgets/heart_button.dart`) vao ProfileKudosListWidget — onToggle -> viewModel.toggleHeart(kudosId). Optimistic update state -> sync server qua KudosRepository.toggleHeart() | `lib/features/profile/presentation/widgets/profile_kudos_list_widget.dart`

### Copy link

- [x] T052 [P] [US5] Tich hop copy link vao ProfileKudosListWidget — tap icon copy -> Clipboard.setData(kudos.shareUrl) + ScaffoldMessenger.showSnackBar("Da sao chep lien ket", duration: 2s). Dung i18n key | `lib/features/profile/presentation/widgets/profile_kudos_list_widget.dart`

### Avatar tap -> Profile navigation

- [x] T053 [P] [US5] Tich hop avatar tap tren kudos card trong ProfileKudosListWidget — GestureDetector tren avatar -> context.push('/profile/$userId'). Neu userId = currentUser -> redirect sang tab 4 | `lib/features/profile/presentation/widgets/profile_kudos_list_widget.dart`

### "Xem chi tiet" navigation

- [x] T054 [P] [US5] Tich hop "Xem chi tiet" tap tren kudos card -> navigate sang man hinh chi tiet kudos (placeholder route neu chua build) | `lib/features/profile/presentation/widgets/profile_kudos_list_widget.dart`

### Spam label

- [x] T055 [P] [US5] Hien thi orange pill tag "Spam" (#FF8C00, radius: 100px) tren kudos card khi isSpam = true. Kiem tra Kudos model da co field `isSpam` chua — them neu can | `lib/features/profile/presentation/widgets/profile_kudos_list_widget.dart`

### "Mo Secret Box" navigation

- [x] T056 [US3] Tich hop nut "Mo Secret Box" trong StatisticsContainerWidget — tap -> navigate sang man hinh Open Secret Box (screenId: `kQk65hSYF2`). Placeholder route neu chua build. Button disabled khi unopenedSecretBoxes = 0 | `lib/features/profile/presentation/widgets/statistics_container_widget.dart`

**Checkpoint**: Heart like/unlike + copy link + avatar nav + xem chi tiet + spam label + Mo Secret Box — tat ca hoat dong. `flutter test` pass.

---

## Phase 6: Polish & Cross-cutting Concerns

**Muc dich**: Accessibility, animations, error boundary, deep link, performance

### Accessibility

- [x] T057 [P] Them `Semantics` widgets cho tat ca interactive elements theo bang VoiceOver trong spec: Avatar "Anh dai dien cua {ten}", Badge "{danh hieu}", Stat Row "{label}: {count}", Button "Mo Secret Box" "Mo Secret Box. Ban co {count} hop chua mo", Heart "{count} luot thich. {Da thich / Chua thich}", Copy Link "Sao chep lien ket", "Xem chi tiet" "Xem chi tiet kudos", Back button "Quay lai", CTA "Gui loi cam on cho {ten}", Nav tabs "{Tab name}. Tab {index} tren 4" | `lib/features/profile/presentation/widgets/*.dart`

### Animations

- [x] T058 [P] Fine-tune animations: dropdown overlay open/close (200ms ease-out), heart scale (150ms ease-in-out), push/pop transition (300ms ease-in-out) | `lib/features/profile/presentation/widgets/*.dart`

### Error boundary & Auth

- [x] T059 [P] Xu ly 401 error -> verify auth redirect flow hoat dong khi token expired (tich hop voi existing auth redirect trong router.dart) | `lib/features/profile/data/datasources/profile_remote_datasource.dart`

### Deep link

- [x] T060 [P] Kiem tra deep link: `/profile` -> mo tab Profile ban than, `/profile/:userId` -> mo Profile nguoi khac. Dam bao routing hoat dong dung | `lib/app/router.dart`

### Performance & Quality

- [x] T061 Performance audit tren device that — profile screen load < 2 giay, filter switch < 1 giay, infinite scroll smooth, avatar loading | Device testing
- [x] T062 Chay `flutter analyze` + `dart format` — dam bao 0 warnings, 0 lint errors | Toan bo project
- [x] T063 Chay toan bo test suite: `flutter test` — dam bao tat ca tests pass, coverage >= 80% cho ViewModel + Repository | `test/`

**Checkpoint**: Feature hoan chinh. Tat ca tests pass. Lint clean. Accessibility OK. Performance OK tren device that.

---

## Phu thuoc & Thu tu thuc thi

### Phu thuoc giua Phases

```
Phase 0 (Setup) ──────────────────────────────────────────────────┐
    |                                                              |
    v                                                              |
Phase 1 (Models) ──────────────────────────────────┐              |
    |                                               |              |
    v                                               |              |
Phase 2 (Datasource + Repository + ViewModels) ────┘              |
    |                                                              |
    v                                                              |
Phase 3 (Profile ban than — MVP) ──────────────────────────────── |
    |                                                              |
    ├──> Phase 4 (Profile nguoi khac) ── sau Phase 3              |
    |                                                              |
    └──> Phase 5 (Tuong tac) ── sau Phase 3 + Phase 4            |
         |                                                         |
         v                                                         |
    Phase 6 (Polish) ─────────────────────────────────────────────┘
```

### Song song trong moi Phase

- **Phase 0**: T001, T002, T003 song song (files khac nhau). T005 doc lap
- **Phase 1**: Tat ca model tests + implementations (T006–T016) song song. T017 cuoi cung (build_runner)
- **Phase 2**: T019-T020 (datasource) -> T021-T022 (repository) -> T023-T026 (viewmodels) tuan tu. T023+T025 co the song song
- **Phase 3**: T027-T040 (widgets) song song. T041-T042 (screen) sau widgets. T043 (tich hop) cuoi
- **Phase 4**: T044-T047 (widgets) song song. T048-T049 (screen) sau widgets. T050 (router) song song voi widgets
- **Phase 5**: T051-T056 song song (cung file nhung logic doc lap)
- **Phase 6**: T057-T060 song song. T061-T063 cuoi cung

### Trong moi task

1. Test PHAI viet truoc va FAIL (Red)
2. Implement minimal code de pass (Green)
3. Refactor neu can
4. Models truoc services, widgets truoc screen integration

---

## Chien luoc trien khai

### MVP First (Khuyen nghi)

1. Hoan thanh Phase 0 + 1 + 2
2. Hoan thanh Phase 3 (Profile ban than — MVP)
3. **DUNG va KIEM TRA**: Test doc lap tren device
4. Hoan thanh Phase 4 (Profile nguoi khac)
5. Hoan thanh Phase 5 + 6

### Tong so tasks: 63

| Phase | So tasks | Uu tien |
|-------|---------|---------|
| Phase 0: Setup | 5 | Nen tang |
| Phase 1: Models | 13 | Nen tang |
| Phase 2: Data Layer | 8 | Nen tang |
| Phase 3: Profile ban than (MVP) | 17 | P1 |
| Phase 4: Profile nguoi khac | 7 | P1 |
| Phase 5: Tuong tac | 6 | P2 |
| Phase 6: Polish | 7 | P2 |

---

## Ghi chu

- Commit sau moi task hoac nhom logic
- Chay `flutter test` truoc khi chuyen phase
- Cap nhat spec.md neu requirements thay doi trong qua trinh implement
- Danh dau task hoan thanh: `[x]`
- TDD bat buoc: Viet test -> Test FAIL (Red) -> Implement -> Test PASS (Green) -> Refactor
- REUSE tu Kudos feature: `KudosCard`, `HeartButton`, `KudosRepository`, `Kudos` model, `PersonalStats` model, `UserSummary` model — KHONG tao lai
- REUSE tu shared/: `OutlineButtonWidget`, `SectionHeaderWidget`, `BottomNavBar` — KHONG tao lai
- Tat ca text PHAI dung i18n (slang), khong hardcode string
- Asset paths PHAI dung `flutter_gen` (`Assets.xxx`), khong hardcode string
- Moi seed data chi APPEND, KHONG xoa du lieu cu, KHONG chay `supabase db reset`
