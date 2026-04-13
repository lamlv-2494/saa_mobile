# Đặc tả tính năng: [iOS] Sun*Kudos - Tất cả Kudos

**Frame ID**: `j_a2GQWKDJ`
**Frame Name**: `[iOS] Sun*Kudos_All Kudos`
**File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Ngày tạo**: 2026-04-13
**Trạng thái**: Đã review (2026-04-13)

---

## Tổng quan

Màn hình **All Kudos** là trang hiển thị danh sách toàn bộ kudos trong hệ thống Sun* Annual Awards 2025. Đây là màn hình chi tiết mà người dùng truy cập từ nút "Xem tất cả" trên màn hình chính Kudos (`fO0Kt19sZZ`). Màn hình hiển thị danh sách kudos dạng scrollable theo thứ tự thời gian, mỗi kudos gồm thông tin người gửi/nhận, nội dung, hashtag và các hành động tương tác.

**Đối tượng sử dụng**: Nhân viên Sun* (Sunner) đã đăng nhập vào ứng dụng.

**Bối cảnh kinh doanh**: Cho phép người dùng duyệt và khám phá toàn bộ lời cảm ơn trong tổ chức, tăng cường văn hóa ghi nhận lẫn nhau.

---

## Kịch bản người dùng & Kiểm thử *(bắt buộc)*

### User Story 1 - Xem danh sách tất cả Kudos (Ưu tiên: P1)

Là một Sunner, tôi muốn xem danh sách tất cả các kudos để khám phá các lời cảm ơn trong toàn bộ tổ chức.

**Lý do ưu tiên**: Đây là chức năng cốt lõi của màn hình — nếu không hiển thị được danh sách kudos, màn hình mất ý nghĩa.

**Kiểm thử độc lập**: Có thể test bằng cách mở màn hình và verify danh sách kudos hiển thị đúng với dữ liệu mock.

**Kịch bản chấp nhận**:

1. **Cho biết** người dùng đã đăng nhập và có ít nhất 1 kudos, **Khi** mở màn hình All Kudos, **Thì** hiển thị danh sách kudos theo thứ tự thời gian mới nhất trước, mỗi thẻ gồm: avatar/tên/phòng ban/danh hiệu người gửi, icon mũi tên, avatar/tên/phòng ban/danh hiệu người nhận, thời gian, tiêu đề (nếu có), nội dung, hashtag, số lượt heart, nút "Copy Link" và nút "Xem chi tiết".
2. **Cho biết** danh sách kudos có nhiều hơn 1 trang, **Khi** người dùng cuộn xuống cuối danh sách, **Thì** tự động tải thêm kudos tiếp theo (infinite scroll / pagination).
3. **Cho biết** không có kudos nào trong hệ thống, **Khi** mở màn hình, **Thì** hiển thị empty state phù hợp.

---

### User Story 2 - Điều hướng và quay lại (Ưu tiên: P1)

Là một Sunner, tôi muốn có thể quay lại màn hình trước đó để tiếp tục sử dụng app bình thường.

**Lý do ưu tiên**: Navigation là yêu cầu cơ bản của mọi màn hình — không thể sử dụng được nếu không có.

**Kiểm thử độc lập**: Có thể test bằng cách bấm nút back và verify đã quay lại đúng màn hình trước.

**Kịch bản chấp nhận**:

1. **Cho biết** người dùng ở màn hình All Kudos, **Khi** bấm nút back (mũi tên trái) trên TopNavigation, **Thì** quay lại màn hình Kudos chính (`fO0Kt19sZZ`).
2. **Cho biết** người dùng ở màn hình All Kudos, **Khi** vuốt từ mép trái màn hình (iOS swipe back), **Thì** quay lại màn hình trước.

---

### User Story 3 - Tương tác Heart (thả tim) (Ưu tiên: P2)

Là một Sunner, tôi muốn thả tim (heart) cho kudos để thể hiện sự đồng tình với lời cảm ơn.

**Lý do ưu tiên**: Đây là tương tác chính giúp tăng engagement nhưng không phải chức năng thiết yếu để xem danh sách.

**Kiểm thử độc lập**: Có thể test bằng cách bấm nút heart trên một kudos card và verify số lượt heart tăng lên.

