# Đặc tả tính năng: [iOS] Sun*Kudos - Màn hình chính Kudos

**Frame ID**: `fO0Kt19sZZ`
**Frame Name**: `[iOS] Sun*Kudos`
**File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Ngày tạo**: 2026-04-13
**Ngày cập nhật**: 2026-04-16
**Trạng thái**: Đã cập nhật (2026-04-16)

---

## Tổng quan

Màn hình chính **Sun*Kudos** là trang feed của hệ thống ghi nhận và cảm ơn (Kudos) trong ứng dụng Sun* Annual Awards 2025. Đây là màn hình trung tâm nơi nhân viên (Sunner) có thể xem các kudos nổi bật, spotlight board (tên những người vừa gửi kudos), tất cả các kudos, và thống kê cá nhân. Người dùng cũng có thể gửi kudos mới từ nút CTA ngay trên hero banner.

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
5. **Cho biết** carousel hiển thị nhiều thẻ, **Khi** thẻ nằm ở vị trí trung tâm (active), **Thì** thẻ đó hiển thị đầy đủ và rõ nét; các thẻ ở hai bên (side) hiển thị mờ dần (faded) để tạo hiệu ứng depth — cho thấy còn thẻ khác để vuốt (TC_FUN_038).
6. **Cho biết** nội dung kudos trong highlight card quá dài, **Khi** hiển thị, **Thì** nội dung được truncate sau 3 dòng; tên người gửi truncate với "..." khi quá dài (TC_GUI_005).

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

> ⚠️ **Phạm vi triển khai hiện tại**: Filter **CHỈ ảnh hưởng đến Highlight Kudos carousel** (`highlightKudos`). All Kudos feed (`allKudos`) hiển thị toàn bộ kudos bất kể filter. Đây là giới hạn kỹ thuật do client-side filtering — nếu cần filter All Kudos, phải dùng Supabase Edge Function hoặc Database View.

**Kịch bản chấp nhận**:

1. **Cho biết** người dùng ở section Highlight Kudos, **Khi** bấm dropdown "Hashtag", **Thì** hiển thị danh sách hashtag để chọn (screenId: `V5GRjAdJyb`).
2. **Cho biết** người dùng đã chọn hashtag "#teamwork", **Khi** filter được áp dụng, **Thì** carousel Highlight Kudos chỉ hiển thị kudos có hashtag "#teamwork" và reset về thẻ 1. All Kudos feed **không thay đổi**.
3. **Cho biết** người dùng bấm dropdown "Phòng ban", **Khi** mở dropdown, **Thì** hiển thị danh sách phòng ban (screenId: `76k69LQPfj`).
4. **Cho biết** cả hai filter đều được chọn, **Khi** áp dụng, **Thì** kết quả Highlight là AND logic (cả hashtag và phòng ban phải khớp).
5. **Cho biết** filter đang active và không có highlight nào khớp, **Khi** hiển thị carousel, **Thì** hiển thị empty state "Không tìm thấy Kudos phù hợp." (TC_FUN_030).

---

### User Story 4 - Xem Spotlight Board (Ưu tiên: P2)

Là một Sunner, tôi muốn xem tên những người vừa gửi kudos trên spotlight board để thấy ai đang tích cực ghi nhận đồng nghiệp.

**Lý do ưu tiên**: Spotlight Board là tính năng unique tạo sự khác biệt, nhưng không phải core flow.

**Kiểm thử độc lập**: Có thể test bằng cách render canvas với danh sách recent senders dạng floating text labels.

**Kịch bản chấp nhận**:

