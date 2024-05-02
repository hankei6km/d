# d

簡易的な環境設定を行うスクリプト。

`devcontainer.json` や `csb.nix` で設定するのはよろしくないと考えているものを扱う。

## 使い方

定型的なテキストを入力するツール(例: IME のユーザー辞書、IDE のキーボードショーカットなど)を利用し、下記のようなコマンドを実行する(入力ツールの利用は必須ではない)。

```
. <(curl -L https://github.com/hankei6km/d/raw/main/s)
```

### `s` - CodeSandbox 用

CodeSandbox の IDE や VSCode でサンドボックスやリポジトリ(ブランチ)を開いた後にターミナルから実行。一旦ターミナルを閉じて開くと設定された環境となる。

基本は Bash と TMUX の Vi キーバインド的な環境設定。

また、`$CSB` が定義されていて Nix が使える場合は、[個人用の channel](https://github.com/hankei6km/test-nix-channel-simple) を登録した後に各種ツールをインストールする。

なお、VSCode の Bash IDE 拡張機能で `shellcheck` を利用する場合は、Window の reload が必要。

### `t` - VS Code Remote - Tunnels 用

調整中

コンテナなどの一時的な環境で [Remote - Tunnels](https://code.visualstudio.com/docs/remote/tunnels) を使いたくなったときにターミナルから実行。以下のようなコマンドでサーバーを開始し、VS Code で接続すると設定された環境になる。

```
 ~/.local/bin/code tunnel --accept-server-license-terms --name <server name>
    --install-extension GitHub.copilot \
    --install-extension GitHub.copilot-chat \
    --install-extension GitHub.vscode-pull-request-github \
    --install-extension Github.vscode-github-actions \
    --install-extension esbenp.prettier-vscode \
    --install-extension mads-hartmann.bash-ide-vscode \
    --install-extension timonwong.shellcheck
```

調整が必要な箇所:

- GitHub CLI のインストールで `sudo` を使っている
- GitHub CLI の認証は別途必要
- `tmux` は設定のみ(インストールは別途必要)
- `code` コマンド は `alpine-x64` 用を決め打ちでコピー
- `bash-completion` `git` はインストールされている前提
- Git のユーザー設定などは別途必要(GitHub の認証は VS Code 側でヘルパーが設定される)
