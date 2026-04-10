# Implementation Plan: [iOS] Login

**Frame**: `8HGlvYGJWq-ios-login`
**Date**: 2026-04-09
**Spec**: `specs/8HGlvYGJWq-ios-login/spec.md`

---

## Summary

Xây dựng màn hình Login cho SAA Mobile — điểm vào đầu tiên của ứng dụng.
Sử dụng **Supabase Auth** với Google OAuth (native sign-in) để xác thực người dùng (bất kỳ Google account).
Hỗ trợ chuyển đổi ngôn ngữ (VN/EN) trước khi đăng nhập qua DropdownButton.

Đây là feature đầu tiên trong project mới, nên cần thiết lập foundation (project structure,
dependencies, theme, routing, i18n) trước khi implement UI.

---

## Technical Context

**Language/Framework**: Dart / Flutter 3.41.3
**Primary Dependencies**: flutter_riverpod, supabase_flutter, go_router, google_fonts, slang
**Database**: Supabase (PostgreSQL) — managed auth tables
**Testing**: flutter_test (unit + widget), integration_test
**State Management**: Riverpod (providers as ViewModel)
**API Style**: Supabase SDK (built-in Auth methods)

---

## Constitution Compliance Check

*GATE: Must pass before implementation can begin*

- [x] Follows MVVM architecture (Principle I)
- [x] Uses Riverpod for state management
- [x] Uses go_router for navigation
- [x] Feature-based module structure
- [x] Widget tách nhỏ, reusable (Principle II)
- [x] Không hardcode — dùng theme + slang i18n
- [x] TDD flow: test trước, implement sau (Principle III)
- [x] Lint rules nghiêm ngặt (Principle IV)
- [x] Dependencies có kỷ luật (Principle V)

**Violations (if any)**:

| Violation | Justification | Alternative Rejected |
|-----------|---------------|---------------------|
| Thêm nhiều packages mới | Project mới — cần thiết lập foundation | Không có alternative |

---

## Architecture Decisions

### Flutter App Architecture (MVVM + Riverpod)

```
lib/
├── app/
│   ├── app.dart                          # ProviderScope + MaterialApp.router
│   ├── router.dart                       # GoRouter configuration + auth redirect
│   └── theme/
│       ├── app_theme.dart                # ThemeData chính
│       └── app_colors.dart               # Color constants từ design tokens
├── core/
│   ├── constants/
│   │   └── app_constants.dart            # Timeout values, supported locales
│   ├── env/
│   │   └── env_config.dart               # Supabase URL/Key (flutter_dotenv từ .env)
│   ├── utils/
│   │   └── validators.dart               # (không còn dùng — email domain check đã bỏ)
│   └── network/
│       └── supabase_config.dart          # Supabase initialization
├── features/
│   └── auth/
│       ├── data/
│       │   ├── models/
│       │   │   └── auth_state.dart                # Freezed union (AuthState)
│       │   ├── datasources/
│       │   │   └── auth_remote_datasource.dart    # Supabase Auth calls
│       │   └── repositories/
│       │       └── auth_repository.dart           # Repository implementation
│       └── presentation/
│           ├── screens/
│           │   └── login_screen.dart                # Login screen
│           ├── viewmodels/
│           │   └── auth_viewmodel.dart            # Auth state + logic (Riverpod)
│           └── widgets/
│               ├── login_background.dart          # BG image + gradient
│               ├── login_header.dart              # Logo + language selector
│               ├── login_body.dart                # Tagline + description
│               ├── login_footer.dart              # Copyright text
│               └── google_login_button.dart       # Button with states
├── shared/
│   ├── widgets/
│   │   └── language_selector.dart                 # Reusable language dropdown
│   └── providers/
│       └── locale_provider.dart                   # Global locale state
├── i18n/                                          # slang generated files
│   └── strings.i18n.json                          # Translation source
└── main.dart                                      # Entry point

test/
├── unit/
│   ├── viewmodels/
│   │   └── auth_viewmodel_test.dart               # AuthViewModel tests
│   ├── repositories/
│   │   └── auth_repository_test.dart              # AuthRepository + email check
│   └── providers/
│       └── locale_provider_test.dart              # Locale persistence
├── widget/
│   ├── login_screen_test.dart                       # Full login view tests
│   ├── google_login_button_test.dart              # Button state tests
│   └── language_selector_test.dart                # Language widget tests
└── helpers/
    └── mocks.dart                                 # Shared mock classes
```