1. **Cho biết** có dữ liệu kudos, **Khi** scroll đến section Spotlight Board, **Thì** hiển thị tên của những người vừa gửi kudos dưới dạng floating text labels (tên người gửi) trên canvas tối, bọc trong `InteractiveViewer` để hỗ trợ pan/zoom. Số kudos hiển thị từ `spotlight.totalKudos` (dynamic từ Supabase, không hardcode).
2. **Cho biết** không có dữ liệu (danh sách senders rỗng), **Khi** hiển thị, **Thì** hiển thị empty state với text "Chưa có dữ liệu." trong container 159px.
3. **Cho biết** người dùng muốn tìm kiếm sunner trên spotlight, **Khi** bấm ô "Tìm kiếm sunner", **Thì** mở chức năng tìm kiếm (screenId: `3jgwke3E8O`).
4. **Cho biết** kết quả tìm kiếm trả về 1 user, **Khi** user được highlight, **Thì** tên của user đó trên canvas hiển thị màu accent (`#FFEA9E`), font size lớn hơn, nổi bật so với các tên khác.
5. **Cho biết** người dùng muốn pan/zoom canvas, **Khi** kéo/pinch, **Thì** `InteractiveViewer` xử lý gesture và di chuyển/scale canvas.
6. **Cho biết** có dữ liệu kudos gần đây, **Khi** nhìn xuống phần dưới canvas B.7, **Thì** hiển thị live feed text dạng `"08:30PM Nguyễn Bá Chức đã nhận được một Kudos mới"` — mỗi dòng gồm timestamp + tên **người nhận** + "đã nhận được một Kudos mới". Feed hiển thị TRONG bordered canvas (159px), tại khoảng y≈124px từ đỉnh container.

**Logic lấy dữ liệu Spotlight (client-side):**
- Fetch `kudos` gần đây nhất (`ORDER BY created_at DESC LIMIT 50`) + JOIN `users` (id, name)
- **Canvas entries**: Danh sách **unique senders** (dedup theo `sender.userId`) — mỗi entry: `userId`, `name`, `x`, `y` (tọa độ ngẫu nhiên trong bounds 0–700, 0–110, assign lúc fetch)
- **Rendering**: `Stack` của các `Positioned(Text(...))` widget bọc trong `InteractiveViewer`. KHÔNG dùng `CustomPaint` với circles/edges
- **Search/KUDOS label**: Fixed overlays đặt NGOÀI `InteractiveViewer` (trong outer Stack), không pan theo canvas
- `totalKudos` = COUNT tổng số active kudos
- **Live feed**: 10 kudos gần nhất, mỗi dòng format `"HH:MMam/pm {receiverName} đã nhận được một Kudos mới"` — dùng tên **người nhận** (receiver), hiển thị trong canvas tại ~y=124px từ đỉnh

---

### User Story 5 - Xem tất cả Kudos (Feed) (Ưu tiên: P1)

Là một Sunner, tôi muốn xem danh sách tất cả các kudos đã gửi để theo dõi hoạt động ghi nhận.

**Lý do ưu tiên**: Đây là nội dung feed chính của hệ thống, mang lại giá trị liên tục cho người dùng.

**Kiểm thử độc lập**: Có thể test bằng cách hiển thị danh sách kudos với pagination.

**Kịch bản chấp nhận**:

1. **Cho biết** người dùng scroll đến section "ALL KUDOS", **Khi** dữ liệu được load, **Thì** hiển thị danh sách kudos với thông tin: người gửi, người nhận, thời gian, nội dung, hashtag, số heart.
2. **Cho biết** danh sách kudos hiển thị, **Khi** bấm link "Xem tất cả", **Thì** điều hướng sang màn hình danh sách đầy đủ (screenId: `j_a2GQWKDJ`).
3. **Cho biết** mỗi kudos card, **Khi** hiển thị, **Thì** gồm: avatar + tên + danh hiệu người gửi → icon "sent" → avatar + tên + danh hiệu người nhận, thời gian, nội dung, hashtag, và nút tương tác (heart, copy link, "Xem chi tiết" → điều hướng sang màn hình chi tiết kudos screenId: `T0TR16k0vH`).
4. **Cho biết** nội dung kudos trong feed quá dài, **Khi** hiển thị, **Thì** nội dung truncate sau 5 dòng; hashtag truncate sau 1 dòng (TC_GUI_003, TC_GUI_004).
5. **Cho biết** kudos có ảnh đính kèm, **Khi** bấm vào ảnh, **Thì** mở ảnh full screen (TC_FUN_029).

