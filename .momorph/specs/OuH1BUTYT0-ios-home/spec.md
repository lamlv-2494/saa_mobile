# Đặc tả tính năng — [iOS] Home

> Screen ID: `OuH1BUTYT0` | File Key: `9ypp4enmFmdK3YAFJLIu6C`

## 1. Tổng quan

### Tên tính năng
Màn hình chính SAA 2025

### Mục đích
Màn hình Home là trang chủ của ứng dụng SAA (Sun* Annual Awards) 2025. Cung cấp tổng quan về sự kiện, bộ đếm ngược thời gian thực, điều hướng nhanh đến các tính năng Awards và Kudos, cùng nút hành động nổi (FAB) để tạo Kudos nhanh.

### Đối tượng sử dụng
- **Sunners** (nhân viên Sun*) — toàn bộ nhân sự tham gia sự kiện SAA 2025

### Bối cảnh nghiệp vụ
SAA 2025 là lễ trao giải thường niên dành cho nhân viên Sun*. Màn hình Home đóng vai trò trung tâm cung cấp thông tin sự kiện, duyệt danh mục giải thưởng, và giới thiệu tính năng mới "Sun* Kudos" — ghi nhận đồng nghiệp. Màn hình cần tạo sự hào hứng với chủ đề "Root Further" và thúc đẩy tương tác với cả Awards lẫn Kudos.

---

## 2. User Stories

### US1: Xem thông tin sự kiện [P1]

**Là** một Sunner
**Tôi muốn** xem nhanh thông tin sự kiện SAA 2025
**Để** biết thời gian và địa điểm tổ chức

#### Kịch bản chấp nhận

**Kịch bản 1: Hiển thị thông tin sự kiện**
- Cho: Người dùng mở app / điều hướng về Home
- Khi: Màn hình Home được tải
- Thì: Hiển thị logo "ROOT FURTHER", ngày sự kiện (26/12/2025), địa điểm (Âu Cơ Art Center) và thông tin livestream

**Kịch bản 2: Dữ liệu tải từ API**
- Cho: Thông tin sự kiện được lấy từ backend
- Khi: API trả về dữ liệu
- Thì: Ngày, địa điểm và thông tin livestream được hiển thị động (không hardcode)

**Kịch bản 3: API lỗi**
- Cho: API thông tin sự kiện bị lỗi
- Khi: Màn hình Home được tải
- Thì: Hiển thị dữ liệu cache nếu có, hoặc trạng thái lỗi với tùy chọn thử lại

**Kịch bản 4: Trạng thái đang tải**
- Cho: Người dùng mở app lần đầu (không có cache)
- Khi: API đang tải dữ liệu
- Thì: Hiển thị skeleton/shimmer placeholder cho các vùng nội dung động (countdown, thông tin sự kiện, danh sách giải thưởng, phần Kudos)

**Kịch bản 5: Pull-to-refresh**
- Cho: Người dùng đang ở màn hình Home
- Khi: Người dùng kéo xuống (pull down) ở đầu trang
- Thì: Tải lại toàn bộ dữ liệu từ API (event info, awards, kudos, notification count)

---

### US2: Bộ đếm ngược [P1]

**Là** một Sunner
**Tôi muốn** xem bộ đếm ngược thời gian thực đến ngày sự kiện
**Để** cảm nhận sự hào hứng và biết còn bao lâu nữa

#### Kịch bản chấp nhận

**Kịch bản 1: Đếm ngược đang chạy**
- Cho: Ngày sự kiện còn trong tương lai
- Khi: Màn hình Home đang hiển thị
- Thì: Bộ đếm ngược hiển thị DAYS, HOURS, MINUTES và cập nhật thời gian thực

**Kịch bản 2: Đến ngày sự kiện**
- Cho: Thời gian hiện tại đã qua ngày sự kiện
- Khi: Bộ đếm ngược về 0
- Thì: Hiển thị "00 / 00 / 00" (hardcode cố định, không cần xử lý trạng thái đặc biệt)

---

### US3: Điều hướng đến trang giới thiệu Awards [P1]

**Là** một Sunner
**Tôi muốn** nhấn "ABOUT AWARD" để tìm hiểu về giải thưởng
**Để** hiểu hệ thống giải thưởng trước sự kiện

#### Kịch bản chấp nhận

**Kịch bản 1: Điều hướng thành công**
- Cho: Người dùng đang ở màn hình Home
- Khi: Người dùng nhấn nút "ABOUT AWARD"
- Thì: Ứng dụng điều hướng đến màn hình giới thiệu Awards

---

### US4: Điều hướng đến trang giới thiệu Kudos [P1]

