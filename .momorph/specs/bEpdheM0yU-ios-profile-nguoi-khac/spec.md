# Dac ta tinh nang: [iOS] Profile nguoi khac

**Frame ID**: `bEpdheM0yU`
**Frame Name**: `[iOS] Profile nguoi khac`
**File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Ngay tao**: 2026-04-14
**Trang thai**: Draft

---

## Tong quan

Man hinh **Profile nguoi khac** hien thi thong tin cua mot nguoi dung khac (khong phai nguoi dang dang nhap) trong ung dung Sun* Annual Awards 2025. Nguoi dung truy cap man hinh nay khi bam vao avatar tren kudos card (o bat ky man hinh nao co kudos card: Kudos feed, All Kudos, Profile ban than). Man hinh hien thi: thong tin nguoi dung (avatar, ten, team, danh hieu), bo suu tap huy hieu, nut CTA "Gui loi cam on" (de gui kudos cho nguoi nay), va lich su kudos cua nguoi do (da nhan / da gui) voi dropdown filter.

**Doi tuong su dung**: Nhan vien Sun* (Sunner) da dang nhap, dang xem profile cua mot dong nghiep.

**Boi canh kinh doanh**: Profile nguoi khac cho phep nguoi dung tim hieu ve dong nghiep va gui loi cam on truc tiep — thuc day van hoa ghi nhan lan nhau.

**Khac biet voi Profile ban than (screenId: `hSH7L8doXB`)**:
- **Khong co** section thong ke ca nhan (Statistics Container) — chi hien thi cho chinh minh.
- **Co them** nut CTA "Gui loi cam on" de gui kudos cho nguoi nay.
- **Khong co** nut "Mo Secret Box" — secret box chi danh cho chinh minh.
- Bottom Navigation Bar: khong co tab nao active (vi day khong phai man hinh chinh cua tab).
- Co nut back de quay lai man hinh truoc.

---

## Kich ban nguoi dung & Kiem thu *(bat buoc)*

### User Story 1 — Xem thong tin nguoi khac (Uu tien: P1)

La mot Sunner, toi muon xem thong tin profile cua dong nghiep (avatar, ten, team, danh hieu) de biet ro ho la ai.

**Ly do uu tien**: Day la thong tin co ban, hien thi dau tien khi mo profile nguoi khac.

**Kiem thu doc lap**: Co the test bang cach render profile header voi du lieu user mock.

**Kich ban chap nhan**:

1. **Cho biet** nguoi dung bam vao avatar tren kudos card, **Khi** man hinh Profile nguoi khac mo, **Thi** hien thi avatar hinh tron, ten day du, ma team, va badge danh hieu cua nguoi do.
2. **Cho biet** nguoi do khong co avatar, **Khi** hien thi, **Thi** hien thi placeholder voi chu cai dau cua ten.
3. **Cho biet** du lieu profile, **Khi** hien thi, **Thi** du lieu lay tu API profile theo userId.

---

### User Story 2 — Gui loi cam on (kudos) cho nguoi nay (Uu tien: P1)

La mot Sunner, toi muon gui kudos cho dong nghiep nay truc tiep tu profile cua ho.

**Ly do uu tien**: Day la action chinh (primary CTA) cua man hinh — thuc day hanh vi gui kudos.

**Kiem thu doc lap**: Co the test bang cach bam nut CTA va verify navigation sang man hinh gui kudos voi nguoi nhan da duoc pre-fill.

**Kich ban chap nhan**:

1. **Cho biet** nguoi dung dang xem profile nguoi khac, **Khi** bam nut "Gui loi cam on", **Thi** dieu huong sang man hinh gui kudos (screenId: `PV7jBVZU1N`) voi nguoi nhan da duoc pre-fill la nguoi dang xem.
2. **Cho biet** nut CTA luon hien thi, **Khi** trang duoc load, **Thi** nut CTA o trang thai enabled (khong co dieu kien disable).

---

### User Story 3 — Xem bo suu tap huy hieu (Uu tien: P2)

La mot Sunner, toi muon xem bo suu tap huy hieu cua dong nghiep de biet thanh tich cua ho.

**Ly do uu tien**: Tinh nang gamification bo sung, khong phai core flow.

**Kiem thu doc lap**: Co the test bang cach render danh sach huy hieu voi du lieu mock.

**Kich ban chap nhan**:

