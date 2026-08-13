# ISBN Book Finder

ISBNから書籍情報を検索する、作りかけの読書管理アプリです。FlutterクライアントからFastAPIへISBNを送り、Google Books APIで取得したタイトル・著者・出版社・表紙などを表示します。

> [!NOTE]
> 現在は書籍検索までを実装したプロトタイプです。読書記録の保存やリーダー機能はまだありません。

## 現在できること

- ISBNを入力して書籍を検索
- Google Books APIから書誌情報を取得
- タイトル、著者、出版社、出版日、表紙をFlutterで表示
- FastAPIのJSON APIとして書籍情報を返却

## 構成

```text
bookapp/                 Flutterクライアント
  lib/main.dart          ISBN検索画面
  lib/api_service.dart   FastAPIクライアント

app/                     FastAPIバックエンド
  main.py                アプリ設定
  api/routes.py          /api/decode エンドポイント
  service/book_service.py
                         Google Books API連携
```

## 技術スタック

- Flutter / Dart
- FastAPI / Python
- Google Books API

## バックエンドの起動

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --reload
```

動作確認:

```text
GET http://127.0.0.1:8000/api/decode?isbn=978...
```

## Flutterアプリの起動

```bash
cd bookapp
flutter pub get
flutter run
```

`bookapp/lib/api_service.dart`のAPI URLは現在`127.0.0.1:8000`固定です。実機やエミュレーターから試す場合は、実行環境に応じたバックエンドのアドレスへ変更してください。

## 今後の候補

- バーコードカメラ読み取り
- 読了・積読・読書中などのステータス管理
- 読書メモと進捗の保存
- ローカルDBまたはクラウド同期
- API URLの設定化
- エラー処理とテストの追加
