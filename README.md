# dotfiles

開発環境管理

- bash
- fish
- vim
- tmux
- iTerm2

## 初期設定

リポジトリをホームディレクトリ配下にクローン

```bash
cd ~/
git clone git@github.com:negi524/dotfiles.git
```

必要なデータをダウンロード

```bash
~/dotfiles/etc/init
```

## 設定の構築

各種設定を反映する

```bash
~/dotfiles/etc/setup
```

## ディレクトリ構成

### bin/

自作のコマンドスクリプトやバイナリなどを配置

### etc/

dotfiles の設定反映などに利用する設定用のスクリプトなどを配置

### downloads/

設定時に必要なダウンロードしたものを配置

### iTerm2/

iTerm2 で利用する設定ファイルを配置

### tmp/

一時的なファイルを配置
削除されても問題ないファイルを配置

## Vim

- color scheme : hybrid
- plugin : vim-plug

### plugin for Vim

|          名称          |             説明             |
| :--------------------: | :--------------------------: |
|  [vim-jp/vimdoc-ja][]  |       ヘルプの日本語化       |
| [tpope/vim-fugitive][] |       git を便利にする       |
|   [posva/vim-vue][]    | vue のシンタックスハイライト |
|   [w0ng/vim-hybrid][]  | カラースキーム               |

### Vim コマンド

#### install vim plugin

```
:PlugInstall
```

#### create code tags

```
:Maketag
```

`~/dotfiles/tmp/tags` にタグを生成する。

- `Ctrl + ]`: 宣言元へジャンプ
- `Ctrl + o`: 戻る

## fish

### plugin for fish

|        名称        |      説明      |
| :----------------: | :------------: |
| [jethrokuan/fzf][] | 曖昧検索をする |

#### install fish plugin

```
$ fisher add jethrokuan/fzf
```

## zsh

### plugin manager

[zplug/zplug][]

### plugin for zsh

|                 名称                  |            説明            |
|:-------------------------------------:|:--------------------------:|
| [zsh-users/zsh-autosuggestions][]     | 履歴からコマンドを補完する |
| [zsh-users/zsh-syntax-highlighting][] | シンタックスハイライト     |

[vim-jp/vimdoc-ja]: https://github.com/vim-jp/vimdoc-ja
[tpope/vim-fugitive]: https://github.com/tpope/vim-fugitive
[posva/vim-vue]: https://github.com/posva/vim-vue
[jethrokuan/fzf]: https://github.com/jethrokuan/fzf
[w0ng/vim-hybrid]: https://github.com/w0ng/vim-hybrid
[zplug/zplug]: https://github.com/zplug/zplug
[zsh-users/zsh-autosuggestions]: https://github.com/zsh-users/zsh-autosuggestions
[zsh-users/zsh-syntax-highlighting]: https://github.com/zsh-users/zsh-syntax-highlighting/tree/master