---

### User Story 6 - Xem thống kê cá nhân (Ưu tiên: P2)

Là một Sunner, tôi muốn xem thống kê cá nhân (số kudos nhận/gửi, hearts, hộp bí mật) để biết mức độ tham gia của mình.

**Lý do ưu tiên**: Thống kê cá nhân tăng sự gắn kết nhưng không ảnh hưởng đến core flow.

**Kiểm thử độc lập**: Có thể test bằng cách hiển thị block thống kê với dữ liệu user.

**Kịch bản chấp nhận**:

1. **Cho biết** người dùng scroll đến section thống kê, **Khi** hiển thị, **Thì** hiển thị các chỉ số: Số kudos nhận được, Số kudos đã gửi, Số hearts nhận được, Số hộp bí mật đã mở, Số hộp bí mật chưa mở.
2. **Cho biết** có badge "x2 Fire Bonus", **Khi** hiển thị, **Thì** badge bonus xuất hiện bên cạnh chỉ số tương ứng.
3. **Cho biết** `secret_boxes_unopened > 0`, **Khi** bấm nút "Mở hộp bí mật", **Thì** query `secret_boxes` table lấy box chưa mở đầu tiên (`is_opened = false`, order by `created_at` ASC, limit 1), sau đó UPDATE `is_opened = true, opened_at = now()`, rồi điều hướng sang màn hình Open secret box (screenId: `kQk65hSYF2`). Sau khi mở: thống kê cập nhật (opened +1, unopened -1) (TC_FUN_024).
4. **Cho biết** `secret_boxes_unopened = 0`, **Khi** hiển thị thống kê, **Thì** nút "Mở hộp bí mật" bị disabled (TC_FUN_039).
5. **Cho biết** người dùng bấm "Mở hộp bí mật" nhanh nhiều lần, **Khi** action được trigger, **Thì** chỉ 1 lần mở được thực hiện (double-tap prevention) (TC_FUN_025).

---

### User Story 7 - Xem 10 Sunner nhận quà mới nhất (Ưu tiên: P3)

Là một Sunner, tôi muốn xem danh sách 10 đồng nghiệp nhận quà gần đây nhất để biết ai vừa được ghi nhận.

**Lý do ưu tiên**: Tính năng social bổ sung, tạo cảm giác cộng đồng sôi nổi.

**Kiểm thử độc lập**: Có thể test bằng cách render danh sách 10 sunner với dữ liệu mock.

**Kịch bản chấp nhận**:

1. **Cho biết** có dữ liệu người nhận quà, **Khi** scroll đến section này, **Thì** hiển thị danh sách tối đa 10 sunner nhận quà gần đây nhất. Mỗi dòng gồm: số thứ tự (rank), avatar, tên, phòng ban, và `rewardName` (tên phần quà — ví dụ: "Nhận được 1 áo phông SAA") — sắp xếp theo thời gian nhận quà mới nhất trước.
2. **Cho biết** danh sách đang hiển thị, **Khi** bấm vào avatar hoặc tên của một sunner, **Thì** điều hướng sang màn hình profile người đó (screenId: `bEpdheM0yU`).
3. **Cho biết** không có dữ liệu người nhận quà, **Khi** hiển thị section, **Thì** hiển thị empty state "Chưa có dữ liệu."

---

### Trường hợp biên (Edge Cases)

