## Mintのインストール   
```brew install mint```

## Swiftgenのインストール
### 個別インストール
  ```$mint install Swiftgen/Swiftgen```   
Swiftgen公式Githubに記載されているインストール方法です。(私はこちらの方法でしました。）

## エラーの対応
### 1. command not found: swiftgen が出てくる場合
```echo $PATH```
- 上記のコマンドをターミナルに入力して
```/Users/seobyeonggwan/.mint/bin```
  このように/.mint/binが含まれているかを確認してください。
- もしなかった場合は、   
```nano ~/.zshrc```
- 上記のコマンドを使って一番下に```"export PATH="$HOME/.mint/bin:$PATH"```このラインを追加してください。
- <img width="300" alt="image" src="https://github.com/user-attachments/assets/91fe9ecd-a57e-4038-adec-3e6fe4836e40" />
- 上記の画像の様に黄色文字で表記されるパスを入力しても動作します。
- 追加したら**source ~/.zshrc**このコマンドで反映させ、ターミナルを再起動してください。
```swiftgen --version```
でswiftgenがインストールされているかの確認ができます。
- 一番確実なのはmintでswiftgenを再インストールすることです。
### 2. SwiftGenCLI/resource_bundle_accessor.swift:12: Fatal error: could not load resource bundle: ~ from /Users/seobyeonggwan/.mint/bin/SwiftGen_SwiftGenCLI.bundleの場合。
- Mintのパス→.mint/binにSwiftGen_SwiftGenCLI.bundleがない場合発生するエラーです。
- 私の場合は.mint/binではなく、.mint/bin/package~ の中だけに入っていました。packageパス中のSwiftGen_SwiftGenCLI.bundleファイルをbinにコピーするだけでエラーが解除されました。
