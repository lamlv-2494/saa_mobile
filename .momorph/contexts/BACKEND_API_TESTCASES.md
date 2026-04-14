# Backend API Test Cases – Sun*Kudos

> Auto-generated from Figma design analysis and frontend test cases.
> Screen: **[iOS] Sun*Kudos** (screenId: fO0Kt19sZZ)
> Last updated: 2026-04-13

---

## 1. GET /api/v1/kudos – List All Kudos

### Description
Returns a paginated list of active Kudos. Supports filtering by hashtag and department (AND logic).

### Test Cases

| ID | Category | Scenario | Input | Expected Output | Status |
|----|----------|----------|-------|-----------------|--------|
| KUDOS_LIST_01 | Positive | List Kudos with default pagination | `GET /kudos` | `200` – Array of KudosItem, meta with page=1, limit=20 | 200 |
| KUDOS_LIST_02 | Positive | List Kudos with custom pagination | `GET /kudos?page=2&limit=10` | `200` – Page 2 with 10 items, correct meta | 200 |
| KUDOS_LIST_03 | Positive | Filter by hashtag | `GET /kudos?hashtag_id=1` | `200` – Only Kudos with hashtag_id=1 | 200 |
| KUDOS_LIST_04 | Positive | Filter by department | `GET /kudos?department_id=3` | `200` – Only Kudos where recipient belongs to department_id=3 | 200 |
| KUDOS_LIST_05 | Positive | Filter by hashtag AND department | `GET /kudos?hashtag_id=1&department_id=3` | `200` – Only Kudos matching BOTH filters (ref: TC_IOS_KUDOS_FUN_004) | 200 |
| KUDOS_LIST_06 | Negative | Filter with no matching results | `GET /kudos?hashtag_id=9999` | `200` – Empty array `[]`, meta.totalItems=0 | 200 |
| KUDOS_LIST_07 | Boundary | Page beyond total pages | `GET /kudos?page=9999` | `200` – Empty array `[]`, hasNextPage=false | 200 |
| KUDOS_LIST_08 | Boundary | Limit = 0 | `GET /kudos?limit=0` | `422` – Validation error: limit must be >= 1 | 422 |
| KUDOS_LIST_09 | Boundary | Limit exceeds max | `GET /kudos?limit=200` | `422` – Validation error: limit must be <= 100 | 422 |
| KUDOS_LIST_10 | Auth | No token | `GET /kudos` (no Bearer) | `401` – UNAUTHORIZED | 401 |
| KUDOS_LIST_11 | Auth | Expired token | `GET /kudos` (expired Bearer) | `401` – UNAUTHORIZED | 401 |
| KUDOS_LIST_12 | Validation | Verify response includes isLikedByMe and canLike | `GET /kudos` (authenticated) | `200` – Each item has `isLikedByMe` (bool) and `canLike` (false for own Kudos) | 200 |
| KUDOS_LIST_13 | Validation | Only active Kudos returned | Insert Kudos with status='hidden', then `GET /kudos` | `200` – Hidden Kudos NOT in results | 200 |
| KUDOS_LIST_14 | Validation | Deleted Kudos excluded | Soft-delete a Kudos, then `GET /kudos` | `200` – Deleted Kudos NOT in results | 200 |

---

## 2. GET /api/v1/kudos/highlight – Highlight Kudos (Top 5)

### Description
Returns the top 5 Kudos sorted by heart count (descending). Supports hashtag and department filters.

### Test Cases

| ID | Category | Scenario | Input | Expected Output | Status |
|----|----------|----------|-------|-----------------|--------|
| KUDOS_HL_01 | Positive | Get top 5 Highlight Kudos | `GET /kudos/highlight` | `200` – Array of max 5 KudosItem sorted by heartCount DESC (ref: TC_IOS_KUDOS_FUN_001) | 200 |
| KUDOS_HL_02 | Positive | Filter highlight by hashtag | `GET /kudos/highlight?hashtag_id=1` | `200` – Top 5 of filtered set (ref: TC_IOS_KUDOS_FUN_030) | 200 |
| KUDOS_HL_03 | Positive | Filter highlight by department | `GET /kudos/highlight?department_id=3` | `200` – Top 5 of filtered set (ref: TC_IOS_KUDOS_FUN_033) | 200 |
| KUDOS_HL_04 | Positive | Filter by hashtag AND department | `GET /kudos/highlight?hashtag_id=1&department_id=3` | `200` – AND logic applied, max 5 results | 200 |
| KUDOS_HL_05 | Negative | No Kudos match filter | `GET /kudos/highlight?hashtag_id=9999` | `200` – Empty array (ref: TC_IOS_KUDOS_FUN_002) | 200 |
| KUDOS_HL_06 | Boundary | Fewer than 5 Kudos in system | (only 3 active Kudos exist) | `200` – Array with 3 items | 200 |
| KUDOS_HL_07 | Validation | Verify sort order | Create Kudos with varying heart counts | `200` – First item has highest heartCount | 200 |
| KUDOS_HL_08 | Auth | No token | `GET /kudos/highlight` (no Bearer) | `401` – UNAUTHORIZED | 401 |

