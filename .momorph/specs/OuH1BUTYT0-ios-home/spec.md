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
- Thì: Hiển thị logo "ROOT FURTHER", ngày sự kiện, địa điểm và thông tin livestream theo dữ liệu từ API

> **Giá trị mẫu trên thiết kế Figma**: ngày `26/12/2025`, địa điểm `Âu Cơ Art Center`, livestream note dưới dạng 2 dòng. Đây là dữ liệu mockup — giá trị thực sẽ do API `/event/info` trả về và có thể khác theo locale.

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
**Tôi muốn** xem bộ đếm ngược 20 ngày liên tục, bền vững qua các lần mở/đóng app
**Để** cảm nhận sự hào hứng và biết còn bao lâu nữa trước mốc tiếp theo

#### Kịch bản chấp nhận

**Kịch bản 1: Khởi tạo lần đầu**
- Cho: Người dùng mở app lần đầu (chưa có dữ liệu countdown lưu sẵn)
- Khi: Màn hình Home được tải
- Thì: Khởi tạo `countdownEndTime = now + 20 ngày` và lưu vào storage cục bộ (SharedPreferences), hiển thị DAYS/HOURS/MINUTES tương ứng

**Kịch bản 2: Đếm ngược đang chạy**
- Cho: Storage đã có `countdownEndTime` trong tương lai
- Khi: Màn hình Home đang hiển thị
- Thì: Bộ đếm ngược tính `countdownEndTime - now` và cập nhật DAYS/HOURS/MINUTES mỗi giây theo thời gian thực

**Kịch bản 3: Kill app và mở lại**
- Cho: App đã bị kill ở trạng thái đếm ngược (ví dụ còn 12 ngày 05 giờ 30 phút)
- Khi: Người dùng mở lại app
- Thì: Đọc `countdownEndTime` từ storage, tính lại `countdownEndTime - now` và tiếp tục đếm từ giá trị đúng (không reset, không bị "đóng băng" theo thời gian app không chạy)

**Kịch bản 4: Reset khi về 0**
- Cho: `countdownEndTime <= now` (bộ đếm ngược đã về 0 hoặc qua hạn, có thể xảy ra khi đang mở app hoặc khi mở lại app sau nhiều ngày)
- Khi: ViewModel phát hiện `remaining <= 0`
- Thì: Tự động gán lại `countdownEndTime = now + 20 ngày`, ghi đè vào storage và bắt đầu chu kỳ đếm ngược 20 ngày mới (không hiển thị trạng thái "00 / 00 / 00" kéo dài)

**Kịch bản 5: Format chữ số 2 digit cố định**
- Cho: Giá trị DAYS/HOURS/MINUTES có thể trong khoảng 0–99
- Khi: Render các ô số countdown
- Thì: Luôn padLeft về đúng 2 chữ số (ví dụ `03` thay vì `3`). DAYS tối đa 20 nên không vượt 2 chữ số; HOURS (0–23), MINUTES (0–59) đều vừa 2 chữ số.

**Kịch bản 6: Label "Coming soon"**
- Cho: Khối countdown được render
- Khi: Bất kỳ trạng thái nào (chạy bình thường, sau khi reset)
- Thì: Hiển thị label tĩnh "Coming soon" (i18n key `t.home.comingSoon`) ở phía trên bộ đếm — không thay đổi theo giá trị countdown

**Kịch bản 7: Thiết bị đổi giờ hệ thống (clock tampering)**
- Cho: Người dùng chỉnh `DateTime.now()` của thiết bị tiến/lùi
- Khi: ViewModel tính `remaining = endTime - DateTime.now()`
- Thì:
  - Nếu giờ bị đẩy **lùi**: countdown có thể hiển thị tăng lên (≤ 20 ngày) — KHÔNG xử lý đặc biệt, chấp nhận behavior này (app không phải ứng dụng bảo mật giờ)
  - Nếu giờ bị đẩy **tiến** vượt `endTime`: kích hoạt Kịch bản 4 (auto reset 20 ngày)

> **Ghi chú kỹ thuật:**
> - Persist bằng `SharedPreferences` với key `home_countdown_end_time`, giá trị ISO-8601 string (ví dụ `"2026-05-07T10:30:00.000Z"`) dùng `DateTime.toIso8601String()` / `DateTime.parse()` để tránh lệch timezone.
> - Dùng `Timer.periodic(Duration(seconds: 1))` làm **nguồn tick** để re-build UI; bên trong mỗi tick PHẢI tính `endTime.difference(DateTime.now())` chứ KHÔNG được giảm counter cục bộ — tránh lệch khi app bị tạm dừng (background/suspended).
> - Khi widget `dispose`, PHẢI `cancel()` Timer để tránh memory leak.

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
- Bộ đếm ngược: KHÔNG announce cho screen reader mỗi giây (tránh spam). Chỉ announce khi phút (MINUTES) thay đổi — dùng `Semantics(liveRegion: true)` trên khối MINUTES. DAYS/HOURS có thể không cần announce liên tục, chỉ đọc khi user focus thủ công.

