# Screen Spec: [iOS] Home

## Screen Info

| Key | Value |
|-----|-------|
| Screen ID | OuH1BUTYT0 |
| Frame ID | 6885:8978 |
| Status | discovered |
| Platform | iOS |
| Screen Type | Home / Landing |

## Description

The Home screen is the main landing page of the SAA (Sun* Annual Awards) 2025 mobile app. It serves as the central hub featuring the "ROOT FURTHER" event branding, a countdown timer to the event date (26/12/2025), event details (time and venue), and quick navigation to the Awards system and Kudos recognition feature. The screen has a dark, premium-themed background with gold accents.

## Navigation Analysis

### Incoming Navigation

| From Screen | Trigger | Confidence |
|-------------|---------|------------|
| [iOS] Login | Successful authentication | High |
| Any screen (via Bottom Nav) | Tap "SAA 2025" tab | High |

### Outgoing Navigation

| Target Screen | Trigger | Component | Confidence |
|---------------|---------|-----------|------------|
| [iOS] Language dropdown | Tap language switcher (VN flag) | mms_1_header > language | High |
| [iOS] Sun*Kudos_Searching | Tap search icon | mms_1_header > mm_media_search | High |
| Notifications panel | Tap notification bell | mms_1_header > mm_media_notification | High |
| [iOS] Thể lệ / Awards overview | Tap "ABOUT AWARD" button | mms_2.2_Button | High |
| [iOS] Sun*Kudos / Kudos overview | Tap "ABOUT KUDOS" button | mms_2.3_Button | High |
| [iOS] Award_Top talent (or specific award) | Tap "Chi tiết" on award card | mms_4.2_award list > Button | High |
| [iOS] Sun*Kudos (Kudos detail) | Tap "Chi tiết" in Kudos section | mms_5.3_Button | High |
| [iOS] Sun*Kudos_Gửi lời chúc Kudos | Tap Pencil icon on FAB | mms_6_float button > Pen | High |
| [iOS] Sun*Kudos_All Kudos | Tap S/Kudos icon on FAB | mms_6_float button > Kudos Logo | High |
| [iOS] Home (current - active) | Tap "SAA 2025" bottom tab | mms_7_nav bar > saa | High |
| Awards screen | Tap "Awards" bottom tab | mms_7_nav bar > awards | High |
| [iOS] Sun*Kudos | Tap "Kudos" bottom tab | mms_7_nav bar > kudo | High |
| [iOS] Profile bản thân | Tap "Profile" bottom tab | mms_7_nav bar > profile | High |

## Component Schema

### Layout

```
FRAME: [iOS] Home (393 x 1262)
├── INSTANCE: mms_1_header (Header Bar)
│   ├── StatusBar (iOS system status bar)
│   ├── mm_media_logo (SAA 2025 logo)
│   └── actions
│       ├── language (VN flag + dropdown)
│       ├── mm_media_search (search icon)
│       └── mm_media_notification (bell + badge dot)
│
├── GROUP: mm_media_bg (Background visuals)
│   ├── Shadow Left
│   ├── MM_MEDIA_Keyvisual BG
│   └── Shadow Bottom
│
├── FRAME: mms_2_content (Hero Content Area)
│   ├── INSTANCE: mms_2.1_MM_MEDIA_Logo/RootFuther (Theme logo)
│   ├── FRAME: countdown time
│   │   ├── TEXT: "Coming soon"
│   │   └── FRAME: countdown
│   │       ├── days (20 DAYS)
│   │       ├── hours (20 HOURS)
│   │       └── minutes (20 MINUTES)
│   ├── FRAME: event info
│   │   ├── time: "Thời gian: 26/12/2025"
│   │   ├── venue: "Địa điểm: Âu Cơ Art Center"
│   │   └── livestream: "Tường thuật trực tiếp tại Group Facebook Sun* Family"
│   └── FRAME: actions
│       ├── INSTANCE: mms_2.2_Button ("ABOUT AWARD")
│       └── INSTANCE: mms_2.3_Button ("ABOUT KUDOS")
│
├── FRAME: mms_3_note (Theme Description Text)
│   └── TEXT: "Root Further is not merely a name..." (long description)
│
├── FRAME: mms_4_awards (Awards Section)
│   ├── INSTANCE: mms_4.1_header
│   │   ├── TEXT: "Sun* Annual Awards 2025"
│   │   └── TEXT: "Hệ thống giải thưởng"
│   └── FRAME: mms_4.2_award list (horizontal scroll)
│       ├── INSTANCE: Top Talent Award card
│       ├── INSTANCE: Top Project Award card
│       └── INSTANCE: (more award cards...)
│
├── FRAME: mms_5_kudos (Kudos Section)
│   ├── INSTANCE: mms_5.1_header
│   │   ├── TEXT: "Phong trào ghi nhận"
│   │   └── TEXT: "Sun* Kudos"
│   ├── FRAME: mms_5.2_mm_media_Sunkudos (Banner image)
│   ├── FRAME: note
│   │   └── TEXT: "ĐIỂM MỚI CỦA SAA 2025..." (description)
│   └── INSTANCE: mms_5.3_Button ("Chi tiết")
│
├── INSTANCE: mms_6_float button (Floating Action Button)
│   ├── MM_MEDIA_Pen (Write Kudos)
│   └── MM_MEDIA_IC_Kudos Logo (Kudos feed)
│
└── INSTANCE: mms_7_nav bar (Bottom Navigation)
    ├── saa (Home - active)
    ├── awards
    ├── kudo
    └── profile
```

