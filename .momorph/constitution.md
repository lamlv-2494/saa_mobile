<!--
=== Sync Impact Report ===
Version change: 1.3.0 → 1.3.1 (PATCH — bỏ subfolder feature-specific trong assets/images/)

Modified principles:
  - Principle II (Clean Code) > Asset Rules: Xóa `images/home/` subfolder,
    images giờ đặt phẳng trong `assets/images/` dùng chung cho mọi screen.

Added sections: N/A

Removed sections: N/A

Templates requiring updates:
  ✅ .momorph/templates/plan-template.md — không cần cập nhật
  ✅ .momorph/templates/spec-template.md — không cần cập nhật
  ✅ .momorph/templates/tasks-template.md — không cần cập nhật

Follow-up TODOs:
  - ✅ Di chuyển ảnh từ assets/images/home/ sang assets/images/ — DONE
  - Chạy `dart run build_runner build` để regenerate asset classes
=== End Report ===
-->

# SAA Mobile Constitution

## Core Principles

### I. Kiến trúc MVVM có khả năng mở rộng

Toàn bộ ứng dụng PHẢI tuân theo kiến trúc **MVVM (Model-View-ViewModel)** kết hợp
**Riverpod** làm state management và **go_router** để điều hướng.

- Mỗi feature PHẢI được tổ chức theo cấu trúc feature-based module:
  ```
  lib/
  ├── app/                       # Cấu hình ứng dụng
  │   ├── app.dart
  │   ├── router.dart            # go_router configuration
  │   └── theme/
  ├── core/                      # Shared utilities
  │   ├── constants/
  │   ├── extensions/
  │   ├── utils/
  │   └── network/               # Dio configuration
  ├── features/                  # Feature modules
  │   └── [feature_name]/
  │       ├── data/              # Data layer
  │       │   ├── models/        # Freezed data models
  │       │   ├── repositories/  # Repository implementations
  │       │   └── datasources/   # Remote/Local data sources
  │       ├── presentation/      # UI layer
  │       │   ├── screens/       # Màn hình chính (đặt tên *_screen.dart)
  │       │   ├── widgets/       # Widget phụ của feature (StatelessWidget)
  │       │   └── viewmodels/    # Riverpod providers (ViewModel)
  │       └── domain/            # Business logic (nếu cần)
  ├── shared/                    # Shared widgets & components
  │   ├── widgets/
  │   └── providers/
  ├── i18n/                      # slang translations
  └── main.dart
  ```
- View (widget) KHÔNG ĐƯỢC chứa business logic — chỉ hiển thị UI và gọi ViewModel.
- ViewModel (Riverpod provider) chịu trách nhiệm xử lý logic, gọi repository, quản lý state.
- Model PHẢI sử dụng **freezed** cho immutability và **json_serializable** cho serialization.
- Repository pattern PHẢI được áp dụng để tách biệt data source khỏi business logic.
- KHÔNG ĐƯỢC viết tất cả code trong 1 file — mỗi class/widget PHẢI nằm trong file riêng.
- Thiết kế PHẢI hướng tới dễ scale, dễ maintain, không tạo bottleneck.

#### ViewModel Pattern (BẮT BUỘC)

Mỗi feature PHẢI có **đúng 1 ViewModel** dạng `AsyncNotifier<XxxState>`:

- ViewModel PHẢI extend `AsyncNotifier<XxxState>` với state model freezed riêng.
  Ví dụ: `HomeViewModel extends AsyncNotifier<HomeState>`.
- **KHÔNG ĐƯỢC** dùng nhiều `FutureProvider` rời rạc cho cùng 1 feature.
  Tất cả data của feature PHẢI gộp vào 1 state model duy nhất.
- State model đặt tên theo pattern `XxxState` (ví dụ: `HomeState`, `ProfileState`)
  và PHẢI dùng freezed.
