# CLAUDE.md

このファイルは、このリポジトリでコードを操作する際のClaude Code (claude.ai/code)向けのガイダンスを提供します。

## プロジェクト概要

これはmacOS上の開発環境設定を[chezmoi](https://www.chezmoi.io/)で管理するための個人用dotfilesリポジトリです。シェル設定、テキストエディタのセットアップ、ターミナルマルチプレクサの設定、完全な開発環境のためのパッケージ管理が含まれています。

## 主要なコマンド

### 初期設定
```bash
# chezmoiをインストール（Homebrewの事前インストールが必要）
brew install chezmoi

# リポジトリをchezmoiソースディレクトリとしてクローン
chezmoi init git@github.com:negi524/dotfiles.git

# 設定ファイルをホームディレクトリに適用
chezmoi apply

# 全てのHomebrewパッケージをインストール
brew bundle --global

# zshプラグインをインストール
zplug install
```

### 日常の開発作業
```bash
# IDE風のtmuxレイアウトを起動（70/30縦分割）
ide

# 設定ファイルを編集（chezmoiエディタで開く）
chezmoi edit ~/.zshrc

# chezmoiソースディレクトリで直接編集
cd ~/.local/share/chezmoi
# ファイル編集後...
chezmoi apply

# Homebrewパッケージリストを更新
brew bundle dump --global --force

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
- **chezmoiベースの管理**: 設定ファイルは`~/.local/share/chezmoi`に保存され、`chezmoi apply`でホームディレクトリに展開
- **テンプレート機能**: `.chezmoiexternal.toml.tmpl`でホスト名に応じた設定の切り替えが可能
- **外部リポジトリ統合**: Claude SkillsなどをGitリポジトリから自動取得（`.chezmoiexternal.toml.tmpl`で管理）
- **冪等操作**: `chezmoi apply`は変更があった場合のみファイルを更新

### 主要ディレクトリ
- `bin/`: カスタムスクリプト（`ide` tmuxレイアウトスクリプトなど）※chezmoiの管理外
- `etc/`: レガシーのセットアップスクリプト ※chezmoi移行後は主に使用していない
- `dot_config/nvim/`: lazy.nvimを使用するモダンなLuaベースのNeovim設定（chezmoiで`~/.config/nvim/`に展開）
- `dot_config/wezterm/`: WezTermターミナル設定（`~/.config/wezterm/`に展開）
- `iTerm2/`: レガシーのターミナル設定 ※WezTermに移行済み
- `tmp/`: 一時ファイル用ディレクトリ

### ランタイム管理スタック
- **シェル**: zshをメイン（`.zshrc`で設定）
- **バージョン管理**: mise（統合ランタイムマネージャー、pyenv/rbenv/fnmを置き換え）
- **Pythonパッケージ**: uv（Poetryを置き換え）
- **テキストエディタ**: Neovim（アクティブ）、Vim（レガシー）
- **ターミナルエミュレータ**: WezTerm（Kittyグラフィックスプロトコル対応）
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
1. chezmoiソースディレクトリ内の設定ファイルを編集
   ```bash
   cd ~/.local/share/chezmoi
   # または
   chezmoi edit ~/.zshrc
   ```
2. 変更を適用: `chezmoi apply`
3. シェル設定を反映: `source ~/.zshrc`
4. tmux変更の場合: `tmux source-file ~/.tmux.conf`

### パッケージ管理
- `brew install <package>`で新しいパッケージをインストール
- `brew bundle dump --global --force`でパッケージリストを更新（`~/.Brewfile`に保存）
- chezmoiソースディレクトリの`dot_Brewfile`に変更を反映
- VSCode拡張機能は`--no-vscode`オプションで管理対象から除外

### 変更のテスト
- シェル設定: `source ~/.zshrc`
- tmux設定: `tmux source-file ~/.tmux.conf`
- Neovimプラグイン: Neovimを起動して`:Lazy`でプラグインステータスを確認
- chezmoi管理ファイル: `chezmoi managed`で管理対象ファイル一覧を確認
- 差分確認: `chezmoi diff`で適用前に変更内容を確認

## 重要な注意事項

### 前提条件
- macOSシステム（`/opt/homebrew`パスを使用）
- Homebrewの事前インストールが必要
- chezmoiのインストールが必要（`brew install chezmoi`）
- プライベートGitHubリポジトリ用のSSHキーが設定されたGit

### 言語コンテキスト
- 主要ドキュメントは日本語
- コメントとREADMEファイルは日本語を使用
- Gitコミットメッセージは`feat:`、`fix:`などのプレフィックス付き英語形式に従う

### 現在のブランチ状況
- `main`ブランチで作業中
- 最近の変更にはchezmoi移行、Claude Skillsの外部リポジトリ化が含まれる

### 既知の制限事項
- Flutter SDKはインストールされているが、現在シェル設定で無効化されている
- Gitエイリアスはdotfilesで管理されておらず、手動セットアップが必要
- `etc/`ディレクトリの古いセットアップスクリプト（init, setup）はchezmoi移行後は主に使用していない
- `bin/`ディレクトリはchezmoiの管理外（`.chezmoiignore`に含まれる）