**Kịch bản chấp nhận**:

1. **Cho biết** người dùng chưa heart một kudos và có quyền heart, **Khi** bấm icon heart, **Thì** số heart tăng 1, icon chuyển trạng thái đã heart, và gửi API cập nhật.
2. **Cho biết** người dùng đã heart một kudos, **Khi** bấm icon heart lần nữa, **Thì** số heart giảm 1, icon chuyển về trạng thái chưa heart.
3. **Cho biết** người dùng không có quyền heart (ví dụ: chính mình gửi), **Khi** nhìn icon heart, **Thì** icon heart bị disable, không thể bấm.

---

### User Story 4 - Sao chép liên kết kudos (Ưu tiên: P2)

Là một Sunner, tôi muốn sao chép liên kết chia sẻ kudos để gửi cho đồng nghiệp.

**Lý do ưu tiên**: Tính năng bổ trợ giúp lan tỏa kudos nhưng không phải chức năng cốt lõi.

**Kiểm thử độc lập**: Có thể test bằng cách bấm "Copy Link" và verify clipboard chứa đúng URL.

**Kịch bản chấp nhận**:

1. **Cho biết** kudos có shareUrl hợp lệ, **Khi** bấm "Copy Link", **Thì** sao chép URL vào clipboard và hiển thị snackbar xác nhận.
2. **Cho biết** kudos không có shareUrl, **Khi** nhìn nút "Copy Link", **Thì** nút bị ẩn hoặc disable.

---

### User Story 5 - Xem chi tiết kudos (Ưu tiên: P2)

Là một Sunner, tôi muốn xem chi tiết một kudos để đọc toàn bộ nội dung và thông tin liên quan.

**Lý do ưu tiên**: Bổ trợ cho trường hợp nội dung kudos bị cắt ngắn trên danh sách.

**Kiểm thử độc lập**: Có thể test bằng cách bấm "Xem chi tiết" và verify navigation đến màn hình chi tiết.

**Kịch bản chấp nhận**:

1. **Cho biết** người dùng đang xem danh sách kudos, **Khi** bấm "Xem chi tiết" trên một thẻ kudos thường, **Thì** điều hướng đến màn hình chi tiết kudos (`T0TR16k0vH`) với đầy đủ thông tin.
2. **Cho biết** người dùng bấm "Xem chi tiết" trên thẻ kudos có `isAnonymous=true`, **Thì** điều hướng đến cùng màn hình chi tiết kudos (`T0TR16k0vH`) nhưng thông tin người gửi bị ẩn (hiển thị tên ẩn danh, avatar mặc định).

---

### User Story 6 - Xem hồ sơ người gửi/nhận (Ưu tiên: P3)

Là một Sunner, tôi muốn bấm vào avatar người gửi hoặc người nhận để xem hồ sơ của họ.

**Lý do ưu tiên**: Tính năng nâng cao, tăng trải nghiệm khám phá nhưng có thể bổ sung sau.

**Kiểm thử độc lập**: Có thể test bằng cách bấm avatar và verify navigation.

**Kịch bản chấp nhận**:

1. **Cho biết** người dùng đang xem danh sách, **Khi** bấm vào avatar người gửi hoặc người nhận, **Thì** điều hướng đến trang hồ sơ của người đó.

---

### User Story 7 - Kéo để làm mới danh sách (Ưu tiên: P2)

Là một Sunner, tôi muốn kéo xuống để làm mới danh sách kudos để xem các kudos mới nhất.

**Lý do ưu tiên**: Pattern phổ biến trên mobile, người dùng kỳ vọng có tính năng này.

**Kiểm thử độc lập**: Có thể test bằng cách pull-to-refresh và verify danh sách được tải lại từ đầu.

**Kịch bản chấp nhận**:

1. **Cho biết** người dùng đang xem danh sách kudos, **Khi** kéo xuống (pull-to-refresh), **Thì** danh sách được tải lại từ trang 1, hiển thị refresh indicator.
2. **Cho biết** đang pull-to-refresh, **Khi** tải xong, **Thì** refresh indicator biến mất, danh sách hiện dữ liệu mới nhất, cuộn về đầu trang.

---

### Edge Cases