---

## 3. GET /api/v1/kudos/{kudosId} – Kudos Detail

### Description
Returns full detail of a single Kudos including sender/receiver info, message, hashtags, photos, and reaction status.

### Test Cases

| ID | Category | Scenario | Input | Expected Output | Status |
|----|----------|----------|-------|-----------------|--------|
| KUDOS_DET_01 | Positive | Get existing Kudos detail | `GET /kudos/101` | `200` – Full KudosItem with all fields | 200 |
| KUDOS_DET_02 | Positive | Anonymous Kudos detail | `GET /kudos/102` (is_anonymous=true) | `200` – sender.name hidden, anonymousNickname shown | 200 |
| KUDOS_DET_03 | Positive | Kudos with photos | `GET /kudos/103` (has photos) | `200` – photos array populated with imageUrl, sortOrder | 200 |
| KUDOS_DET_04 | Negative | Non-existent Kudos | `GET /kudos/999999` | `404` – NOT_FOUND | 404 |
| KUDOS_DET_05 | Negative | Hidden/deleted Kudos | `GET /kudos/104` (status='hidden') | `404` – NOT_FOUND | 404 |
| KUDOS_DET_06 | Validation | shareUrl is valid deep link | `GET /kudos/101` | `200` – shareUrl matches pattern (ref: TC_IOS_KUDOS_FUN_014, _017) | 200 |
| KUDOS_DET_07 | Auth | No token | `GET /kudos/101` (no Bearer) | `401` – UNAUTHORIZED | 401 |

---

## 4. POST /api/v1/kudos – Send Kudos

### Description
Create a new Kudos from the authenticated user to a recipient. Supports hashtags, images, award category, and anonymous sending.

### Test Cases

| ID | Category | Scenario | Input | Expected Output | Status |
|----|----------|----------|-------|-----------------|--------|
| KUDOS_CREATE_01 | Positive | Send Kudos with minimal fields | `{"recipient_id": 42, "message": "Great work!"}` | `201` – KudosItem created | 201 |
| KUDOS_CREATE_02 | Positive | Send Kudos with all fields | `{"recipient_id": 42, "message": "...", "award_category_name": "MVP", "hashtag_ids": [1,3], "is_anonymous": true, "anonymous_nickname": "Doraemon"}` + photos | `201` – All fields populated | 201 |
| KUDOS_CREATE_03 | Positive | Send with hashtags | `{"recipient_id": 42, "message": "...", "hashtag_ids": [1, 2, 3]}` | `201` – hashtags array populated | 201 |
| KUDOS_CREATE_04 | Negative | Missing recipient_id | `{"message": "Hello"}` | `422` – VALIDATION_ERROR: recipient_id required | 422 |
| KUDOS_CREATE_05 | Negative | Missing message | `{"recipient_id": 42}` | `422` – VALIDATION_ERROR: message required | 422 |
| KUDOS_CREATE_06 | Negative | Send to self | `{"recipient_id": <self_id>, "message": "..."}` | `400` – Cannot send Kudos to yourself | 400 |
| KUDOS_CREATE_07 | Negative | Non-existent recipient | `{"recipient_id": 999999, "message": "..."}` | `404` – Recipient not found | 404 |
| KUDOS_CREATE_08 | Boundary | Message at max length (5000 chars) | `{"recipient_id": 42, "message": "<5000 chars>"}` | `201` – Created successfully | 201 |
| KUDOS_CREATE_09 | Boundary | Message exceeds max length | `{"recipient_id": 42, "message": "<5001 chars>"}` | `422` – VALIDATION_ERROR: message too long | 422 |
| KUDOS_CREATE_10 | Boundary | Empty message | `{"recipient_id": 42, "message": ""}` | `422` – VALIDATION_ERROR: message required | 422 |
| KUDOS_CREATE_11 | Boundary | Max 5 photos | Upload 5 photos | `201` – All 5 photos saved | 201 |
| KUDOS_CREATE_12 | Boundary | Exceed 5 photos | Upload 6 photos | `422` – VALIDATION_ERROR: max 5 photos | 422 |
| KUDOS_CREATE_13 | Validation | Anonymous without nickname | `{"recipient_id": 42, "message": "...", "is_anonymous": true}` | `201` – Created with default anonymous display | 201 |
| KUDOS_CREATE_14 | Validation | Anonymous nickname max length | `{"...", "anonymous_nickname": "<51 chars>"}` | `422` – VALIDATION_ERROR: nickname too long | 422 |
| KUDOS_CREATE_15 | Validation | Invalid hashtag_id | `{"...", "hashtag_ids": [999999]}` | `422` – VALIDATION_ERROR: invalid hashtag | 422 |
| KUDOS_CREATE_16 | Auth | No token | `POST /kudos` (no Bearer) | `401` – UNAUTHORIZED | 401 |

