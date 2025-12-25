---
name: guideline-vue-nuxt
description: Vue/Nuxt特有の注意点、useState、computed、リアクティブ、SSR対応のガイド。Vueコンポーネント実装、Nuxtページ作成、composables実装、状態管理の際に自動参照。
---

# Vue/Nuxt ガイドライン

## 基本原則

### 1. useStateではnullを使う（undefinedは避ける）
- `useState`はJSONシリアライズされる仕組み
- `undefined`はJSONで表現できないため、予期せぬ挙動を引き起こす
- 複数コンポーネント間で状態が共有されない問題が発生する可能性がある

### 2. computedは重い計算にのみ使用
- `computed`はキャッシュするため、軽い計算には通常のメソッドを使う
- キャッシュが不要な場合、通常のメソッドの方がシンプル
- 依存関係の追跡によるオーバーヘッドを避ける

### 3. SSRを意識した実装
- `window`や`document`へのアクセスは`onMounted`内で行う
- サーバーサイドとクライアントサイドの状態の一貫性を保つ

---

## アンチパターン

### useStateでundefinedを使用
```typescript
// NG: undefinedはJSONシリアライズできない
const myState = useState<number | undefined>('myState', () => undefined)

// OK: nullを使用
const myState = useState<number | null>('myState', () => null)
```

**問題点**:
- `useState`はSSRのハイドレーション時にJSONシリアライズされる
- `undefined`を格納すると、別コンポーネントで参照した際に初期値に戻る
- 複数コンポーネント間で状態の不整合が発生する

### 軽い計算にcomputedを使用
```typescript
// NG: 単純な計算にcomputedを使用
const isOverLimit = computed(() => {
  return count.value > limit.value
})

// OK: 通常のメソッドを使用
const isOverLimit = () => {
  return count.value > limit.value
}
```

**理由**:
- `computed`はキャッシュするため、依存値が変わらない限り再計算しない
- 軽い計算ではキャッシュのメリットよりオーバーヘッドが大きい
- メソッドの方が動作が明確で予測しやすい

---

## 推奨パターン

### computedを使うべき場面
```typescript
// 重い計算（配列のフィルタリング・ソートなど）にはcomputedが適切
const filteredItems = computed(() => {
  return items.value
    .filter(item => item.isActive)
    .sort((a, b) => a.name.localeCompare(b.name))
})
```

### null/undefinedの使い分け
```markdown
プロジェクト方針として統一する：

1. **null統一（推奨）**
   - JSONシリアライズで問題が起きない
   - useStateで安全に使用できる
   - APIレスポンス（JSON）との親和性が高い

2. **使い分け基準**
   - DB/APIからの値 → null
   - 未初期化・未設定 → null（undefinedは避ける）
```

### useStateの型定義
```typescript
// 初期値がnullの場合の型定義
const userData = useState<User | null>('userData', () => null)

// nullチェックを明示的に行う
if (userData.value !== null) {
  // userData.value は User 型として扱える
}
```

---

## 学習した知識

### NuxtのuseStateでundefinedを避ける
**学習元**: PRレビュー (2024-12)

**内容**:
`useState`で初期値を`0`から`undefined`に変更したところ、以下の問題が発生した：

1. あるページで`fetchData()`を実行し、APIからnullを受け取る
2. 状態が`undefined`で更新される
3. 別コンポーネントで`useState`から同じキーで参照すると、初期値の`0`が返る
4. コンポーネント間で状態が共有されない

**原因**:
`useState`はSSRハイドレーション時にJSONシリアライズされる。`undefined`はJSON化できないため、格納できず予期せぬ挙動を引き起こす。

**コード例**:
```typescript
// NG
const limit = useState<number | undefined>('limit', () => undefined)

// OK
const limit = useState<number | null>('limit', () => null)
```

**結論**:
プロジェクトとして`undefined`は使わず、`null`に統一する方針が望ましい。

**参考**: https://nuxt.com/docs/api/composables/use-state

---

### Vue computedは重い計算にのみ使用
**学習元**: PRレビュー (2024-12)

**内容**:
単純な比較や軽い計算に`computed`を使用していたところ、通常のメソッドへの変更が提案された。

**理由**:
- `computed`は良くも悪くもキャッシュする
- 計算量が少ない処理には通常のメソッドを使う方が無難
- 理想は適切なタイミングを理解して`computed`を使うこと
- 大した計算量じゃない場合は通常のメソッドを使う方が考えることが少なくて済む

**コード例**:
```typescript
// Before: computedを使用
const remainingSlots = computed(() => {
  return availableSlots.value - rows.value.length
})
const isOverLimit = computed(() => {
  return remainingSlots.value < 0
})

// After: 通常のメソッドを使用
const remainingSlots = () => {
  return availableSlots.value - rows.value.length
}
const isOverLimit = () => {
  return remainingSlots() < 0
}
```

**参考**: https://ja.vuejs.org/guide/essentials/computed#computed-caching-vs-methods