---

## 4. Yêu cầu dữ liệu

### 4.1 Trường nhập liệu
Không có — Màn hình Home chỉ hiển thị và điều hướng.

### 4.2 Trường hiển thị

| Trường | Nguồn | Kiểu | Ghi chú |
|--------|-------|------|---------|
| Ảnh nền hero (Key Visual) | Asset tĩnh (bundled) | Image | `Assets.images.keyVisualBg` — background hero, gradient overlay |
| Logo chủ đề sự kiện | Asset tĩnh | Image | `Assets.images.rootFurtherLogo` — branding "ROOT FURTHER" |
| Ngày sự kiện | API | DateTime | Định dạng: dd/MM/yyyy (chỉ để hiển thị "Event Date", KHÔNG dùng cho countdown) |
| Địa điểm sự kiện | API | String | Tên địa điểm |
| Thông tin livestream | API | String | Text tĩnh, KHÔNG nhấn được (chỉ hiển thị, không link) |
| Bộ đếm ngược | Storage cục bộ (SharedPreferences) | Days/Hours/Minutes | Tính từ `countdownEndTime - now`, chu kỳ 20 ngày, tự reset khi về 0 |
| Mô tả chủ đề | API (`/event/info?locale={vi\|en}`) | String | `themeDescription` — đoạn text dài về Root Further, đa ngôn ngữ theo locale |
| Danh mục giải thưởng | API | List\<Award\> | name, image, description |
| Thông tin phần Kudos | API / Tĩnh | Object | banner, title, description |
| Số thông báo | API | Integer | Số chưa đọc cho badge |

### 4.3 Storage Schema (Persistence cục bộ)

| Key | Loại | Type | Mục đích | Khởi tạo / Reset |
|-----|------|------|----------|------------------|
| `home_countdown_end_time` | `SharedPreferences` | `String` (ISO-8601 DateTime) | Thời điểm kết thúc chu kỳ đếm ngược 20 ngày | Tạo lần đầu khi mount Home và chưa tồn tại. Ghi đè mỗi khi chu kỳ reset. **Clear khi user logout.** |

> **Format**: `DateTime.toIso8601String()` khi ghi, `DateTime.parse()` khi đọc. Nếu giá trị đọc không parse được → xem như chưa tồn tại, tái khởi tạo.
>
> **Scope**: Per-session. Logout flow PHẢI gọi `prefs.remove('home_countdown_end_time')` để account kế tiếp (hoặc login lại) bắt đầu chu kỳ mới.

### 4.4 Data Models (Dự kiến)

