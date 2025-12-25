---
name: guideline-component-design
description: Vueコンポーネント設計、単一責任、props/emit設計、レイアウト分離のガイド。コンポーネント作成、UI実装、レイアウト調整、リファクタリングの際に自動参照。
---

# コンポーネント設計ガイドライン

## 基本原則

### 1. 単一責任の原則
- コンポーネントは1つの責任（役割）に集中する
- 意味的に異なる要素は別コンポーネントに分離する
- 「このコンポーネントは何をするものか」を一言で説明できるようにする

### 2. レイアウトは上位で制御
- コンポーネント自身は外側のマージン・配置を持たない
- レイアウト調整（中央寄せ、間隔など）は親コンポーネントで行う
- コンポーネントは自身のコンテンツ領域に集中する

### 3. 疎結合を保つ
- コンポーネント間の依存は props/emit で明示的に
- 運命共同体でない要素は同じコンポーネントに入れない
- 表示条件が異なる要素は分離を検討する

---

## アンチパターン

### 意味の異なる要素を同じコンポーネントに配置
```vue
<!-- NG: プログレスバーとナビゲーションボタンは意味が異なる -->
<template>
  <div class="relative">
    <!-- プログレス表示 -->
    <div class="flex items-center">
      <StepIndicator :step="1" />
      <StepIndicator :step="2" />
    </div>
    <!-- ナビゲーション（意味が違う） -->
    <button v-if="step >= 2" @click="emit('back')">
      戻る
    </button>
  </div>
</template>

<!-- OK: 上位コンポーネントで組み合わせる -->
<!-- 親コンポーネント -->
<template>
  <div class="relative flex items-center justify-center">
    <BackButton v-if="step >= 2" @click="handleBack" />
    <ProgressIndicator :current-step="step" />
  </div>
</template>
```

**理由**:
- プログレス表示はステップ可視化の責任
- 戻るボタンはナビゲーションの責任
- 完了画面では戻るボタンが不要など、表示条件が異なる

### コンポーネントに外側マージンを持たせる
```vue
<!-- NG: mx-autoなどの外側マージンがある -->
<template>
  <div class="mx-auto w-[400px]">
    <!-- コンテンツ -->
  </div>
</template>

<!-- OK: 外側マージンなし、親で制御 -->
<template>
  <div class="w-[400px]">
    <!-- コンテンツ -->
  </div>
</template>

<!-- 親コンポーネントでレイアウト -->
<template>
  <div class="mx-auto max-w-4xl">
    <MyComponent />
  </div>
</template>
```

**理由**:
- 外側マージンがあると別の場所で使いにくい
- レイアウトは利用側の文脈で決まる
- 再利用性が下がる

---

## 推奨パターン

### コンポーネント分離の判断基準
```markdown
以下のいずれかに該当したら分離を検討：

1. 表示条件が異なる
   - 「完了画面では非表示」など

2. 責任が異なる
   - 「表示」と「ナビゲーション」など

3. 独立してテストしたい
   - 単体テストが書きやすくなる

4. 別の場所でも使いたい
   - 再利用性の向上
```

### propsによる状態の受け渡し
```vue
<!-- ステップ間で状態を保持する場合 -->
<template>
  <FileUploadStep
    v-if="step === 1"
    :file="uploadedFile"
    @change-file="handleChangeFile"
  />
</template>

<script setup>
// 親で状態を管理し、propsで子に渡す
const uploadedFile = ref<File | undefined>()

const handleChangeFile = (file: File | undefined) => {
  uploadedFile.value = file
}
</script>
```

### レイアウトコンテナの活用
```vue
<!-- レイアウト専用のラッパーを使う -->
<template>
  <div class="relative mx-auto flex w-full max-w-4xl items-center justify-center">
    <!-- 左寄せ要素 -->
    <BackButton
      v-if="step >= 2"
      class="absolute left-0"
      @click="handleBack"
    />

    <!-- 中央寄せ要素 -->
    <ProgressIndicator :current-step="step" />
  </div>
</template>
```

