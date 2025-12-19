---
name: guideline-datetime
description: 日時処理、タイムゾーン、Date オブジェクト、UTC変換、moment.js、date-fns、dayjs の実装ガイド。日付計算、時刻表示、期間計算、スケジュール機能、予約システムが含まれるコードの際に自動参照。
---

# 日時処理ガイドライン

## 基本原則

### 1. 内部表現はUTCオフセット付き（ISO 8601）
- データベース保存、API通信、内部処理は全てUTCオフセット付きで扱う
- 例: `2024-12-19T10:30:00+09:00` または `2024-12-19T01:30:00Z`

### 2. タイムゾーン変換はUI層のみ
- ユーザーへの表示時のみローカルタイムゾーンに変換
- ユーザー入力を受け取った瞬間にUTCオフセット付きに変換
- ビジネスロジック内ではタイムゾーンを意識しない

### 3. 日時ライブラリを使用する
- JavaScriptの`Date`オブジェクトを直接操作しない
- 推奨: `date-fns`（関数型、tree-shakable）、`dayjs`（軽量、moment互換）
- `moment.js`は非推奨（メンテナンスモード、サイズ大）

---

## アンチパターン

### ローカルタイムをそのままDB保存
```typescript
// NG: タイムゾーン情報が失われる
const date = new Date();
await db.save({ createdAt: date.toLocaleString() });

// OK: ISO 8601形式で保存
await db.save({ createdAt: date.toISOString() });
```

### タイムゾーンなしの日時文字列
```typescript
// NG: どのタイムゾーンか不明
const dateStr = "2024-12-19 10:30:00";

// OK: オフセット付き
const dateStr = "2024-12-19T10:30:00+09:00";
```

### 自前での日付計算
```typescript
// NG: うるう年、月末処理などバグの温床
const nextMonth = new Date(date);
nextMonth.setMonth(date.getMonth() + 1);

// OK: ライブラリを使用
import { addMonths } from 'date-fns';
const nextMonth = addMonths(date, 1);
```

### Date.now()の直接使用（テスト困難）
```typescript
// NG: テスト時にモックしづらい
const isExpired = Date.now() > expiresAt;

// OK: 現在時刻を注入可能にする
const isExpired = (now: Date) => now.getTime() > expiresAt;
```

---

## 推奨パターン

### date-fnsを使った日時処理
```typescript
import { format, addDays, parseISO, isAfter } from 'date-fns';
import { formatInTimeZone } from 'date-fns-tz';

// パース
const date = parseISO('2024-12-19T10:30:00+09:00');

// 計算
const nextWeek = addDays(date, 7);

// 比較
const isExpired = isAfter(new Date(), expiresAt);

// フォーマット（表示用）
const display = format(date, 'yyyy/MM/dd HH:mm');

// タイムゾーン指定でフォーマット
const tokyo = formatInTimeZone(date, 'Asia/Tokyo', 'yyyy-MM-dd HH:mm:ss');
```

### dayjsを使った日時処理
```typescript
import dayjs from 'dayjs';
import utc from 'dayjs/plugin/utc';
import timezone from 'dayjs/plugin/timezone';

dayjs.extend(utc);
dayjs.extend(timezone);

// UTC変換
const utcTime = dayjs().utc();

// タイムゾーン変換（表示用）
const tokyoTime = dayjs().tz('Asia/Tokyo').format('YYYY-MM-DD HH:mm:ss');

// ISO 8601形式で出力
const isoString = dayjs().toISOString();
```

### 期間・範囲の扱い
```typescript
// 期間は開始と終了を明示的に持つ
interface DateRange {
  start: Date;  // inclusive
  end: Date;    // exclusive（推奨）
}

// 「終了日を含むか」は明示的に決める
// exclusive: [start, end) - 重複判定が簡単
// inclusive: [start, end] - ユーザー入力に近い
```

---

## 学習した知識

<!-- PR学習スキルで追記されるセクション -->
<!-- 形式:
### [タイトル]
**学習元**: PR#xxx (yyyy-mm-dd)
**内容**:
-->