```dart
// Thông tin sự kiện (sử dụng freezed theo constitution)
@freezed
class EventInfo with _$EventInfo {
  const factory EventInfo({
    required String themeName,
    required DateTime eventDate, // CHỈ để format hiển thị "Thời gian: dd/MM/yyyy" — KHÔNG dùng cho countdown (xem US2)
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
- **Widget `CountdownTimerWidget` (StatefulWidget)** giữ:
  - `countdownEndTime` (DateTime) đọc qua `CountdownRepository` / ViewModel khi `initState`. Nếu chưa có trong storage → gọi service khởi tạo `now + 20 ngày` và persist.
  - `Timer.periodic(Duration(seconds: 1))` làm **nguồn tick** gọi `setState`; mỗi tick tính `endTime.difference(DateTime.now())` (KHÔNG decrement counter) → miễn nhiễm app suspension/background.
  - Khi `remaining <= 0` → gọi service để reset (`endTime = now + 20d`, persist) rồi `setState` với giá trị mới.
  - `dispose()` PHẢI cancel Timer.
- Vị trí cuộn hiện tại (cho hiệu ứng opacity header) — `ScrollController`
- Pull-to-refresh indicator state
- Index tab nav dưới đang chọn

> **Phân lớp (constitution compliance)**: Logic persist/read/reset countdown PHẢI nằm trong `CountdownRepository` (hoặc service tương đương) — widget chỉ gọi API của repository. Widget giữ tick Timer + render. Không truy cập `SharedPreferences` trực tiếp từ widget.

### 6.2 State toàn cục (Riverpod Providers)
- `homeViewModelProvider` — `AsyncNotifierProvider<HomeViewModel, HomeState>`:
  Quản lý tất cả data của Home trong 1 state model duy nhất (constitution v1.2.0):
  ```dart
  HomeState { eventInfo, awards, kudosInfo, unreadNotificationCount }
  ```
- `localeNotifierProvider` — `StateNotifierProvider<LocaleNotifier, Locale>` (shared)
- `currentTabIndexProvider` — `StateProvider<int>` — Tab nav dưới đang chọn

### 6.3 Yêu cầu Cache / Persistence
- Thông tin sự kiện: Cache trong phiên (ít thay đổi)
- Danh mục giải thưởng: Cache 5 phút (có thể cập nhật định kỳ)
- Thông tin Kudos: Cache trong phiên
- Số thông báo: Làm mới khi focus màn hình / pull-to-refresh
- **Countdown endTime**: Persist per-session trong `SharedPreferences` với key `home_countdown_end_time` (giá trị ISO-8601 string). Được rehydrate mỗi lần màn hình Home mount; được ghi lại khi reset (về 0) hoặc khi khởi tạo lần đầu. **PHẢI được xóa (`prefs.remove`) trong logout flow** để account kế tiếp bắt đầu chu kỳ 20 ngày mới.

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
| I. Kiến trúc MVVM | `HomeViewModel` xử lý API calls (event/awards/kudos/notifications). `CountdownRepository` (tách riêng) xử lý đọc/ghi/reset `countdownEndTime` qua `SharedPreferences`. `CountdownTimerWidget` (StatefulWidget) chỉ giữ Timer tick + gọi repository API. Screen chỉ render UI. |
| II. Clean Code | Widget nhỏ, không hardcode (theme colors, i18n cho text). Asset paths qua flutter_gen (`Assets.xxx`), không hardcode string. |
| III. Test-First | Unit tests `CountdownRepository` cover: (a) load/save `countdownEndTime` qua `SharedPreferences` (dùng `SharedPreferences.setMockInitialValues`), (b) khởi tạo lần đầu khi storage rỗng, (c) parse lỗi → tái khởi tạo, (d) auto-reset khi endTime ≤ now, (e) clear key khi logout. Unit tests cho logic tick: tính `remaining` đúng khi endTime tương lai, clock tampering (giờ bị đẩy tiến/lùi). Widget tests cover render countdown, label "Coming soon", tap CTA. ViewModel tests cho 4 API + locale reload. |
| IV. Chất lượng Code | Lint rules, format, không dùng deprecated APIs. |
| V. Dependencies | Chỉ dùng packages đã duyệt (Riverpod, go_router, freezed, dio). |

---

## 9. Quyết định đã xác nhận

| # | Câu hỏi | Quyết định |
|---|---------|-----------|
| 1 | Hành vi bộ đếm ngược | Đếm ngược cố định 20 ngày. Thời điểm kết thúc (`countdownEndTime`) được lưu trong SharedPreferences; kill/mở lại app vẫn đếm tiếp đúng. Khi về 0 thì auto reset lại 20 ngày (ghi đè `countdownEndTime = now + 20d`). Không liên quan tới ngày sự kiện từ API. |
| 2 | Feature flag Kudos | Dựa vào backend — gọi API kiểm tra, nếu không có thì ẩn section |
| 3 | Số lượng danh mục giải | Hardcode 6 giải (Top Talent, Top Project, Top Project Leader, Best Manager, MVP, Signature 2025 Creator) |
| 4 | Link livestream | Không nhấn được — chỉ hiển thị text tĩnh |
| 5 | Header scroll behavior | Có thay đổi opacity/ẩn dần khi cuộn xuống |
| 6 | Ngôn ngữ hỗ trợ | 2 ngôn ngữ: VN và EN (sử dụng slang) |
| 7 | Hero image source | Asset tĩnh đóng gói trong app (không tải từ API) |
| 8 | Asset referencing | Sử dụng flutter_gen type-safe access (`Assets.xxx`), không hardcode path string (constitution v1.3.0) |
| 9 | Label "Coming soon" trên countdown | Giữ nguyên text "Coming soon" ở cả VN và EN (không dịch). Key i18n có thể vẫn là `t.home.comingSoon` nhưng cùng value cho 2 locale. |
| 10 | Manual reset countdown (debug/QA) | KHÔNG cần — chỉ dựa vào cơ chế reset tự nhiên (về 0) hoặc xóa app/clear app data để test. |
| 11 | Countdown persistence scope | Per-session (tied to auth). Khi user logout → PHẢI clear key `home_countdown_end_time` khỏi SharedPreferences. Khi user login lại (cùng hoặc khác account) và mount Home lần đầu → khởi tạo mới `now + 20 ngày`. |