- Chỉ được tạo thêm `StateNotifier` / `StateProvider` cho state đơn giản
  không liên quan đến async data (ví dụ: `localeNotifierProvider`, tab index).
- **Screen** gọi `ref.watch(xxxViewModelProvider)` rồi truyền data xuống widget con.
  Widget con **PHẢI là `StatelessWidget`** — KHÔNG dùng `ConsumerWidget`
  trừ trường hợp đặc biệt có justification rõ ràng.

```dart
// ✅ ĐÚNG — 1 ViewModel + 1 State
@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required EventInfo eventInfo,
    required List<AwardCategory> awards,
    required bool hasUnreadNotifications,
  }) = _HomeState;
}

class HomeViewModel extends AsyncNotifier<HomeState> {
  @override
  FutureOr<HomeState> build() async { ... }
  Future<void> refresh() async { ... }
}

// ❌ SAI — nhiều FutureProvider rời rạc
final eventInfoProvider = FutureProvider((ref) => ...);
final awardsProvider = FutureProvider((ref) => ...);
final notifCountProvider = FutureProvider((ref) => ...);
```

### II. Clean Code & Tái sử dụng

Mọi code PHẢI tuân thủ nguyên tắc clean code để đảm bảo khả năng bảo trì dài hạn.

- KHÔNG ĐƯỢC viết code thừa — mọi dòng code PHẢI có mục đích rõ ràng.
- Widget PHẢI được tách nhỏ — mỗi widget chỉ đảm nhận một nhiệm vụ duy nhất.
  Nếu widget `build()` vượt quá ~80 dòng, PHẢI tách thành widget con.
- Ưu tiên **reusable components** — widget/logic dùng chung PHẢI đặt trong `shared/`.
- KHÔNG ĐƯỢC hardcode giá trị — sử dụng constants, theme, hoặc config.
  Ví dụ: màu sắc dùng `Theme.of(context)`, chuỗi text dùng slang (i18n).
- Comment PHẢI được viết khi logic phức tạp hoặc không tự giải thích.
  KHÔNG viết comment cho code đã rõ ràng.
- Đặt tên biến, hàm, class PHẢI mang ý nghĩa rõ ràng theo convention Dart/Flutter.
- **Naming convention cho UI layer**:
  - Màn hình chính (full-page) PHẢI đặt tên `*_screen.dart` với class `*Screen`
    (ví dụ: `login_screen.dart`, `LoginScreen`).
  - Chỉ widget phụ (sub-widget, partial view) mới được đặt tên `*_view.dart`
    với class `*View`.
  - File màn hình đặt trong `presentation/screens/`,
    widget phụ đặt trong `presentation/widgets/`.

#### Asset Rules (BẮT BUỘC)

- **Icons** PHẢI sử dụng format **SVG** và render qua `flutter_svg`.
  KHÔNG ĐƯỢC dùng PNG/JPG cho icons.
  Đặt trong `assets/icons/` với tên `ic_*.svg`.
- **Background images / Key Visual** PHẢI dùng format **PNG** hoặc **JPG**.
  Đặt trong `assets/images/`.
- **Lý do**: SVG giữ chất lượng ở mọi resolution, file size nhỏ hơn cho icons.
  PNG phù hợp cho ảnh phức tạp (photos, illustrations, key visuals).

```
assets/
├── icons/           # SVG only — ic_search.svg, ic_notification.svg
│   └── flags/       # SVG flags — vn.svg, en.svg
├── images/          # PNG/JPG — backgrounds, key visuals, logos (shared across screens)
└── fonts/           # Custom fonts
```

#### flutter_gen — Type-safe Asset Access (BẮT BUỘC)

Toàn bộ project PHẢI sử dụng **flutter_gen** để generate type-safe asset classes.
KHÔNG ĐƯỢC hardcode đường dẫn asset dưới dạng string literal.

