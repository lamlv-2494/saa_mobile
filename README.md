# Sun\* SAA — Sun\* Annual Awards 2025 Mobile App

Ứng dụng mobile cho sự kiện **Sun\* Annual Awards 2025** của Sun\*. App cung cấp countdown, hệ thống giải thưởng (Awards), và tính năng ghi nhận đồng nghiệp **Sun\* Kudos**.

> **Nền tảng chính:** dự án này được **build cho Android**. iOS project có sẵn trong thư mục `ios/` nhưng hiện không phải ưu tiên kiểm thử.

---

## 1. Tech Stack

| Thành phần | Công nghệ | Version |
|-----------|-----------|---------|
| Framework | Flutter | 3.41.3 |
| Language | Dart SDK | ^3.11.1 |
| State management | flutter_riverpod | ^2.6.1 |
| Navigation | go_router | ^14.8.1 |
| Backend (BaaS) | supabase_flutter | ^2.8.4 |
| Immutable models | freezed | ^2.5.8 |
| JSON | json_serializable | ^6.9.4 |
| i18n | slang + slang_flutter | ^3.31.x |
| SVG rendering | flutter_svg | ^2.0.17 |
| Asset generation | flutter_gen_runner | ^5.7.0 |
| Local storage | shared_preferences | ^2.3.5 |
| Env config | flutter_dotenv | ^5.2.1 |
| Image picker | image_picker | ^1.1.2 |
| URL launcher | url_launcher | ^6.3.1 |
| Testing | flutter_test + mocktail | ^1.0.4 |
| App icons | flutter_launcher_icons | ^0.14.1 |

**Kiến trúc:** MVVM (1 `AsyncNotifier<XxxState>` per feature, widget con là `StatelessWidget` — xem [.momorph/constitution.md](.momorph/constitution.md)).

**Ngôn ngữ UI:** Tiếng Việt + English (qua slang).

---

## 2. Features đã implement

- **Auth** — Google OAuth qua Supabase Auth ([lib/features/auth/](lib/features/auth/))
- **Home** — countdown 20 ngày (persist `SharedPreferences` + auto-reset), event info, awards list, kudos promo, bottom nav ([lib/features/home/](lib/features/home/))
- **Awards** — 6 hạng mục: Top Talent / Top Project / Project Leader / Best Manager / MVP / Signature Creator ([lib/features/award/](lib/features/award/))
- **Kudos** — Feed, send, view, all-kudos (infinite scroll + pull-to-refresh), detail, view ẩn danh ([lib/features/kudos/](lib/features/kudos/))
- **Profile** — profile cá nhân + profile người khác ([lib/features/profile/](lib/features/profile/))
- **Language switcher** — VN ↔ EN ([lib/shared/widgets/language_dropdown.dart](lib/shared/widgets/language_dropdown.dart))

---

## 3. Yêu cầu môi trường

- **Flutter SDK** 3.41.3
- **Dart** ^3.11.1
- **Android Studio** (hoặc Xcode nếu build iOS)
- **Supabase CLI** — https://supabase.com/docs/guides/local-development/cli/getting-started
- **Android emulator (AVD)** hoặc physical Android device có bật USB debugging + `adb` trong PATH

---

## 4. Setup dự án

```bash
# 1. Clone + cd
git clone <repo-url>
cd saa_mobile

# 2. Copy env config
cp .env.example .env
# Sau đó paste SUPABASE_ANON_KEY vào .env (lấy từ output của `supabase start`)

# 3. Install dependencies
flutter pub get

# 4. Generate code (freezed, json_serializable, slang, flutter_gen)
dart run build_runner build --delete-conflicting-outputs

# 5. Khởi tạo Supabase local
supabase start
# Ports: API 54321 | DB 54322 | Studio 54323
# Migrations trong supabase/migrations/ và seed supabase/seed.sql sẽ auto-apply
```

---

## 5. ⚠️ Android Emulator — chạy `adb reverse` trước khi login

**Bắt buộc:** sau khi start Android emulator, chạy lệnh sau **trước khi launch app**:

```bash
adb reverse tcp:54321 tcp:54321
```

> Lệnh này phải chạy **mỗi lần** emulator khởi động — port forwarding không persist sau khi restart AVD.

### Tại sao phải chạy `adb reverse`?

Android emulator chạy trong một **network namespace riêng** (isolated VM network):

- Trong app chạy trên emulator, khi gọi `http://127.0.0.1:54321` → request đi tới **loopback của emulator**, KHÔNG phải loopback của máy host.
- Supabase local đang chạy trên **máy host** tại `127.0.0.1:54321`, emulator **không tiếp cận** trực tiếp được.
- Kết quả: login fail với lỗi `Connection refused` / `ClientException: Failed to fetch` ngay cả khi Supabase local đang chạy ổn trên host.

`adb reverse tcp:54321 tcp:54321` mở **reverse port forwarding**: khi emulator gửi request tới `localhost:54321` trong namespace của nó, ADB chuyển tiếp request về `localhost:54321` trên máy host (nơi Supabase local đang listen).

