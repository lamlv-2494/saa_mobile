# Đặc tả tính năng: [iOS] Sun*Kudos - Màn hình chính Kudos

**Frame ID**: `fO0Kt19sZZ`
**Frame Name**: `[iOS] Sun*Kudos`
**File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Ngày tạo**: 2026-04-13
**Trạng thái**: Đã review (2026-04-13)

---

## Tổng quan

Màn hình chính **Sun*Kudos** là trang feed của hệ thống ghi nhận và cảm ơn (Kudos) trong ứng dụng Sun* Annual Awards 2025. Đây là màn hình trung tâm nơi nhân viên (Sunner) có thể xem các kudos nổi bật, mạng lưới kết nối spotlight, tất cả các kudos, và thống kê cá nhân. Người dùng cũng có thể gửi kudos mới từ nút CTA ngay trên hero banner.

**Đối tượng sử dụng**: Nhân viên Sun* (Sunner) đã đăng nhập vào ứng dụng.

**Bối cảnh kinh doanh**: Đây là trang chính của chương trình Sun* Annual Awards 2025 — nơi khuyến khích văn hóa ghi nhận lẫn nhau giữa các đồng nghiệp.

---

## Kịch bản người dùng & Kiểm thử *(bắt buộc)*

### User Story 1 - Xem Highlight Kudos (Ưu tiên: P1)

Là một Sunner, tôi muốn xem các lời cảm ơn (kudos) nổi bật nhất để cảm nhận được sự ghi nhận trong tổ chức và lấy cảm hứng.

**Lý do ưu tiên**: Đây là nội dung chính trên màn hình, thu hút người dùng ngay khi mở app. Highlight Kudos hiển thị top 5 kudos được yêu thích nhất.

**Kiểm thử độc lập**: Có thể kiểm thử bằng cách hiển thị carousel với dữ liệu mock mà không cần các section khác.

**Kịch bản chấp nhận**:

1. **Cho biết** người dùng đã đăng nhập và có ít nhất 1 kudos highlight, **Khi** mở màn hình Sun*Kudos, **Thì** hiển thị carousel Highlight Kudos với tối đa 5 thẻ kudos, mỗi thẻ gồm: avatar/tên người gửi, avatar/tên người nhận, nội dung, hashtag, thời gian, số lượt heart, và nút "Xem chi tiết".
2. **Cho biết** carousel đang hiển thị thẻ thứ 2/5, **Khi** bấm nút mũi tên phải (next), **Thì** chuyển sang thẻ thứ 3/5 và cập nhật chỉ số trang.
3. **Cho biết** carousel đang ở thẻ cuối cùng (5/5), **Khi** bấm nút mũi tên phải, **Thì** nút bị disable/ẩn và không chuyển trang.
4. **Cho biết** không có kudos highlight nào, **Khi** mở màn hình, **Thì** hiển thị empty state: "Hiện tại chưa có Kudos nào."

---

### User Story 2 - Gửi Kudos mới (Ưu tiên: P1)

Là một Sunner, tôi muốn gửi lời cảm ơn (kudos) đến đồng nghiệp để ghi nhận đóng góp của họ.

**Lý do ưu tiên**: Đây là action chính (primary CTA) của toàn bộ hệ thống — nếu không gửi được kudos thì tính năng mất ý nghĩa.

**Kiểm thử độc lập**: Có thể test bằng cách bấm nút CTA và verify navigation sang màn hình gửi kudos.

**Kịch bản chấp nhận**:

1. **Cho biết** người dùng ở màn hình Sun*Kudos, **Khi** bấm nút "Hôm nay, bạn muốn gửi kudos đến ai?", **Thì** điều hướng sang màn hình gửi kudos (screenId: `PV7jBVZU1N`).
2. **Cho biết** nút CTA luôn hiển thị trên hero banner, **Khi** trang được load, **Thì** nút CTA luôn ở trạng thái enabled (không có điều kiện disable).

---

### User Story 3 - Lọc Highlight Kudos theo Hashtag và Phòng ban (Ưu tiên: P2)

Là một Sunner, tôi muốn lọc các kudos highlight theo hashtag hoặc phòng ban để tìm nội dung phù hợp với quan tâm của tôi.

