### セットアップ（日本語）

このプロジェクトをローカルで動かすための最小手順です。

- クローン
  - `git clone <YOUR_REPOSITORY_URL>`
  - `cd SharkCheap`

- 必須ツール
  - Xcode
  - Java (JDK 17+ 推奨)
  - fastlane
  - xcodegen（`fastlane ios setup` 実行時に自動インストール）

- 初回実行手順
  - 実行コマンド:
```bash
fastlane ios setup
fastlane ios build_ios
```

- `fastlane ios setup` は `.githooks/post-checkout` も自動で有効化します。

- fastlane が未インストールの場合（初回のみ）
```bash
brew install fastlane
```

---