- **Mất mạng khi tải trang đầu**: Hiển thị error state toàn màn hình với nút "Thử lại".
- **Mất mạng khi tải thêm (infinite scroll)**: Hiển thị thông báo lỗi ở cuối danh sách, nút "Thử lại", danh sách đã tải vẫn hiện.
- **Mất mạng khi pull-to-refresh**: Hiển thị snackbar lỗi, giữ dữ liệu cũ.
- **Mất mạng khi toggle heart**: Optimistic update rồi rollback nếu API fail, hiện snackbar lỗi.
- **Kudos bị xóa sau khi đã hiển thị**: Xử lý graceful khi API 404, xóa khỏi danh sách.
- **Nội dung kudos quá dài**: Truncate nội dung với "..." (maxLines: 3), bấm "Xem chi tiết" để xem đầy đủ.
- **Người gửi ẩn danh (anonymous)**: Hiển thị text ẩn danh (từ i18n `t.kudos.anonymous`), avatar mặc định (chữ cái "?"), ẩn department và badge.
- **Danh sách rỗng sau khi tải xong**: Hiển thị empty state với thông điệp khuyến khích gửi kudos.
- **Người dùng cuộn nhanh**: Không gọi API trùng lặp — debounce hoặc lock pagination request.

---

## Yêu cầu UI/UX *(từ Figma)*

### Các thành phần màn hình

