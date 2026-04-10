# Tasks: [iOS] Login

**Frame**: `8HGlvYGJWq-ios-login`
**Prerequisites**: plan.md (required), spec.md (required), design-style.md (required)

---

## Task Format

```
- [x] T### [P?] [Story?] Description | file/path
```

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this belongs to (US1, US2)
- **|**: File path affected by this task

---

## Phase 1: Setup (Foundation)

**Purpose**: Thiết lập project structure, dependencies, theme, routing, platform config. BLOCKS tất cả phases sau.

- [x] T001 Cập nhật dependencies + asset declarations trong pubspec.yaml: thêm flutter_riverpod, go_router, supabase_flutter, google_fonts, flutter_svg, shared_preferences, freezed_annotation, json_annotation, slang, slang_flutter, google_sign_in, flutter_dotenv (dependencies); build_runner, freezed, json_serializable, slang_build_runner, mocktail (dev_dependencies); khai báo assets/ folders | pubspec.yaml
- [x] T002 Cấu hình strict lint rules: bật prefer_single_quotes, always_use_package_imports, unawaited_futures, etc. | analysis_options.yaml
- [x] T003 [P] Tạo env config: tạo .env + .env.example + class EnvConfig load SUPABASE_URL + SUPABASE_ANON_KEY từ .env via flutter_dotenv. Thêm .env vào .gitignore | lib/core/env/env_config.dart, .env, .env.example
- [x] T004 [P] Tạo Supabase config: hàm initSupabase() gọi Supabase.initialize(url, anonKey) từ EnvConfig | lib/core/network/supabase_config.dart
- [x] T005 [P] Tạo app constants: kLoginTimeoutSeconds = 10, supportedLocaleCodes | lib/core/constants/app_constants.dart
- [x] T006 [P] Tạo app colors từ design tokens: kColorBgDark=#00101A, kColorTextWhite=#FFFFFF, kColorButtonBg=#FFEA9E, kColorButtonText=#00101A, kColorButtonPressed=#E6D28E, kColorErrorBg=#EF4444, kColorLoadingSpinner=#00101A | lib/app/theme/app_colors.dart
- [x] T007 Tạo app theme: ThemeData với Montserrat (google_fonts), colorScheme từ AppColors, ElevatedButton style (bg #FFEA9E, radius 4, height 40), SnackBar theme (bg #EF4444/90%, floating, radius 8) | lib/app/theme/app_theme.dart
- [x] T008 Tạo GoRouter config: initialLocation '/login', routes cho /login (LoginScreen placeholder) và /home (Placeholder), redirect logic stub (sẽ wire auth ở Phase 2) | lib/app/router.dart
- [x] T009 Tạo App root widget: ProviderScope wrapping MaterialApp.router, dùng appTheme, routerConfig từ goRouter | lib/app/app.dart
- [x] T010 Cập nhật main.dart: WidgetsFlutterBinding.ensureInitialized(), initSupabase(), SystemChrome.setPreferredOrientations([portrait]), SystemChrome.setSystemUIOverlayStyle(light), runApp(const App()) | lib/main.dart
- [x] T011 Download assets từ Figma: keyvisual_bg.png, root_further.png, saa_logo.png → assets/images/; ic_google.svg, ic_arrow_down.svg → assets/icons/; vn.svg, en.svg → assets/icons/flags/ | assets/
- [x] T012 Setup i18n: tạo strings.i18n.json với keys cho 2 ngôn ngữ (vi, en) — loginDescription, loginButton, copyright, errorNetwork, errorAuth, languageVN, languageEN. Run dart run slang | lib/i18n/strings.i18n.json
- [x] T013 [P] Cấu hình iOS OAuth callback: thêm URL scheme (CFBundleURLTypes) cho Supabase deep link redirect trong Info.plist | ios/Runner/Info.plist
- [x] T014 [P] Cấu hình Android OAuth callback: thêm intent-filter cho Supabase deep link redirect | android/app/build.gradle
- [x] T015 Tạo test mocks: MockSupabaseClient, MockGoRouter, MockSharedPreferences dùng mocktail | test/helpers/mocks.dart

**Checkpoint**: `flutter run` thành công, hiển thị blank Login route, theme Montserrat đúng, OAuth callback configured.

---

## Phase 2: User Story 1 — Đăng nhập bằng Google (Priority: P1) 🎯 MVP

**Goal**: Người dùng có thể đăng nhập qua Google OAuth (bất kỳ Google account) và được redirect đến Home.

**Independent Test**: Mở app → Nhấn "LOGIN With Google" → Xác thực Google → Chuyển đến Home. Loading spinner hiển thị trong khi chờ. Error SnackBar hiển thị khi thất bại.

### Data Layer (TDD)

- [x] T016 [US1] Viết unit tests cho AuthRepository: test signInWithGoogle success → trả về AuthResponse, test signInWithGoogle failure → throw Exception, test getSession khi có/không session, test signOut. Mock SupabaseClient | test/unit/repositories/auth_repository_test.dart
- [x] T017 [P] [US1] Tạo AuthState freezed union: initial | loading | authenticated(User) | unauthenticated | error(String). Run build_runner | lib/features/auth/data/models/auth_state.dart
- [x] T018 [P] [US1] Tạo AuthRemoteDataSource: wrap Supabase Auth calls — signInWithOAuth(OAuthProvider.google), getSession(), signOut(), onAuthStateChange stream | lib/features/auth/data/datasources/auth_remote_datasource.dart
- [x] T019 [US1] Tạo AuthRepository: interface + implementation — signInWithGoogle() gọi datasource, getSession(), signOut(). Inject datasource via constructor | lib/features/auth/data/repositories/auth_repository.dart
- [x] T020 [US1] Run unit tests auth_repository → all pass | (verify)

### ViewModel Layer (TDD)

- [x] T021 [US1] Viết unit tests cho AuthViewModel: test initial state = unauthenticated, test signInWithGoogle → loading → authenticated, test signInWithGoogle failure → error(message), test checkSession có session → authenticated, test checkSession không session → unauthenticated. Mock AuthRepository | test/unit/viewmodels/auth_viewmodel_test.dart
- [x] T022 [US1] Tạo AuthViewModel: AsyncNotifier<AuthState>. build() → checkSession(). signInWithGoogle() → set loading → call repository → set authenticated/error. Riverpod: authViewModelProvider | lib/features/auth/presentation/viewmodels/auth_viewmodel.dart
- [x] T023 [US1] Run unit tests auth_viewmodel → all pass | (verify)

### Presentation Layer (TDD)

- [x] T024 [US1] Viết widget tests cho GoogleLoginButton: test renders text "LOGIN With Google" + icon, test onPressed callback fires, test loading state → shows CircularProgressIndicator + disabled, test disabled state → onPressed not called | test/widget/google_login_button_test.dart
- [x] T025 [P] [US1] Tạo LoginBackground widget: Stack — Image.asset keyvisual_bg.png BoxFit.cover + Container gradient overlay (top #00101A opacity 0.8 → transparent, height 104px) | lib/features/auth/presentation/widgets/login_background.dart
- [x] T026 [US1] Tạo GoogleLoginButton widget: ElevatedButton 246x40, bg #FFEA9E radius 4. Row: SvgPicture ic_google 20x20 + SizedBox(8) + Text "LOGIN With Google" Montserrat 14px w600 #00101A. Loading state: CircularProgressIndicator 20px #00101A, opacity 0.7, disabled. Double-tap prevention via isLoading prop | lib/features/auth/presentation/widgets/google_login_button.dart
- [x] T027 [P] [US1] Tạo LoginFooter widget: Container height 48, Center Text i18n copyright "Bản quyền thuộc về Sun* © 2025" Montserrat 12px w300 white opacity 0.6 | lib/features/auth/presentation/widgets/login_footer.dart
- [x] T028 [P] [US1] Tạo LoginBody widget: Column crossAxisAlignment start. Image.asset root_further.png 247x109. SizedBox height 32. Text i18n description, Montserrat 14px w300 white letterSpacing 0.25 | lib/features/auth/presentation/widgets/login_body.dart
- [x] T029 [P] [US1] Tạo LoginHeader widget: Row mainAxisAlignment spaceBetween. Left: Image.asset saa_logo.png 48x44. Right: placeholder Container 90x32 (language selector sẽ thêm ở US2) | lib/features/auth/presentation/widgets/login_header.dart

### Screen Assembly (TDD)

- [x] T030 [US1] Viết widget tests cho LoginScreen: test renders all components (background, header, body, button, footer), test tap login button → shows loading, test error state → shows SnackBar with message, test authenticated → navigates away | test/widget/login_screen_test.dart
- [x] T031 [US1] Tạo LoginScreen: Scaffold body Stack — LoginBackground (bottom layer) + SafeArea Column padding 20px: LoginHeader, Spacer, LoginBody, Spacer, GoogleLoginButton (wired to authViewModel.signInWithGoogle), LoginFooter. Watch authViewModelProvider: on error → show SnackBar (floating, bg #EF4444/90%, Montserrat 14px white, 4 giây, behavior floating) | lib/features/auth/presentation/screens/login_screen.dart
- [x] T032 [US1] Wire auth redirect trong GoRouter: read authViewModelProvider state, redirect /login→/home khi authenticated, redirect /home→/login khi unauthenticated. Refresh listenable từ authViewModel stream | lib/app/router.dart
- [x] T033 [US1] Run tất cả tests (unit + widget) → all pass, flutter analyze → 0 warnings | (verify)

**Checkpoint**: User Story 1 complete — đăng nhập Google OAuth hoạt động end-to-end, loading/error hoạt động.

---

## Phase 3: User Story 2 — Chọn ngôn ngữ hiển thị (Priority: P2)

**Goal**: Nhân viên Sun* có thể chuyển đổi ngôn ngữ (VN/EN) trước khi đăng nhập qua DropdownButton, ngôn ngữ persist qua app restart.

**Independent Test**: Mở app → Nhấn dropdown → Chọn EN → Tất cả text thay đổi sang English → Đóng/mở lại → Vẫn hiển thị EN.

### Provider Layer (TDD)

- [x] T034 [US2] Viết unit tests cho LocaleNotifier: test initial locale = vi, test changeLocale(en) → state = Locale('en'), test persistence → SharedPreferences.setString called, test loadSavedLocale reads from prefs, test invalid locale falls back to vi | test/unit/providers/locale_provider_test.dart
- [x] T035 [US2] Tạo LocaleNotifier: extends StateNotifier<Locale>. Constructor inject SharedPreferences. loadSavedLocale() đọc 'locale' key → set state. changeLocale(String code) → set state + persist. Riverpod: localeNotifierProvider | lib/shared/providers/locale_provider.dart
- [x] T036 [US2] Run locale provider tests → all pass | test/unit/providers/locale_provider_test.dart

### Widget Layer (TDD)

- [x] T037 [US2] Viết widget tests cho LanguageSelector: test renders flag icon + "VN" label + arrow down, test tap triggers onTap callback, test display changes for EN (UK flag + "EN") | test/widget/language_selector_test.dart
- [x] T038 [US2] Tạo LanguageSelector widget: GestureDetector wrapping Row(gap 8): SvgPicture flag 24x24, Text locale code (Montserrat 14px w500 white), SvgPicture arrow_down 24x24. Container 90x32 padding fromLTRB(8,4,0,4) radius 4. Props: currentLocale, onTap. Map locale → flag asset path + label | lib/shared/widgets/language_selector.dart
- [x] T039 [US2] Run language selector widget tests → all pass | test/widget/language_selector_test.dart

### Integration

- [x] T040 [US2] Cập nhật LoginHeader: thay placeholder bên phải bằng LanguageSelector widget. Sử dụng PopupMenuButton hiển thị popup menu BÊN DƯỚI selector với 2 options (VN/EN) với flag + tên ngôn ngữ. Chọn → gọi localeNotifier.changeLocale() | lib/features/auth/presentation/widgets/login_header.dart
- [x] T041 [US2] Wire i18n vào App: MaterialApp.router thêm locale từ localeNotifierProvider, supportedLocales [vi, en], localizationsDelegates. Slang TranslationProvider wrapping app | lib/app/app.dart
- [x] T042 [US2] Run tất cả tests (unit + widget) → all pass, flutter analyze → 0 warnings | (verify)

**Checkpoint**: User Story 2 complete — chuyển đổi ngôn ngữ hoạt động, text cập nhật, persist qua restart.

---

## Phase 4: Accessibility & Responsive

**Purpose**: Accessibility compliance, responsive verification, lint clean, final quality gate.

- [x] T043 [P] Thêm Semantics widgets: LoginButton → Semantics(label: i18n "Đăng nhập bằng Google"), LanguageSelector → Semantics(label: i18n "Chọn ngôn ngữ, hiện tại: {locale}"). Đảm bảo screen reader đọc đúng thứ tự | lib/features/auth/presentation/screens/login_screen.dart
- [x] T044 [P] Verify touch targets: GoogleLoginButton hit area ≥ 48dp height (thêm padding nếu cần), LanguageSelector hit area ≥ 48dp height (thêm padding nếu cần) | lib/features/auth/presentation/widgets/google_login_button.dart, lib/shared/widgets/language_selector.dart
- [x] T045 Responsive testing: verify layout trên iPhone SE (375px), iPhone 16 (393px), iPhone Pro Max (430px), Android (360px). Đảm bảo Spacer/Expanded phân bố vertical space đúng, không overflow, background cover đúng | lib/features/auth/presentation/screens/login_screen.dart
- [x] T046 Run flutter analyze → 0 warnings, dart format → all files formatted | (verify)
- [x] T047 Run full test suite → all tests pass, verify coverage targets: AuthViewModel 90%+, AuthRepository 95%+, Widgets 80%+, Locale 85%+ | (verify)

**Checkpoint**: Accessibility pass, responsive OK, lint clean, all tests green. Feature DONE.

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies — start immediately
- **US1 (Phase 2)**: Depends on Phase 1 completion — BLOCKS all user stories
- **US2 (Phase 3)**: Depends on Phase 1 completion. Có thể chạy song song với US1 (provider + widget layer), nhưng integration cần LoginScreen từ US1
- **Polish (Phase 4)**: Depends on Phase 2 + 3 completion

### Within Each Phase

- Tests MUST be written and FAIL before implementation (TDD — Constitution Principle III)
- Models/State trước Services/Repository
- Repository trước ViewModel
- ViewModel trước Widgets
- Widgets trước Screen assembly
- Screen assembly trước routing integration

### Parallel Opportunities

**Phase 1**: T003, T004, T005, T006 chạy song song (files độc lập). T013, T014 chạy song song.

**Phase 2**:
- T017, T018 chạy song song (AuthState + DataSource không phụ thuộc nhau)
- T025, T027, T028, T029 chạy song song (widgets độc lập)

**Phase 3**:
- T034 + T037 chạy song song (test cho provider + widget)

**Phase 4**: T043, T044 chạy song song

---

## Implementation Strategy

### MVP First (Recommended)

1. Complete Phase 1 (Setup)
2. Complete Phase 2 (US1 — Đăng nhập Google) → **STOP and VALIDATE**
3. Deploy/demo nếu ready — đây là MVP
4. Continue Phase 3 (US2 — Ngôn ngữ) + Phase 4 (Polish)

### Incremental Delivery

1. Phase 1 → App chạy được với blank screen
2. Phase 2 → Login Google hoạt động end-to-end
3. Phase 3 → Chuyển ngôn ngữ hoạt động
4. Phase 4 → Accessibility + responsive + quality gate

---

## Notes

- Commit sau mỗi task hoặc logical group
- Run tests trước khi chuyển phase
- **Naming convention**: Màn hình chính dùng `*_screen.dart` / `*Screen`, widget phụ dùng tên mô tả. File screen đặt trong `presentation/screens/`, widget trong `presentation/widgets/` (tuân thủ Constitution v1.1.0)
- Cập nhật spec.md nếu requirements thay đổi trong quá trình implement
- Mark tasks complete khi hoàn thành: `[x]`