### State Management Approach

```
┌──────────────────────────────────────────────────┐
│                   Riverpod                        │
│                                                   │
│  ┌───────────────────┐  ┌──────────────────────┐ │
│  │ authViewModelPr    │  │ localeNotifierPr     │ │
│  │ (AsyncNotifier)    │  │ (StateNotifier)      │ │
│  │                    │  │                      │ │
│  │ - signInGoogle()   │  │ - changeLocale()     │ │
│  │ - checkSession()   │  │ - loadSavedLocale()  │ │
│  │ - signOut()        │  │ - persist to prefs   │ │
│  └────────┬──────────┘  └──────────────────────┘ │
│           │                                       │
│  ┌────────▼──────────┐                            │
│  │ authRepository     │                           │
│  │ (Provider)         │                           │
│  │                    │                           │
│  │ → Supabase Auth    │                           │
│  └────────────────────┘                           │
└──────────────────────────────────────────────────┘
```

- `authViewModelProvider`: `AsyncNotifierProvider<AuthViewModel, AuthState>` — quản lý login flow, loading, error. `AuthState` là freezed union: `initial | loading | authenticated(User) | unauthenticated | error(String)`
- `localeNotifierProvider`: `StateNotifierProvider<LocaleNotifier, Locale>` — đọc/ghi locale từ SharedPreferences
- `authRepositoryProvider`: `Provider<AuthRepository>` — wrap Supabase Auth SDK
- `supabaseClientProvider`: `Provider<SupabaseClient>` — singleton Supabase client

### Navigation (go_router)

```dart
// router.dart
GoRouter(
  initialLocation: '/login',
  redirect: (context, state) {
    final isLoggedIn = /* check auth state */;
    final isLoginRoute = state.matchedLocation == '/login';
    
    if (!isLoggedIn && !isLoginRoute) return '/login';
    if (isLoggedIn && isLoginRoute) return '/home';
    return null;
  },
  routes: [
    GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
    GoRoute(path: '/home', builder: (_, __) => const Placeholder()), // future
  ],
)
```

### Authentication Flow

```
User taps "LOGIN With Google"
  → Button enters loading state (disable + spinner)
  → authViewModel.signInWithGoogle()
    → authRepository.signInWithGoogle()
      → supabase.auth.signInWithOAuth(OAuthProvider.google)
        → Opens Google OAuth consent (system browser/webview)
        → Google returns auth code
        → Supabase exchanges code for session
    → ✅ Success: Save session, GoRouter redirects to /home
  → On error: Show SnackBar, reset button state
  → On cancel: Reset button state, no error shown
```

---

## Project Structure

### New Files

| File | Purpose |
|------|---------|
| `lib/app/app.dart` | Root widget: ProviderScope + MaterialApp.router |
| `lib/app/router.dart` | GoRouter config + auth redirect logic |
| `lib/app/theme/app_theme.dart` | ThemeData (Montserrat, colors, button styles) |
| `lib/app/theme/app_colors.dart` | Color constants từ design tokens |
| `lib/core/constants/app_constants.dart` | Timeout values, supported locales |
| `lib/core/network/supabase_config.dart` | Supabase.initialize() config |
| `lib/features/auth/data/datasources/auth_remote_datasource.dart` | Supabase Auth API calls |
| `lib/features/auth/data/repositories/auth_repository.dart` | Auth repository (interface + impl) |
| `lib/features/auth/presentation/screens/login_screen.dart` | Login screen (Stack layout) |
| `lib/features/auth/presentation/viewmodels/auth_viewmodel.dart` | Auth Riverpod provider |
| `lib/features/auth/presentation/widgets/login_background.dart` | BG image + gradient overlay |
| `lib/features/auth/presentation/widgets/login_header.dart` | Logo + language selector row |
| `lib/features/auth/presentation/widgets/login_body.dart` | Tagline + description text |
| `lib/features/auth/presentation/widgets/login_footer.dart` | Copyright text |
| `lib/features/auth/presentation/widgets/google_login_button.dart` | Button with loading/error states |
| `lib/shared/widgets/language_selector.dart` | Language dropdown widget |
| `lib/shared/providers/locale_provider.dart` | Locale state + SharedPreferences |
| `lib/features/auth/data/models/auth_state.dart` | Freezed union: initial/loading/authenticated/unauthenticated/error |
| `lib/i18n/strings.i18n.json` | Translation strings (VN/EN) |
| `lib/core/env/env_config.dart` | Load SUPABASE_URL + SUPABASE_ANON_KEY từ .env via flutter_dotenv |
| `.env` | File chứa credentials (KHÔNG commit — nằm trong .gitignore) |
| `.env.example` | Template .env cho team reference (commit được) |
| `test/unit/viewmodels/auth_viewmodel_test.dart` | Unit tests cho AuthViewModel |
| `test/unit/repositories/auth_repository_test.dart` | Unit tests cho AuthRepository |
| `test/unit/providers/locale_provider_test.dart` | Unit tests cho locale persistence |
| `test/widget/login_screen_test.dart` | Widget tests cho LoginScreen + button states |
| `test/widget/google_login_button_test.dart` | Widget tests cho button loading/error/disabled |
| `test/widget/language_selector_test.dart` | Widget tests cho language selector |
| `test/helpers/mocks.dart` | Mock classes (Supabase, SharedPreferences, GoRouter) |
| `assets/images/keyvisual_bg.png` | Background key visual |
| `assets/images/root_further.png` | ROOT FURTHER tagline image |
| `assets/images/saa_logo.png` | Sun* Annual Awards logo |
| `assets/icons/ic_google.svg` | Google logo icon |
| `assets/icons/ic_arrow_down.svg` | Dropdown arrow icon |
| `assets/icons/flags/vn.svg` | Vietnam flag |
| `assets/icons/flags/en.svg` | UK flag |

