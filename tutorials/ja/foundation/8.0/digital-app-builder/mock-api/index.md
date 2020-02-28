---
layout: tutorial
title: モック REST API の使用
weight: 14
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->

## モック API
{: #dab-mock-api }

通常、モバイル・アプリケーションの開発中は、フェッチする必要があるデータが入っている実際のバックエンドをモバイル開発者が容易には使用できません。 そのような場合、実際のバックエンドと同じデータを返すモック・サーバーを使用できると便利です。 Digital App Builder のモック API 機能は、このようなときに役立ちます。 モバイル・アプリケーション開発者は、JSON データを提供するだけで簡単にサーバーをモックできます。

>**注**: この機能は、コード・モードでのみ使用可能です。

バックエンド REST サービスをモックする API を作成および管理するには、以下のようにします。

1. アプリケーション・プロジェクトをコード・モードで開きます。 
2. **「API」**を選択します。 **「API の追加 (Add an API)」**をクリックします。
    ![モック API](dab-mock-api.png)

3. 表示されるウィンドウで、API の名前を入力し、**「追加」**をクリックします。
    ![モック API 追加](dab-new-mock-api.png)

4. これにより、作成された API と自動生成された URL が表示されます。
    ![モック API jason](dab-new-mock-api-jason.png)

5. **「編集」**をクリックします。 この API が呼び出されたときに返す必要があるデータを提供し、**「保存」**をクリックします。 以下に例を示します。 

    ```
    [
      {
        "firstName": "John",
        "lastName": "Doe",
        "title": "Director of Marketing",
        "office": "D531"
      },
      {
        "firstName": "Don",
        "lastName": "Joe",
        "title": "Vice President,Sales",
        "office": "B2600"
      }
    ]
    ```

    ![モック API jason サンプル](dab-exp-moc-api.png)

>**注**: API を即時にテストするには、**「今すぐ試す (Try now)」**をクリックします。そうすると、デフォルト・ブラウザーに swagger 文書が開くので、そこで API をテストできます。

### アプリケーション内でのモック API の取り込み
{: #dab-mock-api-consuming }

1. コード・モードで、**「モバイル・コア (MOBILE CORE)」**セクションから **API 呼び出し**のコード・スニペットをドラッグ・アンド・ドロップします。
2. コードを編集して、URL を変更し、モック API エンドポイントを指すようにします。 以下に例を示します。

    ```
     var resourceRequest = new WLResourceRequest(
         "/adapters/APIProject/api/entity4",
         WLResourceRequest.GET,
         { "useAPIProxy": false }
     );
     resourceRequest.send().then(
         function(response) {
             alert("Success: " + response.responseText);
         },
         function(response) {
             alert("Failure: " + JSON.stringify(response));
         }
     );
    ```
 
