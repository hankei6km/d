# d

簡易的な環境設定を行うスクリプト。

`devcontainer.json` や `csb.nix` で設定するのはよろしくないと考えているものを扱う。

## 使い方

定型的なテキストを入力するツール(例: IME のユーザー辞書、IDE のキーボードショーカットなど)を利用し、下記のようなコマンドを実行する(入力ツールの利用は必須ではない)。

```
. <(curl -L https://github.com/hankei6km/d/raw/main/s)
```

### `s` - 主に CodeSandbox 用

CodeSandbox の IDE や VSCode でサンドボックスやリポジトリ(ブランチ)を開いた後にターミナルから実行。一旦ターミナルを閉じて開くと設定された環境となる。

基本は Bash と TMUX の Vi キーバインド的な環境設定。

また、`$CSB` が定義されていて Nix が使える場合は、[個人用の channel](https://github.com/hankei6km/test-nix-channel-simple) を登録した後に各種ツールをインストールする。

なお、VSCode の Bash IDE 拡張機能で `shellcheck` を利用する場合は、Window の reload が必要。