### Modified Files

| File | Changes |
|------|---------|
| `lib/main.dart` | Thay thế toàn bộ — Supabase init + runApp(App()) |
| `pubspec.yaml` | Thêm dependencies + assets declaration |
| `analysis_options.yaml` | Nâng cấp lint rules (strict) |
| `android/app/build.gradle` | Thêm Google Sign-In config (nếu cần) |
| `ios/Runner/Info.plist` | Thêm URL scheme cho OAuth callback |

### Dependencies

| Package | Purpose | Category |
|---------|---------|----------|
| `flutter_riverpod` | State management (ViewModel providers) | dependencies |
| `go_router` | Declarative routing + auth redirect | dependencies |
| `supabase_flutter` | Supabase SDK (Auth, Database, Realtime) | dependencies |
| `google_fonts` | Load Montserrat font | dependencies |
| `flutter_svg` | Render SVG icons (flags, google logo) | dependencies |
| `shared_preferences` | Persist locale selection | dependencies |
| `freezed_annotation` | Annotation cho freezed models (AuthState) | dependencies |
| `json_annotation` | JSON serialization annotation | dependencies |
| `slang` | i18n code generation | dependencies |
| `slang_flutter` | Flutter integration cho slang | dependencies |
| `google_sign_in` | Native Google Sign-In flow | dependencies |
| `flutter_dotenv` | Load env variables từ .env file | dependencies |
| `build_runner` | Code generation runner | dev_dependencies |
| `freezed` | Code generation cho immutable models | dev_dependencies |
| `json_serializable` | JSON serialization code gen | dev_dependencies |
| `slang_build_runner` | Generate i18n từ JSON | dev_dependencies |
| `mocktail` | Mocking library cho tests | dev_dependencies |

**Lưu ý**: Dùng Riverpod manual approach (không dùng `riverpod_annotation`/`riverpod_generator`) để giảm complexity code gen. `dio` không cần cho feature Login vì dùng `supabase_flutter` SDK trực tiếp — sẽ thêm `dio` khi có feature cần custom API calls.

---

## Implementation Strategy

### Phase 1: Setup (Foundation) — BLOCKS tất cả

**Purpose**: Thiết lập project structure, dependencies, theme, routing, platform config