**Lý do ưu tiên**: Tăng trải nghiệm khám phá, nhưng người dùng vẫn xem được kudos mà không cần filter.

**Kiểm thử độc lập**: Có thể test bằng cách chọn filter và verify danh sách kudos thay đổi.

**Kịch bản chấp nhận**:

1. **Cho biết** người dùng ở section Highlight Kudos, **Khi** bấm dropdown "Hashtag", **Thì** hiển thị danh sách hashtag để chọn (screenId: `V5GRjAdJyb`).
2. **Cho biết** người dùng đã chọn hashtag "#teamwork", **Khi** filter được áp dụng, **Thì** carousel chỉ hiển thị kudos có hashtag "#teamwork" và reset về thẻ 1.
3. **Cho biết** người dùng bấm dropdown "Phòng ban", **Khi** mở dropdown, **Thì** hiển thị danh sách phòng ban (screenId: `76k69LQPfj`).
4. **Cho biết** cả hai filter đều được chọn, **Khi** áp dụng, **Thì** kết quả là AND logic (cả hashtag và phòng ban phải khớp).

---

### User Story 4 - Xem Spotlight Board (Ưu tiên: P2)

Là một Sunner, tôi muốn xem mạng lưới kết nối kudos (spotlight board) để hiểu mối quan hệ ghi nhận trong tổ chức.

**Lý do ưu tiên**: Spotlight Board là tính năng unique tạo sự khác biệt, nhưng không phải core flow.

**Kiểm thử độc lập**: Có thể test bằng cách render network chart với dữ liệu graph.

**Kịch bản chấp nhận**:

1. **Cho biết** có dữ liệu kudos, **Khi** scroll đến section Spotlight Board, **Thì** hiển thị đồ thị mạng lưới (pan-zoom network chart) với tổng số kudos (ví dụ: "388 KUDOS").
2. **Cho biết** người dùng muốn tìm kiếm sunner trên spotlight, **Khi** bấm ô "Tìm kiếm sunner", **Thì** mở chức năng tìm kiếm (screenId: `3jgwke3E8O`).

---

### User Story 5 - Xem tất cả Kudos (Feed) (Ưu tiên: P1)

Là một Sunner, tôi muốn xem danh sách tất cả các kudos đã gửi để theo dõi hoạt động ghi nhận.

**Lý do ưu tiên**: Đây là nội dung feed chính của hệ thống, mang lại giá trị liên tục cho người dùng.

**Kiểm thử độc lập**: Có thể test bằng cách hiển thị danh sách kudos với pagination.

**Kịch bản chấp nhận**:

1. **Cho biết** người dùng scroll đến section "ALL KUDOS", **Khi** dữ liệu được load, **Thì** hiển thị danh sách kudos với thông tin: người gửi, người nhận, thời gian, nội dung, hashtag, số heart.
2. **Cho biết** danh sách kudos hiển thị, **Khi** bấm link "Xem tất cả", **Thì** điều hướng sang màn hình danh sách đầy đủ (screenId: `j_a2GQWKDJ`).
3. **Cho biết** mỗi kudos card, **Khi** hiển thị, **Thì** gồm: avatar + tên + danh hiệu người gửi → icon "sent" → avatar + tên + danh hiệu người nhận, thời gian, nội dung, hashtag, và nút tương tác (heart, copy link, chi tiết).

---

### User Story 6 - Xem thống kê cá nhân (Ưu tiên: P2)

Là một Sunner, tôi muốn xem thống kê cá nhân (số kudos nhận/gửi, hearts, hộp bí mật) để biết mức độ tham gia của mình.

**Lý do ưu tiên**: Thống kê cá nhân tăng sự gắn kết nhưng không ảnh hưởng đến core flow.

**Kiểm thử độc lập**: Có thể test bằng cách hiển thị block thống kê với dữ liệu user.

**Kịch bản chấp nhận**:

1. **Cho biết** người dùng scroll đến section thống kê, **Khi** hiển thị, **Thì** hiển thị các chỉ số: Số kudos nhận được, Số kudos đã gửi, Số hearts nhận được, Số hộp bí mật đã mở, Số hộp bí mật chưa mở.
2. **Cho biết** có badge "x2 Fire Bonus", **Khi** hiển thị, **Thì** badge bonus xuất hiện bên cạnh chỉ số tương ứng.
3. **Cho biết** người dùng muốn mở hộp bí mật, **Khi** bấm nút "Mở hộp bí mật", **Thì** điều hướng sang màn hình Open secret box (screenId: `kQk65hSYF2`).

