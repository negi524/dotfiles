---
name: code-review-maintainability
description: 長期的な保守性と拡張性の観点からコードをレビューし、改善提案をGitHub PR形式で出力するスキル
---

# Code Review Skill: Maintainability

Pull Requestのコードを分析し、**長期的な保守性と拡張性**の観点から詳細なレビューを行うスキルです。命名規則、設計原則、文書化、テストの保守性など、コードが将来にわたって変更・拡張しやすい状態にあるかを評価し、改善提案をGitHub PRに直接投稿可能な形式で提供します。

## 機能

このスキルは以下のタスクを実行します：

1. **PR情報の自動取得**
   - `gh`コマンドを使用して現在のブランチに関連するPRを特定
   - PRのdiff、変更ファイル一覧、既存のコメントを取得
   - 変更規模と影響範囲を分析

2. **保守性の多角的な分析**
   - **可読性**: コードの理解しやすさ
   - **一貫性**: コーディングスタイルとパターンの統一
   - **拡張性**: 将来の機能追加への対応力
   - **文書化**: コメント、ドキュメントの充実度
   - **テスト保守性**: テストコードの質と保守性

3. **設計原則への準拠確認**
   - SOLID原則のチェック
   - デザインパターンの適切な使用
   - 責任分離と凝集度
   - 疎結合の実現

4. **GitHub PR形式での出力**
   - ファイル・行番号を含むコメント形式
   - `gh pr review`コマンドで直接投稿可能
   - Markdown形式での見やすい整形
   - 優先度の高い順に整理

## レビュー観点：長期保守性の確保

### 1. 可読性 (Readability) 📖

コードが人間にとって理解しやすいかを評価します。

#### チェックポイント

**a) 命名規則**
- **意図が伝わる名前**
  ```typescript
  // Bad: 意味不明な略語
  function calcTtl(d: Data): number { ... }

  // Good: 意図が明確
  function calculateTimeToLive(data: Data): number { ... }
  ```

- **一貫した命名スタイル**
  - 変数: camelCase (JavaScript/TypeScript)
  - クラス: PascalCase
  - 定数: UPPER_SNAKE_CASE
  - プライベート: _prefix または #private (言語仕様に準拠)

- **名詞と動詞の使い分け**
  - 変数/クラス: 名詞 (`user`, `UserService`)
  - 関数/メソッド: 動詞 (`getUser`, `validateEmail`)
  - Boolean: is/has/can で始める (`isActive`, `hasPermission`)

**b) コメントと文書化**
- **複雑なロジックへの説明**
  ```typescript
  // Bad: 自明なコメント
  // ユーザーを取得
  const user = await getUser(id);

  // Good: WHYを説明
  // キャッシュを使わず毎回DBから取得する
  // 理由: ユーザー権限は即座に反映される必要があるため
  const user = await getUserFromDB(id);
  ```

- **公開APIのドキュメント**
  ```typescript
  /**
   * ユーザーの権限を確認する
   *
   * @param userId - 確認対象のユーザーID
   * @param permission - 必要な権限（'read' | 'write' | 'admin'）
   * @returns 権限がある場合はtrue
   * @throws {UnauthorizedError} ユーザーが存在しない場合
   */
  async function checkPermission(userId: string, permission: Permission): Promise<boolean>
  ```

- **TODOコメントの適切な管理**
  ```typescript
  // TODO: (#123) パフォーマンス改善 - N+1問題を解消
  // 担当: @username, 期限: 2025-01-15
  ```

**c) コード構造**
- **適切な関数サイズ**: 1関数30-50行以内が目安
- **ネストの深さ**: 3階層以内に抑える
- **早期リターンの活用**: ハッピーパスを明確に
- **関数の責任**: 1つの関数は1つのことをする

### 2. 一貫性 (Consistency) 🔄

コードベース全体で統一されたスタイルとパターンを保つことを評価します。

#### チェックポイント

**a) コーディングスタイルの統一**
- Prettier/ESLintなどフォーマッターの使用
- インデント、クォート、セミコロンの統一
- import順序の整理（標準ライブラリ → 外部 → 内部）
- ファイル構造の一貫性