---

## 5. POST /api/v1/kudos/{kudosId}/reactions – Like Kudos

### Description
Add a heart reaction to a Kudos. Business rules: one like per user per Kudos, sender cannot like own, special day x2.

### Test Cases

| ID | Category | Scenario | Input | Expected Output | Status |
|----|----------|----------|-------|-----------------|--------|
| REACT_LIKE_01 | Positive | Like a Kudos (normal day) | `POST /kudos/101/reactions` | `201` – heartCount incremented by 1, isLikedByMe=true (ref: TC_IOS_KUDOS_FUN_007) | 201 |
| REACT_LIKE_02 | Positive | Like a Kudos (special day) | `POST /kudos/101/reactions` (bonus active) | `201` – heartCount incremented by 2, heartsAwarded=2 (ref: TC_IOS_KUDOS_FUN_010) | 201 |
| REACT_LIKE_03 | Negative | Like own Kudos | `POST /kudos/<own_kudos_id>/reactions` | `400` – CANNOT_LIKE_OWN: sender cannot like own Kudos (ref: TC_IOS_KUDOS_FUN_008) | 400 |
| REACT_LIKE_04 | Negative | Like already liked Kudos | `POST /kudos/101/reactions` (already liked) | `409` – ALREADY_LIKED (ref: TC_IOS_KUDOS_FUN_007) | 409 |
| REACT_LIKE_05 | Negative | Like non-existent Kudos | `POST /kudos/999999/reactions` | `404` – NOT_FOUND | 404 |
| REACT_LIKE_06 | Validation | Verify sender heart count updated | Like Kudos by User B → check User B's hearts_received | `201` – sender's hearts_received increases (ref: TC_IOS_KUDOS_FUN_032) | 201 |
| REACT_LIKE_07 | Auth | No token | `POST /kudos/101/reactions` (no Bearer) | `401` – UNAUTHORIZED | 401 |

---

## 6. DELETE /api/v1/kudos/{kudosId}/reactions – Unlike Kudos

### Description
Remove a heart reaction from a Kudos. Hearts withdrawn: 1 normal, 2 on special days.

### Test Cases

| ID | Category | Scenario | Input | Expected Output | Status |
|----|----------|----------|-------|-----------------|--------|
| REACT_UNLIKE_01 | Positive | Unlike a Kudos (normal day) | `DELETE /kudos/101/reactions` | `200` – heartCount decremented by 1, isLikedByMe=false (ref: TC_IOS_KUDOS_FUN_009) | 200 |
| REACT_UNLIKE_02 | Positive | Unlike a Kudos (special day) | `DELETE /kudos/101/reactions` (bonus active) | `200` – heartCount decremented by 2 (ref: TC_IOS_KUDOS_FUN_009) | 200 |
| REACT_UNLIKE_03 | Negative | Unlike Kudos not liked | `DELETE /kudos/101/reactions` (never liked) | `404` – Reaction not found | 404 |
| REACT_UNLIKE_04 | Negative | Unlike non-existent Kudos | `DELETE /kudos/999999/reactions` | `404` – NOT_FOUND | 404 |
| REACT_UNLIKE_05 | Auth | No token | `DELETE /kudos/101/reactions` (no Bearer) | `401` – UNAUTHORIZED | 401 |