- **Package**: `flutter_gen` (dev_dependency) + `flutter_gen_runner` (dev_dependency).
- Sau khi thêm/xóa/đổi tên file trong `assets/`, PHẢI chạy:
  ```bash
  dart run build_runner build
  ```
  để re-generate asset classes.
- Cấu hình trong `pubspec.yaml`:
  ```yaml
  flutter_gen:
    output: lib/gen/
    line_length: 80
    integrations:
      flutter_svg: true
  ```
- **Quy tắc sử dụng**:
  - Ảnh PNG/JPG: `Assets.images.keyVisualBg.image(fit: BoxFit.cover)`
  - SVG icons: `Assets.icons.icSearch.svg(width: 24, height: 24)`
  - Fonts: `Assets.fonts.digitalNumbersRegular` (nếu cần path)
- **KHÔNG ĐƯỢC** viết `'assets/icons/ic_search.svg'` trực tiếp.
  PHẢI dùng `Assets.icons.icSearch` thay thế.
- **Lý do**: Compile-time safety — nếu asset bị xóa hoặc đổi tên,
  code sẽ báo lỗi compile thay vì crash runtime.
  Tự động hoàn thành (autocomplete) giúp developer nhanh hơn.

```dart
// ✅ ĐÚNG — type-safe qua flutter_gen
Assets.icons.icSearch.svg(width: 24, height: 24)
Assets.images.keyVisualBg.image(fit: BoxFit.cover)

// ❌ SAI — hardcode string path
SvgPicture.asset('assets/icons/ic_search.svg', width: 24, height: 24)
Image.asset('assets/images/key_visual_bg.png', fit: BoxFit.cover)
```

### III. Test-First (KHÔNG THƯƠNG LƯỢNG)

Phát triển PHẢI theo quy trình **TDD (Test-Driven Development)**.

- Quy trình bắt buộc: Viết test → Test FAIL (Red) → Implement code →
  Test PASS (Green) → Refactor.
- Unit test PHẢI cover ViewModel (providers) và Repository.
- Widget test PHẢI cover các interaction chính của UI.
- Integration test PHẢI được viết cho các luồng người dùng quan trọng.
- Code dễ test: mọi dependency PHẢI được inject qua Riverpod provider,
  KHÔNG ĐƯỢC tạo dependency trực tiếp trong widget/viewmodel.
- Test PHẢI chạy pass trước khi merge bất kỳ code nào.

### IV. Chất lượng Code & Linting

Toàn bộ codebase PHẢI tuân thủ lint rules nghiêm ngặt và format chuẩn.

- PHẢI sử dụng `flutter_lints` (hoặc `very_good_analysis`) và bật strict rules.
- `flutter analyze` PHẢI pass với 0 warnings trước khi commit.
- `dart format` PHẢI được chạy trước mỗi commit — code KHÔNG ĐƯỢC có format sai.
- KHÔNG ĐƯỢC sử dụng deprecated APIs — nếu phát hiện, PHẢI migrate sang API mới ngay.
- Mọi Dart file PHẢI có `part` directive đúng khi dùng code generation
  (freezed, json_serializable).
- KHÔNG ĐƯỢC ignore lint rules mà không có justification rõ ràng.

### V. Quản lý Dependencies có kỷ luật

Mọi dependency PHẢI được kiểm soát chặt chẽ để tránh bloat và conflict.

- Chỉ sử dụng packages đã được phê duyệt trong constitution.
- Thêm package mới PHẢI có justification rõ ràng và được review.
- PHẢI pin version cụ thể hoặc dùng caret syntax (`^`) với version range hợp lý.
- Định kỳ kiểm tra `flutter pub outdated` và cập nhật dependencies.
- KHÔNG ĐƯỢC thêm package chỉ để giải quyết 1 vấn đề nhỏ có thể tự implement.

## Tech Stack & Dependencies

### Framework & Công cụ chính

