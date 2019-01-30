---
layout: tutorial
title: 인증 및 보안
weight: 7
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

{{ site.data.keys.product_adj }} 보안 프레임워크는 [OAuth 2.0](http://oauth.net/) 프로토콜을 기반으로 합니다. 이 프로토콜에 따라 자원에 액세스하기 위해 필요한 권한을 정의하는 **범위**를 사용하여 자원을 보호할 수 있습니다. 보호된 자원에 액세스하려면 클라이언트에게 부여되는 권한의 범위를 캡슐화하는 일치하는 **액세스 토큰**을 클라이언트가 제공해야 합니다.

OAuth 프로토콜은 자원이 호스팅되는 자원 서버와 권한 부여 서버의 역할을 구분합니다.

* 권한 부여 서버는 클라이언트 권한 부여 및 토큰 생성을 관리합니다.
* 자원 서버는 권한 부여 서버를 사용하여 클라이언트가 제공하는 액세스 토큰을 유효성 검증하고 요청된 자원의 보호 범위와 일치하게 합니다.

보호 프레임워크는 OAuth 프로토콜을 구현하는 권한 부여 서버를 중심으로 빌드되고 클라이언트가 액세스 토큰을 얻기 위해 상호작용하는 OAuth 엔드포인트를 노출합니다. 보안 프레임워크는 권한 부여 서버 및 기반이 되는 OAuth 프로토콜의 맨 위에 사용자 정의 권한 부여 로직을 구현하기 위한 빌딩 블록을 제공합니다.
기본적으로 {{ site.data.keys.mf_server }}는 **권한 부여 서버** 역할도 합니다. 하지만 권한 서버로서 역할을 하고 {{ site.data.keys.mf_server }}와 상호 작용하도록 IBM WebSphere DataPower 어플라이언스를 구성할 수 있습니다.

그런 다음 클라이언트 애플리케이션은 이러한 토큰을 사용하여 **자원 서버**에서 자원에 액세스할 수 있습니다. 자원 서버는 {{ site.data.keys.mf_server }} 자체 또는 외부 서버일 수 있습니다. 자원 서버는 클라이언트가 요청된 자원에 대한 액세스 권한을 부여받을 수 있는지 확인하기 위해 토큰의 유효성을 검사합니다. 자원 서버 및 권한 서버 사이의 구분을 통해 사용자는 {{ site.data.keys.mf_server }} 외부에서 실행 중인 자원에 대해 보안을 강제 실행할 수 있습니다.

애플리케이션 개발자는 각 보호된 자원에 대한 필수 범위를 정의하고 **보안 검사** 및 **인증 확인 핸들러**를 구현하여 해당 자원에 대한 액세스를 보호합니다. 서버 측 보안 프레임워크 및 클라이언트 측 API는 권한 부여 서버와의 상호작용 및 OAuth 메시지 교환을 투명하게 처리하여 개발자가 권한 부여 로직에만 초점을 둘 수 있게 합니다.

#### 다음으로 이동:
{: #jump-to }

* [권한 부여 엔티티](#authorization-entities)
* [자원 보호](#protecting-resources)
* [권한 부여 플로우](#authorization-flow)
* [다음 학습서](#tutorials-to-follow-next)

## 권한 부여 엔티티
{: #authorization-entities }

### 액세스 토큰
{: #access-tokens }

{{ site.data.keys.product_adj }} 액세스 토큰은 클라이언트의 권한 부여 권한을 설명하는 디지털 서명된 엔티티입니다. 특정 범위에 대한 클라이언트의 권한 부여 요청이 허용되고 클라이언트가 인증되면 권한 부여 서버의 토큰 엔드포인트는 요청된 액세스 토큰이 포함된 HTTP 응답을 클라이언트에게 전송합니다.

#### 구조
{: #structure }

{{ site.data.keys.product_adj }} 액세스 토큰은 다음과 같은 정보를 제공합니다.

* **클라이언트 ID**: 클라이언트의 고유 ID입니다.
* **범위**: 토큰에 부여된 범위입니다(OAuth 범위 참조). 이 범위는 [필수 애플리케이션 범위](#mandatory-application-scope)를 포함하지 않습니다.
* **토큰 만기 시간**: 토큰이 올바르지 않게 되는(만기되는) 시간(초)입니다.

#### 토큰 만기
{: #token-expiration }

만기 시간이 경과할 때까지 부여된 액세스 토큰은 유효한 상태를 유지합니다. 액세스 토큰의 만기 시간은 범위에 포함된 모든 보안 검사의 만기 시간들 중에서 가장 짧은 만기 시간으로 설정됩니다. 그러나 이 가장 짧은 만기 시간이 애플리케이션의 최대 토큰 만기 기간보다 더 길면 토큰의 만기 시간은 '현재 시간 + 최대 만기 기간'으로 설정됩니다. 기본 최대 토큰 만기 기간(유효성 기간)은 3,600초(1시간)이지만 `maxTokenExpiration` 특성의 값을 설정하여 구성할 수 있습니다. 최대 액세스 토큰 만기 기간 구성을 참조하십시오.

<div class="panel-group accordion" id="configuration-explanation" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="access-token-expiration">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#access-token-expiration" data-target="#collapse-access-token-expiration" aria-expanded="false" aria-controls="collapse-access-token-expiration"><b>최대 액세스 토큰 만기 기간 구성</b></a>
            </h4>
        </div>

        <div id="collapse-access-token-expiration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="access-token-expiration">
            <div class="panel-body">
            <p>다음과 같은 대체 방법 중 하나를 사용하여 애플리케이션의 최대 액세스 토큰 만기 기간을 구성하십시오.</p>
            <ul>
                <li>{{ site.data.keys.mf_console }} 사용
                    <ul>
                        <li><b>[사용자 애플리케이션] → 보안</b> 탭을 선택하십시오.</li>
                        <li><b>토큰 구성</b> 섹션에서, <b>토큰 만기 기간(초)</b> 필드의 값을 선호하는 값으로 설정한 다음 <b>저장</b>을 클릭하십시오. 언제든지 이 프로시저를 반복하여 최대 토큰 만기 기간을 변경하거나, <b>기본값 복원</b>을 선택하여 기본값을 복원할 수 있습니다.</li>
                    </ul>
                </li>
                <li>애플리케이션의 구성 파일 편집
                    <ol>
                        <li><b>명령행 창</b>에서 프로젝트의 루트 폴더로 이동하여 <code>mfpdev app pull</code>을 실행하십시오.</li>
                        <li><b>[project-folder]\mobilefirst</b> 폴더에 있는 구성 파일을 여십시오.</li>
                        <li><code>maxTokenExpiration</code> 특성을 정의하여 파일을 편집하고 해당 값을 최대 액세스 토큰 만기 기간(초)으로 설정하십시오.

{% highlight xml %}
{
    ...
    "maxTokenExpiration": 7200
}
{% endhighlight %}</li>
                        <li>다음 명령 <code>mfpdev app push</code>를 실행하여 업데이트된 구성 JSON 파일을 배치하십시오.</li>
                    </ol>
                </li>
            </ul>

            <br/>
            <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#access-token-expiration" data-target="#collapse-access-token-expiration" aria-expanded="false" aria-controls="collapse-access-token-expiration"><b>닫기 섹션</b></a>
            </div>
        </div>
    </div>
</div>

<div class="panel-group accordion" id="response-access-token" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="response-structure">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#response-structure" data-target="#collapse-response-structure" aria-expanded="false" aria-controls="collapse-response-structure"><b>액세스 토큰 응답 구조</b></a>
            </h4>
        </div>

        <div id="collapse-response-structure" class="panel-collapse collapse" role="tabpanel" aria-labelledby="response-structure">
            <div class="panel-body">
                <p>액세스 토큰 요청에 대한 성공적 HTTP 응답에는 액세스 토큰 및 추가 데이터를 포함한 JSON 오브젝트가 들어 있습니다. 다음은 권한 부여 서버의 유효한 토큰 응답의 예제입니다.</p>

{% highlight json %}
HTTP/1.1 200 OK
Content-Type: application/json
Cache-Control: no-store
Pragma: no-cache
{
    "token_type": "Bearer",
    "expires_in": 3600,
    "access_token": "yI6ICJodHRwOi8vc2VydmVyLmV4YW1",
    "scope": "scopeElement1 scopeElement2"
}
{% endhighlight %}

<p>토큰 응답 JSON 오브젝트는 다음과 같은 특성 오브젝트를 갖습니다.</p>
<ul>
    <li><b>token_type</b>: 토큰 유형은 <a href="https://tools.ietf.org/html/rfc6750">OAuth 2.0 Bearer 토큰 사용법 스펙</a>에 따라 항상 <i>"Bearer"</i>입니다.</li>
    <li><b>expires_in</b>: 액세스 토큰의 만기 시간(초)입니다.</li>
    <li><b>access_token</b>: 생성된 액세스 토큰입니다(실제 액세스 토큰은 예제에 표시된 것보다 깁니다.).</li>
    <li><b>scope</b>: 요청된 범위입니다.</li>
</ul>

<p><b>expires_in</b> 및 <b>scope</b> 정보는 토큰 자체(<b>access_token</b>) 내에도 포함됩니다.</p>

<blockquote><b>참고:</b> 사용자가 하위 레벨의 <code>WLAuthorizationManager</code> 클래스를 사용하고 클라이언트 및 권한 인증과 자원 서버 자체 사이에 OAuth 상호작용을 관리하는 경우 또는 기밀 클라이언트를 사용하는 경우에 올바른 액세스 토큰 응답의 구조가 관련됩니다. 상위 레벨 <code>WLResourceRequest</code> 클래스(보호된 자원에 액세스하는 데 필요한 OAuth 플로우를 캡슐화함)를 사용하는 경우에는 보안 프레임워크가 액세스 토큰 응답 처리를 수행합니다. <a href="http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.dev.doc/dev/c_oauth_client_apis.html?view=kc#c_oauth_client_apis">클라이언트 보안 API</a> 및 <a href="confidential-clients">기밀 클라이언트</a>를 참조하십시오.</blockquote>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#response-structure" data-target="#collapse-response-structure" aria-expanded="false" aria-controls="collapse-response-structure"><b>닫기 섹션</b></a>
            </div>
        </div>
    </div>
</div>

### 새로 고치기 토큰
{: #refresh-tokens}

새로 고치기 토큰은 특수한 유형의 토큰으로, 이를 사용하여 액세스 토큰이 만료된 경우 새 액세스 토큰을 확보할 수 있습니다. 새 액세스 토큰을 요청하려는 경우 유효한 새로 고치기 토큰을 제시할 수 있습니다. 새로 고치기 토큰은 장기 토큰이며, 액세스 토큰과 비교해서 더 오랜 기간 유효합니다.

새로 고치기 토큰은 사용자를 계속 인증된 상태로 허용하기 때문에 애플리케이션에서 신중하게 사용해야 합니다. 소셜 미디어 애플리케이션, 전자 상거래 애플리케이션, 제품 카탈로그 브라우징 등 애플리케이션 제공자가 사용자를 정기적으로 인증하지 않는 경우 새로 고치기 토큰을 사용할 수 있습니다. 사용자 인증을 자주 지시하는 애플리케이션은 새로 고치기 토큰 사용을 피해야 합니다.  

#### MobileFirst 새로 고치기 토큰
{: #mfp-refresh-token}

MobileFirst 새로 고치기 토큰은 액세스 토큰과 같이 클라이언트의 권한 부여 권한을 설명하는 디지털 서명된 엔티티입니다. 새로 고치기 토큰은 동일한 범위의 새 액세스 토큰을 가져오는 데 사용할 수 있습니다. 특정 범위에 대한 클라이언트의 권한 부여 요청이 허용되고 클라이언트가 인증되면 권한 부여 서버의 토큰 엔드포인트는 요청된 액세스 토큰 및 새로 고치기 토큰이 포함된 HTTP 응답을 클라이언트에게 전송합니다. 액세스 토큰이 만료되면 클라이언트는 액세스 토큰 및 새로 고치기 토큰의 새 세트를 얻기 위해 인증 서버의 토큰 엔드포인트로 새로 고치기 토큰을 전송합니다.

**구조**

MobileFirst 액세스 토큰과 마찬가지로, MobileFirst 새로 고치기 토큰은 다음 정보를 포함합니다.
* **클라이언트 ID**: 클라이언트의 고유 ID입니다.
* **범위**: 토큰에 부여된 범위입니다(OAuth 범위 참조). 이 범위는 필수 애플리케이션 범위를 포함하지 않습니다.
* **토큰 만기 시간**: 토큰이 올바르지 않게 되는(만기되는) 시간(초)입니다.

#### 토큰 만기
{: #token-expiration}

새로 고치기 토큰의 토큰 만기 기간은 일반 액세스 토큰 만료 기간보다 깁니다. 만기 시간이 경과할 때까지 새로 고치기 토큰은 일단 유효한 상태를 유지합니다. 이 유효 기간 내 클라이언트는 새로 고치기 토큰을 사용하여 액세스 토큰 및 새로 고치기 토큰의 새 세트를 가져올 수 있습니다. 새로 고치기 토큰의 고정된 만료 기간은 30일입니다. 클라이언트가 액세스 토큰 및 새로 고치기 토큰의 새 세트를 성공적으로 얻을 때마다 새로 고치기 토큰 만료가 재설정되므로, 클라이언트는 절대로 만료되지 않는 토큰을 이용할 수 있습니다. 액세스 토큰 만료 규칙은 **액세스 토큰** 절에서 설명한 것과 동일합니다.

<div class="panel-group accordion" id="configuration-explanation-rt" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="refresh-token-expiration">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#refresh-token-expiration" data-target="#collapse-refresh-token-expiration" aria-expanded="false" aria-controls="collapse-refresh-token-expiration"><b>새로 고치기 토큰 기능 사용</b></a>
            </h4>
        </div>

        <div id="collapse-refresh-token-expiration" class="panel-collapse collapse" role="tabpanel" aria-labelledby="refresh-token-expiration">
            <div class="panel-body">
            <p>새로 고치기 토큰 기능은 클라이언트 측 및 서버 측 각각에서 다음 특성을 사용하여 사용할 수 있습니다.</p>
            <b>클라이언트 측 특성(Android)</b><br/>

            <i>파일 이름</i>:            mfpclient.properties<br/>
            <i>특성 이름</i>:   wlEnableRefreshToken<br/>
            <i>특성 값</i>:   true<br/>

            예를 들어, 다음과 같습니다.<br/>
            <i>wlEnableRefreshToken=true</i><br/><br/>

            <b>클라이언트 측 특성(iOS)</b><br/>

            <i>파일 이름</i>:            mfpclient.plist<br/>
            <i>특성 이름</i>:   wlEnableRefreshToken<br/>
            <i>특성 값</i>:   true<br/>

            예를 들어, 다음과 같습니다.<br/>
            <i>wlEnableRefreshToken=true</i><br/><br/>


            <b>서버 측 특성</b><br/>

            <i>파일 이름</i>:            server.xml<br/>
            <i>특성 이름</i>:   mfp.security.refreshtoken.enabled.apps<br/>
            <i>특성 값</i>:   <i>‘;’으로 분리된 애플리케이션 번들 ID</i><br/><br/>

            <p>예를 들어, 다음과 같습니다.</p><br/>
            {% highlight xml %}
            <jndiEntry jndiName="mfp/mfp.security.refreshtoken.enabled.apps" value='"com.sample.android.myapp1;com.sample.android.myapp2"'/>
            {% endhighlight %}

            <p>다른 플랫폼에 대해 다른 번들 ID를 사용합니다.</p>

                                    <br/>
                                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#refresh-token-expiration" data-target="#collapse-refresh-token-expiration" aria-expanded="false" aria-controls="collapse-refresh-token-expiration"><b>닫기 섹션</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>

<div class="panel-group accordion" id="response-refresh-token" role="tablist">
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="response-structure-rt">
        <h4 class="panel-title">
            <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#response-structure-rt" data-target="#collapse-response-structure-rt" aria-expanded="false" aria-controls="collapse-response-structure-rt"><b>새로 고치기 토큰 응답 구조</b></a>
        </h4>
    </div>

    <div id="collapse-response-structure-rt" class="panel-collapse collapse" role="tabpanel" aria-labelledby="response-structure-rt">
      <div class="panel-body">
        <p>다음은 권한 부여 서버의 유효한 새로 고치기 토큰 응답의 예제입니다.</p>

        {% highlight json %}
HTTP/1.1 200 OK
Content-Type: application/json
Cache-Control: no-store
Pragma: no-cache
{
            "token_type": "Bearer",
            "expires_in": 3600,
            "access_token": "yI6ICJodHRwOi8vc2VydmVyLmV4YW1",
            "scope": "scopeElement1 scopeElement2",
            "refresh_token": "yI7ICasdsdJodHRwOi8vc2Vashnneh "
        }
        {% endhighlight %}

        <p>새로 고치기 토큰 응답에는 액세스 토큰 응답 구조에서 설명한 기타 특성 오브젝트를 제외한 추가 특성 오브젝트 <code>refresh_token</code>이 있습니다.</p>

        <br/>
              <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#response-structure-rt" data-target="#collapse-response-structure-rt" aria-expanded="false" aria-controls="collapse-response-structure-rt"><b>닫기 섹션</b></a>
            </div>
          </div>
        </div>
</div>


>**참고:** 새로 고치기 토큰은 액세스 토큰에 비해 유효 기간이 깁니다. 따라서 새로 고치기 토큰은 신중하게 사용해야 합니다. 정기적으로 사용자 인증이 필요하지 않은 애플리케이션이 새로 고치기 토큰 기능을 사용하는 데 적합한 후보입니다. 
>
> MobileFirst는 CD 업데이트 3부터 iOS에서 새로 고치기 토큰 기능을 지원합니다. 


### 보안 검사
{: #security-checks }

보안 검사는 서버 측 애플리케이션 자원을 보호하기 위한 보안 로직을 구현하는 서버 측 엔티티입니다. 보안 검사의 단순한 예는 사용자의 신임 정보를 수신하고 사용자 레지스트리에 대해 신임 정보를 확인하는 사용자 로그인 보안 검사입니다. 다른 예는 모바일 애플리케이션의 인증을 유효성 검증하여 애플리케이션의 자원에 액세스하려는 불법적인 시도에 대해 보호하는 사전 정의된 {{ site.data.keys.product_adj }} 애플리케이션-인증 보안 검사입니다. 동일한 보안 검사를 여러 자원을 보안하는 데 사용할 수도 있습니다.

보안 검사는 일반적으로 클라이언트가 검사를 통과하기 위해 특정 방식으로 응답하게 하는 보안 인증 확인을 발행합니다. 이 핸드쉐이크는 OAuth 액세스 토큰 획득 플로우의 일부로 발생합니다. 클라이언트는 **인증 확인 핸들러**를 사용하여 보안 검사의 인증 확인을 처리합니다.

#### 기본 제공 보안 검사
{: #built-in-security-checks }

다음 사전 정의된 보안 검사를 사용할 수 있습니다.

- [애플리케이션 인증](application-authenticity/)
- [LTPA 기반 싱글 사인온(SSO)](ltpa-security-check/)
- [직접 업데이트](../application-development/direct-update)

### 인증 확인 핸들러
{: #challenge-handlers }
보호된 자원에 액세스하려고 할 때 클라이언트가 인증 확인에 직면할 수 있습니다. 인증 확인은 클라이언트가 이 자원에 액세스를 허용받았는지 확인하기 위한 서버의 프롬프트, 보안 테스트, 질문입니다. 가장 일반적으로 이 인증 확인은 사용자 이름 및 비밀번호와 같이 신임 정보에 대한 요청입니다.

인증 확인 핸들러는 클라이언트 측 보안 로직 및 관련 사용자 상호작용을 구현하는 클라이언트 측 엔티티입니다.
**중요**: 인증 확인을 수신한 후에는 무시될 수 없습니다. 응답을 하거나 취소해야 합니다. 인증 확인을 무시하면 예상치 않은 동작이 발생할 수 있습니다.

> [보안 검사 작성](creating-a-security-check/) 학습서에서 보안 검사에 대해, [신임 정보 유효성 검증](credentials-validation) 학습서에서 인증 확인 핸들러에 대해 자세히 알아보십시오.

### 범위
{: #scopes }

어댑터와 같은 자원에 **범위**를 지정하여 이를 권한 부여되지 않은 액세스로부터 보호할 수 있습니다.

범위는 간격으로 구분된 하나 이상의 범위 요소 문자열("scopeElement1 scopeElement2 ...")로 정의되며, 기본 범위(`RegisteredClient`)를 적용하려는 경우에는 널입니다. {{ site.data.keys.product_adj }} 보안 프레임워크는 어댑터 자원에 대한 자원 보호를 사용 안함으로 설정하지 않는 한, 모든 어댑터 자원에 대해 범위가 지정되지 않은 경우에도 액세스 토큰을 요구합니다. [어댑터 자원 보호](#protecting-adapter-resources )를 참조하십시오.

#### 범위 요소
{: #scope-elements }

범위 요소는 다음 중 하나일 수 있습니다.

* 보안 검사의 이름.
* 이 자원에 필요한 보안 레벨을 정의하는 `access-restricted` 또는 `deletePrivilege`와 같은 임의의 키워드. 이 키워드는 나중에 보안 검사와 맵핑됩니다.

#### 범위 맵핑
{: #scope-mapping }

기본적으로 사용자가 **범위**에 작성한 **범위 요소**는 **동일한 이름의 보안 검사**에 맵핑됩니다.
예를 들어 `PinCodeAttempts`라는 보안 검사를 작성하는 경우 범위 내에서 동일한 이름의 범위 요소를 사용할 수 있습니다.

범위 맵핑은 범위 요소를 보안 검사에 맵핑할 수 있게 합니다. 클라이언트가 범위 요소를 요청할 때 적용될 보안 검사를 정의합니다.   예를 들어 범위 요소 `access-restricted`를 사용자의 `PinCodeAttempts` 보안 검사에 맵핑할 수 있습니다.

자원에 액세스하려는 애플리케이션에 따라 다르게 자원을 보호하려는 경우 범위 맵핑이 유용합니다.
0개 이상으로 된 보안 검사 목록에 범위를 맵핑할 수도 있습니다.

예:
scope = `access-restricted deletePrivilege`

* 앱 A에서
  * `access-restricted`는 `PinCodeAttempts`에 맵핑됩니다.
  * `deletePrivilege`는 빈 문자열에 맵핑됩니다.
* 앱 B에서
  * `access-restricted`는 `PinCodeAttempts`에 맵핑됩니다.
  * `deletePrivilege`는 `UserLogin`에 맵핑됩니다.

> 사용자의 범위 요소를 빈 문자열에 맵핑하려면 **새 범위 요소 맵핑 추가** 팝업 메뉴에서 보안 검사를 선택하지 마십시오.

<img class="gifplayer" alt="범위 맵핑" src="scope_mapping.png"/>

필수 구성으로 애플리케이션의 구성 JSON 파일을 수동으로 편집하고 변경사항을 다시 {{ site.data.keys.mf_server }}로 푸시할 수도 있습니다.

1. **명령행 창**에서 프로젝트의 루트 폴더로 이동하여 `mfpdev app pull`을 실행하십시오.
2. **[project-folder]\mobilefirst** 폴더에 있는 구성 파일을 여십시오.
3. `scopeElementMapping` 특성을 정의하여 파일을 편집하고 이 특성에서 선택한 범위 요소의 이름과, 요소가 맵핑되는 0개 이상의 공백으로 구분된 보안 검사의 문자열로 구성된 데이터 쌍을 정의하십시오. 예:

    ```xml
    "scopeElementMapping": {
        "UserAuth": "UserAuthentication",
        "SSOUserValidation": "LtpaBasedSSO CredentialsValidation"
    }
    ```
4. 다음 명령 `mfpdev app push`를 실행하여 업데이트된 구성 JSON 파일을 배치하십시오.

> 또한 원격 서버에 업데이트 구성을 푸시할 수 있습니다. [{{ site.data.keys.product_adj }} 아티팩트를 관리하기 위해 {{ site.data.keys.mf_cli }} 사용](../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts) 학습서를 검토하십시오.

## 자원 보호
{: #protecting-resources }

OAuth 모델에서 보호된 자원은 액세스 토큰을 요구하는 자원입니다. {{ site.data.keys.product_adj }} 보안 프레임워크를 사용하여 {{ site.data.keys.mf_server }}의 인스턴스에서 호스팅되는 자원과 외부 서버의 자원을 모두 보호할 수 있습니다. 자원에 대한 액세스 토큰을 얻는 데 필요한 권한을 정의하는 범위를 지정하여 자원을 보호합니다.

다양한 방법으로 사용자의 자원을 보호할 수 있습니다.

### 필수 애플리케이션 범위
{: #mandatory-application-scope }

애플리케이션 레벨에서, 애플리케이션이 사용하는 모든 자원에 적용될 범위를 정의할 수 있습니다. 보안 프레임워크는 요청된 자원 범위의 보안 검사 외에 이러한 검사(존재하는 경우)를 실행합니다.

**참고:**
* 필수 애플리케이션 범위는 [보호되지 않은 자원](#unprotected-resources)에 액세스할 때 적용되지 않습니다.
* 자원 범위에 부여되는 액세스 토큰에 필수 애플리케이션 범위가 포함되어 있지 않습니다.

<br/>
{{ site.data.keys.mf_console }}의 경우 탐색 사이드바의 **애플리케이션** 섹션에서 애플리케이션을 선택한 다음 **보안** 탭을 선택하십시오. **필수 애플리케이션 범위**에서 **범위에 추가**를 선택하십시오.

<img class="gifplayer" alt="필수 애플리케이션 범위" src="mandatory-application-scope.png"/>

필수 구성으로 애플리케이션의 구성 JSON 파일을 수동으로 편집하고 변경사항을 다시 {{ site.data.keys.mf_server }}로 푸시할 수도 있습니다.

1.  **명령행 창**에서 프로젝트의 루트 폴더로 이동하여 `mfpdev app pull`을 실행하십시오.
2.  **project-folder\mobilefirst** 폴더에 있는 구성 파일을 여십시오.
3.  `mandatoryScope` 특성을 정의하고 특성 값을 선택한 범위 요소의 공백으로 구분된 목록을 포함하는 범위 문자열로 설정하여 파일을 편집하십시오. 예:

    ```xml
    "mandatoryScope": "appAuthenticity PincodeValidation"
    ```
4.  다음 명령 `mfpdev app push`를 실행하여 업데이트된 구성 JSON 파일을 배치하십시오.

> 또한 원격 서버에 업데이트 구성을 푸시할 수 있습니다. [{{ site.data.keys.product_adj }} 아티팩트를 관리하기 위해 {{ site.data.keys.mf_cli }} 사용](../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts) 학습서를 검토하십시오.

### 어댑터 자원 보호
{: #protecting-adapter-resources }

어댑터에서는 다음 [Java](#protecting-java-adapter-resources) 및 [JavaScript](#protecting-javascript-adapter-resources) 섹션에 설명되어 있는 바와 같이 Java 메소드 또는 JavaScript 자원 프로시저, 또는 전체 Java 자원 클래스에 대해 보호 범위를 지정할 수 있습니다. 범위는 간격으로 구분된 하나 이상의 범위 요소 문자열("scopeElement1 scopeElement2 ...")로 정의되며, 기본 범위를 적용하려는 경우에는 널입니다([범위](#scopes) 참조).

기본 {{ site.data.keys.product_adj }} 범위는 `RegisteredClient`이며, 이는 자원에 액세스하는 데 액세스 토큰을 요구하고 자원 요청이 {{ site.data.keys.mf_server }}에 등록된 애플리케이션의 요청인지 확인합니다. 이 보호는 [자원 보호를 사용 안함으로 설정](#disabling-resource-protection)하지 않는 한 항상 적용됩니다. 따라서 자원은 해당 자원에 대해 범위를 설정하지 않아도 보호됩니다.

> <b>참고:</b> `RegisteredClient`는 예약된 {{ site.data.keys.product_adj }} 키워드입니다. 이 이름을 사용하여 사용자 정의 요소 또는 보안 검사를 정의하지 마십시오.

#### Java 어댑터 자원 보호
{: #protecting-java-adapter-resources }

JAX-RS 메소드 또는 클래스에 보호 범위를 지정하려면 메소드 또는 클래스 선언에 `@OAuthSecurity` 어노테이션을 추가하고 어노테이션의 `scope` 요소를 원하는 범위로 설정하십시오. `YOUR_SCOPE`를 하나 이상의 범위 요소 문자열("scopeElement1 scopeElement2 ..."):
```
@OAuthSecurity(scope = "YOUR_SCOPE")
```

클래스 범위는 고유의 `@OAuthSecurity` 어노테이션이 있는 메소드를 제외한 클래스 내의 모든 메소드에 적용됩니다.

<b>참고:</b> `@OAuthSecurity` 어노테이션의 `enabled` 요소가 `false`로 설정된 경우에는 `scope` 요소가 무시됩니다. [Java 자원 보호를 사용 안함으로 설정](#disabling-java-resource-protection)을 참조하십시오.

##### 예제
{: #java-adapter-resource-protection-examples }

다음 코드는 `UserAuthentication` 및 `Pincode` 범위 요소를 포함하는 범위를 사용하여 `helloUser` 메소드를 보호합니다.
```java
@GET
@Path("/{username}")
@OAuthSecurity(scope = "UserAuthentication Pincode")
public String helloUser(@PathParam("username") String name){
    ...
}
```

다음 코드는 사전 정의된 `LtpaBasedSSO` 보안 검사를 사용하여 `WebSphereResources` 클래스를 보호합니다.
```java
@Path("/users")
@OAuthSecurity(scope = "LtpaBasedSSO")
public class WebSphereResources {
    ...
}
```

#### JavaScript 어댑터 자원 보호
{: #protecting-javascript-adapter-resources }

JavaScript 프로시저에 보호 범위를 지정하려면 <b>adapter.xml</b> 파일에서 &lt;procedure&gt; 요소의 범위 속성을 원하는 범위로 지정하십시오. `PROCEDURE_NANE`을 프로시저의 이름으로 대체하고, `YOUR SCOPE`를 하나 이상의 범위 요소 문자열("scopeElement1 scopeElement2 ..."):
```xml
<procedure name="PROCEDURE_NANE" scope="YOUR_SCOPE">
```

<b>참고:</b> &lt;procedure&gt; 요소의 `secured` 속성이 false로 설정되면 `scope` 속성이 무시됩니다. [JavaScript 자원 보호를 사용 안함으로 설정](#disabling-javascript-resource-protection)을 참조하십시오.

#### 예제
{: #javascript-adapter-resource-protection-examples }

다음 코드는 `UserAuthentication` 및 `Pincode` 범위 요소를 포함하는 범위를 사용하여 `userName` 프로시저를 보호합니다.
```xml
<procedure name="userName" scope="UserAuthentication Pincode">
```

### 자원 보호를 사용 안함으로 설정
{: #disabling-resource-protection }

다음 [Java](#disabling-java-resource-protection) 및 [JavaScript](#disabling-javascript-resource-protection) 섹션에 설명되어 있는 바와 같이 특정 Java 또는 JavaScript 어댑터 자원, 또는 전체 Java 클래스에 대해 [기본 {{ site.data.keys.product_adj }} 자원 보호](#protecting-adapter-resources)를 사용 안함으로 설정할 수 있습니다. 자원 보호가 사용 안함으로 설정되면 {{ site.data.keys.product_adj
 }} 보안 프레임워크는 자원을 액세스하는 데 토큰을 요구하지 않습니다. [보호되지 않은 자원](#unprotected-resources)을 참조하십시오.

#### Java 자원 보호를 사용 안함으로 설정
{: #disabling-java-resource-protection }

Java 자원 메소드 또는 클래스에 대해 OAuth 보호를 완전히 사용 안함으로 설정하려면 `@OAuthSecurity` 어노테이션을 자원 또는 클래스 선언에 추가하고 `enabled` 요소의 값을 `false`로 설정하십시오.
```java
@OAuthSecurity(enabled = false)
```
어노테이션의 `enabled` 요소의 기본값은 `true`입니다. `enabled` 요소가 `false`로 설정되면 `scope` 요소가 무시되며 자원 또는 자원 클래스가 [보호되지 않습니다](#unprotected-resources).

<b>참고:</b> 보호되지 않은 클래스의 메소드에 범위를 지정하면 자원 어노테이션의 `enabled`요소를 `false`로 설정하지 않은 한 해당 메소드가 클래스 어노테이션에 관계없이 보호됩니다.

##### 예제
{: #disabling-java-resource-protection-examples }

다음 코드는 `helloUser` 메소드에 대해 자원 보호를 사용 안함으로 설정합니다.
```java
    @GET
    @Path("/{username}")
    @OAuthSecurity(enabled = "false")
    public String helloUser(@PathParam("username") String name){
        ...
    }
```

다음 코드는 `MyUnprotectedResources` 클래스에 대해 자원 보호를 사용 안함으로 설정합니다.
```java
    @Path("/users")
    @OAuthSecurity(enabled = "false")
    public class MyUnprotectedResources {
        ...
    }
```

#### JavaScript 자원 보호를 사용 안함으로 설정
{: #disabling-javascript-resource-protection }

JavaScript 어댑터 자원(프로시저)에 대해 OAuth 보호를 완전히 사용 안함으로 설정하려면 <b>adapter.xml</b> 파일에서 &lt;procedure&gt; 요소의 `secured` 속성을 `false`로 설정하십시오.
```xml
<procedure name="procedureName" secured="false">
```

`secured` 속성이 `false`로 설정되면 `scope` 속성이 무시되며 자원이 [보호되지 않습니다](#unprotected-resources).

##### 예제
{: #disabling-javascript-resource-protection-examples }

다음 코드는 `userName` 프로시저에 대해 자원 보호를 사용 안함으로 설정합니다.
```xml
<procedure name="userName" secured="false">
```

### 보호되지 않는 자원
{: #unprotected-resources }

보호되지 않는 자원은 액세스 토큰을 요구하지 않는 자원입니다. {{ site.data.keys.product_adj }} 보안 프레임워크에서 보호되지 않는 자원에 대한 액세스를 관리하지 않으며, 이 자원에 액세스하는 클라이언트의 ID를 검사하거나 검증하지도 않습니다. 따라서 보호되지 않는 자원에 대해서는 직접 업데이트, 디바이스 액세스 차단 또는 애플리케이션 사용 안함 원격 설정과 같은 기능이 지원되지 않습니다.

### 외부 자원 보호
{: #protecting-external-resources }

외부 자원을 보호하기 위해 외부 자원 서버에 액세스 토큰 유효성 검증 모듈과 함께 자원 필터를 추가합니다. 토큰 유효성 검증 모듈은 자원에 대한 OAuth 클라이언트 액세스를 부여하기 전에 보안 프레임워크의 권한 부여 서버의 자체 점검 엔드포인트를 사용하여 {{ site.data.keys.product_adj }} 액세스 토큰을 유효성 검증합니다. [{{ site.data.keys.product_adj }} REST API for the {{ site.data.keys.product_adj }} runtime](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/c_restapi_runtime_overview.html?view=kc#rest_runtime_api)을 사용하여 외부 서버를 위한 자체 액세스 토큰 유효성 검증 모듈을 작성할 수 있습니다. 또는 [외부 자원 보호](protecting-external-resources) 학습서의 간략한 설명대로 외부 Java 자원 보호를 위해 제공된 {{ site.data.keys.product_adj }} 확장기능 중 하나를 사용하십시오.

## 권한 부여 플로우
{: #authorization-flow }

권한 부여 플로우는 두 개의 단계를 가지고 있습니다.

1. 클라이언트가 액세스 토큰을 획득합니다.
2. 클라이언트가 토큰을 사용하여 보호된 자원에 액세스합니다.

### 액세스 토큰 얻기
{: #obtaining-an-access-token }

이 단계에서, 클라이언트는 액세스 토큰을 수신하기 위해 **보안 검사**를 받습니다.

액세스 토큰 요청 전에 클라이언트는 스스로를 {{ site.data.keys.mf_server }}에 등록합니다. 등록의 일부로 클라이언트는 ID를 인증하는 데 사용할 공개 키를 제공합니다. 이 단계는 모바일 애플리케이션 인스턴스의 수명 동안 한 번 발생합니다. 애플리케이션 인증 보안 검사가 사용으로 설정되면 애플리케이션의 인증이 등록 동안 유효성 검증됩니다.

![토큰 얻기](auth-flow-1.jpg)

1.  클라이언트 애플리케이션은 지정된 범위에 대한 액세스 토큰을 얻기 위해 요청을 보냅니다.

    > 클라이언트는 특정 범위로 액세스 토큰을 요청합니다. 요청된 범위는 클라이언트가 액세스하려는 보호된 자원의 범위와 동일한 보안 검사에 맵핑되어야 하고 선택적으로 추가 보안 검사에도 맵핑할 수 있습니다. 클라이언트는 보호된 자원의 범위에 대한 사전 지식을 가지고 있지 않으면 먼저 비어 있는 범위를 가진 액세스 토큰을 요청한 후 확보한 토큰을 사용하여 자원에 액세스를 시도할 수 있습니다. 클라이언트는 403(금지) 오류가 포함된 응답과 요청된 자원의 필요한 범위를 수신합니다.

2.  클라이언트 애플리케이션은 요청된 범위에 따라 보안 검사를 받습니다.

    > {{ site.data.keys.mf_server }}는 클라이언트 요청의 범위가 맵핑되는 보안 검사를 실행합니다. 권한 부여 서버는 이 검사의 결과를 기반으로 클라이언트의 요청을 허용하거나 거부합니다. 필수 애플리케이션 범위가 정의된 경우 이 범위의 보안 검사는 요청된 범위의 검사 외에 추가로 실행됩니다.

3.  인증 확인 프로세스가 성공적으로 완료된 후 클라이언트 애플리케이션은 요청을 권한 부여 서버로 전달합니다.

    > 성공적으로 인증한 후 클라이언트는 권한 부여 서버의 토큰 엔드포인트로 경로 재지정되며 여기에서 클라이언트가 클라이언트 등록의 일부로 제공된 공개 키를 사용하여 인증됩니다. 인증에 성공하면 권한 부여 서버가 클라이언트 ID, 요청된 범위 및 토큰 만기 시간을 캡슐화하는 디지털로 서명된 액세스 토큰을 클라이언트에 발행합니다.

4.  클라이언트 애플리케이션은 액세스 토큰을 수신합니다.

### 보호된 자원에 액세스하기 위해 토큰 사용
{: #using-a-token-to-access-a-protected-resource }

이 다이어그램에 표시된 것처럼 {{ site.data.keys.mf_server }}에서 실행되는 자원 및 [외부 자원을 인증하기 위해 {{ site.data.keys.mf_server }} 사용](protecting-external-resources/) 학습서에 설명한 대로 외부 자원 서버에서 실행되는 자원에서 보안을 강제 실행할 수 있습니다.

액세스 토큰을 확보한 후 클라이언트는 확보한 토큰을 후속 요청에 첨부하여 보호된 자원에 액세스합니다. 자원 서버는 권한 부여 서버의 검사 엔드포인트를 사용하여 토큰을 검증합니다. 유효성 검증에는 토큰의 디지털 서명을 사용하여 클라이언트의 ID를 확인하고, 범위가 권한 부여된 요청 범위와 일치하는지 확인하고, 토큰이 만료되지 않았는지 확인하는 과정이 포함됩니다. 토큰의 유효성이 검증되면 클라이언트에 자원 액세스 권한이 부여됩니다.

![자원 보호](auth-flow-2.jpg)

1. 클라이언트 애플리케이션은 수신 토큰과 함께 요청을 전송합니다.
2. 유효성 검증 모듈이 토큰을 유효성 검증합니다.
3. {{ site.data.keys.mf_server }}는 어댑터 호출을 진행합니다.

## 다음 학습서
{: #tutorials-to-follow-next }

사이드바 탐색에서 학습서에 따라 {{ site.data.keys.product_adj }} Foundation에서 인증에 대해 읽기를 계속하십시오.