**Là** một Sunner
**Tôi muốn** nhấn "ABOUT KUDOS" để tìm hiểu về tính năng Kudos
**Để** hiểu cách ghi nhận đồng nghiệp hoạt động trong SAA 2025

#### Kịch bản chấp nhận

**Kịch bản 1: Điều hướng thành công**
- Cho: Người dùng đang ở màn hình Home
- Khi: Người dùng nhấn nút "ABOUT KUDOS"
- Thì: Ứng dụng điều hướng đến màn hình giới thiệu Kudos

---

### US5: Duyệt danh mục giải thưởng [P1]

**Là** một Sunner
**Tôi muốn** duyệt qua các danh mục giải thưởng
**Để** khám phá các giải thưởng mà tôi quan tâm

#### Kịch bản chấp nhận

**Kịch bản 1: Hiển thị danh sách giải thưởng**
- Cho: Dữ liệu giải thưởng có sẵn từ API (cố định 6 giải: Top Talent, Top Project, Top Project Leader, Best Manager, MVP, Signature 2025 Creator)
- Khi: Màn hình Home được tải
- Thì: Hiển thị danh sách 6 card giải thưởng cuộn ngang

**Kịch bản 2: Vuốt qua các giải thưởng**
- Cho: Danh sách giải thưởng có nhiều mục
- Khi: Người dùng vuốt trái/phải trên các card
- Thì: Danh sách cuộn mượt mà hiển thị thêm danh mục

**Kịch bản 3: Điều hướng đến chi tiết giải thưởng**
- Cho: Một card giải thưởng đang hiển thị
- Khi: Người dùng nhấn "Chi tiết" trên card
- Thì: Ứng dụng điều hướng đến màn hình Chi tiết giải thưởng tương ứng

**Kịch bản 4: Trạng thái rỗng**
- Cho: Không có dữ liệu giải thưởng từ API
- Khi: Phần giải thưởng được tải
- Thì: Hiển thị trạng thái rỗng/đang tải phù hợp

**Kịch bản 5: Nội dung card giải thưởng**
- Cho: Dữ liệu giải thưởng đã tải
- Khi: Một card được hiển thị
- Thì: Hiển thị ảnh thumbnail, tên giải, mô tả rút gọn (tối đa 3 dòng với ellipsis), và link "Chi tiết"

---

### US6: Xem phần Kudos [P2]

**Là** một Sunner
**Tôi muốn** xem thông tin về tính năng Sun* Kudos
**Để** tìm hiểu về điểm mới nổi bật của SAA 2025

#### Kịch bản chấp nhận

**Kịch bản 1: Hiển thị phần Kudos**
- Cho: Tính năng Kudos đang hoạt động
- Khi: Người dùng cuộn đến phần Kudos
- Thì: Hiển thị header, banner, badge "ĐIỂM MỚI CỦA SAA 2025", mô tả và nút "Chi tiết"

**Kịch bản 2: Điều hướng đến chi tiết Kudos**
- Cho: Phần Kudos đang hiển thị
- Khi: Người dùng nhấn nút "Chi tiết"
- Thì: Ứng dụng điều hướng đến màn hình chi tiết Kudos

**Kịch bản 3: Tính năng Kudos chưa khả dụng**
- Cho: API `/api/kudos/info` trả về `isEnabled = false` hoặc lỗi
- Khi: Màn hình Home được tải
- Thì: Ẩn toàn bộ phần Kudos section

---

### US7: Hành động nhanh Kudos qua FAB [P1]

**Là** một Sunner
**Tôi muốn** nhanh chóng gửi kudos hoặc xem feed kudos từ bất kỳ vị trí cuộn nào
**Để** tương tác với tính năng ghi nhận đồng nghiệp mà không cần điều hướng đi

#### Kịch bản chấp nhận

**Kịch bản 1: Gửi Kudos**
- Cho: FAB đang hiển thị (overlay cố định)
- Khi: Người dùng nhấn icon bút chì
- Thì: Mở form/màn hình Gửi Kudos

**Kịch bản 2: Xem feed Kudos**
- Cho: FAB đang hiển thị
- Khi: Người dùng nhấn icon S/Kudos
- Thì: Ứng dụng điều hướng đến màn hình danh sách/feed Kudos

**Kịch bản 3: Chống nhấn đúp**
- Cho: Người dùng nhấn icon FAB
- Khi: Người dùng nhấn nhanh lần nữa
- Thì: Chỉ kích hoạt một hành động điều hướng (không trùng lặp)

---

### US8: Chuyển đổi ngôn ngữ [P2]

