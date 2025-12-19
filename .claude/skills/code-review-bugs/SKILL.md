---
name: code-review-bugs
description: バグ、エッジケース、セキュリティ脆弱性を検出し、修正方法をGitHub PR形式で出力するスキル
---

# Code Review Skill: Bug Detection

Pull Requestのコードを分析し、**バグ、ロジックエラー、セキュリティ脆弱性**を検出するスキルです。実装の正しさ、エッジケースの処理、セキュリティリスクなど、コードが正常に動作するかを多角的に検証し、具体的な修正方法をGitHub PRに直接投稿可能な形式で提供します。

## 機能

このスキルは以下のタスクを実行します：

1. **PR情報の自動取得**
   - `gh`コマンドを使用して現在のブランチに関連するPRを特定
   - PRのdiff、変更ファイル一覧、既存のコメントを取得
   - 変更規模と影響範囲を分析

2. **多角的なバグ検出**
   - **ロジックエラー**: 実装の誤り、条件式の間違い
   - **エッジケース**: 境界値、null/undefined、空配列等の処理漏れ
   - **セキュリティ**: OWASP Top 10、認証認可、インジェクション
   - **リソース管理**: メモリリーク、ファイルハンドルの解放漏れ
   - **並行処理**: レースコンディション、デッドロック
   - **型安全性**: TypeScript型の不適切な使用

3. **具体的な修正提案**
   - 問題箇所の特定（ファイル名、行番号）
   - 深刻度レベル（Critical / High / Medium / Low）
   - 修正前後のコード例
   - なぜバグなのかの説明

4. **GitHub PR形式での出力**
   - ファイル・行番号を含むコメント形式
   - `gh pr review`コマンドで直接投稿可能
   - Markdown形式での見やすい整形
   - 深刻度の高い順に整理

## レビュー観点：コードの正しさと安全性

### 1. ロジックエラー (Logic Errors) 🐛

実装の誤りや条件式の間違いを検出します。

#### チェックポイント

**a) 条件式の誤り**
```typescript
// Bad: 論理演算子の誤り
if (user.age > 18 || user.hasPermission) {
  // 18歳以下でも hasPermission があれば通過してしまう
  // 意図: 18歳以上 AND 権限あり
}

// Good: 正しい論理演算子
if (user.age >= 18 && user.hasPermission) {
  // 18歳以上かつ権限ありの場合のみ
}
```

**b) Off-by-one エラー**
```typescript
// Bad: 配列の範囲外アクセス
for (let i = 0; i <= array.length; i++) {
  console.log(array[i]); // 最後の反復でundefined
}

// Good: 正しい範囲指定
for (let i = 0; i < array.length; i++) {
  console.log(array[i]);
}
```

**c) 演算順序の誤り**
```typescript
// Bad: 優先順位の考慮漏れ
const discount = price * 0.1 + 100; // (price * 0.1) + 100
// 意図: price に 10% + 100円を加算した金額から割引？

// Good: 意図を明確に
const discount = (price + 100) * 0.1; // 10%割引
```

**d) 非同期処理の誤り**
```typescript
// Bad: awaitを忘れる
async function fetchUsers() {
  const users = getUsersFromDB(); // Promiseが返る
  console.log(users.length); // エラー: Promiseにlengthはない
}

// Good: awaitを使う
async function fetchUsers() {
  const users = await getUsersFromDB();
  console.log(users.length);
}
```

### 2. エッジケースの処理漏れ (Edge Cases) ⚠️

境界値や特殊な入力パターンへの対処を確認します。

#### チェックポイント

**a) null / undefined チェック**
```typescript
// Bad: nullチェックなし
function getUserName(user: User | null): string {
  return user.name; // userがnullの場合エラー
}

// Good: ガード節で処理
function getUserName(user: User | null): string {
  if (!user) return 'Guest';
  return user.name;
}
```

**b) 空配列・空文字列**
```typescript
// Bad: 空配列を考慮していない
function getFirstUser(users: User[]): User {
  return users[0]; // usersが空の場合undefined
}

// Good: 空配列をチェック
function getFirstUser(users: User[]): User | null {
  if (users.length === 0) return null;
  return users[0];
}
```

**c) 境界値**
```typescript
// Bad: 境界値の考慮漏れ
function isValidAge(age: number): boolean {
  return age > 0 && age < 150;
  // age が 0 や 150 の場合の扱いが不明確
}

// Good: 仕様を明確に
function isValidAge(age: number): boolean {
  return age >= 0 && age <= 150;
  // 0歳と150歳を含む
}
```

