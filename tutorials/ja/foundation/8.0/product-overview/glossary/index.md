---
layout: tutorial
title: 用語集
weight: 8
---
<!-- NLS_CHARSET=UTF-8 -->

<!-- START NON-TRANSLATABLE -->
{% comment %}
Do note use keywords in the keyword terms, as this presents issues with the glossary sort tool. (You can use keywords in the definitions.)
When the term should logically use a keyword, use the keyword text in the term, and add a no-translation comment.
For example, instead of using "{{site.data.keys.mf_console }}" for the console term, use "MobileFirst Operations Console" and add the following between the term and the definition (starting with the "START NON-TRANSLATABLE" comment):
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst Operations Console" in the term above (site.data.keys.mf_console keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->

<br/>
この用語集では、{{site.data.keys.product }} のソフトウェアと製品の用語および定義を示します。

この用語集では、以下の相互参照が使用されています。

* 「**参照してください**」は、非推奨の用語から推奨される用語に、または略語から正式名称に言及します。
* 「**も参照。**」は、関連する用語または対比する用語を示します。

その他の用語および定義については、[IBM Terminology Web サイト](http://www.ibm.com/software/globalization/terminology/)を参照してください。

## A {
{: #a }
}
### 取得ポリシー (acquisition policy)
{: #acquisition-policy }
モバイル・デバイスのセンサーからデータを収集する方法をコントロールするポリシー。ポリシーはアプリケーション・コードにより定義されます。

### アダプター (adapter)
{: #adapter }
{{site.data.keys.product_adj }} アプリケーションのサーバー・サイドのコード。アダプターはエンタープライズ・アプリケーションと接続し、モバイル・アプリケーションとのデータの送受信を行ったり、送信されたデータに必要なすべてのサーバー・サイド・ロジックを実行したりします。

### 管理データベース (administration database)
{: #administration-database }
{{site.data.keys.mf_console }} および Administration Services のデータベース。データベース表に、アプリケーション、アダプター、プロジェクトなどの要素が、それぞれの説明とともに、規模順に明示されます。

### Administration Services
{: #administration-services }
REST サービスおよび管理タスクをホストするアプリケーション。Administration Services アプリケーションは、その独自の WAR ファイルにパッケージされています。

### 別名 (alias)
{: #alias }
2 つのデータ・エンティティーの間や、またはデータ・エンティティーとポインターとの間における、仮想と実体の関連付け。

### Android
{: #android }
Google 社が作成したモバイル・オペレーティング・システム。大半は Apache 2.0 および GPLv2 オープン・ソースのライセンスを使用してリリースされています。「モバイル・デバイス (mobile device)」も参照。

### API / アプリケーション・プログラミング・インターフェース (API) (Application Programming Interface (API)) 
{: #api-application-programming-interfacae-api }
オペレーティング・システムまたは別のプログラムが持つ特定のデータや機能が、高水準言語で作成されたアプリケーション・プログラムで使用できるようになるインターフェースのこと。

### app
{: #app }
Web またはモバイル・デバイスのアプリケーション。「Web アプリケーション (web application)」も参照。

### Application Center
{: #application-center }
{{site.data.keys.product_adj }} のコンポーネントの 1 つ。これを使用すれば、チーム・メンバー同士が、モバイル・アプリケーションの単一リポジトリーでアプリケーションを共有したりコラボレーションを促進したりできます。

### Application Center インストーラー (Application Center installer)
{: #application-center-installer }
Application Center で入手可能なアプリケーションのカタログをリストするアプリケーション。専用アプリケーション・リポジトリーからアプリケーションをインストールするには、デバイス上に Application Center Installer が存在している必要があります。

### アプリケーション記述子ファイル (application descriptor file)
{: #application-descriptor-file }
アプリケーションの様々な面を定義するメタデータ・ファイル。

### 認証 (authentication)
{: #authentication }
コンピューター・システムのユーザーが真に本人であることを証明するセキュリティー・サービス。このサービスを実装するための一般的なメカニズムはパスワードとデジタル署名です。

## B
{: #b }
### Base64
{: #base64 }
バイナリー・データのエンコードに使用されるプレーン・テキスト・フォーマット。Base64 エンコードは、X.509 certificate、X.509 CSR、および X.509 CRL をエンコードするために User Certificate Authentication で標準的に使用されています。「DER エンコード化 (DER encoded)」、「PEM エンコード化 (PEM encoded)」も参照。

### バイナリー (binary)
{: #binary }
コンパイルされているもの、または実行可能なものに関連している。

### ブロック (block)
{: #block }
複数のプロパティーの集合体 (アダプター、プロシージャー、またはパラメーターなど)。

### ブロードキャスト通知 (broadcast notification)
{: #broadcast-notification }
特定の {{site.data.keys.product_adj }} アプリケーションのユーザー全員に宛てた通知。「タグ・ベースの通知 (tag-based notification)」も参照。

### ビルド定義 (build definition)
{: #build-definition }
週 1 回のプロジェクト全体の統合ビルドなど、ビルドを定義するオブジェクト。

## C
{: #c }

### CA / 認証局 (CA) (Certificate Authority (CA))
{: #ca--certificate-authority-ca }
デジタル証明書を発行する、信頼できるサード・パーティー組織または企業。認証局は通常、固有の認証を認可された個人の ID を検証します。[証明書 (certificate)](#certificate) も参照。

### コールバック機能 (callback function)
{: #callback-function }
下位ソフトウェア・レイヤーが上位レイヤーで定義された機能を呼び出せる、実行可能コード。

### カタログ (catalog)
{: #catalog }
アプリケーションの集合体

### 証明書 (certificate)
{: #certificate }
コンピューター・セキュリティーにおいては、公開鍵を証明書の所有者の ID にバインドする、デジタル文書。これにより、証明書の所有者が認証されます。証明書は、認証局が発行およびデジタル署名を行います。[認証局 (certificate authority)](#ca--certificate-authority-ca) も参照。

### 認証局エンタープライズ・アプリケーション (certificate authority enterprise application)
{: #certificate-authority-enterprise-application }
クライアント・アプリケーションに証明書および秘密鍵を提供する企業アプリケーション。

### チャレンジ (challenge)
{: #challenge }
ある情報についての、システムへの要求。クライアント認証には、要求に応答してサーバーに返信されるこの情報が必要です。

### チャレンジ・ハンドラー (challenge handler)
{: #challenge-handler }
サーバー・サイドに一連の課題を出してクライアント・サイドに応答する、クライアント・サイドのコンポーネント。

### クライアント (client)
{: #client }
サーバーからのサービスを要求するソフトウェア・プログラムまたはコンピューター。

### クライアント・サイド認証コンポーネント (client-side authentication component)
{: #client-side-authentication-componnet }
クライアント情報を収集して、その情報を検証するためにログイン・モジュールを使用するコンポーネント。

### クローン (clone)
{: #clone }
コンポーネントの最後に承認されたバージョンと同一のコピー。このコピーには、独自のコンポーネント ID が新しく割り当てられます。

### クラスター (cluster)
{: #cluster }
連携して単一の統合コンピューティング機能を提供する完全なシステムの集合。

### 企業アプリケーション (company application)
{: #company-application }
企業の社内で使用するように設計されたアプリケーション。

### 企業ハブ (Company Hub)
{: #company-hub }
モバイル・デバイスにインストールされる、特定のアプリケーションを配布できるアプリケーション。例えば、Application Center は企業ハブです。[Application Center](#application-center) も参照。

### コンポーネント (component)
{: #component }
特定の機能を実行し、他のコンポーネントおよびアプリケーションと連携して動作する、再使用可能なオブジェクトまたはプログラム。

### 資格情報 (credential)
{: #credential }
ユーザーを認可する、または特定のアクセス権限を処理する、情報のセット。

### CRL / 証明書取り消しリスト (CRL) (Certificate Revocation List (CRL))
{: #crl-certificate-revocation-list-crl }
スケジュールされた有効期限より前に取り消された証明書のリスト。証明書取り消しリストは認証局が保守します。関係する証明書が取り消されないよう Secure Sockets Layer (SSL) がハンドシェークしている間に、認証局が証明書取り消しリストを使用します。

## D
{: #d }

### データ・ソース (data source)
{: #data-source }
アプリケーションがデータベースからデータにアクセスするための手段。

### デプロイメント (deployment)
{: #deployment }
ソフトウェア・アプリケーションおよびそのすべてのコンポーネントをインストールして構成する処理。

### DER エンコード化 (DER encoded)
{: #der-encoded }
ASCII PEM フォーマットの証明書の、バイナリー形式に関連すること。「Base64」、「PEM エンコード化 (PEM encoded)」も参照。

### デバイス (device)
{: #device }
[モバイル・デバイス (mobile device)](#mobile-device) を参照してください。

### デバイス・コンテキスト (device context)
{: #device-context }
デバイスの位置を特定するために使用されるデータ。このデータには、地理的座標、WiFi アクセス・ポイント、およびタイム・スタンプの詳細が含まれる場合があります。「トリガー (trigger)」も参照。

### デバイスの登録 (device enrollment)
{: #device-enrollment }
デバイス所有者が所有するデバイスを信頼できるものとして登録するプロセス。

### documentify
{: #documentify }
文書の作成に使用される JSONStore コマンド。

## E
{: #e }

### エミュレーター (emulator)
{: emulator }
現行プラットフォーム以外のプラットフォーム向けのアプリケーションを実行するのに使用されるアプリケーション。

### 暗号化 (encryption)
{: #encryption }
コンピューター・セキュリティーにおいて、元のデータを取得できないような方法、または暗号化解除プロセスによってのみ取得できるような方法で、データを解読不能な形式に変換するプロセス。

### エンタープライズ・アプリケーション (enterprise application)
{: #enterprise-application }
「企業アプリケーション (company application)」を参照してください。

### エンティティー (entity)
{: #entity }
セキュリティー・サービスに対して定義されているユーザー、グループ、またはリソース。

### 環境 (environment)
{: #environment }
ハードウェアまたはソフトウェアの構成の特定のインスタンス。

### イベント (event)
{: #event }
タスクまたはシステムに重要な事柄が発生すること。イベントには、オペレーション、ユーザー処置、または処理状態の変更の完了または失敗が含まれる場合があります。

### イベント・ソース (event source)
{: #event-source }
単一の Java™ 仮想マシン内の非同期通知サーバーをサポートするオブジェクト。イベント・ソースを使用して、任意のインターフェースを実装するためにイベント・リスナー・オブジェクトを登録および使用することができます。

## F
{: #f }

### ファセット (facet)
{: #facet }
XML データ型を制限する XML エンティティー。

### ファーム・ノード (farm node)
{: #farm-node }
サーバー・ファームに配置されるネットワーク・サーバー。

### 発生 (fire)
{: #fire }
オブジェクト指向プログラミングにおいて、状態遷移を発生させること。

## G
{: #g }
### ゲートウェイ (gateway)
{: #gateway }
ネットワーク体系の異なるネットワークまたはシステムに接続するために使用される、デバイスまたはプログラム。

### ジオコーディング (geocoding)
{: #geocoding }
従来の地理マーカー (住所、郵便番号など) からジオコードを特定するプロセス。例えば、ランドマークとなるビルなどがあるのは 2 本の通りが交差する地点ですが、そのランドマークのジオコードは数列で構成されています。

### 地理位置情報 (geolocation)
{: #geolocation }
様々なタイプの信号のアセスメントに基づいて、位置を正確に示す処理。モバイル・コンピューティングにおいては、しばしば WLAN アクセス・ポイントおよび携帯電話の基地局が位置を概算するのに使用されます。「ジオコーディング (geocoding)」、「ロケーション・サービス (location services)」も参照。

## H
{: #h }

### 同種サーバー・ファーム (homogeneous server farm)
{: #homogeneous-server-farm }
すべてのアプリケーション・サーバーが同じタイプ、レベル、バージョンのサーバー・ファーム。

### ハイブリッド・アプリケーション (hybrid application)
{: #hybrid-application }
主に Web 指向言語 (HTML5、CSS、および JS) で書かれているが、ネイティブ・シェルで包まれているアプリケーション。そのためそのアプリケーションはネイティブ・アプリケーションのように振る舞い、そのネイティブ・アプリケーションのすべての機能がユーザーに提供されます。

## I
{: #i }

### 社内アプリケーション (in-house application)
{: #in-house-application }
[企業アプリケーション (company application)](#company-application) を参照してください。

## J
{: #j }

### JMX / Java Management Extensions (JMX)
{: #jmx--java-management-extensions-jmx }
Java テクノロジーの管理および Java テクノロジーによる管理を行う手段。JMX は管理用の Java プログラミング言語の公開された拡張版であり、管理が必要なすべての業界でデプロイすることができます。

## K
{: #k }

### 鍵 (key)
{: #key }
メッセージに対しデジタル署名、検証、暗号化、または暗号化解除を行うために使用される、暗号化された数値。「秘密鍵 (private key)」、「公開鍵 (public key)」も参照。
データ項目内の 1 つ以上の文字であり、一意的にレコードを特定し、その他のレコードに対しその順序を確立するために使用されます。

### キーチェーン (keychain)
{: #keychain }
Apple ソフトウェアのパスワード管理システム。キーチェーンは、複数のアプリケーションおよびサービスで使用されるパスワードのセキュア・ストレージ・コンテナーとして動作します。

### 鍵ペア (key pair)
{: #key-pair }
コンピューター・セキュリティーにおいては公開鍵と秘密鍵のこと。暗号化に鍵ペアを使用する場合、送信側は受信側の公開鍵を使用してメッセージを暗号化し、受信側は秘密鍵を使用してそのメッセージの暗号化解除を行います。署名に鍵ペアを使用する場合、署名者は秘密鍵を使用してメッセージの表明を暗号化し、受信側は送信側の公開鍵を使用してそのメッセージの表明の暗号化解除を行い、署名を検証します。

## L
{: #l }

### ライブラリー (library)
{: #library }
他のオブジェクトへのディレクトリーとして機能するシステム・オブジェクトです。ライブラリーは関連したオブジェクトをグループ化し、ユーザーは名前からオブジェクトを検索することができます。
モデル・エレメントの集合。ビジネス・アイテム、プロセス、タスク、リソース、および組織を含みます。

### ロード・バランシング (load balancing)
{: #load-balancing }
複数のコンピューター、コンピューター・クラスター、ネットワーク・リンク、中央演算処理装置、ディスク・ドライブ、または他のリソースにワークロードを分散するための、コンピューター・ネットワーキング・メソッド。適切なロード・バランシングによりリソース使用の最適化、スループットの最大化、応答時間の最小化や、過負荷の回避が可能になります。

### ローカル・ストア (local store)
{: #local-store }
アプリケーションがネットワーク接続する必要がなく、ローカルにデータを格納したり取得したりできる、デバイス上の領域。

## M
{: #m }

### MBean / Managed Bean (MBean)
{: #mbean--managed-bean-mbean}
Java Management Extensions (JMX) 仕様において、リソースとそのインスツルメンテーションを実装する Java オブジェクト。

### モバイル (mobile)
{: #mobile }
[モバイル・デバイス (mobile device)](#mobile-device) を参照してください。

### モバイル・クライアント (mobile client)
{: #mobile-client }
[Application Center インストーラー (Application Center installer)](#application-center-installer) を参照してください。

### モバイル・デバイス (mobile device)
{: #mobile-device }
無線ネットワーク上で作動する電話、タブレット、または携帯情報端末。「Android」も参照。

### MobileFirst アダプター (MobileFirst adapter)
{: #mobilfirst-adapter }
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst" in the term above (site.data.keys.product_adj keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
[アダプター (adapter)](#adapter) を参照。

### MobileFirst データ・プロキシー (MobileFirst Data Proxy)
{: #mobilefirst-data-proxy }
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst" in the term above (site.data.keys.product_adj keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
{{site.data.keys.product }} OAuth セキュリティー機能の使用により、Cloudant へのモバイル・アプリケーション呼び出しをセキュアに使用できる IMFData SDK に対するサーバー・サイド・コンポーネント。{{site.data.keys.product_adj }} データ・プロキシーにより、Trust Association Interceptor (TAI) を通じた認証を要求されます。

### MobileFirst Operations Console
{: #mobilefirst-operations-console }
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst Operations Console" in the term above (site.data.keys.mf_console keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
{{site.data.keys.mf_server }} でデプロイされる {{site.data.keys.product_adj }} ランタイム環境を制御および管理し、ユーザー統計値を収集および分析するために使用される Web ベースのインターフェース。

### MobileFirst ランタイム環境 (MobileFirst runtime environment)
{: #mobilefirts-runtime-environment }
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst" in the term above (site.data.keys.product_adj keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
モバイル・アプリケーションのサーバー・サイドを実行する、モバイル用に最適化されたサーバー・サイドのコンポーネント (バックエンド統合、バージョン管理、セキュリティー、 統一プッシュ通知)。各ランタイム環境は、Web アプリケーション (WAR ファイル)としてパッケージされます。

### MobileFirst Server
{: #mobilefirst-server }
<!-- START NON-TRANSLATABLE -->
{% comment %}
Do not translate "MobileFirst Server" in the term above (site.data.keys.mf_server keyword).
{% endcomment %}
<!-- END NON-TRANSLATABLE -->
{{site.data.keys.product_adj }} のコンポーネントの 1 つ。セキュリティー、バックエンド接続、プッシュ通知、モバイル・アプリケーション管理、および分析を処理します。{{site.data.keys.mf_server }} は、アプリケーション・サーバー上で稼動するアプリケーションの集合であり、{{site.data.keys.product_adj }} ランタイム環境用のランタイム・コンテナーとして動作します。

## N
{: #n }

### ネイティブ app (native app)
{: #native-app }
デバイス上のモバイル・オペレーティング・システムで使用するための、バイナリー・コードにコンパイルされた app。

### ノード (node)
{: #node }
管理対象サーバーの論理グループ。

### 通知 (notification)
{: #notification }
アクションをトリガーできるプロセス内のオカレンス。通知は、送信側から、関心を示している (通常は不明の) 通話者のセット (受信側) に送信される、インタレスト条件のモデルを作成するために使用することができます。

## O
{: #o }

### OAuth
{: #oauth }
リソース所有者、クライアント、およびリソース・サーバーの間で承認対話を作成することにより、アプリケーションに対しリソース所有者の代わりに保護リソースに限定的なアクセス権限を付与する HTTP ベースの許可プロトコル。

## P
{: #p }

### ページ・ナビゲーション (page navigation)
{: #page-navigation }
ユーザーがブラウザー内を行き来できるように指示するブラウザー機能。

### PEM エンコード化 (PEM encoded)
{: #pem-encoded }
Base64 エンコードされた証明書に関連すること。「Base64」、「DER エンコード化 (DER encoded)」も参照。

### PKI / Public Key Infrastructure (PKI)
{: #pki--public-key-infrastructure-pki }
ネットワーク・トランザクションに関係している各通話者の妥当性を検証し認証する、デジタル証明書、認証局およびその他の登録局のシステム。

### PKI ブリッジ (PKI bridge)
{: #pki-bridge }
ユーザー証明書認証フレームワークを使用可能にして PKI による通信を行う、{{site.data.keys.mf_server }} の概念。

### ポール (poll)
{: #poll }
サーバーから繰り返しデータを要求すること。

### 秘密鍵 (private key)
{: #private-key }
セキュア通信においては、メッセージの暗号化に使用されるアルゴリズム的パターン。暗号化されたメッセージは、対応する公開鍵のみが暗号化解除できる。秘密鍵はまた、対応する公開鍵が暗号化したメッセージの暗号化解除を行うためにも使用されます。秘密鍵はユーザーのシステム上で保持され、パスワードにより保護されます。「鍵 (key)」、「公開鍵 (public key)」も参照。

### プロジェクト (project)
{: #project }
アプリケーション、アダプター、構成ファイル、カスタム Java コード、およびライブラリーなどの様々なコンポーネントのための開発環境。

### プロジェクト WAR ファイル (project WAR file)
{: #project-war-file }
{{site.data.keys.product_adj }} ランタイム環境の構成を含む Web アーカイブ (WAR) ファイル。アプリケーション・サーバーにデプロイされます。

### プロビジョン (provision)
{: #provisin }
サービス、コンポーネント、アプリケーション、またはリソースを提供、デプロイ、および追跡すること。

### プロキシー (proxy)
{: #proxy }
Telnet または FTP などの特定のネットワーク・アプリケーションのための、1 つのネットワークから別のネットワークへのアプリケーション・ゲートウェイ。例えば、ファイアウォール・プロキシー Telnet サーバーがユーザー認証を行い、そのプロキシーが存在しないかのようにプロキシーを介してトラフィック・フローを通します。関数はクライアント・ワークステーションではなくファイアウォール内で実行されるため、ファイアウォール内の負荷は高くなります。

### 公開鍵 (public key)
{: #public-key }
セキュア通信においては、対応する秘密鍵が暗号化したメッセージの暗号化解除に使用されるアルゴリズム的パターン。公開鍵はまた、対応する秘密鍵のみが暗号化解除できるメッセージを暗号化するためにも使用されます。ユーザーは、暗号化されたメッセージを交換する必要のあるすべての相手に公開鍵をブロードキャストします。「鍵 (key)」、「秘密鍵 (private key)」も参照。

### プッシュ (push)
{: #push }
サーバーからクライアントに情報を送信すること。サーバーがコンテンツをプッシュする場合、トランザクションを開始するのはサーバーであり、クライアントからの要求によるものではありません。

### プッシュ通知 (push notification)
{: #push-notification }
モバイル app アイコン上に表示される、変更または更新を示すアラート。

## R
{: #r }

### リバース・プロキシー (reverse proxy)
{: #reverse-proxy }
プロキシーがバックエンドの HTTP サーバーの代理をする、IP を送信するトポロジー。これは、HTTP を使用するサーバーのアプリケーション・プロキシーです。

### ルート (root)
{: #root }
システム内の他のすべてのディレクトリーを含むディレクトリー。

## S
{: #s}

### ソルト (salt)
{: #salt }
パスワードまたはパスフレーズ・ハッシュにランダムに挿入されるデータ。パスワードをわかりにくく、ハッキングできないようにします。

### SDK / Software Development Kit (SDK)
{: #sdk--software-development-kit-sdk }
特定のコンピューター言語または特定のオペレーティング環境でのソフトウェアの開発を支援するツール、API、資料のセット。

### セキュリティー・テスト (security test)
{: #security-test }
アダプター・プロシージャー、アプリケーション、または静的 URL などのリソースの保護に使用される認証レルムの順序付きセット。

### サーバー・ファーム (server farm)
{: #server-farm }
ネットワーク・サーバーのグループ。

### サービス (service)
{: #service }
サーバーまたは関連ソフトウェアの中で 1 次機能を実行するプログラム。

### セッション (session)
{: #sessions }
ネットワーク上にある 2 つの端末、ソフトウェア・プログラム、またはデバイスがセッション中に通信してデータを交換できるようにする、これら 2 つのエレメント間の論理または仮想接続。

### 署名 (sign)
{: #sign }
文書をメールする際に、文書またはフィールドに送信側のユーザー ID から派生した固有の電子署名を添付すること。メールに署名すると、権限のないユーザーがユーザー ID のコピーを新規に作成しても、その不正ユーザーが署名を偽造することができなくなります。加えて、その署名により、メッセージの転送中にデータが改ざんされなかったことが証明されます。

### シミュレーター (simulator)
{: #simulator }
異なるプラットフォーム用に書き込まれたステージング・コードの環境。シミュレーターは、同じ IDE 内でコードを開発およびテストするために使用されますが、そのコードは固有のプラットフォームにデプロイされます。例えば、コンピューター上で Android デバイス用のコードを開発し、その後、そのコードを当該コンピューター上でシミュレーターを使用してテストすることができます。

### スキン (skin)
{: #skin }
インターフェースの外観を、その機能に影響を与えずに変更するための、変更可能なグラフィカル・ユーザー・インターフェースのエレメント。

### スライド (slide)
{: #slide }
タッチスクリーンでスライダー・インターフェース項目を水平に移動させること。通常、app ではスライド・ジェスチャーを使用して電話のロックおよびアンロック、またはオプションの切り替えを行います。

### サブエレメント (subelement)
{: #subelement }
UN/EDIFACT EDI 標準においては、EDI 複合データ・エレメントの一部である EDI データ・エレメントのこと。例えば、EDI データ・エレメントとその修飾子は、EDI 複合データ・エレメントのサブエレメントです。

### サブスクリプション (subscription)
{: #subscription }
サブスクライバーがローカルのブローカーまたはサーバーに渡す情報を格納するレコード。この情報には、サブスクライバーが受け取るべきパブリケーションが記述されます。

### 構文 (syntax)
{: #syntax }
コマンドまたはステートメントを構成する際の規則。

### システム・メッセージ (system message)
{: #system-message }
モバイル・デバイス上の自動メッセージ。例えば、接続の成功または失敗など、操作状況またはアラートを送信します。

## T
{: t}

### タグ・ベースの通知 (tag-based notification)
{: #tag-based-notification }
特定のタグにサブスクライブされたデバイスをターゲットとする通知。タグを使用してユーザーに役立つトピックを示します。「ブロードキャスト通知 (broadcast notification)」も参照。

### TAI / Trust Association Interceptor (TAI)
{: #tai--trust-association-interceptor-tai }
プロキシー・サーバーによって受け取られたすべての要求のプロダクト環境で、信頼が検証されるときのメカニズム。プロキシー・サーバーおよびインターセプターによって同意された妥当性検査のメソッド。

### タップ (tap)
{: #tap }
タッチスクリーンに軽く触れること。通常、app ではタップ・ジェスチャーを使用して項目を選択します (左マウス・ボタンのクリックと似ています)。

### テンプレート (template)
{: #template }
共通のプロパティーを共有するエレメントのグループ。これらのプロパティーはテンプレート・レベルで 1 度だけ定義できます。そのテンプレートを使用するすべてのエレメントがそのプロパティーを継承します。

### トリガー (trigger)
{: #trigger }
オカレンスを検出するメカニズム。応答として追加の処理を引き起こす場合があります。トリガーは、デバイス・コンテキストに変更が発生するとアクティブ化する場合があります。「デバイス・コンテキスト (device context)」も参照。

## U
{: #u }

## V
{: #v }

### ビュー (view)
{: #view }
エディター領域の外部にあるペイン。ワークベンチのリソースを表示したり、処理したりするのに使用できます。

## W
{: #w}

### Web アプリケーション (web app / application)
{: #web-app--application }
Web ブラウザーによってアクセスが可能であり、情報の静的表示より高度な処理を要する機能 (ユーザーによるデータベース照会など) を提供するアプリケーション。一般的な Web アプリケーションのコンポーネントには、HTML ページ、JSP ページ、およびサーブレットがあります。[app](#A) も参照。

### Web アプリケーション・サーバー (web application server)
{: #web-application-server }
動的な Web アプリケーションのためのランタイム環境。Java EE Web アプリケーション・サーバーは、Java EE 標準のサービスを実装しています。

### Web リソース (web resource)
{: #web-resource }
Web アプリケーションの開発中に作成されるリソースの任意の 1 つ。例えば、Web プロジェクト、HTML ページ、JavaServer Pages (JSP) ファイル、サーブレット、カスタム・タグ・ライブラリー、およびアーカイブ・ファイルがあります。

### ウィジェット (widget)
{: #widget }
移植可能かつ再使用可能なアプリケーションまたは動的コンテンツの 1 部。Web ページに配置し、入力を受け取り、アプリケーションや他のウィジェットと通信することができます。

### ラッパー (wrapper)
{: #wrapper }
コードのセクション。このセクションに実行可能なコードが含まれていないと、コンパイラーがインタープリットできません。ラッパーはコンパイラーとラップされたコードの間のインターフェースとして動作します。

## X
{: #x }

### X.509 certificate
{: #x509-certificate }
X.509 規格が定める情報が含まれた証明書。