- Không có kudos nào trong hệ thống → Hiển thị empty state cho mỗi section.
- Mất kết nối mạng khi đang load → Hiển thị thông báo lỗi và nút retry.
- Carousel highlight có ít hơn 5 thẻ → Chỉ hiển thị số thẻ có sẵn, ẩn nút next nếu chỉ có 1 thẻ.
- Nội dung kudos trong highlight card → Truncate sau **3 dòng** (TC_GUI_005), tên người gửi truncate với "..." khi quá dài.
- Nội dung kudos trong feed → Truncate sau **5 dòng** (TC_GUI_003); hashtag truncate sau **1 dòng** (TC_GUI_004).
- Pull-to-refresh → Reload toàn bộ dữ liệu màn hình (highlight, all kudos, stats).
- Heart toggle (đã like rồi bấm lại) → Unheart, giảm heartCount đi 1.
- Xóa filter (clear) → Quay về trạng thái mặc định (tất cả hashtag, tất cả phòng ban), carousel reset.
- Filter không có kết quả → Hiển thị empty state trong carousel: "Không tìm thấy Kudos phù hợp."
- Spotlight board không có dữ liệu (entries rỗng) → Hiển thị container 159px với text "Chưa có dữ liệu."
- Người dùng bấm vào avatar trên kudos card → Điều hướng sang profile người đó (screenId: `bEpdheM0yU`).
- Secret box button bị double-tap → Chỉ 1 lần open được xử lý (TC_FUN_025).
- Star badge người nhận: dùng `users.hero_tier` → map sang `badgeLevel` (0-4). Hiển thị level tương ứng. `none` → ẩn badge.
- Kudos ẩn danh (is_anonymous = true) → Thông tin người gửi bị ẩn, hiển thị `senderAlias` (nếu người gửi đặt nickname) hoặc "Người gửi ẩn danh" nếu không có alias.

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
| B.7. Spotlight Section | Canvas tối với tên người gửi kudos gần đây (floating text labels), ô tìm kiếm, số KUDOS, live feed | Pan/zoom canvas, tìm kiếm sunner |
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
  - Profile bản thân (screenId: `hSH7L8doXB`) — chỉ khi bấm tab Profile trên NavBar
  - Profile người khác (screenId: `bEpdheM0yU`) — khi bấm avatar người dùng trên kudos card hoặc recipient list
- **Triggers**: Bấm nút CTA, bấm dropdown, bấm link, bấm tab

### Yêu cầu hình ảnh

- Ứng dụng chỉ dành cho mobile (iOS) — width: 375px
- Animations/Transitions: Carousel slide transition, spotlight canvas pan/zoom

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
| B.7.3 Search Sunner | "Tìm kiếm sunner trên Spotlight Board" | Button (tap → screenId: 3jgwke3E8O) |
| D.2. Mở hộp bí mật | "Mở hộp bí mật. Bạn có {count} hộp chưa mở" | Button |
| D.3. Recipient Row | "{rank}. {name}, {department}. {rewardName}" | Button (tap → profile) |
| Nav Bar tabs | "{Tab name}. Tab {index} trên 4" | Tab |

> Chi tiết visual specs xem tại [design-style.md](design-style.md)

---

## Yêu cầu *(bắt buộc)*

### Yêu cầu chức năng

