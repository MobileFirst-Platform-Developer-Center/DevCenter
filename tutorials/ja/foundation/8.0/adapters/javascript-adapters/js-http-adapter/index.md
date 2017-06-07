---
layout: tutorial
title: JavaScript HTTP アダプター
breadcrumb_title: HTTP アダプター
relevantTo: [ios,android,windows,javascript]
downloads:
  - name: アダプター Maven プロジェクトのダウンロード
    url: https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }

HTTP アダプターを使用して、GET HTTP 要求または POST HTTP 要求を送信したり、応答ヘッダーおよび本文からデータを取得したりすることができます。HTTP アダプターは、RESTful および SOAP ベースのサービスで作動し、RSS フィードなどの構造化された HTTP ソースを読み取ることができます。

簡潔なサーバー・サイド JavaScript コードを使用して、HTTP アダプターを簡単にカスタマイズできます。例えば、必要に応じて、サーバー・サイド・フィルタリングをセットアップできます。取得されるデータ形式は、XML、HTML、JSON、プレーン・テキストのいずれかです。

アダプターは、アダプターのプロパティーとプロシージャーを定義するために XML で構成されます。   
必要に応じて、受け取ったレコードとフィールドを XSL を使用してフィルタリングできます。

**前提条件:** 最初に必ず、[JavaScript アダプター](../)チュートリアルをお読みください。