---

### User Story 7 - Xem 10 Sunner nhận quà mới nhất (Ưu tiên: P3)

Là một Sunner, tôi muốn xem danh sách 10 đồng nghiệp nhận quà gần đây nhất để biết ai vừa được ghi nhận.

**Lý do ưu tiên**: Tính năng social bổ sung, tạo cảm giác cộng đồng sôi nổi.

**Kiểm thử độc lập**: Có thể test bằng cách render danh sách 10 sunner với dữ liệu mock.

**Kịch bản chấp nhận**:

1. **Cho biết** có dữ liệu người nhận quà, **Khi** scroll đến section này, **Thì** hiển thị danh sách 10 sunner nhận quà gần đây nhất với avatar, tên, phòng ban, và thời gian nhận quà — sắp xếp theo thời gian mới nhất trước.

---

### Trường hợp biên (Edge Cases)

- Không có kudos nào trong hệ thống → Hiển thị empty state cho mỗi section.
- Mất kết nối mạng khi đang load → Hiển thị thông báo lỗi và nút retry.
- Carousel highlight có ít hơn 5 thẻ → Chỉ hiển thị số thẻ có sẵn, ẩn nút next nếu chỉ có 1 thẻ.
- Nội dung kudos quá dài → Truncate và hiển thị "..." với nút "Xem chi tiết".
- Pull-to-refresh → Reload toàn bộ dữ liệu màn hình (highlight, all kudos, stats).
- Heart toggle (đã like rồi bấm lại) → Unheart, giảm heartCount đi 1.
- Xóa filter (clear) → Quay về trạng thái mặc định (tất cả hashtag, tất cả phòng ban), carousel reset.
- Filter không có kết quả → Hiển thị empty state trong carousel: "Không tìm thấy Kudos phù hợp."
- Spotlight board không có dữ liệu → Hiển thị empty network chart với text "Chưa có dữ liệu."
- Người dùng bấm vào avatar trên kudos card → Điều hướng sang profile người đó (screenId: `bEpdheM0yU`).

---

## Yêu cầu UI/UX *(từ Figma)*

### Thành phần màn hình