**Là** một Sunner
**Tôi muốn** chuyển đổi ngôn ngữ ứng dụng
**Để** sử dụng app bằng ngôn ngữ ưa thích

#### Kịch bản chấp nhận

**Kịch bản 1: Mở bộ chọn ngôn ngữ**
- Cho: Người dùng đang ở màn hình Home
- Khi: Người dùng nhấn vào bộ chuyển ngôn ngữ (cờ VN + "VN" + dropdown)
- Thì: Mở modal/dropdown chọn ngôn ngữ

**Kịch bản 2: Áp dụng thay đổi ngôn ngữ**
- Cho: Modal ngôn ngữ đang mở (2 lựa chọn: VN, EN)
- Khi: Người dùng chọn ngôn ngữ khác
- Thì: Toàn bộ text trong app được cập nhật theo ngôn ngữ đã chọn (sử dụng slang i18n)

---

### US9: Truy cập tìm kiếm [P2]

**Là** một Sunner
**Tôi muốn** nhấn icon tìm kiếm để tìm nội dung cụ thể
**Để** nhanh chóng tìm giải thưởng, người hoặc thông tin

#### Kịch bản chấp nhận

**Kịch bản 1: Điều hướng đến tìm kiếm**
- Cho: Người dùng đang ở màn hình Home
- Khi: Người dùng nhấn icon tìm kiếm ở header
- Thì: Ứng dụng điều hướng đến màn hình Tìm kiếm

---

### US10: Xem thông báo [P2]

**Là** một Sunner
**Tôi muốn** xem và truy cập thông báo
**Để** cập nhật về kudos nhận được, thông báo sự kiện, v.v.

#### Kịch bản chấp nhận

**Kịch bản 1: Mở thông báo**
- Cho: Người dùng đang ở màn hình Home
- Khi: Người dùng nhấn icon chuông thông báo
- Thì: Mở bảng Thông báo

**Kịch bản 2: Badge chưa đọc (chấm đỏ)**
- Cho: Người dùng có thông báo chưa đọc (count > 0)
- Khi: Màn hình Home đang hiển thị
- Thì: Hiển thị chấm đỏ nhỏ (8×8px, `#D4271D`) ở góc trên-phải icon chuông (chỉ hiện dot, KHÔNG hiện số)

**Kịch bản 3: Không có thông báo chưa đọc**
- Cho: Tất cả thông báo đã đọc (count = 0)
- Khi: Màn hình Home đang hiển thị
- Thì: Icon chuông không có badge dot

---

### US11: Điều hướng tab dưới [P1]

**Là** một Sunner
**Tôi muốn** điều hướng giữa các phần chính của app qua tab dưới
**Để** truy cập Awards, Kudos và Profile dễ dàng

#### Kịch bản chấp nhận

**Kịch bản 1: Điều hướng tab**
- Cho: Thanh điều hướng dưới đang hiển thị
- Khi: Người dùng nhấn một tab (SAA 2025, Awards, Kudos, Profile)
- Thì: Ứng dụng điều hướng đến màn hình tương ứng

**Kịch bản 2: Highlight tab đang chọn**
- Cho: Người dùng đang ở màn hình Home
- Khi: Thanh nav dưới đang hiển thị
- Thì: Tab "SAA 2025" được highlight màu vàng (`#FFEA9E`), các tab khác màu trắng

---

## 3. Yêu cầu UI/UX

### 3.1 Danh sách Component

| # | Component | Node ID | Mô tả |
|---|-----------|---------|-------|
| 1 | Header Bar | `6885:9057` | Header cố định với logo, ngôn ngữ, tìm kiếm, thông báo |
| 2 | Hero Content | `6885:8983` | Logo, đếm ngược, thông tin sự kiện, nút CTA |
| 3 | Mô tả chủ đề | `6885:9028` | Đoạn text mô tả chủ đề "Root Further" |
| 4 | Phần Giải thưởng | `6885:9030` | Header phần + danh sách card giải thưởng cuộn ngang |
| 5 | Phần Kudos | `6885:9039` | Header phần + banner + mô tả + CTA |
| 6 | FAB | `6885:9058` | Nút nổi dạng pill với icon bút chì + logo kudos |
| 7 | Thanh Nav dưới | `6885:9056` | Điều hướng 4 tab (SAA 2025, Awards, Kudos, Profile) |

> **Thông số thiết kế**: Xem [design-style.md](./design-style.md) để biết đầy đủ design tokens, typography, spacing và sơ đồ layout.