| Thành phần | Công nghệ | Phiên bản |
|------------|-----------|-----------|
| Framework | Flutter | 3.41.3 |
| Language | Dart | SDK ^3.11.1 |
| State Management | Riverpod | latest stable |
| Navigation | go_router | latest stable |
| Backend (BaaS) | Supabase | latest stable |
| HTTP Client | dio | latest stable |
| Immutable Models | freezed | latest stable |
| JSON Serialization | json_serializable | latest stable |
| Internationalization (i18n) | slang | latest stable |
| SVG Rendering | flutter_svg | latest stable |
| Asset Generation | flutter_gen + flutter_gen_runner | latest stable |

### Kiến trúc Backend

- **Supabase** là Backend-as-a-Service chung, cung cấp:
  - PostgreSQL database với Row Level Security (RLS)
  - Authentication (email, OAuth, OTP)
  - Real-time subscriptions
  - Storage cho file/media
- Giao tiếp với Supabase qua **dio** cho custom API calls
  hoặc **supabase_flutter** SDK cho các tính năng built-in.
- Mọi API call PHẢI đi qua Repository layer — KHÔNG gọi trực tiếp từ UI.

### Cấu trúc Test

```
test/
├── unit/                    # Unit tests
│   ├── viewmodels/          # ViewModel/Provider tests
│   ├── repositories/        # Repository tests
│   └── models/              # Model tests
├── widget/                  # Widget tests
│   └── [feature_name]/
├── integration/             # Integration tests
│   └── [flow_name]/
└── helpers/                 # Test utilities, mocks, fakes
```

## Development Workflow

### Quy trình phát triển feature

1. **Spec**: Phân tích thiết kế Figma → tạo specification (`spec.md`)
2. **Plan**: Lên kế hoạch implementation (`plan.md`)
3. **Tasks**: Chia nhỏ thành tasks có thể thực thi (`tasks.md`)
4. **TDD**: Viết test → Implement → Refactor theo từng task
5. **Review**: Code review kiểm tra constitution compliance
6. **Merge**: Chỉ merge khi tất cả test pass và lint clean

### Quy tắc Commit

- Commit message PHẢI rõ ràng, mô tả thay đổi (tiếng Anh hoặc tiếng Việt).
- Mỗi commit PHẢI ở trạng thái compilable — KHÔNG commit code broken.
- Commit thường xuyên theo từng task hoặc logical group.

### Code Review Checklist

- [ ] Tuân thủ kiến trúc MVVM (1 ViewModel + 1 State per feature)
- [ ] Widget con là StatelessWidget, nhận data qua constructor
- [ ] Widget được tách nhỏ, reusable
- [ ] Không có code thừa hoặc hardcode
- [ ] Icons dùng SVG, backgrounds dùng PNG
- [ ] Asset paths dùng flutter_gen (Assets.xxx), không hardcode string
- [ ] Test đầy đủ và pass
- [ ] Lint pass với 0 warnings
- [ ] Không sử dụng deprecated APIs
- [ ] Dependencies đúng theo constitution

## Governance

- Constitution này là **nguồn sự thật duy nhất** (single source of truth)
  cho mọi quyết định phát triển trong project SAA Mobile.
- Mọi PR/code review PHẢI kiểm tra tuân thủ constitution.
- Sửa đổi constitution PHẢI được ghi nhận với:
  - Mô tả thay đổi
  - Lý do thay đổi
  - Kế hoạch migration (nếu có breaking change)
- Versioning theo Semantic Versioning:
  - **MAJOR**: Thay đổi nguyên tắc không tương thích ngược
  - **MINOR**: Thêm nguyên tắc/section mới
  - **PATCH**: Sửa lỗi chính tả, làm rõ nội dung
- Complexity PHẢI được justify — nếu có giải pháp đơn giản hơn, PHẢI dùng giải pháp đó.

**Version**: 1.3.1 | **Ratified**: 2026-04-09 | **Last Amended**: 2026-04-14