**b) パターンの統一**
- **エラーハンドリング**
  ```typescript
  // プロジェクト内で統一されたエラーハンドリング
  try {
    const result = await fetchData();
    return { success: true, data: result };
  } catch (error) {
    logger.error('Failed to fetch data', { error });
    return { success: false, error: error.message };
  }
  ```

- **非同期処理**
  ```typescript
  // プロジェクト全体でasync/awaitに統一（callbackとの混在を避ける）
  async function processData(id: string): Promise<Result> {
    const data = await fetchData(id);
    const processed = await processData(data);
    return processed;
  }
  ```

- **状態管理パターン**
  - ReactならuseReducerとuseStateの使い分けルール
  - グローバル状態管理ツールの統一

**c) アーキテクチャパターンの一貫性**
- レイヤードアーキテクチャの遵守
- MVC、MVVM等のパターン適用
- フォルダ構造の規則性

### 3. 拡張性 (Extensibility) 🚀

将来の機能追加や変更に対する柔軟性を評価します。

#### チェックポイント

**a) 開放閉鎖原則 (Open/Closed Principle)**
```typescript
// Bad: 新しいタイプ追加時にswitch文を修正が必要
function getPrice(product: Product, type: string): number {
  switch (type) {
    case 'regular': return product.price;
    case 'sale': return product.price * 0.8;
    // 新しいタイプを追加する度にここを変更
  }
}

// Good: 新しい戦略を追加するだけ
interface PricingStrategy {
  calculate(product: Product): number;
}

class RegularPricing implements PricingStrategy {
  calculate(product: Product): number {
    return product.price;
  }
}

class SalePricing implements PricingStrategy {
  calculate(product: Product): number {
    return product.price * 0.8;
  }
}

// 新しい戦略を追加しても既存コードは変更不要
```

**b) 依存性注入**
```typescript
// Bad: 具象クラスに直接依存
class UserService {
  private db = new PostgresDatabase();

  async getUser(id: string) {
    return this.db.query('SELECT * FROM users WHERE id = ?', [id]);
  }
}

// Good: インターフェースに依存
interface Database {
  query(sql: string, params: any[]): Promise<any>;
}

class UserService {
  constructor(private db: Database) {}

  async getUser(id: string) {
    return this.db.query('SELECT * FROM users WHERE id = ?', [id]);
  }
}

// テスト時や別のDBへの切り替えが容易
```

**c) 設定の外部化**
```typescript
// Bad: ハードコード
const API_URL = 'https://api.example.com';
const MAX_RETRY = 3;

// Good: 環境変数や設定ファイル
const config = {
  apiUrl: process.env.API_URL || 'https://api.example.com',
  maxRetry: parseInt(process.env.MAX_RETRY || '3'),
};
```

### 4. 設計原則 (Design Principles) 🏗️

SOLID原則を中心とした設計の健全性を評価します。

#### SOLID原則

**S - 単一責任原則 (Single Responsibility Principle)**
```typescript
// Bad: 複数の責任を持つ
class UserManager {
  validateEmail(email: string): boolean { ... }
  saveToDatabase(user: User): Promise<void> { ... }
  sendWelcomeEmail(user: User): Promise<void> { ... }
  generateReport(users: User[]): string { ... }
}

// Good: 責任を分離
class EmailValidator {
  validate(email: string): boolean { ... }
}

class UserRepository {
  save(user: User): Promise<void> { ... }
}

class EmailService {
  sendWelcome(user: User): Promise<void> { ... }
}

class UserReportGenerator {
  generate(users: User[]): string { ... }
}
```

**O - 開放閉鎖原則 (Open/Closed Principle)**
- 前述の拡張性セクションを参照

