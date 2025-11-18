# CLAUDE.md

このファイルは、このリポジトリでコードを操作する際のClaude Code (claude.ai/code)向けのガイダンスを提供します。

## プロジェクト概要

これはmacOS上の開発環境設定を管理するための個人用dotfilesリポジトリです。シェル設定、テキストエディタのセットアップ、ターミナルマルチプレクサの設定、完全な開発環境のためのパッケージ管理が含まれています。

## 主要なコマンド

### 初期設定
```bash
# 依存関係の初期化（事前にwgetとHomebrewのインストールが必要）
~/dotfiles/etc/init

# シンボリックリンクを通じて設定を適用
~/dotfiles/etc/setup

# 全てのHomebrewパッケージをインストール
brew bundle --file='~/dotfiles/.Brewfile'

# zshプラグインをインストール
zplug install
```

### 日常の開発作業
```bash
# IDE風のtmuxレイアウトを起動（70/30縦分割）
ide

# Homebrewパッケージリストを更新
brew bundle dump --no-vscode --force --file='~/dotfiles/.Brewfile'

# 設定変更後にシェル設定を反映
source ~/.zshrc

# tmux設定をリロード
tmux source-file ~/.tmux.conf
```

### Git設定（手動セットアップが必要）
```bash
git config --global alias.st status
git config --global alias.co commit
git config --global alias.br branch
git config --global alias.ch checkout
git config --global alias.df diff
```

## アーキテクチャと構造

### 設定管理パターン
- **シンボリックリンクベースのデプロイ**: オリジナルファイルはdotfilesリポジトリに残し、ホームディレクトリにシンボリックリンクを作成
- **モジュール化されたセットアップ**: 別々のスクリプトが異なる側面を処理（init、setup、Neovim設定）
- **冪等操作**: スクリプトは処理前に既存のインストールをチェック

### 主要ディレクトリ
- `bin/`: PATHに追加されるカスタムスクリプト（`ide` tmuxレイアウトスクリプトを含む）
- `etc/`: 共有ログユーティリティを含むセットアップと初期化スクリプト
- `.config/nvim/`: lazy.nvimを使用するモダンなLuaベースのNeovim設定
- `iTerm2/`: ターミナルエミュレータの設定とカラースキーム
- `.vim/`: ファイルタイプ固有設定を含むレガシーVim設定

### ランタイム管理スタック
- **シェル**: zshをメイン（`.zshrc`で設定）
- **バージョン管理**: mise（統合ランタイムマネージャー、pyenv/rbenv/fnmを置き換え）
- **Pythonパッケージ**: uv（Poetryを置き換え）
- **テキストエディタ**: Neovim（アクティブ）、Vim（レガシー）
- **ターミナルマルチプレクサ**: カスタムプレフィックス（Ctrl+Q）のtmux
- **パッケージマネージャ**: .Brewfileで管理されるHomebrew

## Neovim設定詳細

### プラグイン管理
自動インストール機能付きのlazy.nvimを使用。プラグインは`lua/plugins/`ディレクトリで整理：
- **nvim-tree.lua**: ファイルエクスプローラー（`:NvimTreeToggle`でtoggle）
- **onedark.nvim**: アクティブなカラースキーム
- **Comment.nvim**: コメントアウトユーティリティ
- **diffview.nvim**: Git差分可視化
- **vimdoc-ja**: 日本語ヘルプドキュメント

### 主要設定
- スマートインデント付きの2スペースインデント
- 現在行ハイライト付きの行番号表示
- バイリンガルドキュメントのための日本語ヘルプ優先
- ハイライト結果付きのスマートケース検索

## シェル環境

### zsh設定機能
- **履歴**: メモリ内1000、ディスクに100,000保存
- **プロンプト**: タイムスタンプ、ディレクトリ、gitステータスを表示するカスタムgit対応プロンプト
- **プラグインマネージャ**: オートサジェストとシンタックスハイライトのzplug
- **ツール**: mise、uv、fzf統合が有効

### カスタム環境変数
- `/opt/homebrew`のHomebrewパス
- PostgreSQL@17カスタムバイナリパス
- Firebase toolsとRancher Desktopパス
- PATHにカスタムbinディレクトリ

## 開発ワークフロー

### ファイル変更プロセス
1. dotfilesリポジトリ内の設定ファイルを編集
2. 必要に応じて`~/dotfiles/etc/setup`を実行してシンボリックリンクを更新
3. シェル設定を反映: `source ~/.zshrc`
4. tmux変更の場合: `tmux source-file ~/.tmux.conf`

### パッケージ管理
- `.Brewfile`に手動または`brew install`経由で新しいパッケージを追加
- `brew bundle dump --no-vscode --force --file='~/dotfiles/.Brewfile'`でパッケージリストを更新
- VSCode拡張機能は管理対象から明示的に除外

### 変更のテスト
- シェル設定: `source ~/.zshrc`
- tmux設定: `tmux source-file ~/.tmux.conf`
- Neovimプラグイン: Neovimを起動して`:Lazy`でプラグインステータスを確認
- シンボリックリンク: `ls -la ~/ | grep dotfiles`でリンクを確認

## 重要な注意事項

### 前提条件
- macOSシステム（`/opt/homebrew`パスを使用）
- Homebrewの事前インストールが必要
- 初期化スクリプトにはwgetが必要
- プライベートGitHubリポジトリ用のSSHキーが設定されたGit

### 言語コンテキスト
- 主要ドキュメントは日本語
- コメントとREADMEファイルは日本語を使用
- Gitコミットメッセージは`feat:`、`fix:`などのプレフィックス付き英語形式に従う

### 現在のブランチ状況
- `feature/claude_skills`ブランチで作業中
- 最近の変更にはClaude Desktop統合、Android Studioセットアップ、PostgreSQL 17インストールが含まれる

### 既知の制限事項
- Flutter SDKはインストールされているが、現在シェル設定で無効化されている
- Gitエイリアスはdotfilesで管理されておらず、手動セットアップが必要
- 一部のスクリプトには未完成機能のTODOマーカーがある（uninstall.sh）