---

## 7. GET /api/v1/kudos/spotlight – Spotlight Board Data

### Description
Returns network graph data (nodes + edges) for the Spotlight Board visualization.

### Test Cases

| ID | Category | Scenario | Input | Expected Output | Status |
|----|----------|----------|-------|-----------------|--------|
| SPOT_DATA_01 | Positive | Get Spotlight data with Kudos | `GET /kudos/spotlight` | `200` – nodes array, edges array, totalKudos count | 200 |
| SPOT_DATA_02 | Positive | Verify totalKudos matches DB | `GET /kudos/spotlight` | `200` – totalKudos equals COUNT of active Kudos (ref: TC_IOS_KUDOS_FUN_012) | 200 |
| SPOT_DATA_03 | Negative | No Kudos in system | (empty DB) | `200` – nodes=[], edges=[], totalKudos=0 (ref: TC_IOS_KUDOS_FUN_011) | 200 |
| SPOT_DATA_04 | Validation | Edge weight accuracy | User A sends 3 Kudos to User B | `200` – Edge from A→B has weight=3 | 200 |
| SPOT_DATA_05 | Auth | No token | `GET /kudos/spotlight` (no Bearer) | `401` – UNAUTHORIZED | 401 |

---

## 8. GET /api/v1/kudos/spotlight/search – Spotlight Search

### Description
Search for a Sunner within the Spotlight network. Returns matched node(s) to highlight on the chart.

### Test Cases

| ID | Category | Scenario | Input | Expected Output | Status |
|----|----------|----------|-------|-----------------|--------|
| SPOT_SEARCH_01 | Positive | Search existing Sunner | `GET /kudos/spotlight/search?q=Dương` | `200` – Array with matching users (ref: TC_IOS_KUDOS_FUN_028) | 200 |
| SPOT_SEARCH_02 | Negative | Search non-existent Sunner | `GET /kudos/spotlight/search?q=xyznotexist123` | `200` – Empty array (ref: TC_IOS_KUDOS_FUN_036) | 200 |
| SPOT_SEARCH_03 | Boundary | Query at max length (100 chars) | `GET /kudos/spotlight/search?q=<100 chars>` | `200` – Search executes (ref: TC_IOS_KUDOS_FUN_035) | 200 |
| SPOT_SEARCH_04 | Boundary | Query exceeds max (101 chars) | `GET /kudos/spotlight/search?q=<101 chars>` | `422` – VALIDATION_ERROR: max 100 chars (ref: TC_IOS_KUDOS_FUN_034) | 422 |
| SPOT_SEARCH_05 | Boundary | Empty query | `GET /kudos/spotlight/search?q=` | `422` – VALIDATION_ERROR: q is required | 422 |
| SPOT_SEARCH_06 | Auth | No token | `GET /kudos/spotlight/search?q=test` (no Bearer) | `401` – UNAUTHORIZED | 401 |

---

## 9. GET /api/v1/kudos/stats/total – Total Kudos Count

### Description
Returns the total count of active Kudos. Displayed on Spotlight Board header.

### Test Cases

| ID | Category | Scenario | Input | Expected Output | Status |
|----|----------|----------|-------|-----------------|--------|
| STATS_TOTAL_01 | Positive | Get total count | `GET /kudos/stats/total` | `200` – `{ data: { totalKudos: N } }` | 200 |
| STATS_TOTAL_02 | Positive | Count updates after new Kudos | Create Kudos, then `GET /kudos/stats/total` | `200` – totalKudos = previous + 1 (ref: TC_IOS_KUDOS_FUN_012) | 200 |
| STATS_TOTAL_03 | Validation | Only active Kudos counted | Insert hidden Kudos, check count | `200` – Hidden Kudos NOT counted | 200 |
| STATS_TOTAL_04 | Auth | No token | `GET /kudos/stats/total` (no Bearer) | `401` – UNAUTHORIZED | 401 |

---

## 10. GET /api/v1/users/me/stats – Personal Statistics

### Description
Returns the authenticated user's personal stats (Kudos received/sent, hearts, secret boxes, star badge, bonus status).