| Thành phần | Mô tả | Tương tác |
|-----------|-------|-----------|
| A. KV Kudos (Hero Banner) | Banner chính với tagline + logo KUDOS + ảnh nền trang trí | Chỉ hiển thị |
| A.1. Button ghi nhận (CTA) — Hero | Nút "Hôm nay, bạn muốn gửi kudos đến ai?" với icon bút chì, nằm trên hero banner | Bấm → Mở màn hình gửi kudos (screenId: `PV7jBVZU1N`) |
| A.1'. Button ghi nhận (CTA) — Feed bottom | Cùng style với A.1, xuất hiện lần nữa ở cuối feed để người dùng dễ truy cập sau khi scroll | Bấm → Mở màn hình gửi kudos (screenId: `PV7jBVZU1N`) |
| B. Highlight Section | Container chứa carousel kudos nổi bật | Layout container |
| B.1. Highlight Header | Tiêu đề "HIGHLIGHT KUDOS" + 2 dropdown button filter | Chứa 2 dropdown buttons |
| B.1.1. Dropdown Button "Hashtag" | Button dạng outlined với icon dropdown, label "Hashtag", width 129px. Khi đã chọn filter thì hiển thị tên hashtag thay cho placeholder. | Bấm → Mở overlay dropdown list hashtag (screenId: `V5GRjAdJyb`). Chọn xong → đóng dropdown, áp dụng filter, carousel reset về trang 1. |
| B.1.2. Dropdown Button "Phòng ban" | Button dạng outlined với icon dropdown, label "Phòng ban", width auto (fit content). Cùng style với B.1.1. Khi đã chọn filter thì hiển thị tên phòng ban thay cho placeholder. | Bấm → Mở overlay dropdown list phòng ban (screenId: `76k69LQPfj`). Chọn xong → đóng dropdown, áp dụng filter, carousel reset về trang 1. |
| B.2. Highlight Kudos Card Area | Carousel chứa tối đa 5 thẻ kudos | Vuốt/swipe hoặc bấm nút điều hướng |
| B.3. KUDO Highlight Card | Thẻ kudos nổi bật với sender/receiver/content | Bấm "Xem chi tiết" → Chi tiết kudos |
| B.5. Slide Indicator | Chỉ số trang carousel (ví dụ: "2/5") với nút prev/next | Bấm nút điều hướng |
| B.6. Spotlight Board Header | Tiêu đề "SPOTLIGHT BOARD" | Chỉ hiển thị |
| B.7. Spotlight Section | Đồ thị mạng lưới pan-zoom + ô tìm kiếm sunner | Pan/zoom đồ thị, tìm kiếm |
| C. All Kudos Section | Container cho khu vực "ALL KUDOS" gồm header + 3 sub-sections theo thứ tự bên dưới | Scroll, bấm "Xem tất cả" |
| C.1. ALL KUDOS Header | Tiêu đề "ALL KUDOS" + link "Xem tất cả" | Bấm "Xem tất cả" → All Kudos screen |
| D.1. Personal Statistics Block | **Thứ tự 1**: Thống kê cá nhân — kudos nhận/gửi, hearts, hộp bí mật đã mở/chưa mở | Bấm "Mở hộp bí mật" → Navigation |
| D.3. 10 Sunner nhận quà mới nhất | **Thứ tự 2**: Danh sách 10 sunner nhận quà gần đây nhất, sort by thời gian DESC | Chỉ hiển thị |
| C.3. Bài đăng KUDO | **Thứ tự 3**: Danh sách feed kudos (infinite scroll) | Bấm heart, copy link, xem chi tiết |
| Nav Bar | Thanh điều hướng bottom tab | Chuyển tab |

### Luồng điều hướng

- **Từ**: [iOS] Home (screenId: `OuH1BUTYT0`) hoặc bottom tab bar
- **Đến**:
  - Gửi kudos (screenId: `PV7jBVZU1N`)
  - All Kudos (screenId: `j_a2GQWKDJ`)
  - Chi tiết kudos (screenId: `T0TR16k0vH`)
  - Dropdown hashtag (screenId: `V5GRjAdJyb`)
  - Dropdown phòng ban (screenId: `76k69LQPfj`)
  - Tìm kiếm sunner (screenId: `3jgwke3E8O`)
  - Mở hộp bí mật (screenId: `kQk65hSYF2`)
  - Profile (screenId: `hSH7L8doXB`)
- **Triggers**: Bấm nút CTA, bấm dropdown, bấm link, bấm tab

### Yêu cầu hình ảnh

- Ứng dụng chỉ dành cho mobile (iOS) — width: 375px
- Animations/Transitions: Carousel slide transition, network chart pan/zoom

### Accessibility (VoiceOver)

| Thành phần | Semantic Label | Trait |
|-----------|---------------|-------|
| A.1. CTA Button | "Gửi kudos. Hôm nay, bạn muốn gửi kudos đến ai?" | Button |
| B.1.1. Dropdown Hashtag | "Lọc theo hashtag. {Giá trị hiện tại hoặc 'Tất cả'}" | Button |
| B.1.2. Dropdown Phòng ban | "Lọc theo phòng ban. {Giá trị hiện tại hoặc 'Tất cả'}" | Button |
| B.3. Highlight Card | "Kudos từ {sender} đến {receiver}. {nội dung rút gọn}" | Button (tap → chi tiết) |
| B.5. Slide Indicator | "Trang {current} trên {total}" | Adjustable |
| B.5 Arrow Left | "Trang trước" | Button (disabled khi trang 1) |
| B.5 Arrow Right | "Trang sau" | Button (disabled khi trang cuối) |
| Heart icon | "{count} lượt thích. {Đã thích / Chưa thích}" | Button, toggle |
| Copy Link | "Sao chép liên kết" | Button |
| "Xem chi tiết" | "Xem chi tiết kudos" | Link |
| D.2. Mở hộp bí mật | "Mở hộp bí mật. Bạn có {count} hộp chưa mở" | Button |
| Nav Bar tabs | "{Tab name}. Tab {index} trên 4" | Tab |

