<!--
=== Sync Impact Report ===
Version change: 1.0.0 → 1.1.0 (MINOR — thêm naming convention)

Added sections:
  - Core Principles (5 nguyên tắc)
  - Tech Stack & Dependencies
  - Development Workflow
  - Governance

Modified principles:
  - Principle II (Clean Code): Thêm naming convention cho UI layer — screen vs view
  - Principle I (Kiến trúc): Đổi folder views/ → screens/ trong cấu trúc feature

Removed sections: N/A

Templates requiring updates:
  ✅ .momorph/templates/plan-template.md — không cần cập nhật (placeholder generic)
  ✅ .momorph/templates/spec-template.md — không cần cập nhật (placeholder generic)
  ✅ .momorph/templates/tasks-template.md — không cần cập nhật (placeholder generic)

Follow-up TODOs: Không có
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
  │       │   ├── widgets/       # Widget phụ của feature (đặt tên *_view.dart hoặc tên mô tả)
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
  - Màn hình chính (full-page) PHẢI đặt tên `*_screen.dart` với class `*Screen` (ví dụ: `login_screen.dart`, `LoginScreen`).
  - Chỉ widget phụ (sub-widget, partial view) mới được đặt tên `*_view.dart` với class `*View`.
  - File màn hình đặt trong `presentation/screens/`, widget phụ đặt trong `presentation/widgets/`.

### III. Test-First (KHÔNG THƯƠNG LƯỢNG)

Phát triển PHẢI theo quy trình **TDD (Test-Driven Development)**.

- Quy trình bắt buộc: Viết test → Test FAIL (Red) → Implement code → Test PASS (Green) → Refactor.
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
- Mọi Dart file PHẢI có `part` directive đúng khi dùng code generation (freezed, json_serializable).
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

- [ ] Tuân thủ kiến trúc MVVM
- [ ] Widget được tách nhỏ, reusable
- [ ] Không có code thừa hoặc hardcode
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

**Version**: 1.1.0 | **Ratified**: 2026-04-09 | **Last Amended**: 2026-04-10
