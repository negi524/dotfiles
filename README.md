# dotfiles

macOS開発環境を[chezmoi](https://www.chezmoi.io/)で管理

- bash
- zsh
- Neovim
- tmux
- iTerm2

## 初期設定

chezmoiをインストール

```bash
brew install chezmoi
```

リポジトリをchezmoiソースディレクトリとして初期化

```bash
chezmoi init git@github.com:negi524/dotfiles.git
```

設定を適用

```bash
chezmoi apply
```

## Homebrewの設定

Homebrewをインストールし、brewコマンドが利用可能な状態にしておく。

### Homebrewによりインストールされたパッケージを保存

```bash
brew bundle dump --global --force
```

※ `~/.Brewfile` に保存される
※VSCodeの拡張機能は`--no-vscode`オプションで管理対象外

chezmoiソースディレクトリの`dot_Brewfile`に反映

```bash
cd ~/.local/share/chezmoi
cp ~/.Brewfile dot_Brewfile
chezmoi apply
```

## gitの設定

gitのアカウントと鍵を作成する。
以下のエイリアスはdotfilesで管理できていないので、手打ちする。

```bash
git config --global alias.st status
git config --global alias.co commit
git config --global alias.br branch
git config --global alias.ch checkout
git config --global alias.df diff
```

## 設定の構築

各種設定を反映する

```bash
chezmoi apply -v
```

設定ファイルを編集する場合

```bash
# chezmoiエディタで編集
chezmoi edit ~/.zshrc

# または、ソースディレクトリで直接編集
chezmoi cd
# ファイル編集後...
chezmoi apply -v
```

## ディレクトリ構成

chezmoiソースディレクトリ (`~/.local/share/chezmoi`) の構成

### dot_config/

`~/.config/` に展開される設定ファイル
- `nvim/`: Neovim設定（lazy.nvimでプラグイン管理）

### bin/

自作のコマンドスクリプトやバイナリなどを配置
※chezmoiの管理外（`.chezmoiignore`に含まれる）

### etc/

レガシーのセットアップスクリプト
※chezmoi移行後は主に使用していない

### iTerm2/

iTerm2 で利用する設定ファイルを配置

### tmp/

一時的なファイルを配置
削除されても問題ないファイルを配置

### dot_*

chezmoiの命名規則で、`dot_`プレフィックスがついたファイルは`.`で始まるファイルとして展開される
- `dot_zshrc` → `~/.zshrc`
- `dot_Brewfile` → `~/.Brewfile`
- `dot_tmux.conf` → `~/.tmux.conf`

## Neovim

- color scheme : onedark
- plugin manager : [lazy.nvim][]

設定ファイルの場所（chezmoi管理下）
- ソース: `~/.local/share/chezmoi/dot_config/nvim/`
- 展開先: `~/.config/nvim/`

### 主要プラグイン

|          名称          |             説明             |
| :--------------------: | :--------------------------: |
|  [vim-jp/vimdoc-ja][]  |       ヘルプの日本語化       |
|  [Comment.nvim][]      |     簡単にコメントアウト     |
|  [onedark.nvim][]      |       カラースキーマ         |
|  [nvim-tree.lua][]     |           ファイラ           |
|  [diffview.nvim][]     |          差分を確認          |
|  [gitsigns.nvim][]     |        Git差分表示           |
|  [copilot.lua][]       |      GitHub Copilot統合      |


## zsh

### Plugin manager

[zplug/zplug][]

### Plugin for zsh

|                 名称                  |            説明            |
|:-------------------------------------:|:--------------------------:|
| [zsh-users/zsh-autosuggestions][]     | 履歴からコマンドを補完する |
| [zsh-users/zsh-syntax-highlighting][] | シンタックスハイライト     |
| [junegunn/fzf][]                      | あいまい検索をする         |

### Installation

```bash
zplug install
```

[lazy.nvim]: https://github.com/folke/lazy.nvim
[vim-jp/vimdoc-ja]: https://github.com/vim-jp/vimdoc-ja
[Comment.nvim]: https://github.com/numToStr/Comment.nvim
[onedark.nvim]: https://github.com/navarasu/onedark.nvim
[nvim-tree.lua]: https://github.com/nvim-tree/nvim-tree.lua
[diffview.nvim]: https://github.com/sindrets/diffview.nvim
[gitsigns.nvim]: https://github.com/lewis6991/gitsigns.nvim
[copilot.lua]: https://github.com/zbirenbaum/copilot.lua
[jethrokuan/fzf]: https://github.com/jethrokuan/fzf
[zplug/zplug]: https://github.com/zplug/zplug
[zsh-users/zsh-autosuggestions]: https://github.com/zsh-users/zsh-autosuggestions
[zsh-users/zsh-syntax-highlighting]: https://github.com/zsh-users/zsh-syntax-highlighting/tree/master
[junegunn/fzf]: https://github.com/junegunn/fzf
