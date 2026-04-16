# Tasks: [iOS] Language Dropdown

**Frame**: `uUvW6Qm1ve-ios-language-dropdown`
**Prerequisites**: plan.md ✅, spec.md ✅, design-style.md ✅

---

## Trạng thái: ĐÃ IMPLEMENT HOÀN CHỈNH

Feature Language Dropdown đã được triển khai đầy đủ. Tasks dưới đây chỉ để **verify** và **điều chỉnh visual** nếu cần.

---

## Phase 1: Verify Implementation vs Spec

- [x] T001 Verify `LanguageDropdown` widget hiển thị đúng 2 options VN/EN với cờ quốc gia | `lib/shared/widgets/language_dropdown.dart`
- [x] T002 Verify `LocaleNotifier` lưu/khôi phục locale từ SharedPreferences | `lib/shared/providers/locale_provider.dart`
- [x] T003 Verify app root watch `localeNotifierProvider` và rebuild khi đổi ngôn ngữ | `lib/app/app.dart`
- [x] T004 Verify flag SVG icons tồn tại và render đúng | `assets/icons/flags/vn.svg`, `assets/icons/flags/en.svg`
- [x] T005 Verify 6 widget tests pass | `test/widget/shared/language_dropdown_test.dart`
- [x] T006 Verify unit tests pass | `test/unit/providers/locale_provider_test.dart`

**Checkpoint**: Chạy `flutter test` — tất cả tests pass. Feature hoàn chỉnh.

---

## Phase 2: Visual Adjustment (nếu cần)

> Chỉ thực hiện nếu Figma design khác với implementation hiện tại.

- [x] T007 So sánh visual implementation hiện tại với design-style.md — ghi nhận khác biệt | `lib/shared/widgets/language_dropdown.dart`
- [x] T008 [US1] Điều chỉnh dropdown style nếu có khác biệt (background, border, radius, selected state) | `lib/shared/widgets/language_dropdown.dart`
- [x] T009 [US1] Chạy `flutter analyze` đạt 0 warnings | —

**Checkpoint**: Visual khớp Figma. `flutter analyze` pass.

---

## Tổng kết

| Metric | Giá trị |
|--------|---------|
| Tổng tasks | 9 |
| Tasks đã hoàn thành | 6 |
| Tasks còn lại (visual) | 3 (tuỳ chọn) |
| User Stories covered | US1 (mở/đóng), US2 (chọn ngôn ngữ), US3 (lưu trạng thái) |
| Scope MVP | Đã hoàn chỉnh |