- **FR-001**: Hệ thống PHẢI hiển thị carousel Highlight Kudos với tối đa 5 thẻ, sắp xếp theo heartCount giảm dần.
- **FR-002**: Hệ thống PHẢI hỗ trợ lọc Highlight Kudos theo hashtag và phòng ban (AND logic).
- **FR-003**: Người dùng PHẢI có thể gửi kudos mới thông qua nút CTA trên hero banner.
- **FR-004**: Hệ thống PHẢI hiển thị Spotlight Board là canvas floating text labels (tên người gửi kudos gần đây) trong `InteractiveViewer` hỗ trợ pan/zoom. KHÔNG phải network chart với circles/edges.
- **FR-005**: Hệ thống PHẢI hiển thị feed "All Kudos" với đầy đủ thông tin: sender, receiver, nội dung, hashtag, thời gian, hearts.
- **FR-006**: Hệ thống PHẢI hiển thị thống kê cá nhân gồm: kudos nhận, kudos gửi, hearts nhận, hộp bí mật đã mở, hộp bí mật chưa mở.
- **FR-007**: Hệ thống PHẢI hiển thị danh sách 10 Sunner nhận quà mới nhất, sắp xếp theo thời gian nhận quà gần đây nhất.
- **FR-008**: Carousel PHẢI reset về thẻ 1 khi thay đổi filter.
- **FR-009**: Hệ thống PHẢI hỗ trợ đa ngôn ngữ (VN/EN) cho tất cả text hiển thị.
- **FR-010**: Người dùng PHẢI có thể bấm heart/like trên mỗi kudos card.
- **FR-011**: Người dùng PHẢI có thể copy link kudos qua nút "Copy Link". Khi copy thành công, hiển thị snackbar/toast "Đã sao chép liên kết" trong 2 giây.
- **FR-012**: Nút heart PHẢI là toggle — bấm lần 1 để like (tăng heartCount + 1), bấm lần 2 để unlike (giảm heartCount - 1). Icon heart thay đổi giữa trạng thái outlined (chưa like) và filled (đã like).
- **FR-013**: Ảnh đính kèm trong kudos card PHẢI mở full screen khi bấm vào (TC_FUN_029).
- **FR-014**: Nút "Mở hộp bí mật" PHẢI bị disabled khi `secret_boxes_unopened = 0` (TC_FUN_039), và chỉ trigger 1 lần mở kể cả khi double-tap (TC_FUN_025).
- **FR-015**: Star badge người nhận PHẢI hiển thị theo `heroTier` từ Supabase (`users.hero_tier`): `none` → không badge; `new_hero` → badgeLevel 1; `rising_hero` → badgeLevel 2; `super_hero` → badgeLevel 3; `legend_hero` → badgeLevel 4. Mapping thực hiện trong `UserSummary._mapUserSummary()`.
- **FR-016**: Nội dung kudos trong Highlight card PHẢI truncate sau 3 dòng (TC_GUI_005). Nội dung trong feed PHẢI truncate sau 5 dòng (TC_GUI_003). Hashtag PHẢI truncate sau 1 dòng (TC_GUI_004).
- **FR-017**: Highlight carousel PHẢI hiển thị card trung tâm (active) rõ nét và các card hai bên (side) mờ dần để tạo hiệu ứng depth (TC_FUN_038).

### Yêu cầu kỹ thuật

- **TR-001**: Dữ liệu PHẢI được cache trong Riverpod `AsyncNotifier` state để giảm số lần query Supabase khi quay lại màn hình.
- **TR-002**: Spotlight Board PHẢI render bằng `Stack` của các `Positioned(Text(...))` widget (tên người gửi kudos) bọc trong `InteractiveViewer` để hỗ trợ pan/zoom gesture. KHÔNG dùng `CustomPaint` với circles/edges. KHÔNG dùng `Image.asset`.
- **TR-003**: Feed All Kudos PHẢI hỗ trợ pagination sử dụng `.range()` của Supabase SDK (page-based).
- **TR-004**: Asset paths PHẢI sử dụng `flutter_gen` (`Assets.xxx`), không hardcode string.
- **TR-005**: Kiến trúc PHẢI tuân theo MVVM pattern với 1 ViewModel (`KudosViewModel extends AsyncNotifier<KudosState>`).
- **TR-006**: Mọi truy vấn dữ liệu PHẢI đi qua `KudosRemoteDatasource` (Supabase SDK). KHÔNG gọi Supabase client trực tiếp từ ViewModel hoặc Widget.
- **TR-007**: Spotlight data được xây dựng client-side từ `kudos` gần đây (sender_id + sender name). Các tên được phân tán ở tọa độ (x, y) ngẫu nhiên trong canvas. Không có edges/weights. Entry được highlight (màu `#FFEA9E`, font lớn hơn) khi user tìm kiếm trên spotlight.