1. Cập nhật `pubspec.yaml` — thêm tất cả dependencies + asset declarations
2. Cấu hình `analysis_options.yaml` — strict lint rules
3. Tạo `.env` + `.env.example` + `lib/core/env/env_config.dart` — Supabase URL + Anon Key via `flutter_dotenv`
4. Tạo `lib/core/network/supabase_config.dart` — Supabase initialization
5. Tạo `lib/core/constants/app_constants.dart` — Timeout values, supported locales
7. Tạo `lib/app/theme/app_colors.dart` — Color constants từ design tokens
8. Tạo `lib/app/theme/app_theme.dart` — ThemeData (Montserrat, button styles, SnackBar theme)
9. Tạo `lib/app/router.dart` — GoRouter với `/login` route + auth redirect
10. Tạo `lib/app/app.dart` — Root widget (ProviderScope + MaterialApp.router)
11. Cập nhật `lib/main.dart` — Supabase.initialize() + lock portrait + light status bar + runApp
12. Download assets từ Figma (images, icons, flags) vào `assets/`
13. Setup i18n — tạo translation JSON files (VN/EN) + run slang build
14. Cấu hình iOS `Info.plist` — URL scheme cho Supabase OAuth callback
15. Cấu hình Android — deep link cho OAuth callback
16. Tạo `test/helpers/mocks.dart` — Mock classes (Supabase, SharedPreferences)

**Checkpoint**: App chạy được, hiển thị blank Login route, theme đúng, OAuth callback configured

### Phase 2: Core Feature — US1: Đăng nhập Google (P1) 🎯 MVP

**Purpose**: Implement full login flow end-to-end — BAO GỒM loading state, error handling, double-tap prevention (đây là acceptance criteria bắt buộc, không phải polish)

#### Data Layer (TDD: test → implement)

17. Viết test `auth_repository_test.dart` — test signInWithGoogle, mock Supabase calls
18. Tạo `auth_state.dart` — Freezed union: `initial | loading | authenticated(User) | unauthenticated | error(String)`
19. Tạo `auth_remote_datasource.dart` — wrap Supabase Auth (signInWithOAuth, getSession, signOut)
20. Tạo `auth_repository.dart` — repository interface + implementation (không check email domain)
21. Run tests → all pass

#### ViewModel Layer (TDD: test → implement)

22. Viết test `auth_viewmodel_test.dart` — test signInWithGoogle flow, loading/error/success states
23. Tạo `auth_viewmodel.dart` — AsyncNotifier: signInWithGoogle(), checkSession(), quản lý AuthState
24. Run tests → all pass

#### Presentation Layer (TDD: test → implement)

25. Viết test `google_login_button_test.dart` — test 4 states (default/pressed/loading/disabled)
26. Tạo `login_background.dart` — Stack: background image + gradient overlay
27. Tạo `google_login_button.dart` — Button với 4 states + double-tap prevention + loading spinner
28. Tạo `login_footer.dart` — Copyright text (i18n)
29. Tạo `login_body.dart` — ROOT FURTHER image + description text (i18n)
30. Tạo `login_header.dart` — Logo (placeholder cho language selector)

#### View (Assembly + TDD)

31. Viết test `login_screen_test.dart` — test full flow: tap → loading → success/error
32. Tạo `login_screen.dart` — Assemble tất cả widgets, connect authViewModel, SnackBar error display
33. Cập nhật `router.dart` — Wire auth redirect logic với authViewModelProvider
34. Run tất cả tests → all pass

**Checkpoint**: User có thể login bằng Google → redirect đến Home (placeholder). Loading state, error SnackBar, double-tap prevention hoạt động.

### Phase 3: Extended Feature — US2: Chọn ngôn ngữ (P2)

**Purpose**: Implement language switching (TDD)

35. Viết test `locale_provider_test.dart` — test change locale, persistence
36. Tạo `locale_provider.dart` — StateNotifier + SharedPreferences persistence
37. Viết test `language_selector_test.dart` — test tap → overlay, flag/label change
38. Tạo `language_selector.dart` — Widget: flag + code + arrow, tap → overlay
39. Cập nhật `login_header.dart` — Thêm language_selector vào header
40. Wire i18n — Connect localeNotifierProvider với MaterialApp.router locale
41. Run tất cả tests → all pass

**Checkpoint**: User có thể chuyển ngôn ngữ, text cập nhật, persist qua app restart

### Phase 4: Accessibility & Responsive

**Purpose**: Accessibility, responsive testing, final polish

42. Thêm `Semantics` widgets — semantic labels cho Login Button và Language Selector
43. Verify touch targets — minimum 48x48dp hit area cho tất cả interactive elements
44. Responsive testing — test trên iPhone SE (375), iPhone 16 (393), Pro Max (430), Android (360)
45. Run `flutter analyze` — 0 warnings
46. Run `dart format` — tất cả files formatted
47. Run full test suite — tất cả tests pass

**Checkpoint**: Accessibility pass, responsive OK, lint clean, all tests green