**d) 数値の特殊値**
```typescript
// Bad: NaN, Infinity を考慮していない
function divide(a: number, b: number): number {
  return a / b; // b=0の場合Infinity
}

// Good: ゼロ除算をチェック
function divide(a: number, b: number): number {
  if (b === 0) throw new Error('Division by zero');
  return a / b;
}
```

**e) 文字列の特殊ケース**
```typescript
// Bad: 空白文字を考慮していない
function isValidUsername(username: string): boolean {
  return username.length > 0; // "   " も通過してしまう
}

// Good: trim後にチェック
function isValidUsername(username: string): boolean {
  return username.trim().length > 0;
}
```

### 3. セキュリティ脆弱性 (Security Vulnerabilities) 🔒

OWASP Top 10を中心としたセキュリティリスクを検出します。

#### チェックポイント

**a) SQLインジェクション**
```typescript
// Bad: 文字列連結でSQL構築
const query = `SELECT * FROM users WHERE id = '${userId}'`;
db.query(query); // SQLインジェクションのリスク

// Good: プリペアドステートメント使用
const query = 'SELECT * FROM users WHERE id = ?';
db.query(query, [userId]);
```

**b) XSS (Cross-Site Scripting)**
```typescript
// Bad: ユーザー入力をそのままHTML挿入
element.innerHTML = userInput; // <script>タグが実行される

// Good: エスケープまたはtextContent使用
element.textContent = userInput;
// または
element.innerHTML = escapeHtml(userInput);
```

**c) 認証・認可の不備**
```typescript
// Bad: クライアント側の権限チェックのみ
if (user.role === 'admin') {
  deleteUser(userId); // クライアント側で改ざん可能
}

// Good: サーバー側で必ず権限チェック
async function deleteUser(userId: string, requestingUser: User) {
  if (requestingUser.role !== 'admin') {
    throw new UnauthorizedError('Admin権限が必要です');
  }
  await userRepository.delete(userId);
}
```

**d) 機密情報の露出**
```typescript
// Bad: パスワードをログ出力
console.log('User login:', { username, password });

// Good: 機密情報をマスク
console.log('User login:', { username, password: '***' });

// Bad: エラーメッセージで内部情報を露出
catch (error) {
  res.status(500).json({ error: error.stack }); // スタックトレースを公開
}

// Good: ユーザーには安全なメッセージのみ
catch (error) {
  logger.error('Internal error', { error }); // サーバーログに記録
  res.status(500).json({ error: 'Internal server error' });
}
```

**e) CSRF (Cross-Site Request Forgery)**
```typescript
// Bad: CSRFトークンなし
app.post('/api/delete-account', (req, res) => {
  deleteAccount(req.user.id); // 他サイトから実行可能
});

// Good: CSRFトークン検証
app.post('/api/delete-account', csrfProtection, (req, res) => {
  deleteAccount(req.user.id);
});
```

**f) ディレクトリトラバーサル**
```typescript
// Bad: ユーザー入力をそのままファイルパスに使用
const filePath = `/uploads/${req.query.filename}`;
fs.readFile(filePath); // ../../etc/passwd のようなパスが可能

// Good: パスを検証・正規化
const filename = path.basename(req.query.filename);
const filePath = path.join('/uploads', filename);
if (!filePath.startsWith('/uploads/')) {
  throw new Error('Invalid file path');
}
fs.readFile(filePath);
```

### 4. リソース管理 (Resource Management) 💾

メモリリークやリソースの解放漏れを検出します。

#### チェックポイント

**a) メモリリーク**
```typescript
// Bad: イベントリスナーの解放漏れ
useEffect(() => {
  window.addEventListener('resize', handleResize);
  // クリーンアップなし → メモリリーク
}, []);

// Good: クリーンアップ関数を返す
useEffect(() => {
  window.addEventListener('resize', handleResize);
  return () => {
    window.removeEventListener('resize', handleResize);
  };
}, []);
```

**b) ファイルハンドルの解放**
```typescript
// Bad: ファイルを閉じない
const file = fs.openSync('file.txt', 'r');
const content = fs.readFileSync(file);
// ファイルが閉じられない

// Good: try-finallyで確実にクローズ
const file = fs.openSync('file.txt', 'r');
try {
  const content = fs.readFileSync(file);
} finally {
  fs.closeSync(file);
}

// Better: 自動クローズされるAPIを使用
const content = fs.readFileSync('file.txt', 'utf-8');
```