### Thực thể chính (khớp với model trong code)

- **Kudos**: `id` (String), `sender` (UserSummary), `receiver` (UserSummary), `content` (message text), `hashtags` (List\<Hashtag\>), `heartCount` (int, đếm từ `kudos_reactions`), `createdAt`, `isAnonymous`, `senderAlias` (String?, nullable — nickname ẩn danh do người gửi tự chọn), `awardTitle` (String?), `imageUrls` (List\<String\>), `shareUrl` (saa://kudos/{id})
- **UserSummary**: `id`, `name`, `avatar` (avatarUrl), `department` (tên phòng ban), `heroTier` (String — enum: `'none'`/`'new_hero'`/`'rising_hero'`/`'super_hero'`/`'legend_hero'`), `badgeLevel` (int 0-4 map từ heroTier)
- **Hashtag**: `id`, `name`
- **Department**: `id`, `name`
- **PersonalStats**: `kudosReceived`, `kudosSent`, `heartsReceived`, `secretBoxesOpened`, `secretBoxesUnopened` (từ view `user_stats`)
- **GiftRecipientRanking**: `rank`, `user` (UserSummary), `rewardName` (award_category_name)
- **SpotlightData**: `entries` (List\<SpotlightEntry\>), `totalKudos` (int), `recentActivity` (List\<SpotlightActivity\> — 10 kudos gần nhất)
- **SpotlightEntry**: `userId`, `name`, `x` (double — tọa độ random 0–700), `y` (double — random 0–110). Highlight state là **local widget state** (`String? _highlightedUserId`), KHÔNG thuộc model.
- **SpotlightActivity**: `timestamp` (String — format "HH:MMam/pm"), `receiverName` (String)
- **SecretBox**: `id`, `isOpened`, `rewardType` (badge/points/message/special), `rewardValue`

---

## Quản lý trạng thái (State Management)

### State Model (KudosState — freezed)

```
KudosState:
  # --- Dữ liệu chính ---
  - highlightKudos: List<Kudos>          # Top 5 highlight kudos (filter by hashtag/dept)
  - allKudos: List<Kudos>                # All kudos feed trên màn hình chính (paginated, không bị filter)
  - allKudosPageList: List<Kudos>        # All kudos dành riêng cho trang "All Kudos" (j_a2GQWKDJ)
  - personalStats: PersonalStats?        # Thống kê cá nhân từ view user_stats
  - topGiftRecipients: List<GiftRecipientRanking>  # Top 10 Sunner nhận quà mới nhất (sort by created_at DESC)
  - spotlightData: SpotlightData?        # Floating name labels (recent kudos senders) cho Spotlight Board

  # --- Filter state ---
  - selectedHashtag: Hashtag?            # Filter hashtag đang chọn (null = tất cả)
  - selectedDepartment: Department?      # Filter phòng ban đang chọn (null = tất cả)
  - availableHashtags: List<Hashtag>     # Danh sách hashtags cho dropdown (load khi init)
  - availableDepartments: List<Department>  # Danh sách phòng ban cho dropdown (load khi init)

  # --- Pagination state ---
  - currentHighlightPage: int            # Trang carousel hiện tại (0-indexed)
  - hasMoreKudos: bool                   # Còn kudos để load thêm trong allKudos feed
  - hasMoreAllKudosPage: bool            # Còn kudos để load thêm trong allKudosPageList
  - isLoadingMoreAllKudos: bool          # Đang load thêm kudos cho All Kudos page
```

> **Ghi chú**: `allKudos` (feed chính) và `allKudosPageList` (trang All Kudos riêng) là 2 list độc lập. `allKudosPageList` được populate khi user navigate sang `j_a2GQWKDJ`, không load trong màn hình chính.

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

## Supabase Data Access

> App dùng **Supabase SDK trực tiếp** (`supabase_flutter`) thông qua `KudosRemoteDatasource`. Không có REST API layer riêng.

| Phương thức Datasource | Supabase Table/View | Mô tả |
|------------------------|---------------------|-------|
| `fetchHighlightKudos({hashtagId?, departmentName?})` | `kudos` + join `users`, `kudos_hashtags`, `kudos_reactions`, `kudos_photos` | Lấy 50 kudos gần nhất, filter client-side theo hashtag/department, sort by `heartCount` DESC, lấy top 5 |
| `fetchKudos({page, limit, hashtagId?, departmentName?})` | `kudos` + joins | Lấy danh sách kudos paginated (`.range()`), filter client-side |
| `likeKudos(kudosId)` | `kudos_reactions` | INSERT reaction với user_id hiện tại |
| `unlikeKudos(kudosId)` | `kudos_reactions` | DELETE reaction của user hiện tại |
| `fetchSpotlight()` | `kudos` + JOIN `users` AS sender + JOIN `users` AS receiver | Fetch 50 kudos gần nhất (`ORDER BY created_at DESC LIMIT 50`), trích xuất: (1) unique senders → `entries` (dedup by userId, assign random x/y); (2) 10 kudos gần nhất → `recentActivity` (receiver.name + created_at timestamp); (3) COUNT tổng → `totalKudos` |
| `fetchTotalKudosCount()` | `kudos` | COUNT kudos active (`.count(CountOption.exact)`) |
| `fetchPersonalStats()` | `user_stats` (VIEW) | SELECT theo `user_id` của user hiện tại |
| `fetchTopRecipients()` | `kudos` + join `users` | Lấy kudos sorted by `created_at DESC`, dedup recipient, lấy top 10 |
| `fetchHashtags()` | `hashtags` | SELECT all, order by `name` |
| `fetchDepartments()` | `departments` | SELECT all, order by `name` |
| `searchUsers(query)` | `users` + join `departments` | `.ilike('name', '%query%')`, limit 20 |
| **Secret Box (chưa implement)** | `secret_boxes` | SELECT where `user_id = me AND is_opened = false`, LIMIT 1; sau đó UPDATE `is_opened = true` |

> **Ghi chú quan trọng**: Highlight kudos và filter ALL dùng client-side filtering do PostgREST không hỗ trợ ORDER BY count của related table. Nếu data lớn, cần xem xét Supabase Edge Function hoặc Database View.

---

## Tiêu chí thành công *(bắt buộc)*

### Kết quả đo lường

- **SC-001**: Highlight Kudos carousel load trong vòng 2 giây (cold start).
- **SC-002**: Tỷ lệ người dùng bấm nút "Gửi Kudos" CTA ≥ 15% trên tổng số lần mở màn hình.
- **SC-003**: Spotlight Board (floating names canvas) render mượt ≥ 30fps khi pan/zoom.
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
- [x] Database schema (`.momorph/contexts/database-schema.sql`) — tables: `kudos`, `users`, `hashtags`, `departments`, `kudos_reactions`, `kudos_photos`, `secret_boxes`; view: `user_stats`
- [x] Screen flow documented (`.momorph/contexts/SCREENFLOW.md`)
- [ ] API specifications — không áp dụng (app dùng Supabase SDK trực tiếp, không có REST API layer)

---

## Ghi chú

- Tất cả text PHẢI hỗ trợ đa ngôn ngữ VN/EN thông qua hệ thống i18n (slang).
- Hero banner background là hình ảnh trang trí, dùng asset path qua `flutter_gen`.
- Carousel highlight có gradient overlay ở cạnh trái/phải để tạo hiệu ứng depth cho card tiếp theo.
- Thống kê cá nhân nằm trong card với border vàng (#998C5F) trên nền tối (#00070C).
- Bottom navigation bar luôn hiển thị cố định ở đáy màn hình.
