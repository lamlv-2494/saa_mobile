# Ke hoach trien khai: [iOS] Profile — Ban than & Nguoi khac

**Frame**: `hSH7L8doXB-ios-profile-ban-than` + `bEpdheM0yU-ios-profile-nguoi-khac`
**Ngay**: 2026-04-15
**Spec**: `specs/hSH7L8doXB-ios-profile-ban-than/spec.md` + `specs/bEpdheM0yU-ios-profile-nguoi-khac/spec.md`

---

## Tom tat

Trien khai 2 man hinh Profile trong cung 1 feature module `lib/features/profile/`:

1. **Profile ban than** — tab 4 trong bottom navigation, hien thi thong tin ca nhan, bo suu tap icon, thong ke hoat dong (kudos nhan/gui, hearts, secret box), va lich su kudos voi dropdown filter (da gui / da nhan). Thay the `_PlaceholderTab(title: 'Profile')` o tab index 3 trong `MainScaffold`.

2. **Profile nguoi khac** — push route `/profile/:userId` khi tap avatar tren kudos card, hien thi thong tin nguoi do, bo suu tap huy hieu (co ten), nut CTA "Gui loi cam on" (pre-fill nguoi nhan), va lich su kudos voi dropdown filter. Khong co stats panel, khong co "Mo Secret Box".

---

## Boi canh ky thuat

**Framework**: Flutter 3.41.3 / Dart ^3.11.1
**Phu thuoc chinh**: flutter_riverpod, go_router, supabase_flutter, freezed, google_fonts, flutter_svg, flutter_gen, slang
**Backend**: Supabase (PostgREST — chua co Edge Functions)
**Testing**: flutter_test + mocktail (TDD bat buoc)
**State Management**: Riverpod — AsyncNotifier pattern (1 ViewModel per screen)
**API Style**: REST (PostgREST)

---

## Kiem tra tuan thu Constitution

| Yeu cau | Quy tac Constitution | Trang thai |
|----------|----------------------|-----------|
| MVVM + Riverpod | `ProfileViewModel extends AsyncNotifier<ProfileState>` + `OtherProfileViewModel extends FamilyAsyncNotifier<OtherProfileState, String>` | Tuan thu |
| Feature-based module | `lib/features/profile/` voi data/presentation | Tuan thu |
| Freezed models | Tat ca state + model dung freezed | Tuan thu |
| Widget con = StatelessWidget | Screen dung ConsumerWidget, widget con StatelessWidget | Tuan thu |
| SVG icons, PNG images | Icons -> `assets/icons/`, backgrounds -> `assets/images/` | Tuan thu |
| flutter_gen (Assets.xxx) | Khong hardcode path | Tuan thu |
| i18n (slang) VN/EN | Tat ca text qua `context.t.profile.*` | Tuan thu |
| TDD | Viet test truoc -> implement -> refactor | Tuan thu |
| Repository pattern | `ProfileRepository` -> `ProfileRemoteDatasource` | Tuan thu |

**Vi pham**: Khong co.

---

## Quyet dinh kien truc

### Frontend