### Component Hierarchy

| Level | Component | Type | Count |
|-------|-----------|------|-------|
| Organism | Header (mms_1_header) | Navigation | 1 |
| Organism | Hero Content (mms_2_content) | Info Block | 1 |
| Organism | Awards Section (mms_4_awards) | Card List | 1 |
| Organism | Kudos Section (mms_5_kudos) | Info Block | 1 |
| Organism | Bottom Nav (mms_7_nav bar) | Navigation | 1 |
| Molecule | Countdown Timer | Display | 1 |
| Molecule | Event Info | Display | 1 |
| Molecule | Award Card | Card | 3 (scrollable) |
| Molecule | Kudos Banner | Display | 1 |
| Molecule | FAB (mms_6_float button) | Action | 1 |
| Atom | Language Switcher | Button | 1 |
| Atom | Search Icon | Button | 1 |
| Atom | Notification Bell | Button (with badge) | 1 |
| Atom | ABOUT AWARD Button | Button | 1 |
| Atom | ABOUT KUDOS Button | Button | 1 |
| Atom | Chi tiết Button (Awards) | Button | per card |
| Atom | Chi tiết Button (Kudos) | Button | 1 |
| Atom | Nav Tab Item | Button | 4 |

### Main Components (7 sections)

1. **mms_1_header** - Global header with logo, language switcher, search, and notifications
2. **mm_media_bg** - Full-screen background visual (key visual)
3. **mms_2_content** - Hero section with theme logo, countdown, event info, CTA buttons
4. **mms_3_note** - Theme description text block
5. **mms_4_awards** - Award system section with horizontal card list
6. **mms_5_kudos** - Kudos recognition feature section with banner and CTA
7. **mms_6_float button** - Floating action button (Write Kudos + Kudos feed)
8. **mms_7_nav bar** - Bottom navigation bar (4 tabs)

## Form Fields

N/A - This screen has no form inputs.

## API Mapping

### On Load

| Method | Endpoint | Purpose | Response |
|--------|----------|---------|----------|
| GET | /api/event/countdown | Fetch countdown target date and event info | `{ targetDate, venue, livestreamUrl }` |
| GET | /api/awards | Fetch list of award categories | `[{ id, name, description, imageUrl }]` |
| GET | /api/kudos/info | Fetch Kudos section content | `{ title, description, bannerUrl, isEnabled }` |
| GET | /api/notifications/unread-count | Fetch unread notification count for badge | `{ count }` |

### On User Action

| Action | Method | Endpoint | Purpose |
|--------|--------|----------|---------|
| Tap award card "Chi tiết" | GET | /api/awards/:id | Load specific award detail |

## State Management

### Local State

| State | Type | Default | Description |
|-------|------|---------|-------------|
| countdownDays | int | 0 | Days remaining until event |
| countdownHours | int | 0 | Hours remaining |
| countdownMinutes | int | 0 | Minutes remaining |
| isCountdownExpired | bool | false | Whether the event date has passed |
| selectedLanguage | String | "VN" | Currently selected language |
| unreadNotificationCount | int | 0 | Badge count for notification bell |

### Global State (Riverpod)

| Provider | Type | Description |
|----------|------|-------------|
| awardsProvider | AsyncValue<List<Award>> | Award categories data |
| kudosInfoProvider | AsyncValue<KudosInfo> | Kudos section info |
| eventCountdownProvider | AsyncValue<EventCountdown> | Event countdown data |
| notificationCountProvider | AsyncValue<int> | Unread notification count |
| currentLocaleProvider | StateProvider<Locale> | App language setting |

## UI States

### Loading

- Shimmer/skeleton placeholders for countdown timer area
- Skeleton cards in the awards horizontal list
- Skeleton block for Kudos section

### Error

- Retry button with error message if main content fails to load
- Individual sections can fail independently (awards list may show error while countdown works)

### Success

- Countdown timer ticking in real-time
- Award cards populated with images and text
- Kudos banner and description visible

### Empty

- Awards section: "No awards available" placeholder if API returns empty list
- Kudos section: Hidden or "Coming soon" if feature is disabled

### Countdown Expired

- Replace countdown with "Event Started" or "Event Ended" label
- Potentially change CTA buttons behavior

## Analysis Metadata

| Key | Value |
|-----|-------|
| Analyzed Date | 2026-04-10 |
| Confidence | High |
| Complexity | Medium |
| Notes | Main landing screen; real-time countdown is the most complex interactive element; horizontal scroll for awards cards requires careful performance handling |
