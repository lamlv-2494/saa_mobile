# Design Style: [iOS] Sun*Kudos - Viết Kudo (Trạng thái mặc định)

**Frame ID**: `7fFAb-K35a`
**Frame Name**: `[iOS] Sun*Kudos_Viết Kudo_default`
**Figma File Key**: `9ypp4enmFmdK3YAFJLIu6C`
**Ngày trích xuất**: 2026-04-14

---

## Design Tokens

> Trạng thái mặc định sử dụng cùng design tokens với màn hình chính `PV7jBVZU1N`.
> Xem chi tiết tại [design-style.md của PV7jBVZU1N](../PV7jBVZU1N-ios-sun-kudos-gui-loi-chuc/design-style.md).

### Màu sắc bổ sung (trạng thái mặc định)

| Tên Token | Giá trị Hex/RGBA | Opacity | Sử dụng |
|-----------|-----------------|---------|---------|
| --color-button-disabled | `rgba(255, 234, 158, 0.40)` | 40% | Nền nút "Gửi đi" khi disabled |
| --color-text-disabled | `rgba(0, 16, 26, 0.50)` | 50% | Text nút "Gửi đi" khi disabled |
| --color-placeholder | `#999999` | 100% | Placeholder text trong input fields |

---

## Layout Specifications

### Container

| Thuộc tính | Giá trị | Ghi chú |
|-----------|---------|---------|
| width | 375px | iPhone standard |
| height | 812px | Vừa 1 màn hình (không scroll ở trạng thái rỗng) |
| background | `#00101A` | Dark theme |

> Layout structure giống hệt `PV7jBVZU1N`. Xem ASCII art tại [design-style.md của PV7jBVZU1N](../PV7jBVZU1N-ios-sun-kudos-gui-loi-chuc/design-style.md).

---

## Component Style Details — Trạng thái mặc định

### Điểm khác biệt so với trạng thái đã điền

#### B.2. Recipient Dropdown (Default State)

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6885:9297` | - |
| content | Placeholder "Tìm kiếm" | i18n: `t.kudos.send.searchPlaceholder` |
| text-color | `#999999` | `Color(0xFF999999)` |
| border-color | `#998C5F` | Không focus, không error |
| icon | chevron-down, `#999999` | `Assets.icons.icChevronDown.svg()` |

---

#### B.4. Danh hiệu Input (Default State)

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6885:9302` | - |
| content | Placeholder "Danh tặng một danh hiệu cho..." | i18n: `t.kudos.send.titlePlaceholder` |
| text-color | `#999999` | `Color(0xFF999999)` |
| border-color | `#998C5F` | Không focus, không error |

---

#### C. Toolbar (All Inactive)

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6885:9306` | - |
| all-icons-color | `rgba(255,255,255,0.6)` | `Color(0x99FFFFFF)` |
| all-buttons-state | inactive | Không có nút nào active |

---

#### D. Message Textarea (Empty)

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6885:9322` | - |
| content | Placeholder "Hãy gửi gắm lời cám ơn và ghi nhận đến đồng đội tại đây nhé!" | i18n: `t.kudos.send.messagePlaceholder` |
| text-color | `#999999` | `Color(0xFF999999)` |
| border-color | `#998C5F` | Không focus |

---

#### E.2. Tag Group (Empty)

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6885:9328` | - |
| chips | Không có chip nào | `[]` |
| add-button | Visible, enabled | "+ Hashtag (Tối đa 5)" |

---

#### F. Image Section (Empty)

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6885:9346` | - |
| thumbnails | Không có thumbnail nào | `[]` |
| add-button | Visible, enabled | "+ Image (Tối đa 5)" |

---

#### G. Anonymous Toggle (Unchecked)

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6885:9363` | - |
| checked | false | `value: false` |
| checkbox-border | `#998C5F` | Default unchecked |
| checkbox-fill | transparent | Chưa chọn |

---

#### I. Send Button (Disabled)

| Thuộc tính | Giá trị | Flutter |
|-----------|---------|--------|
| **Node ID** | `6891:16833` | - |
| background | `rgba(255, 234, 158, 0.40)` | `Color(0x66FFEA9E)` |
| text-color | `rgba(0, 16, 26, 0.50)` | `Color(0x8000101A)` |
| enabled | false | `onPressed: null` |
| cursor | not-allowed | N/A (mobile) |

---

## Component Hierarchy with Styles (Default State)

```
Screen (bg: #00101A, 375x812)
├── Header Overlay (gradient, z-index: 1)
│   ├── StatusBar (h: 44px)
│   └── NavRow (h: 60px)
│
├── ScrollView (flex: 1, padding: 0 20px)
│   ├── A. Header Text (16px/500, white)
│   │
│   ├── B. Form Fields — ALL EMPTY
│   │   ├── B.1. "Người nhận *" (14px/500, #FFEA9E)
│   │   ├── B.2. Dropdown [placeholder: "Tìm kiếm", color: #999]
│   │   ├── B.3. "Danh hiệu *" (14px/500, #FFEA9E)
│   │   ├── B.4. Input [placeholder: "Danh tặng một danh hiệu cho...", color: #999]
│   │   ├── B.5. "Tiêu chuẩn cộng đồng" (link)
│   │   ├── B.7. Label nội dung
│   │   ├── C. Toolbar [all icons: rgba(255,255,255,0.6) — inactive]
│   │   ├── D. Textarea [placeholder, color: #999]
│   │   ├── D.1. Hint "@mention" (12px/400, #999)
│   │   │
│   │   ├── E. Hashtag — EMPTY
│   │   │   ├── E.1. "Hashtag *"
│   │   │   └── E.2. [+ Hashtag (Tối đa 5)] only
│   │   │
│   │   ├── F. Image — EMPTY
│   │   │   ├── F.1. "Image"
│   │   │   └── [+ Image (Tối đa 5)] only
│   │   │
│   │   └── G. Anonymous [☐ unchecked] "Gửi ẩn danh"
│   │
│   └── Spacer
│
├── Bottom Actions
│   ├── H. Cancel (enabled, bg: #2E3940)
│   └── I. Send (DISABLED, bg: #FFEA9E/40%, text: #00101A/50%)
│
└── Safe Area (34px)
```

---

## Icon Specifications

> Giống với `PV7jBVZU1N`. Xem [design-style.md của PV7jBVZU1N](../PV7jBVZU1N-ios-sun-kudos-gui-loi-chuc/design-style.md#icon-specifications).

---

## Animation & Transitions

| Phần tử | Thuộc tính | Thời lượng | Easing | Trigger |
|---------|-----------|-----------|--------|---------|
| Input border | border-color (#998C5F → #FFEA9E) | 150ms | ease-in-out | Focus |
| Send button | bg-color (40% → 100% opacity) | 200ms | ease-in-out | Form becomes valid |

---

## Ghi chú

- Đây KHÔNG phải màn hình riêng — chỉ là trạng thái (state) ban đầu của `PV7jBVZU1N`.
- Khi implement, xử lý bằng conditional rendering dựa trên `SendKudosState` rỗng.
- Height 812px (ngắn hơn 941px của trạng thái đã điền) cho thấy form vừa 1 screen khi rỗng.
- Nút "Gửi đi" disabled là điểm quan trọng nhất để phân biệt với trạng thái đã điền.