## XML ファイル
{: #the-xml-file }

XML ファイルには、設定およびメタデータが含まれています。  
アダプター XML ファイルを編集するには、以下のようにしてください。 

* プロトコルを HTTP または HTTPS に設定します。   
* HTTP ドメインを HTTP URL のドメイン部分に設定します。  
* TCP ポートを設定します。  

`connectivity` エレメントの下で必要なプロシージャーを宣言します。

```xml
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<mfp:adapter name="JavaScriptHTTP"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:mfp="http://www.ibm.com/mfp/integration"
	xmlns:http="http://www.ibm.com/mfp/integration/http">

	<displayName>JavaScriptHTTP</displayName>
	<description>JavaScriptHTTP</description>
	<connectivity>
		<connectionPolicy xsi:type="http:HTTPConnectionPolicyType">
			<protocol>https</protocol>
			<domain>mobilefirstplatform.ibmcloud.com</domain>
			<port>443</port>
			<connectionTimeoutInMilliseconds>30000</connectionTimeoutInMilliseconds>
			<socketTimeoutInMilliseconds>30000</socketTimeoutInMilliseconds>
			<maxConcurrentConnectionsPerNode>50</maxConcurrentConnectionsPerNode>
		</connectionPolicy>
	</connectivity>

	<procedure name="getFeed"/>
	<procedure name="getFeedFiltered"/>
</mfp:adapter>
```

<div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="adapter-xml">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>ここをクリックして <code>connectionPolicy</code> 属性とサブエレメントを表示</b></a>
            </h4>
        </div>

        <div id="collapse-adapter-xml" class="panel-collapse collapse" role="tabpanel" aria-labelledby="adapter-xml">
            <div class="panel-body">
                <ul>
                    <li><b>xsi:type</b>: <i>必須。</i> この属性の値は http:HTTPConnectionPolicyType でなければなりません。</li>
                    <li><b>cookiePolicy</b>: <i>オプション。</i> この属性は、バックエンド・アプリケーションから到達した Cookie を HTTP アダプターが処理する方法を設定します。 以下の値が有効です。
                        <ul>
                            <li>BEST_MATCH: デフォルト値</li>
                            <li>BROWSER_COMPATIBILITY</li>
                            <li>RFC_2109</li>
                            <li>RFC_2965</li>
                            <li>NETSCAPE</li>
                            <li>IGNORE_COOKIES</li>
                        </ul>
                        これらの値について詳しくは、Apache の <a href="http://hc.apache.org/httpclient-3.x/cookies.html">HTTP components</a> ページを参照してください。
                    </li>
                    <li><b>maxRedirects</b>: <i>オプション。</i> HTTP アダプターが従うことのできるリダイレクトの最大数。 この属性は、バックエンド・アプリケーションが、認証障害などの何らかのエラーの結果として循環リダイレクトを送信する場合に役立ちます。 この属性を 0 に設定すると、アダプターはリダイレクトに全く従おうとせず、HTTP 302 応答がユーザーに返されます。デフォルト値は 10 です。</li>
                    <li><b>protocol</b>: <i>オプション。</i> 使用する URL プロトコル。次の値が有効です。<b>http</b> (デフォルト)、<b>https</b>。</li>
                    <li><b>domain</b>: <i>必須。</i> ホスト・アドレス。</li>
                    <li><b>port</b>: <i>オプション。</i> ポート・アドレス。ポートを指定しない場合、デフォルトの HTTP/S ポートが使用されます (80/443)</li>
                    <li><b>sslCertificateAlias</b>: 通常の HTTP 認証および SSL 単純認証の場合はオプションです。SSL 相互認証の場合は必須です。アダプターの SSL 秘密鍵の別名。鍵ストア内の正しい SSL 証明書にアクセスするために HTTP アダプター鍵マネージャーによって使用されます。 鍵ストアのセットアップ・プロセスについて詳しくは、<a href="using-ssl">HTTP アダプターでの SSL の使用</a>チュートリアルを参照してください。</li>
                    <li><b>sslCertificatePassword</b>: 通常の HTTP 認証および SSL 単純認証の場合はオプションです。SSL 相互認証の場合は必須です。アダプターの SSL 秘密鍵のパスワード。鍵ストア内の正しい SSL 証明書にアクセスするために HTTP アダプター鍵マネージャーによって使用されます。 鍵ストアのセットアップ・プロセスについて詳しくは、<a href="using-ssl">HTTP アダプターでの SSL の使用</a>チュートリアルを参照してください。</li>
                    <li><b>authentication</b>: <i>オプション。</i> HTTP アダプターの認証構成。HTTP アダプターは、2 つの認証プロトコルのいずれかを使用することができます。以下のように、<b>authentication</b>< エレメントを定義します。
                        <ul>
                            <li>基本認証
{% highlight xml %}
<authentication>
    <basic/>
</authentication>
{% endhighlight %}</li>
                            <li>ダイジェスト認証
{% highlight xml %}
<authentication>
    <digest/>
</authentication>
{% endhighlight %}</li>


                            接続ポリシーには、<code>serverIdentity</code> エレメントを含めることができます。このフィーチャーはすべての認証スキームに適用されます。例:
{% highlight xml %}
<authentication>
    <basic/>
    <serverIdentity>
        <username></username>
        <password></password>
    </serverIdentity>
</authentication>
{% endhighlight %}
                        </ul>
                    </li>
                    <li><b>proxy</b>: <i>オプション。</i> proxy エレメントでは、バックエンド・アプリケーションへのアクセス時に使用するプロキシー・サーバーの詳細を指定します。プロキシー詳細には、プロトコルのドメインおよびポートが含まれている必要があります。プロキシーが認証を必要とする場合は、<code>proxy</code> 内に、ネストされた <code>authentication</code> エレメントを追加します。このエレメントの構造は、アダプターの認証プロトコルを記述するために使用されるものと同じです。以下の例は、基本認証を必要とし、サーバー ID を使用するプロキシーを示しています。
                    
{% highlight xml %}
<connectionPolicy xsi:type="http:HTTPConnectionPolicyType">
  <protocol>http</protocol>
  <domain>www.bbc.co.uk</domain>
  <proxy>
    <protocol>http</protocol>
    <domain>wl-proxy</domain>
    <port>8167</port>
    <authentication>
      <basic/>
      <serverIdentity>
        <username>${proxy.user}</username>
        <password>${proxy.password}</password>
      </serverIdentity>
    </authentication>
  </proxy>
</connectionPolicy>
{% endhighlight %}</li>
                    <li><b>maxConcurrentConnectionsPerNode</b>: <i>オプション。</i> {{ site.data.keys.mf_server }} がバックエンドに対して開くことができる同時接続の最大数を定義します。 {{ site.data.keys.product }} は、アプリケーションからの着信サービス要求を制限しません。これは、バックエンド・サービスへの同時 HTTP 接続の数のみを制限します。
                    <br/><br/>
同時 HTTP 接続のデフォルト数は 50 個です。この数は、予期されるアダプターへの同時要求数と、バックエンド・サービスで許可される最大要求数に基づいて変更できます。また、同時着信要求の数を制限するようにバックエンド・サービスを構成することもできます。
<br/><br/>
システムで予期されている負荷が 100 個の同時要求で、バックエンド・サービスが最大 80 個の同時要求をサポートできる、2 ノード・システムについて検討します。maxConcurrentConnectionsPerNode を 40 に設定できます。この設定により、バックエンド・サービスに対して行われる同時要求は確実に 80 個以下になります。
<br/><br/>
値を増やした場合、バックエンド・アプリケーションでさらに多くのメモリーが必要となります。メモリーの問題を回避するために、この値は過度に高く設定しないでください。代わりに、1 秒当たりのトランザクションの平均数とピーク数を見積もって、トランザクションの平均所要時間を評価してください。次に、この例に示されるように必要な同時接続の数を計算し、5 から 10 % のマージンを加えます。次に、バックエンドをモニターし、必要に応じてこの値を調整して、バックエンド・アプリケーションがすべての着信要求を確実に処理できるようにします。
<br/><br/>
アダプターをクラスターにデプロイする場合は、この属性の値を、必要な最大負荷をクラスター・メンバーの数で除算した値に設定します。
<br/><br/>
                    バックエンド・アプリケーションのサイズ変更方法について詳しくは、<a href="{{site.baseurl}}/learn-more">「Scalability and Hardware Sizing」の文書</a>とそれに付随するハードウェア計算用スプレッドシートを参照してください。</li>
                    <li><b>connectionTimeoutInMilliseconds</b>: <i>オプション。</i> バックエンドへの接続を確立できるまでのタイムアウト (ミリ秒)。このタイムアウトを設定しても、HTTP 要求を呼び出してから一定時間が経過した後にタイムアウト例外が発生することは保証されません。<code>invokeHTTP()</code> 関数でこのパラメーターに異なる値を渡した場合、ここで定義された値をオーバーライドできます。</li>
                    <li><b>socketTimeoutInMilliseconds</b>: <i>オプション。</i> 接続パケットから開始して、連続する 2 つのパケット間のタイムアウト (ミリ秒)。このタイムアウトを設定しても、HTTP 要求を呼び出してから一定時間が経過した後にタイムアウト例外が発生することは保証されません。<code>invokeHttp()</code> 関数で <code>socketTimeoutInMilliseconds</code> パラメーターに異なる値を渡した場合、ここで定義された値をオーバーライドできます。</li>
                </ul>
                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#adapter-xml" data-target="#collapse-adapter-xml" aria-expanded="false" aria-controls="collapse-adapter-xml"><b>セクションを閉じる</b></a>
            </div>
        </div>
    </div>
</div>


## JavaScript 実装
{: #javascript-implementation }

プロシージャーの呼び出しには、サービス URL を使用します。URL の一部は、例えば http://example.com/ のように、固定のものになります。  
URL の他の部分はパラメーター化できます。つまり、実行時に、 プロシージャーに提供されるパラメーター値に置換されます。

以下の URL 部分はパラメーター化が可能です。

* パス・エレメント
* 照会ストリング・パラメーター
* フラグメント

HTTP 要求を呼び出すには、`MFP.Server.invokeHttp` メソッドを使用します。  
入力パラメーター・オブジェクトを提供します。以下を指定する必要があります。

* HTTP メソッド: `GET`、`POST`、`PUT`、`DELETE`
* 返されるコンテンツのタイプ: `XML`、`JSON`、`HTML`、または `plain`
* サービス `path`
* 照会パラメーター (オプション)
* 要求本体 (オプション)
* 変換タイプ (オプション)

```js
function getFeed() {
  var input = {
      method : 'get',
      returnedContentType : 'xml',
      path : "feed.xml"
  };


  return MFP.Server.invokeHttp(input);
}
```

> オプションの完全なリストについては、ユーザー文書で「MFP.Server.invokeHttp」に関する API 解説書を参照してください。

## XSL Transformation フィルター
{: #xsl-transformation-filtering }

受け取ったデータに XSL Transformation を適用して、例えば、データをフィルターに掛けることもできます。  
XSL Transformation を適用するには、JavaScript 実装ファイルの次に **filtered.xsl** ファイルを作成します。

その後、変換オプションをプロシージャー呼び出しの入力パラメーターで指定することができます。以下に例を示します。 

```js
function getFeedFiltered() {

  var input = {
      method : 'get',
      returnedContentType : 'xml',
      path : "feed.xml",
      transformation : {
        type : 'xslFile',
        xslFile : 'filtered.xsl'
      }
  };

  return MFP.Server.invokeHttp(input);
}
```

## SOAP ベースのサービス要求の作成 
{: #creating-a-soap-based-service-request }

`MFP.Server.invokeHttp` API メソッドを使用して、**SOAP** エンベロープを作成できます。  
注: JavaScript HTTP アダプターで SOAP ベースのサービスを呼び出す場合は、**E4X** を使用して、要求本体内に SOAP XML エンベロープをエンコードすることができます。

```js
var request =
		<soap:Envelope
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xmlns:xsd="http://www.w3.org/2001/XMLSchema"
      xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
			<soap:Body>
				<GetCitiesByCountry xmlns="http://www.webserviceX.NET">
					<CountryName>{countryName}</CountryName>
				</GetCitiesByCountry>
			</soap:Body>
		</soap:Envelope>;
```

次に、`MFP.Server.invokeHttp(options)` メソッドを使用して SOAP サービス要求を呼び出します。  
options オブジェクトには以下のプロパティーを含める必要があります。 

* `method` プロパティー: 通常は `POST`
* `returnedContentType` プロパティー: 通常は `XML`
* `path` プロパティー: サービス・パス
* `body` プロパティー: `content` (ストリングとしての SOAP XML) および `contentType`

```js
var input = {
	method: 'post',
	returnedContentType: 'xml',
	path: '/globalweather.asmx',
	body: {
		content: request.toString(),
		contentType: 'text/xml; charset=utf-8'
	}
};

var result = MFP.Server.invokeHttp(input);
```

## SOAP ベースのサービスの結果の呼び出し
{: #invoking-results-of-soap-based-service }

結果は `JSON` オブジェクトにラップされます。

```json
{
	"statusCode" : 200,
	"errors" : [],
	"isSuccessful" : true,
	"statusReason" : "OK",
	"Envelope" : {
		"Body" : {
			"GetWeatherResponse" : {
				"xmlns" : "http://www.webserviceX.NET",
				"GetWeatherResult" : "<?xml version=\"1.0\" encoding=\"utf-16\"?>\n<CurrentWeather>\n  <Location>Shanghai / Hongqiao, China (ZSSS) 31-10N 121-26E 3M</Location>\n  <Time>Mar 07, 2016 - 01:30 AM EST / 2016.03.07 0630 UTC</Time>\n  <Wind> from the W (270 degrees) at 4 MPH (4 KT) (direction variable):0</Wind>\n  <Visibility> 4 mile(s):0</Visibility>\n  <Temperature> 69 F (21 C)</Temperature>\n  <DewPoint> 53 F (12 C)</DewPoint>\n  <RelativeHumidity> 56%</RelativeHumidity>\n  <Pressure> 29.94 in. Hg (1014 hPa)</Pressure>\n  <Status>Success</Status>\n</CurrentWeather>"
			}
		},
		"xsd" : "http://www.w3.org/2001/XMLSchema",
		"soap" : "http://schemas.xmlsoap.org/soap/envelope/",
		"xsi" : "http://www.w3.org/2001/XMLSchema-instance"
	},
	"responseHeaders" : {
		"X-AspNet-Version" : "4.0.30319",
		"Date" : "Mon, 07 Mar 2016 06:46:08 GMT",
		"Content-Length" : "1027",
		"Content-Type" : "text/xml; charset=utf-8",
		"Server" : "Microsoft-IIS/7.0",
		"X-Powered-By" : "ASP.NET",
		"Cache-Control" : "private, max-age=0",
		"X-RBT-Optimized-By" : "e8i-wx-sh4 (RiOS 8.6.2d-ibm1) SC"
	},
	"warnings" : [],
	"totalTime" : 654,
	"responseTime" : 651,
	"info" : []
}
```

SOAP ベースの要求に固有の `Envelope` プロパティーに注意してください。  
`Envelope` プロパティーには、SOAP ベースの要求の結果コンテンツが含まれています。

XML コンテンツにアクセスするには、次のようにします。

* クライアント・サイドでは、jQuery を使用して結果ストリングをラップし、DOM ノードに従うことができます。

```javascript
var resourceRequest = new WLResourceRequest(
    "/adapters/JavaScriptSOAP/getWeatherInfo",
    WLResourceRequest.GET
);

resourceRequest.setQueryParameter("params", "['Washington', 'United States']");

resourceRequest.send().then(
    function(response) {
        var $result = $(response.invocationResult.Envelope.Body.GetWeatherResponse.GetWeatherResult);
		var weatherInfo = {
			location: $result.find('Location').text(),
			time: $result.find('Time').text(),
			wind: $result.find('Wind').text(),
			temperature: $result.find('Temperature').text(),
		};
    },
    function() {
        // ...
    }
)
```
* サーバー・サイドでは、結果ストリングを持つ XML オブジェクトを作成します。その後、ノードにプロパティーとしてアクセスすることができます。

```javascript
var xmlDoc = new XML(result.Envelope.Body.GetWeatherResponse.GetWeatherResult);
var weatherInfo = {
	Location: xmlDoc.Location.toString(),
	Time: xmlDoc.Time.toString(),
	Wind: xmlDoc.Wind.toString(),
	Temperature: xmlDoc.Temperature.toString()
};
```

## サンプル・アダプター
{: #sample-adapter }

[ここをクリック](https://github.com/MobileFirst-Platform-Developer-Center/Adapters/tree/release80/) してアダプター Maven プロジェクトをダウンロードします。

### 使用例
{: #sample-usage }

* Maven、{{ site.data.keys.mf_cli }}、または任意の IDE を使用して、[JavaScriptHTTP アダプターのビルドとデプロイ](../../creating-adapters/)を行います。
* アダプターをテストまたはデバッグするには、[アダプターのテストおよびデバッグ](../../testing-and-debugging-adapters)チュートリアルを参照してください。