**L - リスコフの置換原則 (Liskov Substitution Principle)**
```typescript
// Bad: 親クラスの契約を破る
class Bird {
  fly(): void { console.log('Flying'); }
}

class Penguin extends Bird {
  fly(): void {
    throw new Error('Penguins cannot fly'); // 契約違反
  }
}

// Good: インターフェースを適切に設計
interface Bird {
  move(): void;
}

class FlyingBird implements Bird {
  move(): void { console.log('Flying'); }
}

class Penguin implements Bird {
  move(): void { console.log('Swimming'); }
}
```

**I - インターフェース分離原則 (Interface Segregation Principle)**
```typescript
// Bad: 太りすぎたインターフェース
interface Worker {
  work(): void;
  eat(): void;
  sleep(): void;
}

class Robot implements Worker {
  work(): void { ... }
  eat(): void { /* ロボットは食べない */ }
  sleep(): void { /* ロボットは寝ない */ }
}

// Good: インターフェースを分離
interface Workable {
  work(): void;
}

interface Eatable {
  eat(): void;
}

interface Sleepable {
  sleep(): void;
}

class Robot implements Workable {
  work(): void { ... }
}

class Human implements Workable, Eatable, Sleepable {
  work(): void { ... }
  eat(): void { ... }
  sleep(): void { ... }
}
```

**D - 依存性逆転原則 (Dependency Inversion Principle)**
- 前述の拡張性セクション「依存性注入」を参照

### 5. テストの保守性 (Test Maintainability) 🧪

テストコード自体の品質と保守性を評価します。

#### チェックポイント

**a) テストの可読性**
```typescript
// Bad: 何をテストしているか不明
test('test1', () => {
  const r = fn(1, 2);
  expect(r).toBe(3);
});

// Good: テスト内容が明確
describe('Calculator', () => {
  describe('add', () => {
    it('should return sum of two positive numbers', () => {
      const calculator = new Calculator();
      const result = calculator.add(1, 2);
      expect(result).toBe(3);
    });
  });
});
```

**b) AAA パターン (Arrange-Act-Assert)**
```typescript
test('should update user name', async () => {
  // Arrange: テストの準備
  const userId = 'user-123';
  const newName = 'John Doe';
  const mockRepository = createMockRepository();
  const userService = new UserService(mockRepository);

  // Act: 実行
  await userService.updateName(userId, newName);

  // Assert: 検証
  expect(mockRepository.update).toHaveBeenCalledWith(userId, { name: newName });
});
```

**c) テストの独立性**
- 各テストが独立して実行可能
- テストの実行順序に依存しない
- 共有状態を避ける

**d) モックの適切な使用**
```typescript
// Good: 外部依存はモック化
test('should fetch user data', async () => {
  const mockApi = {
    get: jest.fn().mockResolvedValue({ id: '1', name: 'John' })
  };

  const service = new UserService(mockApi);
  const user = await service.getUser('1');

  expect(user.name).toBe('John');
});
```

### 6. 文書化 (Documentation) 📚

コードの意図や使い方を理解するための文書化を評価します。

#### チェックポイント

**a) READMEの充実**
- プロジェクト概要
- セットアップ手順
- 使用方法
- 貢献ガイドライン

**b) APIドキュメント**
- JSDoc、TSDoc等の活用
- 引数と戻り値の説明
- 例外の文書化
- 使用例

**c) アーキテクチャドキュメント**
- システム構成図
- データフロー
- 主要な設計判断とその理由

**d) 変更履歴**
- CHANGELOG.md
- マイグレーションガイド
- Breaking Changes の明示

## 重要度レベル定義

保守性への影響度によって重要度を判定します：

- **🔴 Critical**: 保守性を著しく損なう（SOLID原則違反、責任の混在、テスト不可能な設計）
- **🟠 High**: 保守性に大きく影響（命名規則の乱れ、一貫性の欠如、文書化の不足）
- **🟡 Medium**: 改善が望ましい（コメント不足、軽微な設計の改善余地）
- **🟢 Low**: さらに良くできる（より良い命名、追加のドキュメント）

## 出力形式

### GitHub PR Review Comment 形式

