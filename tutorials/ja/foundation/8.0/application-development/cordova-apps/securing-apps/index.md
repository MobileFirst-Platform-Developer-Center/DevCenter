---
layout: tutorial
title: Cordova アプリケーションの保護
breadcrumb_title: Securing applications
relevantTo: [cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
### Cordova パッケージの Web リソースの暗号化
{: #encrypting-the-web-resources-of-your-cordova-packages }
.apk パッケージまたは .ipa パッケージに Web リソースが含まれている間に他のユーザーがその Web リソースを表示および変更するリスクを最小化するために、 {{ site.data.keys.mf_cli }} `mfpdev app webencrypt` コマンドまたは `mfpwebencrypt` フラグを使用して、情報を暗号化できます。 この手順は、破ることが不可能な暗号化を提供するわけではありませんが、基本レベルの難読化を提供します。

**前提条件:**

* Cordova 開発ツールがインストールされている必要があります。 この例では、Apache Cordova CLI を使用します。 他の Cordova 開発ツールを使用する場合は、手順が一部異なります。 手順については、ご使用の Cordova ツールの資料を参照してください。
* {{ site.data.keys.mf_cli }} がインストールされている必要があります。
* {{ site.data.keys.product_adj }} Cordova プラグインがインストールされている必要があります。

この手順を実行する最適のタイミングは、アプリケーションの開発が終わってアプリケーションをデプロイする準備ができたときです。 Web リソース暗号化手順を実行した後に以下のコマンドのいずれかを実行した場合、暗号化されたコンテンツが暗号化解除されます。

* cordova prepare
* cordova build
* cordova run
* cordova emulate
* mfpdev app webupdate
* mfpdev app preview

Web リソースを暗号化した後に上にリストされているコマンドのいずれかを実行した場合、以下の手順を再度実行して、Web リソースを暗号化する必要があります。

1. ターミナル・ウィンドウを開き、暗号化する Cordova アプリケーションのルート・ディレクトリーにナビゲートします。
2. 以下のいずれかのコマンドを入力して、アプリケーションを準備します。
    - cordova prepare
    - mfpdev app webupdate
3. 以下のいずれかの手順を実行して、コンテンツを暗号化します。
    - 以下のコマンドを入力します。`mfpdev app webencrypt`。 **ヒント:** `mfpdev help app webencrypt` と入力することで、`mfpdev app webencrypt` コマンドに関する情報を表示できます。
    - Cordova パッケージのビルド時に `mfpwebencrypt` フラグを `cordova compile` コマンドまたは `cordova build` コマンドに追加することで、Cordova パッケージの Web リソースを暗号化することもできます。
        - `cordova compile -- --mfpwebencrypt` | `cordova build -- --mfpwebencrypt`
    <br/>
    **www** フォルダー内のオペレーティング・システム情報が、暗号化コンテンツを含んだ **resources.zip** ファイルに置き換えられます。  
    アプリケーションが Android オペレーティング・システム用であり、**resources.zip** ファイルが 1 MB より大きい場合、**resources.zip** ファイルは小さい 768 KB の .zip ファイルに分割され、各ファイルの名前は **resources.zip.nnn** になります。 変数 nnn は、001 から 999 までの数字です。
4. プラットフォーム固有のツールで提供されているエミュレーターによって、暗号化リソースを持つアプリケーションをテストします。 例えば、Android の場合は Android Studio、iOS の場合は Xcode のエミュレーターを使用できます。

**注:** 暗号化後にアプリケーションをテストするために、以下の Cordova コマンドは使用しないでください。

* `cordova run`
* `cordova emulate`

上記のコマンドを使用すると、www フォルダーで暗号化されたコンテンツが更新され、暗号化が解除されたコンテンツとして再度保存されてしまいます。 上記コマンドを使用した場合には、アプリケーションを公開する前に、必ず、前述の手順を再度実行して暗号化してください。

### Web リソース・チェックサム機能の有効化
{: #enabling-the-web-resources-checksum-feature }
Web リソース・チェックサム機能は、有効になっている場合、アプリケーションの開始時におけるその元の Web リソースを、そのアプリケーションが初めて開始されたときにキャプチャーされた保管済みベースラインに対して比較します。 これは、アプリケーションが変更されたことを示す可能性がある、アプリケーションの差分を特定する優れた方法です。 この手順は、ダイレクト・アップデート機能と互換性があります。

**前提条件:**

* Cordova 開発ツールがインストールされている必要があります。 この例では、Apache Cordova CLI を使用します。 他の Cordova 開発ツールを使用する場合は、手順が一部異なります。 手順については、ご使用の Cordova ツールの資料を参照してください。
* {{ site.data.keys.mf_cli }} がインストールされている必要があります。
* {{ site.data.keys.product_adj }} プラグインがインストールされている必要があります。
* 対象オペレーティング・システムの Web リソース・チェックサム機能を有効にするには、その前に、`cordova platform add [android|ios|windows|browser]` コマンドを入力して、当該プラットフォームを Cordova プロジェクトに追加しておく必要があります。

Cordova アプリケーションの Web リソース・チェックサム機能を有効にするには、以下のステップを実行します。

1. ターミナル・ウィンドウで、ターゲット・アプリケーションのルート・ディレクトリーにナビゲートします。
2. 以下のコマンドを入力して、ご使用の Cordova アプリケーションのオペレーティング・システム環境の Web リソース・チェックサム機能を有効にします。

   ```bash
   mfpdev app config [android|ios|windows10|windows8|windowsphone8]_security_test_web_resources_checksum true
   ```

   例えば、次のとおりです。  

   ```bash
   mfpdev app config android_security_test_web_resources_checksum true
   ```

   コマンドで **true** を **false** に置き換えることで、この機能を無効にすることができます。

   > **ヒント:** `mfpdev help app config` と入力することで、`mfpdev app config` コマンドに関する情報を表示できます。

3. 以下のコマンドを入力して、チェックサム・テスト時に無視するファイルのタイプを指定します。

   ```bash
   mfpdev app config [android|ios|windows10|windows8|windowsphone8]_security_ignore_file_extensions [ file_extension1,file_extension2 ]
   ```

   複数の拡張子は、間にスペースを入れず、コンマで区切る必要があります。 例えば、次のとおりです。

   ```bash
   mfpdev app config android_security_ignore_file_extensions jpg,png,pdf
   ```

**重要:** このコマンドを実行すると、設定されている値が上書きされます。

Web リソース・チェックサムがテストのためにスキャンするファイルが増えるほど、アプリケーションを開くためにかかる時間が長くなります。 スキップするファイル・タイプの拡張子を指定できます。これにより、アプリケーションの開始速度が改善される可能性があります。

アプリケーションで Web リソース・チェックサム機能が有効になりました。

1. 次のコマンドを実行して、変更をアプリケーションに組み込みます。`cordova prepare`
2. 次のコマンドを入力して、アプリケーションをビルドします。`cordova build`
3. 次のコマンドを入力して、アプリケーションを実行します。`cordova run`
