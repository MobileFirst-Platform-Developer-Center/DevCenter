---
layout: tutorial
title: 追加情報
breadcrumb_title: 追加情報
relevantTo: [android]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
### Android Studio Gradle プロジェクトへの Javadocs の登録
{: #registering-javadocs-to-an-android-studio-gradle-project }
{{site.data.keys.product_adj }} Android Javadocs は、Gradle によってインポートされた *.aar ファイルに含まれています。ただし、Android Studio で関連するライブラリーにリンクする必要があります。

1. Android Studio で、**「Project」**ビューで作業していることを確認します。
2. **「External Libraries」**ノードの下にあるライブラリー名を見つけます (Javadoc ファイルはその下にあります)。
3. ライブラリー名を右クリックして**「Library Properties」**を選択します。
4. 「Library Properties」ダイアログで「+」ボタンを選択します。
5. **..\app\build\intermediates\exploded-aar\ibmmobilefirstplatformfoundation\jars\assets** の下にある、ダウンロードした Javadoc JAR ファイル (**ibmmobilefirstplatformfoundation-javadoc.jar**) にナビゲートして、それを選択します。
6. **「OK」**をクリックします。これで、Javadocs がプロジェクト内で使用可能になりました。

### 注
{: #notes }

* Android Service 内から {{site.data.keys.product_adj }} API をアクティブ化することはできません。