| Thành phần | Mô tả | Tương tác |
|-----------|-------------|--------------|
| TopNavigation | Thanh navigation trên cùng gồm nút back và tiêu đề "All Kudos" | Bấm nút back để quay lại |
| Header Section | Hiển thị "Sun* Annual Awards 2025" và "ALL KUDOS" | Chỉ hiển thị |
| Kudos Card List | Danh sách dọc các thẻ kudos, gap 12px | Cuộn, infinite scroll, pull-to-refresh |
| Sender/Receiver Header | Layout cột: avatar trên, tên + phòng ban + danh hiệu dưới. Sender (trái) → icon mũi tên → Receiver (phải) | Bấm avatar để xem profile |
| Nội dung Card | Thời gian, tiêu đề category (in đậm, center), nội dung text trong khung viền vàng, hashtag | Bấm để xem chi tiết |
| Action Bar | Số heart + icon heart, "Copy Link" + icon, "Xem chi tiết" + icon arrow | Bấm từng action tương ứng |
| Bottom Navigation Bar | 4 tab: SAA (Home), Awards, Kudos (active), Profile | Bấm tab để chuyển section |
| Background | Nền tối (#00101A) với key visual và gradient overlay | Chỉ hiển thị |
| Loading State | Skeleton/shimmer placeholder khi đang tải dữ liệu lần đầu | Chỉ hiển thị |
| Error State | Thông báo lỗi + nút "Thử lại" khi API fail | Bấm "Thử lại" |
| Empty State | Thông điệp "Chưa có kudos nào" khi danh sách rỗng | Chỉ hiển thị |

### Luồng điều hướng

- **Từ (entry points)**:
  - Màn hình Kudos chính (`fO0Kt19sZZ`) — bấm "Xem tất cả" ở section All Kudos
  - Màn hình Home (`OuH1BUTYT0`) — bấm FAB Kudos icon
- **Đến (exit points)**:
  - Màn hình chi tiết Kudos (`T0TR16k0vH`) — bấm "Xem chi tiết" (dùng chung cho cả kudos thường và ẩn danh, `isAnonymous` quyết định hiển thị)
  - Trang hồ sơ người khác (`bEpdheM0yU`) — bấm avatar/tên người gửi hoặc nhận
  - Bottom Nav: Home (`OuH1BUTYT0`), Awards, Kudos (`_b68CBWKl5`), Profile (`hSH7L8doXB`)
- **Quay lại**: Nút back trên TopNavigation hoặc iOS swipe back gesture → quay về màn hình gọi (Home hoặc Kudos chính)

### Yêu cầu hiển thị

- Chỉ hỗ trợ mobile (iOS/Android), không cần responsive cho tablet/desktop
- Transition: slide từ phải sang trái khi mở, ngược lại khi quay lại
- Accessibility: Hỗ trợ screen reader cho tất cả nút bấm và link

> Chi tiết về design style xem tại [design-style.md](design-style.md)

---

## Yêu cầu *(bắt buộc)*

### Yêu cầu chức năng

- **FR-001**: Hệ thống PHẢI hiển thị danh sách toàn bộ kudos theo thứ tự thời gian mới nhất trước.
- **FR-002**: Hệ thống PHẢI hỗ trợ phân trang (pagination / infinite scroll) khi danh sách dài.
- **FR-003**: Mỗi thẻ kudos PHẢI hiển thị đầy đủ: thông tin người gửi/nhận, thời gian, nội dung, hashtag, và các action.
- **FR-004**: Người dùng PHẢI có thể thả/bỏ heart cho kudos.
- **FR-005**: Người dùng PHẢI có thể sao chép liên kết chia sẻ kudos.
- **FR-006**: Người dùng PHẢI có thể xem chi tiết kudos.
- **FR-007**: Người dùng PHẢI có thể quay lại màn hình trước qua nút back hoặc gesture.
- **FR-008**: Hệ thống PHẢI hiển thị danh hiệu (badge) của người dùng nếu có.

### Yêu cầu kỹ thuật

- **TR-001**: Thời gian tải trang đầu tiên PHẢI dưới 2 giây trên mạng 4G.
- **TR-002**: Infinite scroll PHẢI tải thêm dữ liệu trước khi người dùng cuộn hết danh sách (pre-fetch).
- **TR-003**: Hệ thống PHẢI cache danh sách kudos đã tải để tránh tải lại khi quay lại.
- **TR-004**: Tuân thủ kiến trúc MVVM + Riverpod theo constitution.

### Thực thể dữ liệu chính

- **Kudos**: Lời cảm ơn — gồm id, sender, receiver, content, hashtags, heartCount, createdAt, isHighlight, isAnonymous, isLikedByMe, canLike, shareUrl. **Cần thêm field `category` (String?)** — backend trả về tiêu đề category (ví dụ: "IDOL GIỚI TRẺ") cho mỗi kudos.
- **UserSummary**: Thông tin tóm tắt người dùng — gồm id, name, avatar, department, badgeLevel (int). **Cần thêm field `badgeName` (String)** — backend trả về cả tên badge ("Rising Hero", "Legend Hero") cùng với level.
- **Hashtag**: Tag gắn với kudos — gồm id, name.

### Quản lý State

- **ViewModel**: Màn hình All Kudos là feature riêng biệt, PHẢI có ViewModel riêng `AllKudosViewModel extends AsyncNotifier<AllKudosState>` — KHÔNG tái sử dụng `KudosViewModel`. State model `AllKudosState` chỉ chứa dữ liệu cần thiết cho danh sách (không bao gồm highlight, spotlight, personal stats).
- **Local state**:
  - Vị trí cuộn (scroll position) — để quay lại đúng chỗ khi navigate back
  - Pull-to-refresh indicator (đang refresh hay không)
  - Pagination loading indicator (đang tải trang tiếp theo hay không)
- **Global state** (qua Riverpod):
  - Danh sách kudos (`List<Kudos>`)
  - Pagination cursor (`hasMoreKudos`, `currentPage`)
- **Loading states**:
  - **Initial load**: Hiện skeleton/shimmer placeholder cho 3-4 card giả lập
  - **Pagination load**: Hiện loading indicator ở cuối danh sách
  - **Refresh load**: Hiện refresh indicator (pull-to-refresh)
  - **Heart toggle**: Optimistic update (không cần loading indicator)
- **Error states**:
  - **Initial load fail**: Hiện error state toàn màn hình + nút "Thử lại"
  - **Pagination fail**: Hiện lỗi ở cuối danh sách + nút "Thử lại", dữ liệu cũ vẫn hiện
  - **Heart API fail**: Rollback optimistic update + snackbar lỗi

---

## API Dependencies

| Endpoint | Method | Mục đích | Trạng thái |
|----------|--------|---------|--------|
| /rest/v1/kudos | GET | Lấy danh sách kudos phân trang (query: page, limit, sort) | Dự đoán |
| /rest/v1/kudos/{id}/heart | POST | Thả heart cho kudos | Dự đoán |
| /rest/v1/kudos/{id}/heart | DELETE | Bỏ heart cho kudos | Dự đoán |

---

## Tiêu chí thành công *(bắt buộc)*

### Kết quả đo lường được

- **SC-001**: Danh sách kudos hiển thị đúng dữ liệu từ API, không thiếu trường nào.
- **SC-002**: Infinite scroll hoạt động mượt, không bị giật hay tải lại toàn bộ danh sách.
- **SC-003**: Tất cả tương tác (heart, copy link, xem chi tiết, back) hoạt động đúng.
- **SC-004**: Empty state hiển thị khi không có dữ liệu.

---

## Ngoài phạm vi

- Tính năng lọc/tìm kiếm kudos — **xác nhận: không có filter** trên màn hình All Kudos.
- Tính năng gửi kudos mới (đã có trên màn hình chính).
- Màn hình chi tiết kudos (spec riêng, chung cho cả kudos thường và ẩn danh).
- Trang hồ sơ người dùng (spec riêng).

---

## Phụ thuộc

- [x] Constitution document tồn tại (`.momorph/constitution.md`)
- [ ] API specifications có sẵn (`.momorph/API.yml`)
- [ ] Database design hoàn thành (`.momorph/database.sql`)
- [x] Screen flow được tài liệu hóa (`.momorph/contexts/SCREENFLOW.md`)
- [x] Spec màn hình Kudos chính (`.momorph/specs/fO0Kt19sZZ-ios-sun-kudos/spec.md`)

---

## Quyết định đã xác nhận *(2026-04-13)*

| # | Câu hỏi | Quyết định |
|---|---------|-----------|
| Q1 | Tiêu đề card (ví dụ: "IDOL GIỚI TRẺ") | Backend trả về field `category` — thêm vào model `Kudos` |
| Q2 | Có filter trên All Kudos không? | **Không** — màn hình này không có filter |
| Q3 | Kudos ẩn danh navigate đến đâu? | Chung 1 màn chi tiết (`T0TR16k0vH`), chỉ ẩn thông tin sender nếu `isAnonymous=true` |
| Q4 | Card width 274px cố định? | **Scale responsive**: `width = screenWidth - 2 * horizontalPadding` |
| Q5 | Font size 10px (Figma) hay 14px (code)? | **Giữ theo Figma** (10px) — cần cập nhật code hiện tại |
| Q6 | ViewModel riêng hay tái sử dụng? | **Feature riêng biệt** — tạo `AllKudosViewModel` + `AllKudosState`, không dùng chung `KudosViewModel` |
| Q7 | `UserSummary.badgeName`? | **Backend trả về** tên badge — thêm field `badgeName` (String) vào model |

---

## Ghi chú

- **Feature riêng biệt**: All Kudos là feature/module riêng với ViewModel, State, Screen riêng. Không tái sử dụng `KudosViewModel`.
- **Widget mới cần tạo**: Do layout Sender/Receiver trên Figma dùng layout **cột** (avatar trên, tên + dept dưới) khác hoàn toàn với code hiện tại (layout hàng), cần tạo widget mới cho card trên màn hình này thay vì parameterize widget cũ. Card cũng có nền sáng (#FFF8E1) thay vì nền tối.
- **Responsive card width**: Card list width PHẢI scale theo `screenWidth - 2 * horizontalPadding`, KHÔNG cố định 274px.
- **Font size theo Figma**: Sử dụng font size 10px theo đúng thiết kế Figma. Code hiện tại (14px, 12px) là cho màn hình Home — không áp dụng cho màn này.
- **Model cần cập nhật**: Thêm `category` (String?) vào `Kudos`, thêm `badgeName` (String) vào `UserSummary`. Backend trả về cả hai field.
- Thiết kế Figma sử dụng cùng component KUDO Highlight (B.3) lặp lại — trên Figma gồm 4 card mẫu nhưng thực tế là danh sách dynamic.
- Nền tối (#00101A) với key visual background giống màn hình chính Kudos.
- **Bottom Navigation Bar** phải đồng bộ với các màn hình khác — tab Kudos nên ở trạng thái active.
- Badge danh hiệu (Rising Hero, Legend Hero) sử dụng nhiều layer gradient background — có thể cần image asset thay vì render bằng code.