**c) タイマーの解放**
```typescript
// Bad: setIntervalをクリアしない
useEffect(() => {
  setInterval(() => {
    fetchData();
  }, 1000); // コンポーネント破棄後も実行され続ける
}, []);

// Good: クリーンアップでクリア
useEffect(() => {
  const intervalId = setInterval(() => {
    fetchData();
  }, 1000);

  return () => {
    clearInterval(intervalId);
  };
}, []);
```

**d) データベース接続**
```typescript
// Bad: 接続を閉じない
async function getUser(id: string) {
  const connection = await db.connect();
  const user = await connection.query('SELECT * FROM users WHERE id = ?', [id]);
  return user; // 接続が開きっぱなし
}

// Good: 確実にクローズ
async function getUser(id: string) {
  const connection = await db.connect();
  try {
    const user = await connection.query('SELECT * FROM users WHERE id = ?', [id]);
    return user;
  } finally {
    await connection.close();
  }
}

// Better: コネクションプールを使用
async function getUser(id: string) {
  return await db.query('SELECT * FROM users WHERE id = ?', [id]);
  // プールが自動管理
}
```

### 5. 並行処理の問題 (Concurrency Issues) 🔄

レースコンディションやデッドロックなどの並行処理のバグを検出します。

#### チェックポイント

**a) レースコンディション**
```typescript
// Bad: 非同期処理の競合
let counter = 0;

async function increment() {
  const current = counter; // 読み取り
  await delay(10); // 他の処理が割り込む可能性
  counter = current + 1; // 書き込み（他の更新が失われる）
}

// Good: アトミック操作またはロック
let counter = 0;
const lock = new AsyncLock();

async function increment() {
  await lock.acquire('counter', async () => {
    counter += 1;
  });
}
```

**b) Promise.all の誤用**
```typescript
// Bad: 並行実行中の例外処理漏れ
const results = await Promise.all([
  fetchUser(1),
  fetchUser(2),
  fetchUser(3), // この1つが失敗すると全て失敗
]);

// Good: 個別にエラーハンドリング
const results = await Promise.allSettled([
  fetchUser(1),
  fetchUser(2),
  fetchUser(3),
]);

results.forEach((result, index) => {
  if (result.status === 'fulfilled') {
    console.log(`User ${index + 1}:`, result.value);
  } else {
    console.error(`User ${index + 1} failed:`, result.reason);
  }
});
```

**c) 共有状態の変更**
```typescript
// Bad: 複数の非同期処理で共有状態を変更
class ShoppingCart {
  items: Item[] = [];

  async addItem(item: Item) {
    const inventory = await checkInventory(item.id);
    if (inventory > 0) {
      this.items.push(item); // 他の処理と競合の可能性
      await updateInventory(item.id, -1);
    }
  }
}

// Good: トランザクションまたは楽観的ロック
class ShoppingCart {
  items: Item[] = [];

  async addItem(item: Item) {
    await db.transaction(async (tx) => {
      const inventory = await tx.checkInventory(item.id);
      if (inventory > 0) {
        this.items.push(item);
        await tx.updateInventory(item.id, -1);
      } else {
        throw new Error('Out of stock');
      }
    });
  }
}
```

### 6. 型安全性の問題 (Type Safety Issues) 🔤

TypeScript使用時の型の不適切な使用を検出します。

#### チェックポイント

**a) any の乱用**
```typescript
// Bad: any を使うことで型チェックを無効化
function processData(data: any): any {
  return data.value.toString(); // data.valueが存在しない可能性
}

// Good: 適切な型定義
interface Data {
  value: number;
}

function processData(data: Data): string {
  return data.value.toString();
}
```

**b) 型アサーションの誤用**
```typescript
// Bad: 危険な型アサーション
const user = JSON.parse(jsonString) as User;
// JSONが不正な場合でも型チェックをパス

// Good: バリデーション後に型を保証
function parseUser(jsonString: string): User {
  const data = JSON.parse(jsonString);

  if (!isValidUser(data)) {
    throw new Error('Invalid user data');
  }

  return data;
}

function isValidUser(data: any): data is User {
  return (
    typeof data === 'object' &&
    typeof data.id === 'string' &&
    typeof data.name === 'string'
  );
}
```

**c) null/undefined の型ガード漏れ**
```typescript
// Bad: null チェックなしで使用
function getNameLength(user: User | null): number {
  return user.name.length; // userがnullの場合エラー
}

// Good: 型ガードを使用
function getNameLength(user: User | null): number {
  if (!user) return 0;
  return user.name.length;
}
```