### Test Cases

| ID | Category | Scenario | Input | Expected Output | Status |
|----|----------|----------|-------|-----------------|--------|
| USER_STATS_01 | Positive | Get stats for user with data | `GET /users/me/stats` | `200` – All stat fields populated | 200 |
| USER_STATS_02 | Positive | New user with zero stats | `GET /users/me/stats` (new user) | `200` – All counts = 0, starBadgeLevel = 0, isBonusActive from config | 200 |
| USER_STATS_03 | Validation | Star badge level = 1 at 10 Kudos | User has received 10 Kudos | `200` – starBadgeLevel = 1 (ref: TC_IOS_KUDOS_FUN_006) | 200 |
| USER_STATS_04 | Validation | Star badge level = 2 at 20 Kudos | User has received 20 Kudos | `200` – starBadgeLevel = 2 (ref: TC_IOS_KUDOS_FUN_006) | 200 |
| USER_STATS_05 | Validation | Star badge level = 3 at 50 Kudos | User has received 50 Kudos | `200` – starBadgeLevel = 3 (ref: TC_IOS_KUDOS_FUN_006) | 200 |
| USER_STATS_06 | Validation | x2 bonus flag reflects config | Admin activates bonus | `200` – isBonusActive = true (ref: TC_IOS_KUDOS_FUN_013) | 200 |
| USER_STATS_07 | Auth | No token | `GET /users/me/stats` (no Bearer) | `401` – UNAUTHORIZED | 401 |

---

## 11. GET /api/v1/users/me/secret-boxes/next – Next Unopened Secret Box

### Description
Returns the next unopened Secret Box for the authenticated user.

### Test Cases

| ID | Category | Scenario | Input | Expected Output | Status |
|----|----------|----------|-------|-----------------|--------|
| SBOX_NEXT_01 | Positive | Has unopened boxes | `GET /users/me/secret-boxes/next` | `200` – SecretBox with isOpened=false | 200 |
| SBOX_NEXT_02 | Negative | No unopened boxes | `GET /users/me/secret-boxes/next` (all opened) | `204` – No Content (ref: TC_IOS_KUDOS_FUN_039) | 204 |
| SBOX_NEXT_03 | Auth | No token | `GET /users/me/secret-boxes/next` (no Bearer) | `401` – UNAUTHORIZED | 401 |

---

## 12. POST /api/v1/users/me/secret-boxes/{boxId}/open – Open Secret Box

### Description
Open a specific Secret Box. Returns the reward. Idempotent (double-tap safe).

### Test Cases

| ID | Category | Scenario | Input | Expected Output | Status |
|----|----------|----------|-------|-----------------|--------|
| SBOX_OPEN_01 | Positive | Open unopened box | `POST /users/me/secret-boxes/77/open` | `200` – rewardType, rewardValue, openedAt (ref: TC_IOS_KUDOS_FUN_024) | 200 |
| SBOX_OPEN_02 | Negative | Open already opened box | `POST /users/me/secret-boxes/77/open` (already opened) | `400` – BOX_ALREADY_OPENED (ref: TC_IOS_KUDOS_FUN_025 – idempotent) | 400 |
| SBOX_OPEN_03 | Negative | Open another user's box | `POST /users/me/secret-boxes/88/open` (belongs to other user) | `403` – FORBIDDEN | 403 |
| SBOX_OPEN_04 | Negative | Non-existent box | `POST /users/me/secret-boxes/999999/open` | `404` – NOT_FOUND | 404 |
| SBOX_OPEN_05 | Validation | Stats updated after opening | Open box, then `GET /users/me/stats` | secretBoxesOpened +1, secretBoxesUnopened -1 | 200 |
| SBOX_OPEN_06 | Auth | No token | `POST /users/me/secret-boxes/77/open` (no Bearer) | `401` – UNAUTHORIZED | 401 |

---

## 13. GET /api/v1/kudos/top-recipients – Top 10 Gift Recipients

### Description
Returns the top 10 Sunners who received the most recent gifts/rewards.

### Test Cases