1. **Cho biet** nguoi do co huy hieu, **Khi** hien thi, **Thi** hien thi section bo suu tap voi cac icon huy hieu: Revival, Touch Of Light, Stay Gold, Flow To Horizon, Beyond The Boundary, Root Futher (theo thiet ke).
2. **Cho biet** nguoi do chua co huy hieu nao, **Khi** hien thi, **Thi** an section hoac hien thi empty state.

---

### User Story 4 — Xem lich su kudos cua nguoi nay (Uu tien: P1)

La mot Sunner, toi muon xem danh sach kudos ma nguoi nay da nhan hoac da gui, co the chuyen doi qua dropdown filter.

**Ly do uu tien**: Day la noi dung chinh chiem nhieu khong gian nhat tren man hinh.

**Kiem thu doc lap**: Co the test bang cach render list kudos cards voi filter dropdown.

**Kich ban chap nhan**:

1. **Cho biet** nguoi dung o man hinh Profile nguoi khac, **Khi** scroll den section Kudos, **Thi** hien thi header "KUDOS" voi banner "Sun* Annual Awards 2025" va dropdown filter.
2. **Cho biet** dropdown filter, **Khi** hien thi, **Thi** co 2 lua chon: "Da nhan (N)" va "Da gui (N)" — N la so luong tuong ung.
3. **Cho biet** nguoi dung chon filter, **Khi** chon, **Thi** danh sach cap nhat tuong ung, label dropdown doi theo.
4. **Cho biet** filter khong co ket qua, **Khi** hien thi, **Thi** hien empty state phu hop.

---

### User Story 5 — Tuong tac voi kudos card (Uu tien: P2)

La mot Sunner, toi muon tuong tac voi cac kudos card tren profile nguoi khac (xem chi tiet, copy link, tha heart).

**Ly do uu tien**: Tuong tac bo sung tang trai nghiem.

**Kiem thu doc lap**: Co the test tung action rieng le tren 1 kudos card.

**Kich ban chap nhan**:

1. **Cho biet** kudos card hien thi, **Khi** bam "Xem chi tiet", **Thi** dieu huong sang man hinh chi tiet kudos.
2. **Cho biet** kudos card hien thi, **Khi** bam "Copy Link", **Thi** sao chep link vao clipboard va hien thi toast xac nhan.
3. **Cho biet** kudos card hien thi, **Khi** bam icon heart, **Thi** toggle trang thai heart (like/unlike) va cap nhat heart count.

---

### User Story 6 — Quay lai man hinh truoc (Uu tien: P1)

La mot Sunner, toi muon quay lai man hinh truoc do sau khi xem profile nguoi khac.

**Ly do uu tien**: Navigation co ban — thieu thi nguoi dung bi ket.

**Kiem thu doc lap**: Test bang cach bam nut back va verify dieu huong.

**Kich ban chap nhan**:

1. **Cho biet** nguoi dung dang o man hinh Profile nguoi khac, **Khi** bam nut back (hoac swipe back iOS), **Thi** quay lai man hinh truoc do (Kudos feed, All Kudos, hoac bat ky man hinh nao da dieu huong den day).

---

### User Story 7 — Tai them kudos (Infinite Scroll) (Uu tien: P2)

La mot Sunner, toi muon tai them kudos khi cuon den cuoi danh sach de xem toan bo lich su cua nguoi nay.

**Ly do uu tien**: Pagination can thiet de hien thi du lieu lon, nhung khong phai core display.

**Kiem thu doc lap**: Co the test bang cach scroll den cuoi list va verify API call trang tiep theo.

**Kich ban chap nhan**:

1. **Cho biet** danh sach kudos con trang tiep theo (hasMoreKudos = true), **Khi** nguoi dung cuon den cuoi danh sach, **Thi** tu dong goi API load trang tiep theo va append vao danh sach hien tai.
2. **Cho biet** dang tai them kudos, **Khi** loading, **Thi** hien thi loading indicator o cuoi danh sach.
3. **Cho biet** khong con kudos de tai them (hasMoreKudos = false), **Khi** cuon den cuoi, **Thi** khong goi API nua.

---

### User Story 8 — Pull-to-refresh (Uu tien: P2)

La mot Sunner, toi muon keo xuong de lam moi toan bo du lieu profile nguoi khac.

**Ly do uu tien**: Thao tac co ban de cap nhat du lieu.

**Kiem thu doc lap**: Co the test bang cach pull-to-refresh va verify ViewModel.refresh() duoc goi.

**Kich ban chap nhan**:

1. **Cho biet** nguoi dung dang o man hinh Profile nguoi khac, **Khi** keo xuong (pull-to-refresh), **Thi** reload toan bo du lieu: thong tin ca nhan, bo suu tap huy hieu, va danh sach kudos.
2. **Cho biet** refresh thanh cong, **Khi** hoan tat, **Thi** hien thi du lieu moi nhat.
3. **Cho biet** refresh that bai (mat mang), **Khi** loi xay ra, **Thi** hien thi thong bao loi va giu du lieu cu.

---

### Truong hop bien (Edge Cases)

- Mat ket noi mang khi load profile -> Hien thi thong bao loi va nut retry.
- Avatar khong load duoc -> Hien thi placeholder chu cai dau.
- Nguoi dung xem chinh minh qua route nay (edge case) -> Redirect sang Profile ban than (screenId: `hSH7L8doXB`).
- Nguoi do chua co kudos nao -> Hien thi empty state o section kudos list.
- Kudos card co noi dung qua dai -> Truncate voi "..." va nut "Xem chi tiet".
- Bam vao avatar tren kudos card cua nguoi thu 3 -> Dieu huong sang profile nguoi do (push them 1 man hinh Profile nguoi khac).
- userId khong ton tai hoac da bi xoa -> Hien thi man hinh loi "Khong tim thay nguoi dung".
- Pull-to-refresh -> Reload toan bo du lieu profile nguoi do.
- Deep link vao profile nguoi khac (`/profile/:userId`) -> Mo man hinh Profile nguoi khac voi userId tuong ung.

---

## Yeu cau UI/UX *(tu Figma)*

### Thanh phan man hinh

| Thanh phan | Mo ta | Tuong tac |
|-----------|-------|-----------|
| 1. Header | Thanh trang thai iOS + navigation bar (co nut back) | Bam back -> quay lai |
| 2. Member Info Container | Container chua avatar tron, ten day du, ma team, badge danh hieu | Chi hien thi |
| A.2. User Name & Badge | Nhom label xep doc: ten + team + badge | Chi hien thi |
| 3. Badge Collection | Danh sach huy hieu: Revival, Touch Of Light, Stay Gold, Flow To Horizon, Beyond The Boundary, Root Futher | Chi hien thi (co the co tooltip) |
| 3.x. Badge Items | Tung huy hieu rieng le voi icon va ten | Chi hien thi |
| 4. Icon Collection Label | Tieu de "Bo suu tap icon cua toi" | Chi hien thi |
| A.1. Button "Gui loi cam on" | Nut CTA de gui kudos cho nguoi nay | Bam -> dieu huong sang man hinh gui kudos (screenId: `PV7jBVZU1N`) voi nguoi nhan pre-fill |
| 6. Kudos Section Header | Banner trang tri "Sun* Annual Awards 2025" + "KUDOS" | Chi hien thi |
| 7. Kudos Filter Dropdown | Dropdown de loc kudos "Da nhan (N)" / "Da gui (N)" | Bam -> mo overlay |
| 8. Kudos List Container | Danh sach kudos cards theo filter | Scroll doc |
| B.3. Kudos Cards (Highlight + Normal) | Cards kudos voi sender/receiver/content | Xem chi tiet, Copy Link, Heart toggle |
| 9. Bottom Navigation Bar | 4 tab: SAA 2025, Awards, Kudos, Profile | Bam tab -> dieu huong |

### Luong dieu huong

- **Tu**: Bat ky man hinh nao co kudos card (bam avatar):
  - Kudos feed (screenId: `fO0Kt19sZZ`)
  - All Kudos (screenId: `j_a2GQWKDJ`)
  - Profile ban than (screenId: `hSH7L8doXB`)
  - Chi tiet kudos
- **Den**:
  - Man hinh gui kudos (screenId: `PV7jBVZU1N`) — tu nut "Gui loi cam on"
  - Chi tiet kudos — tu "Xem chi tiet" tren card
  - Profile nguoi khac (push them) — tu tap avatar tren kudos card cua nguoi thu 3
  - Man hinh truoc do — tu nut back
- **Triggers**: Bam nut, bam avatar, bam link, swipe back

### Yeu cau hinh anh

- Ung dung chi danh cho mobile (iOS) — width: 375px
- Animations/Transitions: Dropdown overlay open/close, push/pop navigation transition

### Accessibility (VoiceOver)