**d) 非strictモードの問題**
```typescript
// tsconfig.json で strict: true を有効にすることで多くの問題を検出可能

// strict が無効だと以下が許可されてしまう
let value: string;
console.log(value.length); // undefined.length → エラー

// strict が有効なら初期化を強制
let value: string = '';
console.log(value.length); // OK
```

## 深刻度レベル定義

バグの影響度によって深刻度を判定します：

- **🔴 Critical**: データ損失、セキュリティ侵害、システムクラッシュの可能性
- **🟠 High**: 主要機能が動作しない、頻繁に発生するバグ
- **🟡 Medium**: 特定条件下でのバグ、エッジケースの処理漏れ
- **🟢 Low**: まれにしか発生しない問題、軽微な不具合

## 出力形式

### GitHub PR Review Comment 形式

```markdown
## コードレビュー結果：バグ検出

### 📊 変更概要
- 変更ファイル数: X件
- 追加行数: +XXX / 削除行数: -XXX
- 主な変更内容: [概要]

### 🎯 総合評価
- バグリスクレベル: 🟡 中 (3/5)
- 検出された問題: Critical 1件、High 2件、Medium 3件
- 主な懸念事項: [重大なバグの要約]

---

### 🔴 Critical: 即座に修正が必要

#### `src/api/auth.ts:67-75`
**問題**: SQLインジェクションの脆弱性

**詳細**:
- ユーザー入力を直接SQL文字列に連結
- 攻撃者が任意のSQLを実行可能
- データベース全体が危険に晒される

**攻撃例**:
```typescript
// 攻撃者が username に "admin' OR '1'='1" を入力
const username = "admin' OR '1'='1";
const query = `SELECT * FROM users WHERE username = '${username}'`;
// 結果: SELECT * FROM users WHERE username = 'admin' OR '1'='1'
// → 全ユーザーが取得される
```

**修正方法**:
```typescript
// Before: 危険な文字列連結
async function login(username: string, password: string) {
  const query = `SELECT * FROM users WHERE username = '${username}' AND password = '${password}'`;
  const user = await db.query(query);
  return user;
}

// After: プリペアドステートメント使用
async function login(username: string, password: string) {
  const query = 'SELECT * FROM users WHERE username = ? AND password = ?';
  const user = await db.query(query, [username, password]);
  return user;
}

// Better: ORM使用
async function login(username: string, password: string) {
  const user = await User.findOne({
    where: { username, password }
  });
  return user;
}
```

**影響**: Critical - データベース全体の漏洩・改ざんの可能性

---

### 🟠 High: 早急に修正すべき

#### `src/services/payment.ts:120`
**問題**: 非同期処理のawait忘れ

**詳細**:
- `processPayment()`は非同期関数だが、awaitせずに次の処理へ
- 決済完了前に成功レスポンスが返される
- 実際には決済が失敗している可能性

**修正方法**:
```typescript
// Before: awaitを忘れている
async function checkout(orderId: string) {
  processPayment(orderId); // Promiseが返るがawaitしていない
  await updateOrderStatus(orderId, 'completed'); // 決済前に完了扱い
  return { success: true };
}

// After: awaitを追加
async function checkout(orderId: string) {
  await processPayment(orderId); // 決済完了を待つ
  await updateOrderStatus(orderId, 'completed');
  return { success: true };
}
```

**影響**: High - 決済処理の失敗、データ不整合

---

#### `src/utils/array.ts:45`
**問題**: 配列の範囲外アクセス

**詳細**:
- 空配列の場合にundefinedアクセスでエラー

**修正方法**:
```typescript
// Before: 空配列チェックなし
function getLastItem<T>(items: T[]): T {
  return items[items.length - 1]; // 空配列の場合undefined
}

// After: 空配列チェック追加
function getLastItem<T>(items: T[]): T | undefined {
  if (items.length === 0) return undefined;
  return items[items.length - 1];
}
```

**影響**: High - ランタイムエラー

---

### 🟡 Medium: 修正を推奨

#### `src/components/Form.tsx:88`
**問題**: null/undefinedチェック漏れ

**修正方法**:
```typescript
// Before
const email = user.profile.email; // user.profileがnullの可能性

// After
const email = user.profile?.email ?? '';
```

---

### 🟢 Low: 余裕があれば修正

#### `src/utils/format.ts:30`
**問題**: 空白文字の考慮漏れ

**修正方法**:
```typescript
// Before
if (input.length > 0) { ... }

