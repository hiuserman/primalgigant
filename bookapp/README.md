# ISBN Book Finder — Flutter client

ISBNを入力し、FastAPIバックエンドから取得した書籍情報を表示するFlutterクライアントです。

## 起動

```bash
flutter pub get
flutter run
```

バックエンドを先に`uvicorn app.main:app --reload`で起動してください。

APIの接続先は`lib/api_service.dart`にあります。実機・エミュレーターで動かす場合は、`127.0.0.1`をバックエンドへ到達できるアドレスへ変更する必要があります。

プロジェクト全体の説明はルートの`README.md`を参照してください。