| Thanh phan | Semantic Label | Trait |
|-----------|---------------|-------|
| Back button | "Quay lai" | Button |
| Avatar | "Anh dai dien cua {ten}" | Image |
| Badge danh hieu | "{danh hieu}" | Static Text |
| Badge Collection item | "Huy hieu {ten huy hieu}" | Image |
| Button "Gui loi cam on" | "Gui loi cam on cho {ten}" | Button |
| Dropdown Filter | "Loc kudos. {gia tri hien tai}" | Button |
| Heart icon | "{count} luot thich. {Da thich / Chua thich}" | Button, toggle |
| Copy Link | "Sao chep lien ket" | Button |
| "Xem chi tiet" | "Xem chi tiet kudos" | Link |
| Nav Bar tabs | "{Tab name}. Tab {index} tren 4" | Tab |

> Chi tiet visual specs xem tai [design-style.md](design-style.md)

---

## Yeu cau *(bat buoc)*

### Yeu cau chuc nang

- **FR-001**: He thong PHAI hien thi thong tin profile nguoi khac: avatar, ten day du, ma team, badge danh hieu.
- **FR-002**: He thong PHAI hien thi bo suu tap huy hieu cua nguoi do voi ten tung huy hieu.
- **FR-003**: Nguoi dung PHAI co the gui kudos cho nguoi nay qua nut "Gui loi cam on" — dieu huong sang man hinh gui kudos voi nguoi nhan pre-fill.
- **FR-004**: He thong PHAI ho tro dropdown filter de chuyen doi giua "Da nhan" va "Da gui" cho danh sach kudos.
- **FR-005**: He thong PHAI hien thi danh sach kudos cards voi day du thong tin: sender, receiver, noi dung, hashtag, thoi gian, heart count, actions.
- **FR-006**: Nguoi dung PHAI co the tuong tac voi kudos cards: heart toggle, copy link, xem chi tiet.
- **FR-007**: He thong PHAI ho tro da ngon ngu (VN/EN) cho tat ca text hien thi.
- **FR-008**: Nguoi dung PHAI co the quay lai man hinh truoc qua nut back hoac swipe back.
- **FR-009**: Neu userId trung voi user dang dang nhap -> redirect sang Profile ban than.
- **FR-010**: Dropdown filter PHAI cap nhat so luong (N) trong label khi du lieu thay doi.
- **FR-011**: He thong PHAI ho tro pull-to-refresh de reload toan bo du lieu profile nguoi khac.
- **FR-012**: He thong PHAI ho tro infinite scroll (pagination) cho danh sach kudos.

### Yeu cau ky thuat

- **TR-001**: Kien truc PHAI tuan theo MVVM pattern voi 1 ViewModel: `OtherProfileViewModel extends FamilyAsyncNotifier<OtherProfileState, String>` — nhan `userId` lam tham so family.
- **TR-002**: Asset paths PHAI su dung `flutter_gen` (`Assets.xxx`), khong hardcode string.
- **TR-003**: Icons PHAI su dung format SVG va render qua `flutter_svg`.
- **TR-004**: Text PHAI su dung i18n (slang), khong hardcode string.
- **TR-005**: Model PHAI su dung freezed cho immutability.
- **TR-006**: Man hinh PHAI nhan userId lam tham so tu route (go_router path parameter).
- **TR-007**: Du lieu PHAI duoc cache trong ViewModel state.

### So sanh Profile ban than vs Profile nguoi khac

| Thuoc tinh | Profile ban than (`hSH7L8doXB`) | Profile nguoi khac (`bEpdheM0yU`) |
|-----------|--------------------------------|-----------------------------------|
| Header | App header (logo, search, bell) | Header voi nut back |
| Statistics Container | Co (dark panel voi thong ke) | Khong co |
| Button "Mo Secret Box" | Co | Khong co |
| Button "Gui loi cam on" | Khong co | Co (CTA chinh) |
| Badge/Icon Collection | Icon collection (chi icon, khong ten) | Badge collection (icon + ten) |
| Bottom Nav | Profile tab active | Tat ca tab inactive |
| Route | Tab navigation (tab 4) | Push navigation (voi userId param) |
| ViewModel | `ProfileViewModel extends AsyncNotifier<ProfileState>` | `OtherProfileViewModel extends FamilyAsyncNotifier<OtherProfileState, String>` |
| Entry point | Bottom tab / deep link `/profile` | Tap avatar tren kudos card |

### Thuc the chinh

- **UserProfile**: id, name, avatar, team, badge/title, badgeCollection
- **Badge**: id, name, imageUrl, type (Revival, Touch Of Light, Stay Gold, Flow To Horizon, Beyond The Boundary, Root Futher)
- **Kudos**: id, senderId, receiverId, content, hashtags, heartCount, createdAt, awardCategory
- **User (Sunner)**: id, name, avatar, team, badge/title

---