### 3.2 Layout
- Nền tối toàn chiều rộng (`#00101A`) với ảnh nền hero ở trên cùng
- Vùng nội dung: rộng 335px, căn giữa (margin ngang 20px trên màn 375px)
- Nội dung cuộn dọc (SingleChildScrollView hoặc CustomScrollView)
- Header cố định với overlay gradient, **opacity thay đổi/ẩn dần khi cuộn xuống** (transition từ 0.9 → 0 theo scroll offset)
- FAB vị trí cố định, góc dưới-phải (trên thanh nav)
- Thanh nav dưới cố định ở đáy
- Hỗ trợ safe area: top inset cho status bar/notch, bottom inset cho home indicator

### 3.2.1 Điểm vào (Entry Points)
- Từ màn hình Login → sau đăng nhập thành công → Home
- Từ bottom nav tab "SAA 2025" trên các màn hình khác
- Deep link (nếu có) → Home

### 3.3 Responsive
- Thiết kế mobile-first (tham chiếu 375px)
- Chiều rộng nội dung tự điều chỉnh tỉ lệ theo chiều rộng màn hình
- Danh sách card giải thưởng cuộn ngang bất kể chiều rộng màn hình
- FAB và nav dưới luôn neo vào viewport

### 3.4 Accessibility
- Mọi phần tử tương tác phải có vùng nhấn đủ lớn (tối thiểu 44×44 dp)
- Tỉ lệ tương phản text phải đạt WCAG 2.1 AA (vàng trên nền tối đạt yêu cầu)
- Label screen reader cho các nút chỉ có icon (tìm kiếm, thông báo, icon FAB)
- Bộ đếm ngược nên thông báo cập nhật cho công nghệ hỗ trợ theo chu kỳ (không mỗi giây)

---

## 4. Yêu cầu dữ liệu

### 4.1 Trường nhập liệu
Không có — Màn hình Home chỉ hiển thị và điều hướng.

### 4.2 Trường hiển thị

| Trường | Nguồn | Kiểu | Ghi chú |
|--------|-------|------|---------|
| Ảnh nền hero (Key Visual) | Asset tĩnh (bundled) | Image | `Assets.images.home.keyVisualBg` — background hero, gradient overlay |
| Logo chủ đề sự kiện | Asset tĩnh | Image | `Assets.images.home.rootFurtherLogo` — branding "ROOT FURTHER" |
| Ngày sự kiện | API | DateTime | Định dạng: dd/MM/yyyy |
| Địa điểm sự kiện | API | String | Tên địa điểm |
| Thông tin livestream | API | String | Text tĩnh, KHÔNG nhấn được (chỉ hiển thị, không link) |
| Bộ đếm ngược | Tính toán | Days/Hours/Minutes | Thời gian thực từ ngày sự kiện |
| Mô tả chủ đề | API / Tĩnh | String | Đoạn text dài về Root Further |
| Danh mục giải thưởng | API | List\<Award\> | name, image, description |
| Thông tin phần Kudos | API / Tĩnh | Object | banner, title, description |
| Số thông báo | API | Integer | Số chưa đọc cho badge |

### 4.3 Data Models (Dự kiến)

```dart
// Thông tin sự kiện (sử dụng freezed theo constitution)
@freezed
class EventInfo with _$EventInfo {
  const factory EventInfo({
    required String themeName,
    required DateTime eventDate,
    required String venue,
    required String livestreamNote,
    required String themeDescription,
    // heroImage & themeLogo: asset tĩnh bundled trong app, không từ API
  }) = _EventInfo;

  factory EventInfo.fromJson(Map<String, dynamic> json) =>
      _$EventInfoFromJson(json);
}

// Danh mục giải thưởng
@freezed
class AwardCategory with _$AwardCategory {
  const factory AwardCategory({
    required String id,
    required String name,
    required String imageUrl,
    required String description,
  }) = _AwardCategory;

  factory AwardCategory.fromJson(Map<String, dynamic> json) =>
      _$AwardCategoryFromJson(json);
}

// Thông tin Kudos
@freezed
class KudosInfo with _$KudosInfo {
  const factory KudosInfo({
    required String bannerImageUrl,
    required String title,
    required String description,
    required bool isEnabled,
  }) = _KudosInfo;

  factory KudosInfo.fromJson(Map<String, dynamic> json) =>
      _$KudosInfoFromJson(json);
}
```

---

## 5. Yêu cầu API (Dự kiến)