| ID | Category | Scenario | Input | Expected Output | Status |
|----|----------|----------|-------|-----------------|--------|
| TOP_REC_01 | Positive | Get top 10 with data | `GET /kudos/top-recipients` | `200` – Array of max 10 items, sorted by recency | 200 |
| TOP_REC_02 | Negative | No recipients in system | (empty DB) | `200` – Empty array (ref: TC_IOS_KUDOS_FUN_003) | 200 |
| TOP_REC_03 | Boundary | Fewer than 10 recipients | (only 5 recipients) | `200` – Array with 5 items | 200 |
| TOP_REC_04 | Validation | Rank ordering correctness | Multiple recipients with different gift counts | `200` – Sorted by giftCount DESC, then latestGiftAt DESC | 200 |
| TOP_REC_05 | Auth | No token | `GET /kudos/top-recipients` (no Bearer) | `401` – UNAUTHORIZED | 401 |

---

## 14. GET /api/v1/hashtags – List Hashtags

### Description
Returns all available hashtags for the filter bottom sheet.

### Test Cases

| ID | Category | Scenario | Input | Expected Output | Status |
|----|----------|----------|-------|-----------------|--------|
| HASH_LIST_01 | Positive | List all hashtags | `GET /hashtags` | `200` – Array of Hashtag objects with id and name | 200 |
| HASH_LIST_02 | Negative | No hashtags in system | (empty hashtags table) | `200` – Empty array | 200 |
| HASH_LIST_03 | Auth | No token | `GET /hashtags` (no Bearer) | `401` – UNAUTHORIZED | 401 |

---

## 15. GET /api/v1/departments – List Departments

### Description
Returns all departments for the filter bottom sheet.

### Test Cases

| ID | Category | Scenario | Input | Expected Output | Status |
|----|----------|----------|-------|-----------------|--------|
| DEPT_LIST_01 | Positive | List all departments | `GET /departments` | `200` – Array with id, name, code | 200 |
| DEPT_LIST_02 | Negative | No departments in system | (empty table) | `200` – Empty array | 200 |
| DEPT_LIST_03 | Auth | No token | `GET /departments` (no Bearer) | `401` – UNAUTHORIZED | 401 |

---

## 16. GET /api/v1/users/search – Search Sunners

### Description
Search Sunners by name. Used for recipient selection in Send Kudos and general search.

### Test Cases

| ID | Category | Scenario | Input | Expected Output | Status |
|----|----------|----------|-------|-----------------|--------|
| USER_SEARCH_01 | Positive | Search existing user by name | `GET /users/search?q=Dương` | `200` – Array of UserSummary matching "Dương" | 200 |
| USER_SEARCH_02 | Positive | Partial name match | `GET /users/search?q=Xuân` | `200` – Users with "Xuân" in name | 200 |
| USER_SEARCH_03 | Negative | No match | `GET /users/search?q=xyznotexist` | `200` – Empty array | 200 |
| USER_SEARCH_04 | Boundary | Query = 1 character | `GET /users/search?q=D` | `200` – Results matching "D" | 200 |
| USER_SEARCH_05 | Boundary | Query at max (100 chars) | `GET /users/search?q=<100 chars>` | `200` – Executes search | 200 |
| USER_SEARCH_06 | Boundary | Empty query | `GET /users/search?q=` | `422` – VALIDATION_ERROR: q required | 422 |
| USER_SEARCH_07 | Validation | Response includes department | `GET /users/search?q=Dương` | `200` – Each result has departmentCode | 200 |
| USER_SEARCH_08 | Auth | No token | `GET /users/search?q=test` (no Bearer) | `401` – UNAUTHORIZED | 401 |

---

## 17. GET /api/v1/config/bonus – Bonus Configuration

### Description
Returns current bonus multiplier configuration (x2 Fire Bonus status).

### Test Cases

| ID | Category | Scenario | Input | Expected Output | Status |
|----|----------|----------|-------|-----------------|--------|
| CONFIG_BONUS_01 | Positive | Bonus not active | `GET /config/bonus` | `200` – isBonusActive=false, heartMultiplier=1 | 200 |
| CONFIG_BONUS_02 | Positive | Bonus active | `GET /config/bonus` (admin activated) | `200` – isBonusActive=true, heartMultiplier=2 (ref: TC_IOS_KUDOS_FUN_010) | 200 |
| CONFIG_BONUS_03 | Validation | Date fields present when active | `GET /config/bonus` (bonus active) | `200` – bonusStartDate and bonusEndDate are not null | 200 |
| CONFIG_BONUS_04 | Auth | No token | `GET /config/bonus` (no Bearer) | `401` – UNAUTHORIZED | 401 |