Với cách này, `SUPABASE_URL=http://127.0.0.1:54321` trong `.env` dùng chung được cho:
- Dart tool chạy trên host
- iOS simulator
- Android emulator (sau khi `adb reverse`)

### Verify port forwarding

```bash
adb reverse --list   # phải thấy tcp:54321 tcp:54321
```

---

## 6. Run / Build commands

```bash
flutter run                           # debug trên emulator/device đang chọn
flutter run --release                 # release mode
flutter build apk --release           # build APK
flutter build appbundle --release     # build AAB cho Play Store

dart run build_runner watch --delete-conflicting-outputs   # watch code-gen khi develop
dart run slang                                             # regen i18n (strings.g.dart)
dart run flutter_launcher_icons                            # regen app icons (iOS + Android)
```

---

## 7. Testing

```bash
flutter test                         # toàn bộ test suite
flutter test test/unit/              # chỉ unit tests
flutter test test/widget/            # chỉ widget tests
flutter test test/integration/       # chỉ integration tests

flutter analyze                      # static analysis (lint)
dart format .                        # format code
```

---

## 8. Cấu trúc thư mục

```
lib/
├── app/          # routing, theme, main scaffold
├── core/         # constants, utils, network
├── features/     # feature modules (auth, home, award, kudos, profile, ...)
├── shared/       # widgets, providers dùng chung
├── i18n/         # slang translations (VN + EN)
├── gen/          # flutter_gen output (assets.gen.dart — KHÔNG sửa tay)
└── main.dart

supabase/
├── migrations/   # 12 migration files (.sql)
└── seed.sql      # seed data cho local

.momorph/
├── constitution.md   # project standards (MVVM, naming, asset rules, ...)
├── specs/            # feature specifications
└── templates/        # momorph workflow templates

test/
├── unit/             # viewmodel, repository, model tests
├── widget/           # widget tests theo feature
├── integration/      # integration flows
└── helpers/          # mocks + test helpers
```

---

## 9. Phát triển với Spec-Driven Development (SDD) + Claude

Dự án này sử dụng **SDD (Spec-Driven Development)** kết hợp với **Claude Code** để biến mỗi feature/màn hình thành một vòng đời có tài liệu đầy đủ, trước khi code được viết.

Mọi artefact SDD nằm trong [.momorph/](.momorph/):

- [.momorph/constitution.md](.momorph/constitution.md) — chuẩn chung của dự án (MVVM, asset rules, naming, dependencies đã duyệt). **Nguồn sự thật duy nhất** mà mọi spec/plan/task phải tuân thủ.
- [.momorph/specs/{screenId}-{screen_name}/](.momorph/specs/) — thư mục per-feature:
  - `spec.md` — yêu cầu, user story, acceptance criteria
  - `design-style.md` — design tokens + visual spec từ Figma
  - `plan.md` — kiến trúc, file mới/sửa, phase breakdown
  - `tasks.md` — danh sách task TDD-ready
- [.momorph/templates/](.momorph/templates/) — template cho mọi loại artefact
- [.momorph/SCREENFLOW.md](.momorph/SCREENFLOW.md) — luồng chuyển màn tổng thể

### Các slash command Claude được dùng trong dự án

| Command | Mục đích |
|---------|----------|
| `/momorph.specify` | Tạo `spec.md` + `design-style.md` từ Figma frame |
| `/momorph.reviewspecify` | Review + fix spec cho đủ self-contained |
| `/momorph.plan` | Tạo `plan.md` — kiến trúc, file structure, phase |
| `/momorph.reviewplan` | Review plan đối chiếu constitution |
| `/momorph.tasks` | Sinh `tasks.md` — task list có ID, [P] parallel marker, file path |
| `/momorph.implement` | Thực thi task theo thứ tự, TDD strict (Red → Green → Refactor) |
| `/momorph.commit` | Tạo git commit sau khi task hoàn thành |

**Workflow điển hình cho 1 feature:**

```
Figma frame → /momorph.specify → /momorph.reviewspecify
           → /momorph.plan     → /momorph.reviewplan
           → /momorph.tasks    → /momorph.implement → /momorph.commit
```

Mọi file `.md` trong workflow phải viết bằng tiếng Việt (theo [CLAUDE.md](CLAUDE.md)). Claude được cấu hình qua [CLAUDE.md](CLAUDE.md) để tuân thủ TDD, không hardcode string, dùng flutter_gen cho asset, và các quy tắc khác trong constitution.

---

## 10. Tài liệu tham chiếu

- [.momorph/constitution.md](.momorph/constitution.md) — nguồn sự thật cho mọi quyết định kỹ thuật (MVVM, asset rules, naming, dependencies đã duyệt)
- [CLAUDE.md](CLAUDE.md) — rules cho AI assistant (TDD, asset rules, i18n, Supabase seed rules)
- [.momorph/specs/](.momorph/specs/) — feature specifications (spec.md + design-style.md + plan.md + tasks.md cho từng màn hình)
