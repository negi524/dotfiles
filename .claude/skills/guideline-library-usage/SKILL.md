---
name: guideline-library-usage
description: ライブラリ選定、既存ライブラリの活用、自前実装を避けるべき場面のガイド。機能実装、ユーティリティ作成、新機能追加の際に自動参照し、適切なライブラリ使用を促す。
---

# ライブラリ活用ガイドライン

## 基本原則

### 1. 車輪の再発明をしない
- 一般的な問題には既存のライブラリを使用する
- 「簡単だから自分で書ける」は理由にならない
- ライブラリはエッジケースやバグ修正の蓄積がある

### 2. 適切なライブラリを選ぶ
- メンテナンスが継続されているか確認
- コミュニティの規模とアクティビティを確認
- ライセンスを確認（商用利用可否など）

### 3. 依存を適切に管理する
- 必要以上に依存を増やさない
- 軽量な代替があれば検討する
- セキュリティアップデートに追従できる体制を維持

---

## 自前実装すべきでない領域

### 絶対にライブラリを使うべき
| 領域 | 理由 | 推奨ライブラリ例 |
|------|------|-----------------|
| 暗号化・ハッシュ | セキュリティリスクが高い | bcrypt, argon2, crypto-js |
| 認証・認可 | 脆弱性の温床 | passport, next-auth, Auth0 SDK |
| 日付・時刻処理 | エッジケースが多い | date-fns, dayjs |
| バリデーション | 網羅性が重要 | zod, yup, joi |
| HTTP通信 | エラー処理が複雑 | axios, ky, fetch polyfill |
| SQLクエリビルド | SQLインジェクションリスク | Prisma, Drizzle, Knex |
| HTML/CSSパース | XSSリスク | DOMPurify, sanitize-html |
| メール送信 | 規格が複雑 | nodemailer, SendGrid SDK |
| 画像処理 | 複雑なフォーマット対応 | sharp, jimp |

### 検討すべき（規模による）
| 領域 | 小規模なら自前可 | 大規模なら推奨 |
|------|-----------------|---------------|
| 状態管理 | useState/useReducer | Zustand, Jotai |
| フォーム管理 | 素のReact | react-hook-form |
| テーブル表示 | 単純なmap | TanStack Table |
| アニメーション | CSS Transition | Framer Motion |

---

## ライブラリ選定基準

### 必須チェック項目
1. **最終更新日**: 6ヶ月以内に更新があるか
2. **Issue対応**: 重大なIssueが放置されていないか
3. **ダウンロード数**: 週間ダウンロード数が一定以上か
4. **TypeScript対応**: 型定義が提供されているか
5. **ライセンス**: プロジェクトで使用可能か

### 比較時の観点
```markdown
## ライブラリ比較テンプレート

| 観点 | ライブラリA | ライブラリB |
|------|------------|------------|
| バンドルサイズ | | |
| Tree-shaking | | |
| 型サポート | | |
| 学習コスト | | |
| コミュニティ | | |
| 既存コードとの親和性 | | |
```

---

## アンチパターン

### 簡単だから自前実装
```typescript
// NG: 「簡単だから」でメール正規表現を自作
const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

// OK: バリデーションライブラリを使用
import { z } from 'zod';
const emailSchema = z.string().email();
```

### 依存を避けすぎる
```typescript
// NG: fetchのラッパーを自作してエラー処理を漏らす
async function myFetch(url: string) {
  const res = await fetch(url);
  return res.json(); // エラー処理なし
}

// OK: 実績あるHTTPクライアントを使用
import ky from 'ky';
const data = await ky.get(url).json();
```

### 古いライブラリを使い続ける
```typescript
// NG: moment.jsを新規プロジェクトで採用
import moment from 'moment';

// OK: 後継ライブラリを使用
import { format } from 'date-fns';
```

---

## 推奨パターン

### 段階的な依存追加
1. まず標準APIで解決できないか検討
2. 軽量なユーティリティライブラリを検討
3. フルスタックなライブラリは本当に必要な場合のみ

### ライブラリのラップ
```typescript
// 直接使用せず、薄いラッパーを作る（将来の置き換えに備える）
// src/lib/date.ts
export { format, parseISO, addDays } from 'date-fns';

// 使用側
import { format } from '@/lib/date';
```

### バージョン固定とアップデート戦略
```json
// package.json - メジャーバージョンは固定
{
  "dependencies": {
    "date-fns": "^3.0.0",  // マイナー・パッチは自動更新
    "react": "18.2.0"      // フレームワークは完全固定も検討
  }
}
```

---

## 学習した知識

<!-- PR学習スキルで追記されるセクション -->
<!-- 形式:
### [タイトル]
**学習元**: PR#xxx (yyyy-mm-dd)
**内容**:
-->