---

## Integration Scenarios

### Flow 1: Complete Kudos Send → View Flow

| Step | Action | Expected |
|------|--------|----------|
| 1 | `GET /users/search?q=Dương` | Find recipient |
| 2 | `GET /hashtags` | Get available hashtags |
| 3 | `POST /kudos` with recipient, message, hashtags, photo | `201` – Kudos created |
| 4 | `GET /kudos/<new_id>` | `200` – Full detail visible |
| 5 | `GET /kudos` | `200` – New Kudos appears in feed |
| 6 | `GET /kudos/stats/total` | `200` – totalKudos increased |

### Flow 2: Like → Unlike → Stats Verification

| Step | Action | Expected |
|------|--------|----------|
| 1 | `GET /config/bonus` | Check if bonus active |
| 2 | `POST /kudos/101/reactions` | `201` – Liked, heartCount +1 (or +2) |
| 3 | `GET /kudos/101` | `200` – isLikedByMe=true |
| 4 | `GET /users/me/stats` | heartsReceivedCount updated for sender |
| 5 | `DELETE /kudos/101/reactions` | `200` – Unliked, heartCount -1 (or -2) |
| 6 | `GET /kudos/101` | `200` – isLikedByMe=false |

### Flow 3: Filter → Highlight + All Kudos Sync

| Step | Action | Expected |
|------|--------|----------|
| 1 | `GET /hashtags` | Get hashtag list |
| 2 | `GET /kudos/highlight?hashtag_id=1` | Highlight filtered by hashtag |
| 3 | `GET /kudos?hashtag_id=1` | All Kudos filtered by same hashtag |
| 4 | Both results contain only Kudos with hashtag_id=1 | Consistent filter (ref: TC_IOS_KUDOS_FUN_030) |
| 5 | `GET /departments` | Get department list |
| 6 | `GET /kudos/highlight?hashtag_id=1&department_id=3` | AND filter applied |
| 7 | `GET /kudos?hashtag_id=1&department_id=3` | Same AND filter (ref: TC_IOS_KUDOS_FUN_004) |

### Flow 4: Secret Box Opening

| Step | Action | Expected |
|------|--------|----------|
| 1 | `GET /users/me/stats` | Check secretBoxesUnopened > 0 |
| 2 | `GET /users/me/secret-boxes/next` | `200` – Get box ID |
| 3 | `POST /users/me/secret-boxes/<id>/open` | `200` – Reward received |
| 4 | `POST /users/me/secret-boxes/<id>/open` (duplicate) | `400` – Already opened (idempotent) |
| 5 | `GET /users/me/stats` | secretBoxesOpened +1, secretBoxesUnopened -1 |

### Flow 5: Token Refresh

| Step | Action | Expected |
|------|--------|----------|
| 1 | `GET /kudos` with expired token | `401` – UNAUTHORIZED |
| 2 | Refresh token via Supabase auth | New access token |
| 3 | `GET /kudos` with new token | `200` – Success |

---

## Test Data Requirements

| Entity | Requirement | Notes |
|--------|-------------|-------|
| Users | Min 10 users across 3+ departments | Include users in CECV1, Division A, etc. |
| Kudos | Min 20 active Kudos | Varying heart counts for highlight testing |
| Kudos (anonymous) | Min 2 anonymous Kudos | With nickname "Doraemon" etc. |
| Kudos (with photos) | Min 2 Kudos with photos | 1-5 photos each |
| Hashtags | Min 5 hashtags | #teamwork, #BE OPTIMISTIC, #WASSHO!, #BE A TEAM, etc. |
| Reactions | Varied reactions across Kudos | For like/unlike testing |
| Secret Boxes | Min 3 per test user | Mix of opened and unopened |
| Campaigns (bonus) | 1 active special day campaign | For x2 heart testing |
| Star badge users | Users with 10, 20, 50 Kudos received | For badge level testing |

---

## Summary

| Metric | Count |
|--------|-------|
| Total Endpoints | 17 |
| Total Test Cases | 107 |
| Positive Tests | 34 |
| Negative Tests | 27 |
| Boundary Tests | 16 |
| Validation Tests | 16 |
| Auth Tests | 14 |
| Integration Flows | 5 |