---

## 学習した知識

### コンポーネントの単一責任とレイアウト分離
**学習元**: PRレビュー (2024-12)

**内容**:
ステップ表示コンポーネントに戻るボタンを配置したところ、レビューで以下の指摘があった：

1. **単一責任の違反**: ステップ表示コンポーネントにナビゲーションボタンを入れると意味が違う
2. **表示条件の違い**: 完了画面ではボタンが表示されないため、完全に運命共同体と言えない
3. **外側マージンの問題**: コンポーネントに`mx-auto`を入れると取り回しが悪くなる

**対応**:
- 戻るボタンを別コンポーネントとして分離
- 上位のページコンポーネントでレイアウトを調整
- ステップ表示コンポーネントから外側マージンを削除

**理由・背景**:
- コンポーネントは1つの責任に集中すべき
- レイアウトは利用側（親）の文脈で決まる
- 表示条件が異なる要素は同じコンポーネントに含めない

### 共通コンポーネントの切り口（意味で共通化、機能で共通化しない）
**学習元**: PRレビュー (2024-12)

**内容**:
汎用アイコンコンポーネントを使用していたところ、レビューで以下の指摘があった：

- 「アイコン」として共通化するのではなく「閉じるボタン」として共通化すべき
- 単なるライブラリの薄いラッパーは共通化の意味がない
- 様々な状況に対応させようとするとコンポーネント内部のロジックが複雑化し、共通化のメリットよりデメリットが上回る

**コード例**:
```vue
<!-- NG: 機能（アイコン）で共通化 -->
<MyIcon name="close" variant="secondary" @click="handleClose" />

<!-- OK: 意味（閉じるボタン）で共通化、または直接使用 -->
<CloseButton @click="handleClose" />
<!-- または -->
<button @click="handleClose">
  <span class="material-symbols-outlined">close</span>
</button>
```

**理由・背景**:
- 「機能」で共通化すると汎用的すぎて内部ロジックが複雑化する
- 「意味」で共通化すると用途が明確で保守しやすい
- 外部ライブラリの薄いラッパーは価値が低い

### computedよりメソッドを使う場面
**学習元**: PRレビュー (2024-12)

**内容**:
`computed`は結果をキャッシュするが、計算量が少ない処理には過剰な場合がある。
適切なタイミングを理解して`computed`を使うのが理想だが、大した計算量でなければ通常のメソッドを使う方が考えることが少なくて済む。

**コード例**:
```typescript
// NG: 単純な計算にcomputed
const isOverLimit = computed(() => {
  return remaining.value < 0
})

// OK: 通常のメソッド
const isOverLimit = () => {
  return remaining.value < 0
}
```

**理由・背景**:
- `computed`は良くも悪くもキャッシュする
- 巨大な配列のループや重い計算には`computed`が有効
- 単純な条件判定や加減算程度なら通常メソッドでOK
- キャッシュの挙動を意識しなくて済む分、バグを防げる

### 条件分岐のためにdivタグを新規作成しない
**学習元**: PRレビュー (2024-12)

**内容**:
`v-if`などの条件分岐のために新しい`<div>`タグを追加しない。
既存の要素に条件を付与するか、`<template>`タグを使用する。

**コード例**:
```vue
<!-- NG: v-ifのためにdivを新規作成 -->
<div class="container">
  <div v-if="isVisible">
    <span>内容</span>
  </div>
</div>

<!-- OK: 既存の要素にv-ifを付与 -->
<div v-if="isVisible" class="container">
  <span>内容</span>
</div>

<!-- OK: templateタグを使用（DOM出力なし） -->
<template v-if="isVisible">
  <span>内容A</span>
  <span>内容B</span>
</template>
```

**理由・背景**:
- 不要なDOM要素が増えると可読性・パフォーマンスが低下
- `<template>`タグはDOMに出力されないため条件分岐に適している
- 既存要素で対応できるなら新しい要素を追加しない