```markdown
## コードレビュー結果：保守性チェック

### 📊 変更概要
- 変更ファイル数: X件
- 追加行数: +XXX / 削除行数: -XXX
- 主な変更内容: [概要]

### 🎯 総合評価
- 保守性スコア: ★★★☆☆ (3/5)
- 主な強み: [良い点]
- 改善が必要な領域: [保守性の課題]

---

### 🔴 Critical: 保守性を著しく損なう

#### `src/services/OrderService.ts:45-120`
**問題**: 単一責任原則違反（1つのクラスが複数の責任を持つ）

**詳細**:
- `OrderService`が注文処理、在庫管理、メール送信、レポート生成を担当
- 変更時の影響範囲が広く、テストが困難
- 複数の理由で変更が発生する設計

**改善提案**:
```typescript
// Before: 複数の責任を持つ
class OrderService {
  async createOrder(order: Order): Promise<void> {
    // 注文処理
    await this.validateOrder(order);
    await this.saveToDatabase(order);

    // 在庫管理
    await this.updateInventory(order.items);

    // メール送信
    await this.sendConfirmationEmail(order.customer.email);

    // レポート生成
    await this.updateSalesReport(order);
  }

  private validateOrder(order: Order): void { ... }
  private saveToDatabase(order: Order): Promise<void> { ... }
  private updateInventory(items: Item[]): Promise<void> { ... }
  private sendConfirmationEmail(email: string): Promise<void> { ... }
  private updateSalesReport(order: Order): Promise<void> { ... }
}

// After: 責任を分離
class OrderService {
  constructor(
    private orderRepository: OrderRepository,
    private inventoryService: InventoryService,
    private emailService: EmailService,
    private reportingService: ReportingService
  ) {}

  async createOrder(order: Order): Promise<void> {
    this.validateOrder(order);

    await this.orderRepository.save(order);
    await this.inventoryService.reserve(order.items);
    await this.emailService.sendOrderConfirmation(order);
    await this.reportingService.recordSale(order);
  }

  private validateOrder(order: Order): void { ... }
}

class OrderRepository {
  async save(order: Order): Promise<void> { ... }
}

class InventoryService {
  async reserve(items: Item[]): Promise<void> { ... }
}

class EmailService {
  async sendOrderConfirmation(order: Order): Promise<void> { ... }
}

class ReportingService {
  async recordSale(order: Order): Promise<void> { ... }
}
```

**効果**:
- 各クラスが単一の責任を持つ
- 変更の影響範囲が限定される
- テストが容易になる
- コードの再利用性が向上

---

### 🟠 High: 保守性に大きく影響

#### `src/utils/helpers.ts`
**問題**: 一貫性のない命名規則と不明瞭な関数名

**詳細**:
- 関数名が動作を正確に表現していない
- 略語と完全な単語が混在
- 命名スタイルが不統一

**改善提案**:
```typescript
// Before: 不明瞭な命名
function proc(d: any): any { ... }
function calc_val(x: number): number { ... }
function getStuff(id: string): Promise<any> { ... }

// After: 明確で一貫した命名
function processUserData(data: UserData): ProcessedData { ... }
function calculateTotalValue(amount: number): number { ... }
function getUserProfile(userId: string): Promise<UserProfile> { ... }
```

**効果**:
- コードの意図が即座に理解できる
- IDE の補完機能がより効果的に
- チーム全体での理解が容易に

---

### 🟡 Medium: 改善が望ましい

#### `src/components/UserList.tsx:30-45`
**問題**: 複雑なロジックにコメントがない

**改善提案**:
```typescript
// Before: コメントなし
const filtered = users.filter(u =>
  !u.deleted && u.active && (u.role === 'admin' || u.verified)
);

// After: WHYを説明するコメント
// 表示対象: アクティブかつ（管理者または認証済み）のユーザー
// 削除済みユーザーは常に除外
const filtered = users.filter(user =>
  !user.deleted &&
  user.active &&
  (user.role === 'admin' || user.verified)
);
```

---

### 🟢 Low: さらに良くできる

#### `src/api/endpoints.ts`
**問題**: 関数にJSDocがない

**改善提案**:
```typescript
// 公開APIにはドキュメントを追加
/**
 * ユーザー情報を取得する
 *
 * @param userId - 取得対象のユーザーID
 * @returns ユーザー情報
 * @throws {NotFoundError} ユーザーが存在しない場合
 */