- **Component Structure**: Feature-based (`lib/features/profile/`) theo constitution
- **2 ViewModels**: Tach biet vi Profile ban than va Profile nguoi khac co state khac nhau (ban than co `personalStats`, `iconCollection`; nguoi khac co `badgeCollection`, khong co stats). Dung chung Repository va Datasource.
- **Shared widgets noi bo**: `ProfileInfoWidget` (avatar + ten + team + badge), `ProfileKudosSectionWidget` (header + filter dropdown + kudos list), `ProfileKudosFilterDropdown` — dung chung cho ca 2 man hinh
- **Reuse tu Kudos feature**: `KudosCard` widget (`lib/features/kudos/presentation/widgets/kudos_card.dart`) — KHONG tao lai
- **Reuse tu shared/**: `OutlineButtonWidget` cho CTA buttons, `SectionHeaderWidget`, `BottomNavBar`
- **Scroll Architecture**: `CustomScrollView` + `SliverList` cho kudos list (infinite scroll)
- **Dropdown filter**: Dung pattern tuong tu `FilterDropdownButton` cua Kudos nhung don gian hon (chi 2 options: da nhan / da gui)
- **Self-redirect**: Neu `OtherProfileScreen` nhan userId trung voi user dang dang nhap -> redirect sang Profile ban than (tab 4)

### Backend Integration

- **API Client**: Supabase client qua PostgREST (tuong tu pattern cua `KudosRemoteDatasource`)
- **Data Source**: `ProfileRemoteDatasource` goi cac API endpoints
- **Repository**: `ProfileRepository` xu ly error handling, mapping
- **Reuse models**: `Kudos`, `UserSummary`, `PersonalStats` tu `lib/features/kudos/data/models/` — KHONG duplicate. Import truc tiep.
- **API endpoints** (du doan — dung PostgREST queries):
  - `GET users?id=eq.{userId}` — lay thong tin profile
  - `GET users?id=eq.{me}` — lay thong tin profile ban than
  - `GET user_badges?user_id=eq.{userId}` — lay bo suu tap icon/huy hieu
  - `GET kudos?sender_id=eq.{userId}&order=created_at.desc&limit=20&offset=N` — kudos da gui
  - `GET kudos?receiver_id=eq.{userId}&order=created_at.desc&limit=20&offset=N` — kudos da nhan
  - `GET /users/me/stats` hoac PostgREST query tuong tu `KudosRemoteDatasource.fetchPersonalStats()` — reuse logic
  - `POST kudos_reactions` / `DELETE kudos_reactions` — heart toggle (reuse tu `KudosRepository`)

### Tich hop hien tai

- **`MainScaffold`** (`lib/app/main_scaffold.dart`): Thay `_PlaceholderTab(title: 'Profile')` tai index 3 bang `ProfileScreen()`
- **`Router`** (`lib/app/router.dart`): Them route `/profile/:userId` cho `OtherProfileScreen`
- **`AppColors`** (`lib/app/theme/app_colors.dart`): Da co phan lon colors can thiet tu Kudos feature. Can them: `iconDark` = `#1A1A2E`, `spam` = `#FF8C00`
- **`BottomNavBar`** (`lib/shared/widgets/bottom_nav_bar.dart`): Da co, khong can sua
- **`KudosCard`** (`lib/features/kudos/presentation/widgets/kudos_card.dart`): Reuse truc tiep — can review xem co can expose them props nao khong
- **`HeartButton`** (`lib/features/kudos/presentation/widgets/heart_button.dart`): Reuse truc tiep
- **`OutlineButtonWidget`** (`lib/shared/widgets/outline_button.dart`): Reuse cho "Mo Secret Box" va "Gui loi cam on"
- **`KudosRepository`** (`lib/features/kudos/data/repositories/kudos_repository.dart`): Reuse methods `toggleHeart()` — Profile goi truc tiep KudosRepository cho heart actions
- **i18n** (`lib/i18n/strings_vi.i18n.json`, `strings_en.i18n.json`): Them section `profile` vao ca 2 file
- **Home feature** (`lib/features/home/`): Reference pattern cho ViewModel + Repository + Datasource

---

## Cau truc Project

### Tai lieu

```text
.momorph/specs/hSH7L8doXB-ios-profile-ban-than/
├── spec.md              # Dac ta tinh nang (Profile ban than)
├── design-style.md      # Dac ta thiet ke
├── plan.md              # File nay
└── tasks.md             # Phan chia task (buoc tiep theo)

.momorph/specs/bEpdheM0yU-ios-profile-nguoi-khac/
├── spec.md              # Dac ta tinh nang (Profile nguoi khac)
└── design-style.md      # Dac ta thiet ke
```

### Source Code (anh huong)

```text
lib/
├── app/
│   ├── main_scaffold.dart              # SUA: thay _PlaceholderTab -> ProfileScreen
│   ├── router.dart                     # SUA: them route /profile/:userId
│   └── theme/
│       └── app_colors.dart             # SUA: them colors moi (iconDark, spam)
│
├── features/
│   ├── kudos/
│   │   ├── data/models/                # REUSE: Kudos, UserSummary, PersonalStats (import truc tiep)
│   │   ├── data/repositories/          # REUSE: KudosRepository.toggleHeart()
│   │   └── presentation/widgets/
│   │       ├── kudos_card.dart          # REUSE: KudosCard widget
│   │       └── heart_button.dart        # REUSE: HeartButton widget
│   │
│   └── profile/                         # MOI: toan bo feature
│       ├── data/
│       │   ├── models/
│       │   │   ├── profile_state.dart            # ProfileState (freezed)
│       │   │   ├── other_profile_state.dart      # OtherProfileState (freezed)
│       │   │   ├── user_profile.dart              # UserProfile model (freezed) — full profile info
│       │   │   ├── icon_badge.dart                # IconBadge model (freezed) — bo suu tap icon
│       │   │   ├── badge.dart                     # Badge model (freezed) — huy hieu co ten
│       │   │   └── kudos_filter_type.dart         # Enum: received | sent
│       │   ├── datasources/
│       │   │   └── profile_remote_datasource.dart # API calls (PostgREST queries)
│       │   └── repositories/
│       │       └── profile_repository.dart         # Repository + error handling
│       │
│       └── presentation/
│           ├── viewmodels/
│           │   ├── profile_viewmodel.dart           # AsyncNotifier<ProfileState> (ban than)
│           │   └── other_profile_viewmodel.dart     # FamilyAsyncNotifier<OtherProfileState, String> (nguoi khac)
│           ├── screens/
│           │   ├── profile_screen.dart              # Man hinh Profile ban than (tab 4)
│           │   └── other_profile_screen.dart        # Man hinh Profile nguoi khac (push route)
│           └── widgets/                             # Tat ca StatelessWidget
│               ├── profile_info_widget.dart          # Shared: avatar + ten + team + badge
│               ├── icon_collection_widget.dart       # Ban than: hang icon badges (khong ten)
│               ├── badge_collection_widget.dart      # Nguoi khac: icon + ten huy hieu (Wrap layout)
│               ├── statistics_container_widget.dart   # Ban than: dark panel thong ke + "Mo Secret Box"
│               ├── stat_row_widget.dart              # 1 dong thong ke (label + value)
│               ├── kudos_section_header_widget.dart   # Shared: banner "Sun* Annual Awards 2025" + "KUDOS"
│               ├── profile_kudos_filter_dropdown.dart # Shared: dropdown "Da gui (N)" / "Da nhan (N)"
│               ├── profile_kudos_list_widget.dart     # Shared: danh sach kudos cards (reuse KudosCard)
│               └── send_kudos_button_widget.dart      # Nguoi khac: nut CTA "Gui loi cam on"
│
├── shared/
│   └── widgets/                         # Khong can tao moi — reuse da co
│
├── i18n/
│   ├── strings_vi.i18n.json            # SUA: them profile section
│   └── strings_en.i18n.json            # SUA: them profile section
│
└── gen/                                # Auto-generated (flutter_gen)

assets/
├── icons/
│   ├── ic_back.svg                     # Kiem tra da co chua — neu chua thi MOI
│   └── ic_edit.svg                     # Kiem tra da co chua — neu chua thi MOI
└── images/
    (khong can them anh moi — profile khong co hero banner)

test/
├── unit/
│   ├── viewmodels/
│   │   ├── profile_viewmodel_test.dart
│   │   └── other_profile_viewmodel_test.dart
│   ├── repositories/
│   │   └── profile_repository_test.dart
│   └── models/
│       ├── profile_state_test.dart
│       ├── other_profile_state_test.dart
│       ├── user_profile_test.dart
│       ├── icon_badge_test.dart
│       └── badge_test.dart
├── widget/
│   └── profile/
│       ├── profile_screen_test.dart
│       ├── other_profile_screen_test.dart
│       ├── profile_info_widget_test.dart
│       ├── icon_collection_widget_test.dart
│       ├── badge_collection_widget_test.dart
│       ├── statistics_container_widget_test.dart
│       ├── profile_kudos_filter_dropdown_test.dart
│       └── send_kudos_button_widget_test.dart
└── helpers/
    └── profile_test_helpers.dart        # Mock data, fakes
```

### Dependencies moi

Khong can them package moi — tat ca da co trong `pubspec.yaml`:
- `flutter_riverpod`, `freezed`, `json_serializable`, `flutter_svg`, `google_fonts`, `flutter_gen_runner`, `slang`, `mocktail`, `go_router`

---

## Chien luoc trien khai

### Phase 0: Chuan bi Assets, Theme & Mock Data (Nen tang)

#### 0a. Assets & Theme

- Kiem tra SVG icons da co chua (`ic_back.svg`, `ic_edit.svg`) — download tu Figma neu thieu
- Chay `dart run build_runner build` de generate flutter_gen assets (neu them icon moi)
- Bo sung colors moi vao `AppColors` (chi them nhung chua co):
  - `iconDark` = `#1A1A2E` — **MOI** (nen icon badge trong bo suu tap)
  - `spam` = `#FF8C00` — **MOI** (label spam pill)
  - *(Cac color con lai da co tu Kudos feature: `surfaceCard`, `surfaceDark`, `textSecondary`, `heart`, `divider`, `outlineBtnBg`, `outlineBtnBorder`)*
- Them i18n strings cho profile section (VN + EN) vao `strings_vi.i18n.json` va `strings_en.i18n.json`:
  - `profile.myIconCollection` — "Bo suu tap icon cua toi"
  - `profile.kudosReceived` — "So Kudos ban nhan duoc"
  - `profile.kudosSent` — "So Kudos ban da gui"
  - `profile.heartsReceived` — "So tim ban nhan duoc"
  - `profile.secretBoxOpened` — "So Secret Box ban da mo"
  - `profile.secretBoxUnopened` — "So Secret Box chua mo"
  - `profile.openSecretBox` — "Mo Secret Box"
  - `profile.filterSent` — "Da gui"
  - `profile.filterReceived` — "Da nhan"
  - `profile.sendKudosButton` — "Gui loi cam on"
  - `profile.noKudos` — "Chua co Kudos nao."
  - `profile.noBadges` — "Chua co huy hieu nao."
  - `profile.userNotFound` — "Khong tim thay nguoi dung."
  - `profile.errorRetry` — "Co loi xay ra. Thu lai."
  - `profile.saaAwards` — "Sun* Annual Awards 2025"
  - `profile.kudosTitle` — "KUDOS"
  - Va cac string tuong ung tieng Anh

#### 0b. Supabase Mock Data (APPEND vao seed.sql)

**QUAN TRONG**: KHONG duoc dung `supabase db reset`. Chi APPEND vao cuoi file `supabase/seed.sql`. Sau do chay:
```bash
psql -h localhost -p 54322 -U postgres -d postgres -f supabase/seed.sql
```

Hien tai DB thieu du lieu de test Profile:
- `user_badges`: chi co 4 entries (users 1,2,3,5) — can them cho users 6-15 de test badge collection
- `secret_boxes`: chi co 3 entries (users 1,2) — can them cho users 2-5 de test stats

**SQL can APPEND vao cuoi `supabase/seed.sql`** (truoc dong comment cuoi cung hoac o cuoi file):

```sql
-- ==========================================
-- 17. PROFILE MOCK DATA (bo sung cho feature Profile)
-- ==========================================

-- Them user_badges cho users 6-15 (moi user co 1-3 badges)
INSERT INTO user_badges (user_id, badge_id, earned_at) VALUES
    (6, 1, '2026-02-01 10:00:00+00'),
    (6, 3, '2026-03-15 10:00:00+00'),
    (7, 2, '2026-01-20 10:00:00+00'),
    (7, 4, '2026-03-28 10:00:00+00'),
    (8, 1, '2026-02-14 10:00:00+00'),
    (9, 1, '2026-01-05 10:00:00+00'),
    (9, 2, '2026-02-18 10:00:00+00'),
    (9, 3, '2026-03-22 10:00:00+00'),
    (10, 2, '2026-03-01 10:00:00+00'),
    (11, 1, '2026-02-25 10:00:00+00'),
    (12, 3, '2026-01-30 10:00:00+00'),
    (12, 4, '2026-03-10 10:00:00+00'),
    (13, 2, '2026-02-08 10:00:00+00'),
    (13, 1, '2026-03-20 10:00:00+00'),
    (14, 4, '2026-01-15 10:00:00+00'),
    (15, 1, '2026-02-28 10:00:00+00'),
    (15, 2, '2026-03-25 10:00:00+00')
ON CONFLICT DO NOTHING;

-- Them secret_boxes cho users 2-5 (mix opened/unopened de test stats)
INSERT INTO secret_boxes (id, user_id, is_opened, opened_at, reward_type, reward_value) VALUES
    (4, 2, true, '2026-04-10 09:00:00+00', 'badge', 'Rising Hero'),
    (5, 3, false, NULL, NULL, NULL),
    (6, 3, true, '2026-04-09 14:00:00+00', 'points', '50'),
    (7, 4, false, NULL, NULL, NULL),
    (8, 4, false, NULL, NULL, NULL),
    (9, 4, true, '2026-04-08 11:00:00+00', 'badge', 'Super Hero'),
    (10, 5, true, '2026-04-07 16:00:00+00', 'points', '100'),
    (11, 5, false, NULL, NULL, NULL)
ON CONFLICT (id) DO NOTHING;

SELECT setval('secret_boxes_id_seq', GREATEST((SELECT MAX(id) FROM secret_boxes), 11));
```

**Ket qua du kien sau khi seed**:
- `user_badges`: 21 entries (4 cu + 17 moi) — du de test badge collection cho nhieu user
- `secret_boxes`: 11 entries (3 cu + 8 moi) — du de test stats panel voi mix opened/unopened
- User 4 co 3 secret boxes (1 opened, 2 unopened) — tot de test "Mo Secret Box" enabled
- User 9 co 3 badges — tot de test badge collection day du

### Phase 1: Data Layer (Models + API + Repository)

**Uu tien**: Xay dung nen data layer truoc de tat ca phases sau dung duoc.

1. **Models (freezed)**:
   - `UserProfile` — id, name, avatar, team, badgeTitle, heroTierUrl (mo rong tu UserSummary voi them thong tin)
   - `IconBadge` — id, name, imageUrl, earnedAt (bo suu tap icon ban than)
   - `Badge` — id, name, imageUrl, type (huy hieu nguoi khac — co ten hien thi)
   - `KudosFilterType` — enum: `received`, `sent`
   - `ProfileState` (freezed) — userProfile, iconCollection, personalStats, kudosList, kudosFilter, kudosReceivedCount, kudosSentCount, hasMoreKudos
   - `OtherProfileState` (freezed) — userProfile, badgeCollection, kudosList, kudosFilter, kudosReceivedCount, kudosSentCount, hasMoreKudos
   - **Reuse**: `Kudos`, `PersonalStats`, `UserSummary` tu `lib/features/kudos/data/models/`

2. **Datasource**: `ProfileRemoteDatasource` — PostgREST queries:
   - `fetchMyProfile()` — query bang `users` voi current user id
   - `fetchUserProfile(String userId)` — query bang `users` voi userId
   - `fetchMyIcons()` — query bang `user_badges` (hoac tuong tu) voi current user id
   - `fetchUserBadges(String userId)` — query bang `user_badges` voi userId
   - `fetchUserKudos(String userId, KudosFilterType filter, int page, int limit)` — query bang `kudos` voi sender_id hoac receiver_id
   - `fetchUserKudosCount(String userId)` — dem so kudos da gui va da nhan
   - **Reuse**: `fetchPersonalStats()` logic tu `KudosRemoteDatasource` (hoac goi truc tiep qua KudosRepository)

3. **Repository**: `ProfileRepository` — error handling, mapping, pagination logic
   - Inject `ProfileRemoteDatasource` + `KudosRepository` (cho heart toggle)
   - Methods: `getMyProfile()`, `getUserProfile(userId)`, `getMyIcons()`, `getUserBadges(userId)`, `getUserKudos(userId, filter, page, limit)`, `getUserKudosCount(userId)`, `getMyStats()` (delegate to KudosRepository hoac goi truc tiep)

4. **ViewModels**:
   - `ProfileViewModel extends AsyncNotifier<ProfileState>`:
     - `build()` — load profile, icons, stats, kudos list (default: sent), kudos counts
     - `changeFilter(KudosFilterType)` — reset kudos list, reload voi filter moi
     - `loadMoreKudos()` — pagination, append vao list hien tai
     - `toggleHeart(String kudosId)` — optimistic update, delegate to KudosRepository
     - `refresh()` — re-fetch toan bo du lieu
   - `OtherProfileViewModel extends FamilyAsyncNotifier<OtherProfileState, String>`:
     - `build(String userId)` — load profile, badges, kudos list (default: received), kudos counts
     - `changeFilter(KudosFilterType)` — reset kudos list, reload voi filter moi
     - `loadMoreKudos()` — pagination
     - `toggleHeart(String kudosId)` — optimistic update
     - `refresh()` — re-fetch toan bo du lieu

### Phase 2: Core UI — Profile ban than (US1 + US2 + US3 + US4 + US6)

**Uu tien P1**: Hien thi duoc man hinh Profile ban than voi du lieu.
**User stories**: US1 (thong tin ca nhan), US2 (bo suu tap icon), US3 (thong ke), US4 (lich su kudos + filter), US6 (bottom navigation).

> **Nguyen tac TDD**: Moi widget PHAI co loading/error/empty state ngay tu dau. Moi widget PHAI viet test truoc khi implement.

1. **`ProfileScreen`** — `ConsumerWidget` voi `CustomScrollView` + `RefreshIndicator` (pull-to-refresh) + `ScrollController` (infinite scroll)
2. **`ProfileInfoWidget`** — Shared widget: avatar (CircleAvatar 64px, border trang, fallback chu cai dau), ten (Montserrat 16px Bold, trang), team code (12px Medium, #999), badge title (12px Medium, #FFEA9E)
3. **`IconCollectionWidget`** — Row cac icon badges (44x44, circle, dark bg #1A1A2E). Chi hien thi icon, khong co ten. Nhan `List<IconBadge>`. Empty state: an section.
4. **`StatisticsContainerWidget`** — Dark panel (bg: #00070C, border: #998C5F, radius: 8px). Chua 5 `StatRowWidget` + divider + button "Mo Secret Box" (reuse `OutlineButtonWidget`).
5. **`StatRowWidget`** — 1 dong: label (12px Regular, trang) + value (14px Bold, #FFEA9E). Reusable, nhan label va value.
6. **`KudosSectionHeaderWidget`** — Banner trang tri "Sun* Annual Awards 2025" + "KUDOS" (22px Medium, #FFEA9E). Dung chung cho ca 2 man hinh.
7. **`ProfileKudosFilterDropdown`** — Dropdown button hien thi "Da gui (N)" / "Da nhan (N)". Tap -> mo overlay voi 2 options. Nhan `currentFilter`, `sentCount`, `receivedCount`, `onChanged`.
8. **`ProfileKudosListWidget`** — Danh sach kudos cards. Reuse `KudosCard` tu Kudos feature. Nhan `List<Kudos>`, `isLoading`, `isEmpty`. Empty state: "Chua co Kudos nao."
9. **Infinite scroll** — `ScrollController` listener tren `ProfileScreen`, goi `viewModel.loadMoreKudos()` khi scroll den cuoi.
10. **Tich hop `MainScaffold`** — Thay `_PlaceholderTab(title: 'Profile')` -> `ProfileScreen()`. Xoa class `_PlaceholderTab` neu khong con su dung.

### Phase 3: Core UI — Profile nguoi khac (US1-US8 cua man hinh nguoi khac)

**Uu tien P1**: Man hinh Profile nguoi khac day du chuc nang.
**User stories**: US1 (thong tin nguoi khac), US2 (gui loi cam on CTA), US3 (badge collection), US4 (lich su kudos + filter), US5 (tuong tac card — heart/copy/xem chi tiet), US6 (quay lai), US7 (infinite scroll), US8 (pull-to-refresh).

1. **`OtherProfileScreen`** — `ConsumerWidget` nhan `userId` tu route param. `CustomScrollView` + `RefreshIndicator` + `ScrollController`. AppBar voi nut back (transparent bg).
2. **`BadgeCollectionWidget`** — `Wrap` layout, moi badge la Column(icon 44x44 + ten 10px Regular trang). Gap 12px. Nhan `List<Badge>`. Empty state: an section.
3. **`SendKudosButtonWidget`** — CTA button "Gui loi cam on" (full width, bg: primary-10, border: #998C5F, radius: 4px, font: 14px SemiBold, color: #FFEA9E). Co icon edit SVG. Tap -> navigate sang man hinh gui kudos (screenId: `PV7jBVZU1N`) voi nguoi nhan pre-fill.
4. **Reuse widgets tu Phase 2**: `ProfileInfoWidget`, `KudosSectionHeaderWidget`, `ProfileKudosFilterDropdown`, `ProfileKudosListWidget`
5. **Self-redirect logic**: Trong `OtherProfileScreen.build()`, kiem tra neu `userId == currentUserId` -> redirect sang tab Profile (tab 4) bang cach set `currentTabIndexProvider = 3` va `context.pop()`.
6. **Tich hop Router** — Them route trong `router.dart`:
   ```
   GoRoute(
     path: '/profile/:userId',
     builder: (context, state) => OtherProfileScreen(
       userId: state.pathParameters['userId']!,
     ),
   )
   ```
7. **Bottom nav**: Tat ca tabs inactive khi o man hinh nguoi khac
8. **Error state: User not found** — Khi API tra 404 hoac userId khong ton tai -> hien thi man hinh loi "Khong tim thay nguoi dung" (dung i18n key `profile.userNotFound`) voi nut quay lai
9. **Empty states** — Badge collection rong -> an section. Kudos list rong -> hien thi "Chua co Kudos nao." (dung i18n key `profile.noKudos`)

### Phase 4: Tuong tac & Tinh nang mo rong — Profile ban than (US5 + US7 + US8)

**User stories Profile ban than**: US5 (tuong tac card), US7 (infinite scroll), US8 (pull-to-refresh).

1. **Heart toggle** — Reuse `HeartButton` tu Kudos feature. Goi `viewModel.toggleHeart(kudosId)` -> optimistic update state -> sync voi server qua `KudosRepository.toggleHeart()`
2. **Copy link** — `Clipboard.setData` + snackbar "Da sao chep lien ket" 2 giay
3. **"Xem chi tiet"** — Navigate sang man hinh chi tiet kudos (placeholder route neu chua build)
4. **Avatar tap** — Tap avatar tren kudos card -> `context.push('/profile/${userId}')`. Neu la chinh minh -> redirect sang tab 4.
5. **Dropdown overlay** — Animation open/close (200ms ease-out). Overlay hien thi 2 pill buttons tren nen toi (#00101A, border: #998C5F).
6. **Spam label** — Hien thi orange pill tag "Spam" (#FF8C00) tren card bi report (dung `isSpam` field — can kiem tra Kudos model da co chua, them neu can)
7. **"Mo Secret Box" navigation** — Tap nut -> navigate sang man hinh Open Secret Box (screenId: `kQk65hSYF2`). Placeholder route neu chua build.

### Phase 5: Polish & Cross-cutting Concerns

> Loading/error/empty states da duoc build trong moi phase (Phase 2-4) theo TDD. Phase 5 chi xu ly cac concerns chung chua cover.

1. **Accessibility**: Them `Semantics` widgets theo bang VoiceOver trong spec cho TAT CA interactive elements:
   - Avatar: "Anh dai dien cua {ten}"
   - Badge: "{danh hieu}"
   - Stat Row: "{label}: {count}"
   - Button "Mo Secret Box": "Mo Secret Box. Ban co {count} hop chua mo"
   - Heart: "{count} luot thich. {Da thich / Chua thich}"
   - Back button: "Quay lai"
   - CTA: "Gui loi cam on cho {ten}"
2. **Animation**: Fine-tune dropdown overlay (200ms ease-out), heart scale (150ms ease-in-out), push/pop transition (300ms ease-in-out)
3. **Error boundary**: Xu ly 401 -> redirect login (tich hop auth redirect flow hien tai trong `router.dart`)
4. **Deep link**: `/profile` -> mo tab Profile ban than. `/profile/:userId` -> mo Profile nguoi khac.
5. **Performance audit**: Profile tren device that — kiem tra infinite scroll + filter switch + avatar loading

---

## Danh gia rui ro

| Rui ro | Xac suat | Anh huong | Giam thieu |
|--------|----------|-----------|-----------|
| API chua san sang (endpoints profile chua co) | Cao | Trung binh | Mock data layer voi Riverpod override. Datasource tra mock data ban dau. Reuse pattern tu KudosRemoteDatasource |
| Reuse KudosCard gap van de tuong thich | Thap | Thap | KudosCard da co enum variant (highlight/feed). Neu can variant moi cho profile -> extend enum |
| Self-redirect logic (userId == me) phuc tap | Thap | Thap | Kiem tra trong ViewModel.build() hoac Screen.build(), redirect truoc khi render |
| DB schema cho user_badges/badges chua co | Trung binh | Trung binh | Tao migration + seed data. Tham khao bang `users` va `kudos` da co |
| Dropdown filter overlay z-index conflict | Thap | Thap | Dung `OverlayEntry` hoac `showMenu` de dam bao overlay tren cung |

### Do phuc tap uoc tinh

- **Frontend**: **Trung binh** (nhieu widget nhung pattern lap lai, reuse nhieu tu Kudos)
- **Backend**: **Thap** (chi query PostgREST, khong can Edge Functions)
- **Testing**: **Trung binh** (2 ViewModels + Repository + Widget tests)

---

## Chien luoc kiem thu tich hop

### Pham vi kiem thu

- [x] **Tuong tac component/module**: ViewModel <-> Repository <-> Datasource
- [x] **Phu thuoc ben ngoai**: Supabase PostgREST (7 queries)
- [ ] **Data layer**: Khong co local DB (chi in-memory state)
- [x] **Luong nguoi dung**: Filter switch -> list reload, Heart toggle -> count update, Infinite scroll, Pull-to-refresh

### Phan loai kiem thu

| Loai | Ap dung? | Kich ban chinh |
|------|----------|----------------|
| UI <-> Logic | Co | Filter dropdown -> ViewModel -> list reset; Heart tap -> optimistic update |
| Service <-> Service | Co | ProfileRepository -> KudosRepository (heart toggle); ProfileRepository -> ProfileRemoteDatasource |
| App <-> External API | Co | PostgREST queries cho profile, badges, kudos list |
| Cross-platform | Khong | iOS-only trong phase nay |

### Moi truong kiem thu

- **Loai**: Flutter Test (unit + widget), Emulator (integration)
- **Test data**: Mock factories tao `UserProfile`, `IconBadge`, `Badge`, `Kudos`, `PersonalStats`
- **Co lap**: Riverpod `overrideWith` cho moi test — khong dung real API

### Chien luoc Mock

| Loai dependency | Chien luoc | Ly do |
|-----------------|-----------|-------|
| ProfileRepository | Mock (mocktail) | Unit test ViewModel khong can real API |
| ProfileRemoteDatasource | Mock (mocktail) | Unit test Repository khong can real HTTP |
| KudosRepository | Mock (mocktail) | Test heart toggle khong can real API |
| Supabase client | Mock | Tranh phu thuoc network trong CI |
| Clipboard | Mock | Widget test cho copy link |
| go_router | Mock | Widget test cho navigation |

### Kich ban kiem thu

1. **Happy Path**
   - [x] Load Profile ban than -> hien thi profile info + icons + stats + kudos list
   - [x] Load Profile nguoi khac -> hien thi profile info + badges + CTA + kudos list
   - [x] Chon filter "Da nhan" -> list cap nhat, label dropdown doi
   - [x] Chon filter "Da gui" -> list cap nhat, label dropdown doi
   - [x] Bam heart -> count tang, icon thay doi
   - [x] Scroll xuong -> load them kudos (infinite scroll)
   - [x] Pull-to-refresh -> reload toan bo du lieu
   - [x] Bam "Gui loi cam on" -> navigate sang send kudos voi nguoi nhan pre-fill
   - [x] Bam "Mo Secret Box" -> navigate sang Open Secret Box
   - [x] Bam avatar tren card -> navigate sang profile nguoi do

2. **Error Handling**
   - [x] API tra 401 -> redirect login
   - [x] API tra 500 -> hien thi error + retry button
   - [x] Network timeout -> hien thi error state
   - [x] userId khong ton tai -> hien thi "Khong tim thay nguoi dung"

3. **Edge Cases**
   - [x] Nguoi dung chua co kudos nao -> empty state "Chua co Kudos nao."
   - [x] Bo suu tap icon rong -> an section
   - [x] Bo suu tap huy hieu rong -> an section
   - [x] Thong ke tat ca = 0 -> hien thi gia tri 0, "Mo Secret Box" disabled
   - [x] Xem chinh minh qua route /profile/:userId -> redirect sang tab Profile
   - [x] Double tap heart (race condition) -> debounce/ignore
   - [x] Filter doi tu sent -> received khi dang load -> cancel request cu

### Cong cu & Framework

- **Test framework**: `flutter_test` + `mocktail`
- **CI**: `flutter test` trong pipeline
- **Coverage target**: >= 80% cho ViewModel + Repository

### Muc tieu Coverage

| Khu vuc | Muc tieu | Uu tien |
|---------|---------|---------|
| ProfileViewModel | 90%+ | Cao |
| OtherProfileViewModel | 90%+ | Cao |
| ProfileRepository | 85%+ | Cao |
| Widget tests (key interactions) | 70%+ | Trung binh |
| Model serialization | 100% | Cao |

---

## Phu thuoc & Dieu kien tien quyet

### Yeu cau truoc khi bat dau

- [x] `constitution.md` da review
- [x] `spec.md` (Profile ban than) da review
- [x] `spec.md` (Profile nguoi khac) da review
- [x] `design-style.md` (Profile ban than) da review
- [x] `design-style.md` (Profile nguoi khac) da review
- [x] Kudos feature da trien khai (reuse KudosCard, HeartButton, KudosRepository)
- [ ] API endpoints san sang (hoac mock data layer)
- [ ] SVG icons tu Figma da download (ic_back, ic_edit — kiem tra da co chua)
- [ ] DB schema cho user_badges/badges (migration + seed data)
- [ ] Seed data bo sung cho Profile (Phase 0b) — APPEND vao `supabase/seed.sql` roi chay `psql -h localhost -p 54322 -U postgres -d postgres -f supabase/seed.sql`

### Phu thuoc ben ngoai

- Supabase PostgREST (7 queries) — co the mock neu chua san sang
- Figma assets (icons SVG) — can download truoc Phase 0
- Man hinh gui kudos (screenId: `PV7jBVZU1N`) — placeholder route neu chua build
- Man hinh Open Secret Box (screenId: `kQk65hSYF2`) — placeholder route neu chua build

---

## Ghi chu

- Feature nay reuse nhieu tu Kudos feature (KudosCard, HeartButton, PersonalStats, Kudos model, KudosRepository) — giam thioi gian phat trien dang ke
- 2 ViewModels rieng biet vi state khac nhau (ban than co stats, nguoi khac co CTA) — khong dung chung 1 ViewModel de tranh phuc tap
- Dropdown filter profile don gian hon Kudos filter (chi 2 options co dinh) — khong can bottom sheet, dung overlay popup
- Khi backend deploy, chi can cap nhat `ProfileRemoteDatasource` — Repository va ViewModel khong doi
- Tat ca `.md` deu viet bang tieng Viet theo yeu cau project
