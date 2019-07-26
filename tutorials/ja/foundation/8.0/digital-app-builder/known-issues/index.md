---
layout: tutorial
title: 既知の問題
weight: 8
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #known-issues }

IBM Digital App Builder の使用中に発生する可能性のある既知の問題を以下に示します。

* Windows でアプリケーションをプレビューできない

    管理特権を使用して Windows 上で Digital App Builder を実行します。 これを行うには、Digital App Builder アイコンを選択し、「管理者として実行」を選択します。 

* 数字が含まれているページ名を作成すると、Digital App Builder がクラッシュする

    ページ名には数字を使用しないでください。

* cordova カメラ・プラグインの既知の問題のため、Watson Visual Recognition コントロールのカメラが Web プラットフォームで機能しない
 
    cordova カメラ・プラグインの既知のバグです。 詳しくは、[cordova カメラ・プラグインの既知の問題](https://github.com/apache/cordova-plugin-camera/issues/399)に関する資料を参照してください。