| Endpoint | Method | Mục đích | Response |
|----------|--------|----------|----------|
| `/api/event/info` | GET | Tải thông tin sự kiện (ngày, địa điểm, chủ đề) | `EventInfo` object |
| `/api/awards/categories` | GET | Tải danh sách danh mục giải thưởng | `List<AwardCategory>` |
| `/api/kudos/info` | GET | Tải thông tin phần Kudos | `KudosInfo` object |
| `/api/notifications/unread-count` | GET | Lấy số thông báo chưa đọc | `{ count: number }` |

> **Lưu ý**: Đây là các endpoint dự kiến. Cấu trúc bảng Supabase và RPC calls thực tế sẽ được xác định trong giai đoạn lập kế hoạch.

---

## 6. Quản lý State

### 6.1 State cục bộ (Component)
- Giá trị bộ đếm ngược (days, hours, minutes) — cập nhật qua `Timer` mỗi giây
- Vị trí cuộn hiện tại (cho hiệu ứng opacity header) — `ScrollController`
- Pull-to-refresh indicator state
- Index tab nav dưới đang chọn

### 6.2 State toàn cục (Riverpod Providers)
- `homeViewModelProvider` — `AsyncNotifierProvider<HomeViewModel, HomeState>`:
  Quản lý tất cả data của Home trong 1 state model duy nhất (constitution v1.2.0):
  ```dart
  HomeState { eventInfo, awards, kudosInfo, unreadNotificationCount }
  ```
- `localeNotifierProvider` — `StateNotifierProvider<LocaleNotifier, Locale>` (shared)
- `currentTabIndexProvider` — `StateProvider<int>` — Tab nav dưới đang chọn

### 6.3 Yêu cầu Cache
- Thông tin sự kiện: Cache trong phiên (ít thay đổi)
- Danh mục giải thưởng: Cache 5 phút (có thể cập nhật định kỳ)
- Thông tin Kudos: Cache trong phiên
- Số thông báo: Làm mới khi focus màn hình / pull-to-refresh

---

## 7. Sơ đồ điều hướng

```
Màn hình Home
├── Nút "ABOUT AWARD" → Màn hình giới thiệu Awards
├── Nút "ABOUT KUDOS" → Màn hình giới thiệu Kudos
├── Card giải thưởng "Chi tiết" → Màn hình Chi tiết giải thưởng (theo category ID)
├── Nút "Chi tiết" Kudos → Màn hình Chi tiết Kudos
├── FAB icon bút chì → Màn hình Gửi Kudos
├── FAB icon Kudos → Màn hình Feed Kudos
├── Header icon tìm kiếm → Màn hình Tìm kiếm
├── Header icon chuông → Bảng Thông báo
├── Header chuyển ngôn ngữ → Modal Chọn ngôn ngữ
└── Nav dưới:
    ├── "SAA 2025" → Home (hiện tại)
    ├── "Awards" → Màn hình Awards
    ├── "Kudos" → Màn hình Feed Kudos
    └── "Profile" → Màn hình Profile
```

---

## 8. Tuân thủ Constitution

| Nguyên tắc | Tuân thủ |
|------------|----------|
| I. Kiến trúc MVVM | ViewModel xử lý API calls, logic đếm ngược. Screen chỉ render UI. |
| II. Clean Code | Widget nhỏ, không hardcode (theme colors, i18n cho text). Asset paths qua flutter_gen (`Assets.xxx`), không hardcode string. |
| III. Test-First | Unit tests cho logic đếm ngược, viewmodel. Widget tests cho tương tác chính. |
| IV. Chất lượng Code | Lint rules, format, không dùng deprecated APIs. |
| V. Dependencies | Chỉ dùng packages đã duyệt (Riverpod, go_router, freezed, dio). |

---

## 9. Quyết định đã xác nhận

| # | Câu hỏi | Quyết định |
|---|---------|-----------|
| 1 | Hành vi khi hết đếm ngược | Hardcode cố định, không cần xử lý trạng thái hết hạn |
| 2 | Feature flag Kudos | Dựa vào backend — gọi API kiểm tra, nếu không có thì ẩn section |
| 3 | Số lượng danh mục giải | Hardcode 6 giải (Top Talent, Top Project, Top Project Leader, Best Manager, MVP, Signature 2025 Creator) |
| 4 | Link livestream | Không nhấn được — chỉ hiển thị text tĩnh |
| 5 | Header scroll behavior | Có thay đổi opacity/ẩn dần khi cuộn xuống |
| 6 | Ngôn ngữ hỗ trợ | 2 ngôn ngữ: VN và EN (sử dụng slang) |
| 7 | Hero image source | Asset tĩnh đóng gói trong app (không tải từ API) |
| 8 | Asset referencing | Sử dụng flutter_gen type-safe access (`Assets.xxx`), không hardcode path string (constitution v1.3.0) |
