---
layout: tutorial
title: テンプレート
weight: 18
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## テンプレートの使用
{: #dab-templates }

テンプレートを使用して、アプリケーションを迅速にビルドできます。 これは、アプリケーションを迅速に変更および開発するのに役立つ、特定の機能が有効になったアプリケーション・テンプレートです。

デフォルトで、Digital App Builder には Mod Resorts と Tabs という 2 つのテンプレートが付属しています。

* **Mod Resorts**: このテンプレートは、リゾート・アプリケーションのユース・ケース付きのサンプル・アプリケーションを提供します。はじめは、ログイン・モジュール、チャット・モジュール、アプリケーション内フィードバック・モジュールが含まれています。 その後、ログイン・アダプターをデプロイし、独自のチャットボット資格情報を構成する必要があります。
* **Tabs**: このテンプレートは、最下部にタブを提供するタブ付きモバイル・アプリケーション・インターフェースを提供します。このテンプレートは、ログイン・モジュールも含んでいます。

### カスタム・テンプレートの作成
{: #create-custom-template }

デフォルトのテンプレートは以下の場所に保管されます。
* MacOS: `Users/<systemname>/Library/Application Support/IBM Digital App Builder/ionic_templates/`
* Windows: `Users\<systemname>\AppData\Roaming\IBM Digital App Builder\ionic_templates\`
    
Mod Resorts などのデフォルト・テンプレートの 1 つを複製してから編集することによって、カスタム・テンプレートを作成します。
コピーしたテンプレートで必要な変更をカスタマイズし、フォルダーを zip します。
作成したカスタム・テンプレート用のフォルダーを `\ionic_templates\` の下に作成し、この新規フォルダーに .zip ファイルをコピーします。
\ionic_templates\ フォルダー内の templates.json ファイルを編集して、テンプレートを追加するための新規項目を追加します。
例えば、以下に示すように新規カスタム・テンプレートを追加できます。

```json
{
    "version": 12,
    "templates": [
        {
            "name": "Mod Resorts",
            "icon": "modresorts/modresortslogo.png",
            "templateFile": "modresorts/modresorts.zip"
        },
        {
            "name": "Tabs",
            "icon": "tabs/tabs.png",
            "templateFile": "tabs/tabs.zip"
        }
       {
            "name": "MyCustomTemplate",
            "icon": "mytemplate/customtemplate.png",
            "templateFile": "mytemplate/customtemplate.zip"
        }
     ]
}
```
>**注記**
>* `version` 番号を増やしてください。
>* リリース・チームからのテンプレート追加がある場合、更新によって `\ionic_templates\` フォルダーが置き換えられます。したがって、カスタム・テンプレート・フォルダーのバックアップを作成し、更新後に再適用するように注意してください。