export async function fetchUser(userId: string): Promise<User> { ... }
```

---

### ✅ 保守性の高い実装

- `src/hooks/useAuth.ts`: 適切な責任分離とテスト可能な設計
- `src/types/index.ts`: 型定義が明確で一貫性がある
- `src/services/api.test.ts`: テストが読みやすく保守しやすい

---

### 📝 保守性改善アクションプラン

1. **即対応** (Critical): `OrderService`を責任ごとに分割
2. **今週中** (High): `helpers.ts`の命名を統一
3. **次のスプリント** (Medium): 複雑なロジックにコメント追加
4. **余裕があれば** (Low): 公開APIにJSDoc追加
```

## 使用方法

### 基本的な使い方

1. **レビュー対象のブランチに移動**
   ```bash
   git checkout feature/your-branch
   ```

2. **スキルを実行**
   - Claude Codeでスキルを呼び出す
   - 自動的にPR情報を取得し、保守性の観点からレビューを開始

3. **レビュー結果の確認**
   - Markdown形式でレビュー結果が出力される
   - 保守性への影響度順に問題点が整理される

4. **GitHub PRへのコメント投稿（オプション）**
   ```bash
   gh pr review [PR番号] --comment --body "$(cat review-result.md)"
   ```

### カスタマイズ

レビューの焦点を調整する場合は、以下のような指示を追加できます：

- 「特にSOLID原則への準拠を重点的にチェックしてください」
- 「テストコードの保守性を詳しく見てください」
- 「命名規則とコメントの充実度を確認してください」
- 「拡張性と将来の変更への対応力を評価してください」

## 期待される効果

### 短期的効果
- **変更容易性の向上**: 機能追加・修正が容易に
- **オンボーディング時間の短縮**: 新メンバーがコードを理解しやすい
- **バグ修正時間の削減**: 問題箇所の特定が迅速に

### 長期的効果
- **技術的負債の削減**: 設計の問題を早期に発見・修正
- **開発速度の維持**: コードベースの肥大化による速度低下を防ぐ
- **チームの設計力向上**: SOLID原則などの理解が深まる
- **コード品質の文化醸成**: 保守性を重視する文化の形成

## 制限事項と注意点

### 制限事項
- **ビジネスコンテキストの理解**: ドメイン知識が必要な判断は困難
- **トレードオフの判断**: 保守性と他の要素（パフォーマンス等）のバランス
- **チーム固有のルール**: プロジェクト特有の規約は考慮できない場合がある

### 注意点
- **過剰な抽象化**: 保守性を意識しすぎて不要な複雑さを生まないように
- **適切な粒度**: 全てをマイクロサービスにする必要はない
- **YAGNIとのバランス**: 将来の拡張性と現在の実装のバランスを取る
- **最終判断は人間**: 提案はあくまで参考情報

## 補足情報

### 他のスキルとの連携

- **code-review-simplify**: シンプル化 → 保守性チェックの順で実行
- **code-review-bugs**: バグ検出 → 保守性改善で品質を多角的に向上
- **pr-learning**: レビュー後、優れた設計パターンを学習

### 推奨ワークフロー

```
1. 機能実装
2. code-review-bugs（バグがないか確認）
3. code-review-simplify（シンプル化）
4. code-review-maintainability（保守性確認）← このスキル
5. 改善実施
6. 人間のレビュアーに依頼
7. pr-learningで設計パターンを学習
```

### 保守性の指標

このスキルは以下の指標を重視します：

- **変更影響範囲**: 1つの変更が及ぼす影響の広さ
- **理解時間**: 新しい人がコードを理解するのにかかる時間
- **テスト容易性**: ユニットテストの書きやすさ
- **拡張コスト**: 新機能追加に必要な労力
- **一貫性**: コードベース全体での統一感

このスキルを活用することで、**将来にわたって健全なコードベース**を維持できます。