// After
if (input.trim().length > 0) { ... }
```

---

### ✅ 問題なし・良い実装

- `src/api/validator.ts`: 適切な入力検証
- `src/services/auth.ts`: 認証・認可が適切に実装されている
- `src/utils/db.ts`: リソースが適切に解放されている

---

### 📝 修正アクションプラン

1. **即対応** (Critical): SQLインジェクション脆弱性を修正
2. **今日中** (High): 非同期処理のawait追加、配列アクセス修正
3. **今週中** (Medium): null/undefinedチェック追加
4. **次のスプリント** (Low): 細かな処理漏れの修正

### 🔒 セキュリティチェックリスト

- [ ] 入力検証は全て実施されているか
- [ ] SQLインジェクション対策は十分か
- [ ] XSS対策は実施されているか
- [ ] 認証・認可は適切に実装されているか
- [ ] 機密情報がログに出力されていないか
- [ ] CSRF対策は実施されているか
```

## 使用方法

### 基本的な使い方

1. **レビュー対象のブランチに移動**
   ```bash
   git checkout feature/your-branch
   ```

2. **スキルを実行**
   - Claude Codeでスキルを呼び出す
   - 自動的にPR情報を取得し、バグ検出を開始

3. **レビュー結果の確認**
   - Markdown形式でレビュー結果が出力される
   - 深刻度の高い順に問題点が整理される

4. **GitHub PRへのコメント投稿（オプション）**
   ```bash
   gh pr review [PR番号] --comment --body "$(cat review-result.md)"
   ```

### カスタマイズ

レビューの焦点を調整する場合は、以下のような指示を追加できます：

- 「特にセキュリティ脆弱性を重点的にチェックしてください」
- 「エッジケースの処理漏れを詳しく見てください」
- 「並行処理のバグがないか確認してください」
- 「TypeScriptの型安全性を重点的にチェックしてください」

## 期待される効果

### 短期的効果
- **バグの早期発見**: リリース前にバグを検出・修正
- **セキュリティリスクの低減**: 脆弱性を事前に発見
- **デバッグ時間の削減**: 本番環境でのバグ発生を防止

### 長期的効果
- **品質文化の醸成**: バグを出さない開発習慣の形成
- **セキュリティ意識の向上**: チーム全体のセキュリティスキル向上
- **顧客満足度の向上**: 安定したサービス提供
- **運用コストの削減**: 障害対応の減少

## 制限事項と注意点

### 制限事項
- **実行時の動作検証**: 静的解析のため、実際の動作は確認できない
- **ビジネスロジックの正しさ**: 要件に合っているかは判断困難
- **パフォーマンス問題**: 実測が必要な問題は検出できない
- **複雑な状態遷移**: 複雑なステートマシンのバグは見落とす可能性

### 注意点
- **False Positive**: 誤検出の可能性があり、最終判断は人間が行う
- **コンテキスト依存**: 前後の処理によっては問題でない場合もある
- **テストの重要性**: このレビューだけでなく、適切なテストも必要
- **セキュリティスキャンツール**: 専用ツール（SAST/DAST）の併用を推奨

## 補足情報

### 他のスキルとの連携

- **code-review-simplify**: バグ修正 → シンプル化で品質向上
- **code-review-maintainability**: バグ修正 → 保守性改善で再発防止
- **pr-learning**: バグパターンを学習し、今後の予防に活用

### 推奨ワークフロー

```
1. 機能実装
2. ローカルでのテスト
3. code-review-bugs（バグ検出）← このスキル（最優先）
4. バグ修正
5. code-review-simplify（シンプル化）
6. code-review-maintainability（保守性確認）
7. 人間のレビュアーに依頼
8. 統合テスト・E2Eテスト
```

### バグ検出のベストプラクティス

1. **Critical/Highは必ず修正**: リリース前に全て対応
2. **セキュリティは妥協しない**: 小さな脆弱性も放置しない
3. **テストを追加**: 検出されたバグに対するテストを書く
4. **根本原因を考える**: なぜバグが入ったのかを振り返る
5. **パターンを学習**: 同種のバグを繰り返さない

このスキルを活用することで、**安全で信頼性の高いコード**を実現できます。

## 学習内容の参照

レビュー時は `~/.claude/context/learnings/` の学習記録を参照してください：

- 該当する言語/フレームワークのファイルを確認
- 推奨パターンに合致する実装を見つけたら称賛
- アンチパターンに該当する実装を見つけたら指摘・改善提案
- 新しいパターンを発見したら、学習記録への追加を提案