---

## Integration Testing Strategy

### Test Scope

- [x] **Component/Module interactions**: AuthViewModel ↔ AuthRepository ↔ Supabase
- [x] **External dependencies**: Supabase Auth (mock cho test)
- [ ] **Data layer**: Không có custom DB — Supabase manages
- [x] **User workflows**: Login flow end-to-end, language change flow

### Test Categories

| Category | Applicable? | Key Scenarios |
|----------|-------------|---------------|
| UI ↔ Logic | Yes | Button tap → loading state → navigate |
| Service ↔ Service | Yes | AuthRepository → SupabaseAuth |
| App ↔ External API | Yes | Supabase OAuth flow (mocked) |
| App ↔ Data Layer | No | N/A |
| Cross-platform | Yes | iOS + Android OAuth callback |

### Mocking Strategy

| Dependency | Strategy | Rationale |
|------------|----------|-----------|
| Supabase Auth | Mock | External service — không test trực tiếp |
| SharedPreferences | Mock | Isolate locale persistence logic |
| GoRouter | Mock | Test navigation triggers independently |
| Google OAuth UI | Skip | System browser — không mock được |

### Coverage Goals

| Area | Target | Priority |
|------|--------|----------|
| AuthViewModel (login flow) | 90%+ | High |
| AuthRepository (sign-in flow) | 90%+ | High |
| Login widgets | 80%+ | Medium |
| Locale persistence | 85%+ | Medium |
| Edge cases (error/cancel) | 80%+ | Medium |

---

## Risk Assessment

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| Supabase OAuth callback fails trên iOS/Android | Med | High | Test sớm trên real device, đọc docs cẩn thận |
| Google OAuth consent bị block bởi corporate policy | Low | High | Confirm với IT team trước khi implement |
| `google_fonts` fail khi offline (lần đầu) | Med | Low | Bundle Montserrat font trong assets, fallback |
| slang code generation conflict với freezed | Low | Med | Setup build_runner config đúng thứ tự |
| Deep link conflict giữa Supabase callback và go_router | Med | Med | Tách URL scheme cho Supabase riêng |

---

## Dependencies & Prerequisites

### Required Before Start

- [x] `constitution.md` reviewed and understood
- [x] `spec.md` approved (Status: Reviewed)
- [x] Design assets identified (need export from Figma)
- [ ] Supabase project created và configured (Google OAuth provider enabled)
- [ ] iOS Bundle ID và Android Package Name registered với Google Cloud Console
- [ ] Supabase URL + Anon Key available cho configuration

### External Dependencies

- Supabase project (authentication enabled, Google OAuth provider configured)
- Google Cloud Console (OAuth 2.0 client ID cho iOS + Android)
- Figma assets exported (keyvisual_bg, root_further, saa_logo, icons)

---

## Next Steps

After plan approval:

1. **Run** `/momorph.tasks` to generate task breakdown
2. **Review** tasks.md for parallelization opportunities
3. **Setup** Supabase project + Google Cloud Console (nếu chưa có)
4. **Export** assets từ Figma
5. **Begin** implementation following task order (Phase 1 → 2 → 3 → 4)

---

## Notes

- Đây là feature ĐẦU TIÊN — Phase 1 (Setup) sẽ lâu hơn bình thường vì cần thiết lập toàn bộ foundation.
- Foundation (theme, router, providers, i18n) sẽ được tái sử dụng cho tất cả features sau.
- Supabase Auth SDK đã handle phần lớn OAuth complexity — không cần implement OAuth flow thủ công.
- Không giới hạn email domain — bất kỳ Google account nào cũng có thể đăng nhập.
- Login screen chỉ có 2 interactive elements (button + language selector) — UI complexity thấp, logic complexity trung bình.
- **TDD bắt buộc**: Mỗi layer viết test trước, implement sau — tuân thủ Constitution Principle III.
- **Supabase credentials**: KHÔNG hardcode — sử dụng `flutter_dotenv` load từ file `.env`. File `.env` nằm trong `.gitignore`. Tạo `.env.example` cho team. Run: `flutter run` (không cần --dart-define).
- **`dio` không cần** cho feature Login — dùng `supabase_flutter` SDK trực tiếp. Sẽ thêm `dio` khi cần custom API calls ở features sau.
- **`freezed` bắt buộc** cho `AuthState` model — tuân thủ Constitution (immutable models).