## Quan ly trang thai (State Management)

### State Model (OtherProfileState — freezed)

```
OtherProfileState:
  - userProfile: UserProfile              # Thong tin nguoi dung
  - badgeCollection: List<Badge>          # Bo suu tap huy hieu
  - kudosList: List<Kudos>                # Danh sach kudos (theo filter)
  - kudosFilter: KudosFilterType          # Enum: received | sent
  - kudosReceivedCount: int               # So luong kudos da nhan
  - kudosSentCount: int                   # So luong kudos da gui
  - hasMoreKudos: bool                    # Con kudos de load them (pagination)
```

### ViewModel

```
OtherProfileViewModel extends FamilyAsyncNotifier<OtherProfileState, String>
  - build(String userId) → load profile data
  - changeFilter(KudosFilterType) → switch filter, reload kudos
  - loadMoreKudos() → pagination
  - toggleHeart(String kudosId) → heart toggle
  - refresh() → re-fetch all data
```

> **Ghi chu**: Su dung `FamilyAsyncNotifier` voi `userId` lam tham so de Riverpod quan ly state theo tung user.

### Local State (khong thuoc ViewModel)

- **Dropdown open state**: Quan ly trang thai dong/mo cua dropdown overlay.
- **Scroll controller**: `ScrollController` — quan ly infinite scroll cho kudos list.

### Trang thai Loading/Error

| Section | Loading | Error | Empty |
|---------|---------|-------|-------|
| Profile Info | Shimmer placeholder | Thong bao loi + nut retry | N/A |
| Badge Collection | Shimmer placeholder | An section | An section |
| Kudos List | Shimmer placeholder (3 cards) | Thong bao loi + nut retry | "Chua co Kudos nao." |

### Cache

- Du lieu PHAI duoc cache trong ViewModel state (Riverpod tu quan ly lifecycle).
- Pull-to-refresh goi `refresh()` tren ViewModel -> re-fetch toan bo du lieu.
- Heart action cap nhat state local ngay lap tuc (optimistic update) roi sync voi server.

---

## Phu thuoc API

| Endpoint | Method | Muc dich | Trang thai |
|----------|--------|----------|------------|
| `/api/v1/users/{userId}/profile` | GET | Lay thong tin profile nguoi dung | Du doan |
| `/api/v1/users/{userId}/badges` | GET | Lay bo suu tap huy hieu | Du doan |
| `/api/v1/users/{userId}/kudos?filter={sent\|received}&page={N}` | GET | Lay danh sach kudos cua nguoi do (co filter va pagination) | Du doan |
| `/api/v1/kudos/{id}/heart` | POST | Tha/bo heart cho kudos | Du doan |

---

## Tieu chi thanh cong *(bat buoc)*

### Ket qua do luong

- **SC-001**: Profile nguoi khac load trong vong 2 giay (tu luc tap avatar den hien thi data).
- **SC-002**: Ty le nguoi dung bam nut "Gui loi cam on" >= 10% tren tong so lan xem profile.
- **SC-003**: Ho tro hien thi dung ca 2 ngon ngu VN va EN.
- **SC-004**: Tat ca icons su dung SVG format, asset paths su dung flutter_gen.

---

## Ngoai pham vi

- Chinh sua thong tin profile nguoi khac — khong co quyen.
- Xem thong ke ca nhan cua nguoi khac — chi hien thi tren Profile ban than.
- Block/report nguoi dung.
- Nhan tin/chat truc tiep voi nguoi do.
- Xem danh sach followers/following.

---

## Phu thuoc

- [x] Constitution document ton tai (`.momorph/constitution.md`)
- [ ] API specifications (`.momorph/contexts/api-docs.yaml`)
- [ ] Database design (`.momorph/database.sql`)
- [x] Screen flow documented (`.momorph/SCREENFLOW.md`)

---

## Ghi chu

- Tat ca text PHAI ho tro da ngon ngu VN/EN thong qua he thong i18n (slang).
- Man hinh nay nhan `userId` tu route parameter (go_router).
- Kudos cards tren profile nguoi khac su dung cung component voi Kudos feed va Profile ban than (reusable widget).
- **Khong co** section thong ke (Statistics Container) — chi hien thi tren Profile ban than.
- **Co them** nut CTA "Gui loi cam on" — khong co tren Profile ban than.
- Badge collection hien thi ten huy hieu ben duoi icon (khac voi icon collection cua Profile ban than chi hien thi icon).
- Bottom Navigation Bar van hien thi nhung khong co tab nao active (vi day la man hinh push, khong phai tab).
