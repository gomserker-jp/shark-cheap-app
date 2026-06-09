# SharkCheap App
## 概要
[CheapShark public API](https://apidocs.cheapshark.com/)を使ったゲームのESDプラットフォーム別値段追跡アプリケーション

## 主要機能
- セール全とやESDプラットフォーム別目玉セール情報確認
- ゲーム検索機能
- 3ヶ国語対応（日・韓・英）
- ゲーム別詳細セール情報確認機能（開発中）
- お気に入り機能（開発中）

## 開発環境
| 項目 | 技術スペック |
| --- | --- |
| 言語 | Swift 6.0 |
| UI | SwiftUI |
| 非同期処理 | Swift Concurrency |
| アーキテクチャ | The Composable Architecture（TCA）with Atomic Design |
| 共通ロジック | Kotlin Multiplatform Mobile（KMM） |
| CI/CD | GitHub Actions + Fastlane |
| DB | Realm |
| AIツール | Cursor |
| ライブラリ (KMP) | SKIE |
| ライブラリ (iOS) | Kingfisher |

---

### セットアップ（日本語）

このプロジェクトをローカルで動かすための手順です。

#### 事前に用意するもの（手動）

`bundle exec fastlane ios setup` の前に、以下だけ先に入れておいてください。

| ツール | バージョン | 備考 |
| --- | --- | --- |
| macOS + Xcode | CI と同系統を推奨 | iOS ビルドに必須 |
| [Homebrew](https://brew.sh/) | 最新 | 以降のツール自動インストールに使用 |
| Ruby | **3.3**（`.ruby-version` 参照） | CI も 3.3 を使用 |
| Bundler | Gemfile.lock に合わせて自動解決 | `gem install bundler` |

Ruby 3.3 の例:

```bash
brew install ruby@3.3
echo 'export PATH="/opt/homebrew/opt/ruby@3.3/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
gem install bundler
```

> **fastlane は brew で入れなくて OK**  
> リポジトリの `Gemfile` / `Gemfile.lock` から `bundle exec fastlane` で使います。

> **Java も事前インストールは不要**  
> `fastlane ios setup` が未インストールなら Temurin JDK を brew で入れます（CI は Java 26）。

#### 初回セットアップ

```bash
git clone <YOUR_REPOSITORY_URL>
cd shark-cheap-app

bundle install
bundle exec fastlane ios setup
bundle exec fastlane ios build_ios
```

`setup` が行うこと:

- `scripts/setup_tools.sh` 経由で **Java / xcodegen / swiftgen** を未インストールなら brew インストール
- `iosApp/project.yml` から **`SharkCheapApp.xcodeproj` を生成**（`.xcodeproj` は git 管理外）
- `.githooks/post-checkout` を有効化（ブランチ切替時に xcodegen を自動実行）

#### Assets / 文字列を変更したとき

- `Resources/Assets.xcassets` や `Localizable.strings` を編集したら、ローカルで SwiftGen を再実行してください。
- 生成物（`iosApp/SharkCheapApp/Generated/*.swift`）は **git にコミット** してください。
- CI では SwiftGen を実行せず、コミット済みの Generated ファイルでビルドします。

```bash
cd iosApp
swiftgen config run --config swiftgen.yml
```

#### よく使うコマンド

| コマンド | 用途 |
| --- | --- |
| `bundle exec fastlane ios setup` | ツール確認 + xcodeproj 生成 |
| `bundle exec fastlane ios build_ios` | Simulator 向け iOS ビルド |
| `bundle exec fastlane ios test_shared` | Kotlin shared テスト |
| `bundle exec fastlane ios ci` | CI と同じ流れ（bootstrap + test + build） |

#### トラブルシュート

- **`SharkCheapApp.xcodeproj` がない / 古い**  
  `cd iosApp && xcodegen generate` または `bundle exec fastlane ios setup`
- **`swiftgen: command not found`（Assets 変更時）**  
  `bundle exec fastlane ios setup` を再実行
- **Kotlin フレームワークのビルドエラー**  
  Java が PATH に入っているか `java -version` で確認

---