> Chi tiết visual specs xem tại [design-style.md](design-style.md)

---

## Yêu cầu *(bắt buộc)*

### Yêu cầu chức năng

- **FR-001**: Hệ thống PHẢI hiển thị carousel Highlight Kudos với tối đa 5 thẻ, sắp xếp theo heartCount giảm dần.
- **FR-002**: Hệ thống PHẢI hỗ trợ lọc Highlight Kudos theo hashtag và phòng ban (AND logic).
- **FR-003**: Người dùng PHẢI có thể gửi kudos mới thông qua nút CTA trên hero banner.
- **FR-004**: Hệ thống PHẢI hiển thị mạng lưới kết nối Spotlight Board dạng interactive network chart.
- **FR-005**: Hệ thống PHẢI hiển thị feed "All Kudos" với đầy đủ thông tin: sender, receiver, nội dung, hashtag, thời gian, hearts.
- **FR-006**: Hệ thống PHẢI hiển thị thống kê cá nhân gồm: kudos nhận, kudos gửi, hearts nhận, hộp bí mật đã mở, hộp bí mật chưa mở.
- **FR-007**: Hệ thống PHẢI hiển thị danh sách 10 Sunner nhận quà mới nhất, sắp xếp theo thời gian nhận quà gần đây nhất.
- **FR-008**: Carousel PHẢI reset về thẻ 1 khi thay đổi filter.
- **FR-009**: Hệ thống PHẢI hỗ trợ đa ngôn ngữ (VN/EN) cho tất cả text hiển thị.
- **FR-010**: Người dùng PHẢI có thể bấm heart/like trên mỗi kudos card.
- **FR-011**: Người dùng PHẢI có thể copy link kudos qua nút "Copy Link". Khi copy thành công, hiển thị snackbar/toast "Đã sao chép liên kết" trong 2 giây.
- **FR-012**: Nút heart PHẢI là toggle — bấm lần 1 để like (tăng heartCount + 1), bấm lần 2 để unlike (giảm heartCount - 1). Icon heart thay đổi giữa trạng thái outlined (chưa like) và filled (đã like).

### Yêu cầu kỹ thuật

- **TR-001**: Dữ liệu PHẢI được cache local để giảm số lần gọi API khi quay lại màn hình.
- **TR-002**: Network chart (Spotlight) PHẢI hỗ trợ pan/zoom gesture trên mobile.
- **TR-003**: Feed All Kudos PHẢI hỗ trợ pagination/infinite scroll.
- **TR-004**: Asset paths PHẢI sử dụng `flutter_gen` (`Assets.xxx`), không hardcode string.
- **TR-005**: Kiến trúc PHẢI tuân theo MVVM pattern với 1 ViewModel (`KudosViewModel extends AsyncNotifier<KudosState>`).

### Thực thể chính

- **Kudos**: id, senderId, receiverId, content, hashtags, heartCount, createdAt, isHighlight, isAnonymous
- **User (Sunner)**: id, name, avatar, department, badge/title
- **Hashtag**: id, name
- **Department**: id, name
- **PersonalStats**: kudosReceived, kudosSent, heartsReceived, openedSecretBoxes, unopenedSecretBoxes
- **RecentGiftRecipient**: userId, user (UserSummary), receivedAt

---

## Quản lý trạng thái (State Management)

### State Model (KudosState — freezed)

```
KudosState:
  - highlightKudos: List<Kudos>          # Danh sách highlight kudos (max 5)
  - allKudos: List<Kudos>                # Danh sách all kudos (paginated)
  - personalStats: PersonalStats?        # Thống kê cá nhân
  - recentGiftRecipients: List<GiftRecipientRanking>  # 10 Sunner nhận quà mới nhất
  - spotlightData: SpotlightNetwork?     # Dữ liệu network graph
  - selectedHashtag: Hashtag?            # Filter hashtag đang chọn (null = tất cả)
  - selectedDepartment: Department?      # Filter phòng ban đang chọn (null = tất cả)
  - currentHighlightPage: int            # Trang carousel hiện tại (0-indexed)
  - hasMoreKudos: bool                   # Còn kudos để load thêm (pagination)
```

### Local State (không thuộc ViewModel)

