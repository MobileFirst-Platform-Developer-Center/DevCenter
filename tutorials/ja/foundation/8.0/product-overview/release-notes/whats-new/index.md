---
layout: tutorial
title: 新機能
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
{{ site.data.keys.product_full }} V8.0 では、{{ site.data.keys.product_adj }} アプリケーションの開発、デプロイメント、および管理を最新の方法でできるようにする大幅な変更が加えられています。

<div class="panel-group accordion" id="release-notes" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="building-apps">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-building-apps" aria-expanded="true" aria-controls="collapse-building-apps">アプリケーションのビルドの新機能</a>
            </h4>
        </div>

        <div id="collapse-building-apps" class="panel-collapse collapse" role="tabpanel" aria-labelledby="building-apps">
            <div class="panel-body">
                <p>{{ site.data.keys.product }} SDK およびコマンド・ライン・インターフェースは、アプリケーションの開発時の柔軟性と効率を高めるように再設計されました。 また、クロスプラットフォーム・アプリケーションの開発時に、任意の Cordova ツールを使用できるようになりました。</p>

                <p>以下のセクションで、アプリケーション開発のための新機能について確認してください。</p>

                <h3>新しい開発およびデプロイメントのプロセス</h3>
                <p>アプリケーション・サーバーにインストールする必要のあるプロジェクト WAR ファイルを作成することはありません。 代わりに、{{ site.data.keys.mf_server }} が 1 度インストールされたら、アプリケーション、リソース・セキュリティー、またはプッシュ・サービスのサーバー・サイド構成をサーバーにアップロードしてください。 {{ site.data.keys.mf_console }} を使用してアプリケーションの構成を変更することができます。</p>

                <p>{{ site.data.keys.product_adj }} プロジェクトは、存在しなくなりました。 代わりに、任意の開発環境を使用してモバイル・アプリケーションを開発してください。<br/>
                {{ site.data.keys.mf_server }} を停止することなく、アプリケーションおよびアダプターのサーバー・サイド構成を変更することができます。</p>

                <ul>
                    <li>新しい開発プロセスについて詳しくは、『<a href="../../../application-development/">開発の概念および概要 (Development concepts and overview)</a>』を参照してください。</li>
                    <li>既存のアプリケーションのマイグレーションについて詳しくは、<a href="../../../upgrading/migration-cookbook">マイグレーションの手引き</a>を参照してください。</li>
                    <li>{{ site.data.keys.product_adj }} アプリケーションの管理について詳しくは、『{{ site.data.keys.product_adj }} アプリケーションの管理』を参照してください。</li>
                </ul>

                <h3>Web アプリケーション</h3>
                <p>{{ site.data.keys.product_adj }} クライアント・サイド JavaScript API を使用することで、任意のツールおよび IDE によって Web アプリケーションを開発できるようになりました。 Web アプリケーションを {{ site.data.keys.mf_server }} に登録して、セキュリティー機能をアプリケーションに追加することができます。</p>

                <p>新規 Web SDK の一部として提供される新しいクライアント・サイド JavaScript Web 分析 API を使用して、{{ site.data.keys.mf_analytics }} 機能を Web アプリケーションに追加することもできます。</p>

                <h3>任意の Cordova ツールを使用したクロスプラットフォーム・アプリケーションの開発</h3>
                <p>任意の Cordova ツール (Apache Cordova CLI または Ionic フレームワークなど) を使用して、クロスプラットフォーム・ハイブリッド・アプリケーションを開発できるようになりました。 これらのツールを {{ site.data.keys.product }} とは別個に入手し、{{ site.data.keys.product_adj }} プラグインを追加して、{{ site.data.keys.product_adj }} のバックエンドの機能を提供します。</p>

                <p>{{ site.data.keys.product }} Studio Eclipse プラグインをインストールして、Eclipse 開発環境で {{ site.data.keys.product }} に対応するクロスプラットフォーム Cordova アプリケーションを管理することができます。 {{ site.data.keys.product }} Studio プラグインは、Eclipse 環境内から実行できる追加的な {{ site.data.keys.mf_cli }} コマンドも提供します。</p>

                <h3>SDK のコンポーネント化</h3>
                <p>以前は、{{ site.data.keys.product_adj }} クライアント SDK は単一のフレームワークまたは JAR ファイルとして提供されていました。 現在は、特定の機能を含めたり除外したりすることができるようになりました。 各 {{ site.data.keys.product_adj }} API には、コア SDK に加えて、独自のオプション・コンポーネントのセットがあります。</p>

                <h3>新規または改善された開発用コマンド・ライン・インターフェース (CLI)</h3>
                <p>{{ site.data.keys.mf_cli }} は、自動化されたスクリプトでの使用を含め、開発の効率を高めるように再設計されました。 コマンドには mfpdev というプレフィックスが付けられるようになりました。 CLI は {{ site.data.keys.mf_dev_kit_full }} に組み込まれています。npm から CLI の最新バージョンを素早くダウンロードすることもできます。</p>

                <h3>マイグレーション・アシスト・ツール</h3>
                <p>マイグレーション・アシスト・ツールによって、既存のアプリケーションを {{ site.data.keys.product }} バージョン 8.0 にマイグレーションする手順が簡素化されます。 このツールは、既存の {{ site.data.keys.product_adj }} アプリケーションをスキャンし、ファイル内で使用されている API のうちで、バージョン 8.0 で削除されたか、非推奨になったか、置き換えられた API のリストを作成します。 {{ site.data.keys.product }} で作成された Apache Cordova アプリケーションでマイグレーション・アシスト・ツールを実行すると、そのアプリケーション用に、バージョン 8.0 に準拠する新しい Cordova 構造が作成されます。 マイグレーション・アシスト・ツールについては詳細情報があります。</p>

                <h3>Cordova Crosswalk WebView</h3>
                <p>Cordova 4.0 以降、プラグ可能な WebView を、デフォルトの Web ランタイムの代わりに使用できるようになりました。 Crosswalk は、{{ site.data.keys.product }} を使用する Cordova アプリケーションでサポートされるようになりました。 Android 用の Crosswalk WebView を使用すると、広範なモバイル・デバイスにわたって高いパフォーマンスと一貫した使用感を実現できます。 Crosswalk 機能を利用するには、Cordova Crosswalk プラグインを適用します。</p>

                <h3>NuGet を使用した Windows 8 および Windows 10 ユニバーサル・アプリケーション用の {{ site.data.keys.product_adj }} SDK の配布</h3>
                <p>Windows 8 および Windows 10 ユニバーサル・アプリケーション用の {{ site.data.keys.product_adj }} SDK は、NuGet (<a href="https://www.nuget.org/packages">https://www.nuget.org/packages</a>) から入手できます。 開始します。</p>

                <h3>org.apache.http が okHttp に置き換えられる</h3>
                <p><code>org.apache.http</code> は Android SDK から削除されました。 okHttp が、http の依存関係として使用されます。</p>

                <h3>iOS ハイブリッド Cordova アプリケーション用の WKWebView のサポート</h3>
                <p>Cordova アプリケーション内のデフォルトの UIWebView を WKWebView に置き換えることができるようになりました。</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-apis">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-apis" aria-expanded="true" aria-controls="collapse-mobilefirst-apis">MobileFirst	API の新機能</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-apis" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-apis">
            <div class="panel-body">
                <p>新機能により、モバイル・アプリケーションの開発に使用できる API が改善および拡張されています。 {{ site.data.keys.product }} の新機能、改善された機能、または変更された機能を利用するには、最新の API を使用してください。</p>

                <h3>JavaScript サーバー・サイド API の更新</h3>
                <p>バックエンド呼び出し関数は、サポートされるアダプター・タイプのみでサポートされます。 現在は、HTTP アダプターおよび SQL アダプターのみがサポートされているため、バックエンド呼び出し関数 <code>WL.Server.invokeHttp</code> および <code>WL.Server.invokeSQL</code> もサポートされています。</p>

                <h3>新規 Java サーバー・サイド API</h3>
                <p>新しい Java サーバー・サイド API が提供され、これを使用して {{ site.data.keys.mf_server }} を拡張できます。</p>

                <h4>セキュリティー用の新規 Java サーバー・サイド API</h4>
                <p>新しいセキュリティー API パッケージ <code>com.ibm.mfp.server.security.external</code> と、それに格納されているパッケージには、セキュリティー検査およびセキュリティー検査コンテキストを使用するアダプターを開発するために必要なインターフェースが含まれています。</p>

                <h4>クライアント登録データ用の新規 Java サーバー・サイド API</h4>
                <p>新しいクライアント登録データ API パッケージ <code>com.ibm.mfp.server.registration.external</code> と、それに格納されているパッケージには、永続的な {{ site.data.keys.product_adj }} クライアント登録データへのアクセスを提供するインターフェースが含まれています。</p>

                <h4>Application getJaxRsApplication()</h4>
                <p>この新しい API を使用して、アダプターの JAX-RS アプリケーションを返すことができます。</p>

                <h4>String getPropertyValue (String propertyName)</h4>
                <p>この新しい API を使用して、アダプター構成からの値 (またはデフォルト値) を取得することができます。</p>

                <h3>Java サーバー・サイド API の更新</h3>
                <p>更新された Java サーバー・サイド API が提供され、これを使用して {{ site.data.keys.mf_server }} を拡張できます。</p>

                <h4>getMFPConfigurationProperty(String name)</h4>
                <p>この新しい API のシグニチャーは、このバージョンでは変更されていません。 ただし、その動作は、新しい Java サーバー・サイド API で説明されている <code>String getPropertyValue (String propertyName)</code> の動作と同一になりました。</p>

                <h4>WLServerAPIProvider</h4>
                <p>V7.0.0 および V7.1.0 では、Java API は WLServerAPIProvider インターフェースを通じてアクセス可能でした。 例: <code>WLServerAPIProvider.getWLServerAPI.getConfigurationAPI();</code> および <code>WLServerAPIProvider.getWLServerAPI.getSecurityAPI();</code></p>

                <p>これらの静的インターフェースはまだサポートされ、この製品の以前のバージョンで開発されたアダプターをコンパイルおよびデプロイできるようになっています。 プッシュ通知も以前のセキュリティー API も使用しない古いアダプターは、新しいバージョンでも引き続き機能します。 プッシュ通知または以前のセキュリティー API を使用するアダプターは機能しません。</p>

                <h3>Web アプリケーション用の JavaScript クライアント・サイド API</h3>
                <p>クロスプラットフォーム Cordova アプリケーションの開発に使用される JavaScript クライアント・サイド API は、Web アプリケーションの開発にも使用できるようになりました。ただし初期化方法に多少の違いがあります。 JavaScript API のすべての機能を Web アプリケーションに適用できるわけではないことに注意してください。</p>

                <p>さらに、{{ site.data.keys.mf_analytics }} 機能を Web アプリケーションに追加するための新しい JavaScript クライアント・サイド Web 分析 API が提供されています。</p>

                <h3>Windows 8 Universal および Windows Phone 8 Universal 用の C# クライアント・サイド API の更新</h3>
                <p>Windows 8 Universal および Windows Phone 8 Universal 用の C# クライアント・サイド API が変更されました。</p>

                <h3>Android 向けの新規 Java クライアント・サイド API</h3>
                <h4>public void getDeviceDisplayName(final DeviceDisplayNameListener listener);</h4>
                <p>この新しいメソッドを使用して、{{ site.data.keys.mf_server }} 登録データからデバイスの表示名を取得できます。</p>

                <h4>public void setDeviceDisplayName(String deviceDisplayName,final WLRequestListener listener);</h4>
                <p>この新しいメソッドを使用して、{{ site.data.keys.mf_server }} 登録データ内でデバイスの表示名を設定できます。</p>

                <h3>iOS 向けの新規 Objective-C クライアント・サイド API</h3>
                <h4><code>(void) getDeviceDisplayNameWithCompletionHandler:(void(^)(NSString *deviceDisplayName , NSError *error))completionHandler;</code></h4>
                <p>この新しいメソッドを使用して、{{ site.data.keys.mf_server }} 登録データからデバイスの表示名を取得できます。</p>

                <h4><code>(void) setDeviceDisplayName:(NSString*)deviceDisplayName WithCompletionHandler:(void(^)(NSError* error))completionHandler;</code></h4>
                <p>この新しいメソッドを使用して、{{ site.data.keys.mf_server }} 登録データ内でデバイスの表示名を設定できます。</p>

                <h3>管理サービス用の更新された REST API</h3>
                <p>管理サービス用の REST API は、部分的にリファクタリングされました。 特に、ビーコンおよびメディエーター用の API は削除され、プッシュ通知用のほとんどの REST サービスは、プッシュ・サービス用の REST API の一部になりました。</p>

                <h3>ランタイム用の REST API の更新</h3>
                <p>{{ site.data.keys.product_adj }} ランタイム用の REST API は、モバイル・クライアントおよび機密クライアント用に、アダプターの呼び出し、アクセス・トークンの取得、ダイレクト・アップデートのコンテンツの取得などを行うための、いくつかのサービスを提供するようになりました。 REST API エンドポイントのほとんどは、OAuth によって保護されています。 開発サーバーでは、次の場所で、ランタイム API 用の Swagger 文書を表示できます。<code>http(s)://server_ip:server_port/context_root/doc</code></p>

                <h3>複数の証明書のピン留めをサポート</h3>
                <p>iFix 8.0.0.0-IF201706240159 以降、{{ site.data.keys.mf_bm_short }} は複数の証明書のピン留めをサポートします。 これにより、ユーザーは複数のホストにセキュアにアクセスできます。 この iFix より前では、{{ site.data.keys.mf_bm_short }} は単一の証明書のピン留めをサポートしていました。 {{ site.data.keys.mf_bm_short }} では、複数のホストへの接続を可能にする新しい API が導入されました。これは、ユーザーが複数の X509 証明書 (認証局から購入したもの) の公開鍵をクライアント・アプリケーションにピン留めできるようにすることによって可能になります。 すべての証明書のコピーが、クライアント・アプリケーションに配置されている必要があります。 SSL ハンドシェーク中に、{{ site.data.keys.product_full }} クライアント SDK によって、サーバー証明書の公開鍵が、アプリケーションに保管されているいずれかの証明書からの公開鍵と一致するかが検証されます。</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-security">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-security" aria-expanded="true" aria-controls="collapse-mobilefirst-security">MobileFirst セキュリティーの新機能</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-security" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-security">
            <div class="panel-body">
                <p>{{ site.data.keys.product }} 内のセキュリティー・フレームワークは、完全に再設計されました。 新しいセキュリティー機能が導入され、既存の機能に変更が加えられました。</p>

                <h3>セキュリティー・フレームワークの見直し</h3>
                <p>{{ site.data.keys.product_adj }} セキュリティー・フレームワークは、セキュリティー開発と管理タスクを改善および簡素化するために、再設計されて再実装されました。 フレームワークは基本的に OAuth モデルをベースとするようになり、実装はセッションに依存しません。 『{{ site.data.keys.product_adj }} セキュリティー・フレームワークの概要』を参照してください。</p>

                <p>サーバー・サイドでは、フレームワークの複数のビルディング・ブロックが、セキュリティー検査 (アダプターで実装されている) に置き換えられ、新しい API を使用して容易に開発できるようになっています。 実装のサンプルと、定義済みのセキュリティー検査が用意されています。 『セキュリティー検査』を参照してください。 アダプターを再デプロイしたりフローを中断したりしなくても、アダプター記述子内でセキュリティー検査を構成でき、ランタイム・アダプターまたはアプリケーション構成を変更してセキュリティー検査をカスタマイズすることができます。 構成は、再設計された {{ site.data.keys.mf_console }} セキュリティー・インターフェースから実行できます。 構成ファイルを手動で編集したり、{{ site.data.keys.mf_cli }} または mfpadm ツールを使用することもできます。</p>

                <h3>アプリケーション認証性セキュリティー検査</h3>
                <p>{{ site.data.keys.product_adj }} のアプリケーション認証性の検証は、事前定義されたセキュリティー検査として実装されるようになりました。これが、以前の「拡張アプリケーション認証性チェック」に代わって使用されます。 {{ site.data.keys.mf_console }} または mfpadm のいずれかを使用して、アプリケーション認証性の検証を動的に使用可能または使用不可にしたり構成したりすることができます。 スタンドアロンの {{ site.data.keys.product_adj }} アプリケーション認証性 Java ツール (mfp-app-authenticity-tool.jar) が、アプリケーション認証性ファイルを生成するために提供されています。</p>

                <h3>機密クライアント</h3>
                <p>機密クライアントのサポートは、新しい OAuth セキュリティー・フレームワークを使用して、再設計されて再実装されました。</p>

                <h3>Web アプリケーションのセキュリティー</h3>
                <p>改訂後の OAuth ベースのセキュリティー・フレームワークは、Web アプリケーションをサポートします。 Web アプリケーションを {{ site.data.keys.mf_server }} に登録すると、セキュリティー機能をアプリケーションに追加し、Web リソースへのアクセスを保護することができます。 {{ site.data.keys.product_adj }} Web アプリケーションの開発について詳しくは、『Web アプリケーションの開発』を参照してください。 Web アプリケーションでは、アプリケーション認証性セキュリティー検査はサポートされていません。</p>

                <h3>クロスプラットフォーム・アプリケーション (Cordova アプリケーション)、新規および変更されたセキュリティー機能</h3>
                <p>Cordova アプリケーションの保護に役立つ追加的なセキュリティー機能が使用可能です。 これらの機能には、以下のものが含まれます。</p>

                <ul>
                    <li>Web リソース暗号化: 誰かがパッケージを変更することのないように、この機能を使用して、Cordova パッケージ内の Web リソースを暗号化します。</li>
                    <li>Web リソースのチェックサム: この機能を使用して、アプリケーションの Web リソースの現在の統計と、それが最初に開いたときに設定されたベースライン統計を比較する、チェックサム・テストを実行します。 このチェックは、アプリケーションがインストールされて開かれた後に、誰かがアプリケーションを変更しないようにするために役立ちます。</li>
                    <li>証明書のピン留め: この機能を使用して、アプリケーションの証明書をホスト・サーバー上の証明書に関連付けます。 この機能は、アプリケーションとサーバーの間で渡される情報が表示されたり変更されたりしないようにするために役立ちます。</li>
                    <li>連邦情報処理標準 (FIPS) 140-2 のサポート: この機能を使用して、転送されるデータが確実に FIPS 140-2 暗号化標準に準拠するようにします。</li>
                    <li>OpenSSL: iOS プラットフォーム用の Cordova アプリケーションで OpenSSL データ暗号化および暗号化解除を使用するには、cordova-plugin-mfp-encrypt-utils Cordova プラグインを使用します。</li>
                </ul>

                <h3>デバイスのシングル・サインオン</h3>
                <p>新しい事前定義の <code>enableSSO</code> セキュリティー検査アプリケーション記述子構成プロパティーによってデバイス・シングル・サインオン (SSO) がサポートされるようになりました。</p>

                <h3>ダイレクト・アップデート</h3>
                <p>旧バージョンの {{ site.data.keys.product_adj }} とは異なり、V8.0 以降は以下のようになっています。</p>

                <ul>
                    <li>クライアント・アプリケーションが、保護されていないリソースにアクセスした場合、{{ site.data.keys.mf_server }} に使用可能な更新があっても、アプリケーションは更新を受け取りません。</li>
                    <li>アクティブ化された後は、保護リソースが要求されるたびに、ダイレクト・アップデートが適用されます。</li>
                </ul>

                <h3>外部リソースの保護</h3>
                <p>外部サーバーでリソースを保護するためにサポートされている方法および提供されている成果物が変更されました。</p>

                <ul>
                    <li>{{ site.data.keys.product_adj }} セキュリティー・フレームワークを使用して任意の外部 Java サーバー上のリソースを保護するために、構成可能な新しい {{ site.data.keys.product_adj }} Java トークン・バリデーター・アクセス・トークン検証モジュールが提供されています。 このモジュールは、Java ライブラリー (mfp-java-token-validator-8.0.0.jar) として提供され、カスタム Java 検証モジュールを作成する際に、廃止された {{ site.data.keys.mf_server }} トークン検証エンドポイントの代わりに使用されます。</li>
                    <li>外部 WebSphere Application Server または WebSphere Application Server Liberty サーバー上の Java リソースを保護するための {{ site.data.keys.product_adj }} OAuth トラスト・アソシエーション・インターセプター (TAI) フィルターが、Java ライブラリー (com.ibm.imf.oauth.common_8.0.0.jar) として提供されるようになりました。 このライブラリーでは、新しい Java トークン・バリデーター検証モジュールと、提供されている変更された TAI の構成を使用します。</li>
                    <li>サーバー・サイドの {{ site.data.keys.product_adj }} OAuth TAI API は不要になり、削除されました。</li>
                    <li>外部 Node.js サーバーで Java リソースを保護するための passport-mfp-token-validation {{ site.data.keys.product_adj }} Node.js フレームワークは、新しいセキュリティー・フレームワークをサポートするように変更されました。</li>
                    <li>許可サーバーの新しいイントロスペクション・エンドポイントを使用する任意のタイプのリソース・サーバーに対して、独自のカスタム・フィルターおよび検証モジュールを作成することもできます。</li>
                </ul>

                <h3>許可サーバーとしての WebSphere DataPower との統合</h3>
                <p>デフォルトの {{ site.data.keys.mf_server }} 許可サーバーの代わりに、WebSphere DataPower を OAuth 許可サーバーとして選択できるようになりました。 {{ site.data.keys.product_adj }} セキュリティー・フレームワークと統合するように DataPower を構成することができます。</p>

                <h3>LTPA ベースのシングル・サインオン (SSO) セキュリティー検査</h3>
                <p>WebSphere の Lightweight Third Party Authentication (LTPA) を使用するサーバー間のユーザー認証の共有のサポートが、新しい定義済みの LTPA ベースのシングル・サインオン (SSO) セキュリティー検査を使用して提供されるようになりました。 この検査は、廃止された {{ site.data.keys.product_adj }} LTPA レルムの代わりに使用され、以前に必要であった構成はなくなりました。</p>

                <h3>{{ site.data.keys.mf_console }} を使用したモバイル・アプリケーションの管理</h3>
                <p>{{ site.data.keys.mf_console }} からのモバイル・アプリケーション、ユーザー、およびデバイスの追跡と管理のサポートに対して、変更が加えられました。 デバイスまたはアプリケーションへのアクセスのブロックは、保護リソースにアクセスしようとした場合のみ適用されます。</p>

                <h3>{{ site.data.keys.mf_server }} 鍵ストア</h3>
                <p>単一の {{ site.data.keys.mf_server }} 鍵ストアは、OAuth トークンおよびダイレクト・アップデート・パッケージへの署名と、相互 HTTPS (SSL) 認証に使用されます。 {{ site.data.keys.mf_console }} または mfpadm のいずれかを使用して、この鍵ストアを動的に構成することができます。</p>

                <h3>iOS 向けのネイティブ暗号化および暗号化解除</h3>
                <p>OpenSSL は iOS のメイン・フレームワークから削除され、ネイティブ暗号化/暗号化解除が代わりに使用されるようになりました。 OpenSSL は、別個のフレームワークとして追加できます。 『iOS での OpenSSL の有効化』を参照してください。 iOS Cordova	JavaScript の場合、OpenSSL は現在もメイン・フレームワークに組み込まれています。 両方の API で、ネイティブ暗号化と	OpenSSL 暗号化の両方が使用可能です。</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="os-support">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-os-support" aria-expanded="true" aria-controls="collapse-os-support">オペレーティング・システム・サポートの新機能</a>
            </h4>
        </div>

        <div id="collapse-os-support" class="panel-collapse collapse" role="tabpanel" aria-labelledby="os-support">
            <div class="panel-body">
                <p>{{ site.data.keys.product }} は、Windows 10 Universal アプリケーション、ビットコード・ビルド、および Apple watchOS 2 をサポートするようになりました。</p>

                <h3>Windows 10 ネイティブのユニバーサル・アプリケーションのサポート</h3>
                <p>{{ site.data.keys.product }} を使用して、アプリケーション内で {{ site.data.keys.product_adj }} SDK を使用するためのネイティブ C# Universal App Platform アプリケーションを作成できるようになりました。</p>

                <h3>Windows ハイブリッド環境のサポート</h3>
                <p>Windows ハイブリッド環境向けの Windows 10 Universal Windows Platform (UWP) サポート。 開始方法の詳細情報があります。</p>

                <h3>BlackBerry のサポート終了</h3>
                <p>BlackBerry 環境は、{{ site.data.keys.product }} でサポートされなくなりました。</p>

                <h3>ビットコード</h3>
                <p>ビットコードのビルドが、iOS プロジェクトでサポートされるようになりました。 ただし、{{ site.data.keys.product_adj }} のアプリケーション認証性セキュリティー検査は、ビットコードを使用してビルドされたアプリケーションではサポートされません。</p>

                <h3>Apple watchOS 2</h3>
                <p>Apple watchOS 2 がサポートされるようになり、ビットコードのビルドを必要とします。</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="deploy-manage-apps">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-deploy-manage-apps" aria-expanded="true" aria-controls="collapse-deploy-manage-apps">アプリケーションのデプロイおよび管理の新機能</a>
            </h4>
        </div>

        <div id="collapse-deploy-manage-apps" class="panel-collapse collapse" role="tabpanel">
            <div class="panel-body">
                <p>アプリケーションのデプロイおよび管理に役立つ新しい {{ site.data.keys.product }} 機能が導入されています。 {{ site.data.keys.mf_server }} を再始動しなくても、アプリケーションおよびアダプターを更新できるようになりました。</p>

                <h3>DevOps サポートの改善</h3>
                <p>{{ site.data.keys.mf_server }} は、DevOps 環境のサポートを向上させるため、大幅に再設計されました。 {{ site.data.keys.mf_server }} が、アプリケーション・サーバー環境に 1 度インストールされると、ユーザーがアプリケーションをアップロードするとき、または {{ site.data.keys.mf_server }} 構成を変更するときに、アプリケーション・サーバー構成への変更は必要ありません。</p>

                <p>アプリケーションまたはアプリケーションが依存するアダプターを更新したときに、{{ site.data.keys.mf_server }} を再始動する必要はありません。 サーバーがまだトラフィックを処理している間に、構成操作を実行したり、新規バージョンのアダプターのアップロードまたは新規アプリケーションの登録を実行したりすることができます。</p>

                <p>構成変更および開発操作は、セキュリティー・ロールによって保護されます。</p>

                <p>さまざまな方法で開発成果物をサーバーにアップロードすることができ、操作の柔軟性が高まっています。</p>

                <ul>
                    <li>{{ site.data.keys.mf_console }} の機能拡張: 特に、これを使用してアプリケーションまたは新バージョンのアプリケーションを登録することで、アプリケーション・セキュリティー・パラメーターの管理、証明書のデプロイ、プッシュ通知タグの作成、およびプッシュ通知の送信を実行できます。 コンソールには、コンテキスト・ヘルプ・ガイドも含まれるようになりました。</li>
                    <li>コマンド・ライン・ツール</li>
                </ul>

                <p>サーバーにアップロードする開発成果物には、アダプター、アダプターの構成、アプリケーションのセキュリティー構成、プッシュ通知証明書、およびログ・フィルターが含まれます。</p>

                <h3>IBM Cloud で作成されたアプリケーションの {{ site.data.keys.product }} での実行</h3>
                <p>開発者は、IBM Cloud アプリケーションを、{{ site.data.keys.product }} で実行されるようにマイグレーションすることができます。 マイグレーションするには、{{ site.data.keys.product }} API に適合するようにクライアント・アプリケーションに対して構成変更を加える必要があります。</p>

                <h3>IBM Cloud 上のサービスとしての {{ site.data.keys.product }}</h3>
                <p>IBM Cloud 上の {{ site.data.keys.mf_bm_full }} サービスを使用して、エンタープライズ・モバイル・アプリケーションを作成および実行できるようになりました。</p>

                <h3>.wlapp ファイルがない</h3>
                <p>旧バージョンでは、<b>.wlapp</b> ファイルをアップロードすることによって、アプリケーションが {{ site.data.keys.mf_server }} にデプロイされました。 そのファイルには、アプリケーションを記述し、ハイブリッド・アプリケーションの場合は Web リソースも記述したデータが含まれていました。 V8.0.0 では、<b>.wlapp</b> ファイルを使用する代わりに、以下のようにします。</p>

                <ul>
                    <li>アプリケーション記述子 JSON ファイルをデプロイすることによって、アプリケーションを {{ site.data.keys.mf_server }} に登録します。</li>
                    <li>ダイレクト・アップデートを使用して Cordova アプリケーションを更新するには、修正された Web リソースのアーカイブ (.zip ファイル) をサーバーにアップロードします。 アーカイブ・ファイルには、旧バージョンの {{ site.data.keys.product }} では使用可能であった Web プレビュー・ファイルもスキンも含まれなくなりました。 それらは廃止されました。 アーカイブには、クライアントに送信された Web リソースと、ダイレクト・アップデートの検証用のチェックサムのみが含まれます。</li>
                </ul>

                <p>エンド・ユーザーのデバイスにインストールされているクライアント Cordova アプリケーションのダイレクト・アップデートを有効にするには、変更された Web リソースをアーカイブ (.zip ファイル) としてサーバーにデプロイすることが必要になりました。 セキュアなダイレクト・アップデートを有効にするには、ユーザー定義の鍵ストア・ファイルを {{ site.data.keys.mf_server }} にデプロイする必要があり、一致する公開鍵のコピーを、デプロイされたクライアント・アプリケーションに組み込む必要があります。</p>

                <h3>アダプター</h3>
                <h4>アダプターは Apache Maven プロジェクトです。</h4>
                <p>アダプターは Maven プロジェクトとして扱われるようになりました。 標準のコマンド・ライン Maven コマンドを使用して、または Maven をサポートする任意の IDE (Eclipse や IntelliJ など) を使用して、アダプターを作成、ビルド、およびデプロイすることができます。</p>

                <h4>DevOps 環境でのアダプターの構成およびデプロイメント</h4>
                <ul>
                    <li>{{ site.data.keys.mf_server }} 管理者は、{{ site.data.keys.mf_console }} を使用してデプロイ済みのアダプターの動作を変更できるようになりました。 再構成の後、変更は即時にサーバーに反映されます。アダプターを再デプロイしたり、サーバーを再始動したりする必要はありません。</li>
                    <li>アダプターを「ホット・デプロイ」できるようになりました。すなわち、{{ site.data.keys.mf_server }} がまだトラフィックを処理していても、アダプターを、実行時にデプロイ、アンデプロイ、および再デプロイできます。</li>
                </ul>

                <h4>アダプター記述子ファイルの変更</h4>
                <p><b>adapter.xml</b> 記述子ファイルは、若干変更されました。 アダプターのアダプター記述子ファイルの構造について詳しくは、<a href="{{site.baseurl}}/tutorials/en/foundation/8.0/adapters/">アダプターのチュートリアル (Adapters tutorials)</a>を参照してください。</p>

                <h4>Swagger UI との統合</h4>
                <p>{{ site.data.keys.mf_server }} は Swagger UI と統合するようになりました。 どのアダプターでも、{{ site.data.keys.mf_console }} 内の「リソース」タブで「Swagger 文書の表示」をクリックして、関連付けられた API を表示することができます。 この機能は開発環境のみで使用可能です。</p>

                <h4>JavaScript アダプターのサポート</h4>
                <p>JavaScript アダプターは、HTTP 接続タイプおよび SQL 接続タイプのみでサポートされます。</p>

                <h4>JAX-RS 2.0 のサポート</h4>
                <p>JAX-RS 2.0 では、新しいサーバー・サイド機能を導入しています。サーバー・サイド非同期 HTTP、フィルター、およびインターセプターです。  アダプターで、それらの新機能を利用できるようになりました。</p>

                <h3>{{ site.data.keys.product }} on IBM Containers</h3>
                <p>V8.0.0 用にリリースされた {{ site.data.keys.product }} on IBM Containers は、<a href="http://www-01.ibm.com/software/passportadvantage/">IBM パスポート・アドバンテージのサイト</a>で入手可能です。 このバージョンの {{ site.data.keys.product }} on IBM Containers は、実稼働環境で使用でき、IBM Cloud 上のエンタープライズ dashDB™ トランザクション・データベースをサポートします。</p>

                <p><b>注:</b> {{ site.data.keys.product }} on IBM Containers のデプロイについては、前提条件を参照してください。</p>

                <h3>IBM PureApplication System への {{ site.data.keys.mf_server }} のデプロイ</h3>
                <p>IBM PureApplication System 上の、サポートされる {{ site.data.keys.product }} System Pattern に、{{ site.data.keys.mf_server }} をデプロイして構成することができるようになりました。</p>

                <p>サポートされるすべての {{ site.data.keys.product }} システム・パターンには、既存の IBM DB2 データベースのサポートが含まれるようになりました。 {{ site.data.keys.mf_app_center_full }}が、仮想システム・パターンでサポートされるようになりました。</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-server">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-server" aria-expanded="true" aria-controls="collapse-mobilefirst-server">{{ site.data.keys.mf_server }} の新機能</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-server" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-server">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_server }} は、アプリケーションのデプロイと更新にかかる時間とコストを削減できるように再設計されました。 {{ site.data.keys.mf_server }} の再設計に加えて、 {{ site.data.keys.product }} では使用可能なインストール方法の数が増えています。</p>

                <p>新しい {{ site.data.keys.mf_server }} の設計では、2 つの新規コンポーネントを導入しています。{{ site.data.keys.mf_server }} ライブ・アップデート・サービスおよび {{ site.data.keys.mf_server }} 成果物です。</p>

                <p>{{ site.data.keys.mf_server }} ライブ・アップデート・サービスは、アプリケーションのインクリメンタル更新にかかる時間とコストを削減できるように設計されています。 アプリケーションとアダプターのサーバー・サイド構成データを管理および保管します。 アプリケーションを再ビルドまたは再デプロイしながら、以下のようにアプリケーションのさまざまな部分を変更または更新することができます。</p>

                <ul>
                    <li>定義したユーザー・セグメントに基づいてアプリケーションの動作を動的に変更または更新する。</li>
                    <li>サーバー・サイドのビジネス・ロジックを動的に変更または更新する。</li>
                    <li>アプリケーションのセキュリティーを動的に変更または更新する。</li>
                    <li>アプリケーション構成を外部化し、動的に変更する。</li>
                </ul>

                <p>{{ site.data.keys.mf_server }} 成果物は、{{ site.data.keys.mf_console }} 用のリソースを提供します。</p>

                <p>{{ site.data.keys.mf_server }} が再設計されただけでなく、提供されるインストール・オプションが増えました。 {{ site.data.keys.product }} では、手動インストールのほかに、サーバー・ファームで {{ site.data.keys.mf_server }} をインストールするためのオプションが 2 つ用意されています。 Liberty 集合に {{ site.data.keys.mf_server }} をインストールすることもできます。</p>

                <p>Ant タスクを使用して、またはサーバー構成ツールによって、サーバー・ファームに {{ site.data.keys.mf_server }} コンポーネントをインストールできるようになりました。 詳しくは、以下のトピックを参照してください。</p>

                <ul>
                    <li>サーバー・ファームのインストール</li>
                    <li>{{ site.data.keys.mf_server }} のインストールについてのチュートリアル</li>
                </ul>

                <p>{{ site.data.keys.mf_server }} では、Liberty 集合もサポートします。 サーバー・トポロジーおよび各種インストール方式について詳しくは、以下のトピックを参照してください。</p>

                <ul>
                    <li>Liberty 集合トポロジー</li>
                    <li>サーバー構成ツールの実行</li>
                    <li>Ant タスクを使用したインストール</li>
                    <li>WebSphere Application Server Liberty 集合への手動インストール</li>
                </ul>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-analytics">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-analytics" aria-expanded="true" aria-controls="collapse-mobilefirst-analytics">{{ site.data.keys.mf_analytics }} の新機能</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-analytics" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-analytics">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_analytics }} では、情報の表示を改善し、役割ベースのアクセス制御を行うように再設計されたコンソールを導入しています。 このコンソールは、いくつかの異なる言語で使用できるようになっています。</p>

                <p>{{ site.data.keys.mf_analytics_console }} は、直感的でより理解しやすい方法で情報を表示するように再設計され、一部のイベント・タイプには要約されたデータを使用します。</p>

                <p>歯車アイコンをクリックして {{ site.data.keys.mf_analytics_console }} からサインアウトできるようになりました。</p>

                <p>{{ site.data.keys.mf_analytics_console }} は、以下の言語で使用可能になりました。</p>
                <ul>
                    <li>ドイツ語</li>
                    <li>スペイン語</li>
                    <li>フランス語</li>
                    <li>イタリア語</li>
                    <li>日本語</li>
                    <li>韓国語</li>
                    <li>ポルトガル語 (ブラジル語)</li>
                    <li>ロシア語</li>
                    <li>中国語 (簡体字)</li>
                    <li>中国語 (繁体字)</li>
                </ul>

                <p>{{ site.data.keys.mf_analytics_console }} では、ログインしているユーザーのセキュリティー・ロールに基づいて異なるコンテンツを表示するようになりました。<br/>
                詳しくは、<a href="{{site.baseurl}}/tutorials/en/foundation/8.0/analytics/console/#role-based-access-control">役割ベースのアクセス制御</a>を参照してください。</p>

                <p>{{ site.data.keys.mf_analytics_server }} は Elasticsearch V1.7.5 を使用します。</p>

                <p>Web アプリケーション用の {{ site.data.keys.mf_analytics_short }} のサポートが、新しい Web 分析クライアント・サイド API と共に追加されました。</p>

                <p>旧バージョンの {{ site.data.keys.mf_analytics_server }} と V8.0 の間で、一部のイベント・タイプが変更されました。 この変更のため、ご使用のサーバー構成ファイルで以前に構成されていた JNDI プロパティーは、新しいイベント・タイプに変換する必要があります。</p>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-push">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-push" aria-expanded="true" aria-controls="collapse-mobilefirst-push">{{ site.data.keys.product_adj }} プッシュ通知の新機能</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-push" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-push">
            <div class="panel-body">
                <p>プッシュ通知サービスは、別個の Web アプリケーションでホストされるスタンドアロン・サービスとして提供されるようになりました。</p>

                <p>旧バージョンの {{ site.data.keys.product }} では、プッシュ通知サービスをアプリケーション・ランタイムの一部として組み込んでいました。</p>

                <h3>プログラミング・モデル</h3>
                <p>プログラミング・モデルは、サーバーからクライアントまでにわたって使用されます。プッシュ通知サービスがクライアント・アプリケーションで機能するようにアプリケーションをセットアップする必要があります。 以下の 2 種類のクライアントが、プッシュ通知サービスと相互作用します。</p>

                <ul>
                    <li>モバイル・クライアント・アプリケーション</li>
                    <li>バックエンド・サーバー・アプリケーション</li>
                </ul>

                <h3>プッシュ通知サービスのセキュリティー</h3>
                <p>{{ site.data.keys.product }} 許可サーバーでは、OAuth プロトコルを適用して、プッシュ通知サービスを保護します。</p>

                <h3>プッシュ通知サービス・モデル</h3>
                <p>イベント・ソース・ベースのモデルはサポートされません。 プッシュ・サービス・モデルによって、プッシュ通知機能が {{ site.data.keys.product }} で有効になっています。</p>

                <h3>プッシュ REST API</h3>
                <p>{{ site.data.keys.product }} ランタイムで REST API をプッシュに使用することによって、{{ site.data.keys.mf_server }} の外部でデプロイされたバックエンド・サーバー・アプリケーションが、プッシュ通知機能にアクセスできるようにすることができます。</p>

                <h3>既存のイベント・ソース・ベースの通知モデルからのアップグレード</h3>
                <p>イベント・ソース・ベースのモデルはサポートされません。 プッシュ・サービス・モデルによって、プッシュ通知機能が完全に有効になります。 既存のすべてのイベント・ソース・ベースのアプリケーションを、新しいプッシュ・サービス・モデルにマイグレーションする必要があります。</p>

                <h3>プッシュ通知の送信</h3>
                <p>イベント・ソース・ベース、タグ・ベース、およびブロードキャスト対応のプッシュ通知をサーバーから送信することができます。</p>

                <p>プッシュ通知は、以下の方法で送信できます。</p>
                <ul>
                    <li>{{ site.data.keys.mf_console }} を使用する。2 つのタイプ (タグおよびブロードキャスト) の通知を送信できます。 『{{ site.data.keys.mf_console }} を使用したプッシュ通知の送信』を参照してください。</li>
                    <li>Push Message (POST) REST API を使用する。すべての形式 (タグ、ブロードキャスト、および認証済み) の通知を送信できます。</li>
                    <li>{{ site.data.keys.mf_server }} 管理サービス用の REST API を使用する。すべての形式 (タグ、ブロードキャスト、および認証済み) の通知を送信できます。</li>
                </ul>

                <h3>SMS 通知の送信</h3>
                <p>ユーザー・デバイスにショート・メッセージ・サービス (SMS) 通知を送信するようにプッシュ・サービスを構成することができます。</p>

                <h3>プッシュ通知サービスのインストール</h3>
                <p>プッシュ通知サービスは、{{ site.data.keys.mf_server }} コンポーネント ({{ site.data.keys.mf_server }} プッシュ・サービス) としてパッケージされています。</p>

                <h3>プッシュ・サービス・モデルが Windows Universal Platform アプリケーションでサポートされる</h3>
                <p>プッシュ・サービス・モデルを使用してプッシュ通知を送信するように、ネイティブ Windows Universal Platform (UWP) アプリケーションをマイグレーションすることができるようになりました。</p>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mobilefirst-appcenter">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#release-notes" href="#collapse-mobilefirst-appcenter" aria-expanded="true" aria-controls="collapse-mobilefirst-appcenter"> {{ site.data.keys.mf_app_center }} の新機能</a>
            </h4>
        </div>

        <div id="collapse-mobilefirst-appcenter" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mobilefirst-appcenter">
            <div class="panel-body">
                <p>{{ site.data.keys.mf_app_center }} は現在 BYOL スクリプトを介して IBM Cloud (コンテナーをベースに) でサポートされています。</p>
            </div>
        </div>
    </div>
</div>
