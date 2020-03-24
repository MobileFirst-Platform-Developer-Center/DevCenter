---
layout: tutorial
title: ログイン・フォームの追加
weight: 9
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## ログイン・フォームの追加
{: #dab-login-form }

### 設計 (Design) モードでのアプリケーションへのログイン・フォームの追加
{: #add-login-form-design-mode }

アプリケーション内にログイン・フォームを追加するには、以下のステップを実行します。

1. Mobile Foundation Server で以下の変更を行います。
    * ユーザー名とパスワードを入力として受け取るセキュリティー検査アダプターをデプロイします。 [こちら](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80)のサンプル・アダプターを使用できます。
    * Mobile Foundation Operation Console で、アプリケーションのセキュリティー・タブに移動し、「必須アプリケーション・スコープ」で、上記で作成したセキュリティー定義をスコープ・エレメントとして追加します。
2. ビルダーを使用して、アプリケーションの以下の構成を行います。
    * **「ログイン・フォーム (Login Form)」**コントロールをページのキャンバスに追加します。
    * **「プロパティー」**タブで、**「セキュリティー検査名 (Security check name)」**および**「ログイン成功時 (On Login Success)」**にナビゲートするページを指定します。
    * アプリケーションを実行します。