- **Carousel page controller**: `PageController` — quản lý vị trí carousel, reset khi filter thay đổi.
- **Scroll controller**: `ScrollController` — quản lý infinite scroll cho All Kudos feed.

### Trạng thái Loading/Error

| Section | Loading | Error | Empty |
|---------|---------|-------|-------|
| Highlight Kudos | Shimmer placeholder (3 thẻ) | Thông báo lỗi + nút retry | "Hiện tại chưa có Kudos nào." |
| Spotlight Board | Shimmer placeholder | Thông báo lỗi + nút retry | "Chưa có dữ liệu." |
| All Kudos | Shimmer placeholder (3 rows) | Thông báo lỗi + nút retry | "Chưa có Kudos nào được gửi." |
| Personal Stats | Shimmer placeholder | Ẩn section | Hiển thị tất cả giá trị = 0 |
| 10 Sunner nhận quà mới nhất | Shimmer placeholder | Ẩn section | "Chưa có dữ liệu." |

### Cache

- Dữ liệu PHẢI được cache trong ViewModel state (Riverpod tự quản lý lifecycle).
- Pull-to-refresh gọi `refresh()` trên ViewModel → re-fetch toàn bộ dữ liệu.
- Heart action cập nhật state local ngay lập tức (optimistic update) rồi sync với server.

---

## Phụ thuộc API

| Endpoint | Method | Mục đích | Trạng thái |
|----------|--------|----------|------------|
| `/api/v1/kudos/highlight` | GET | Lấy top 5 kudos highlight (filter: hashtag, department) | Dự đoán |
| `/api/v1/kudos` | GET | Lấy danh sách tất cả kudos (pagination) | Dự đoán |
| `/api/v1/kudos/{id}/heart` | POST | Thả heart cho kudos | Dự đoán |
| `/api/v1/spotlight/network` | GET | Lấy dữ liệu network graph cho spotlight board | Dự đoán |
| `/api/v1/users/me/stats` | GET | Lấy thống kê cá nhân | Dự đoán |
| `/api/v1/kudos/top-recipients` | GET | Lấy 10 sunner nhận quà mới nhất (sort by created_at DESC) | Dự đoán |
| `/api/v1/hashtags` | GET | Lấy danh sách hashtags | Dự đoán |
| `/api/v1/departments` | GET | Lấy danh sách phòng ban | Dự đoán |
| `/api/v1/users/search` | GET | Tìm kiếm sunner (spotlight) | Dự đoán |

---

## Tiêu chí thành công *(bắt buộc)*

### Kết quả đo lường

- **SC-001**: Highlight Kudos carousel load trong vòng 2 giây (cold start).
- **SC-002**: Tỷ lệ người dùng bấm nút "Gửi Kudos" CTA ≥ 15% trên tổng số lần mở màn hình.
- **SC-003**: Network chart (Spotlight) render mượt ≥ 30fps khi pan/zoom.
- **SC-004**: Hỗ trợ hiển thị đúng cả 2 ngôn ngữ VN và EN.

---

## Ngoài phạm vi

- Chức năng admin quản lý kudos (màn hình riêng).
- Push notification khi nhận kudos mới.
- Animation chi tiết cho hộp bí mật (thuộc màn hình riêng).
- Chỉnh sửa/xóa kudos đã gửi.
- Chức năng báo cáo/spam (thuộc flow khác).

---

## Phụ thuộc

- [x] Constitution document tồn tại (`.momorph/constitution.md`)
- [ ] API specifications (`.momorph/contexts/api-docs.yaml`)
- [ ] Database design (`.momorph/database.sql`)
- [x] Screen flow documented (`.momorph/SCREENFLOW.md`)

---

## Ghi chú

- Tất cả text PHẢI hỗ trợ đa ngôn ngữ VN/EN thông qua hệ thống i18n (slang).
- Hero banner background là hình ảnh trang trí, dùng asset path qua `flutter_gen`.
- Carousel highlight có gradient overlay ở cạnh trái/phải để tạo hiệu ứng depth cho card tiếp theo.
- Thống kê cá nhân nằm trong card với border vàng (#998C5F) trên nền tối (#00070C).
- Bottom navigation bar luôn hiển thị cố định ở đáy màn hình.
