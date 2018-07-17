---
layout: tutorial
title: 자주 문의되는 질문(FAQ)
breadcrumb_title: FAQs
relevantTo: [ios,android,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 개요
{: #overview }

이 주제에서는 {{ site.data.keys.mf_analytics_server }}와 관련되어 일반적으로 문의되는 질문 목록에 대해 설명합니다.

<div class="panel-group accordion" id="mfp-analytics-faqs" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq1">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq1" aria-expanded="true" aria-controls="collapse-mfp-faq1"><b>1.	내 분석 클러스터의 샤드 및 복제본 수는 어떻게 설정합니까?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq1">
            <div class="panel-body">
              <p>다중 인덱스 elasticsearch 클러스터에서는 다음을 설정하는 것이 중요합니다.
                <ul><li>샤드의 최소 수를 클러스터의 노드 수로 설정해야 합니다.</li><li>샤드 당 복제본을 최소 두 개로 설정해야 합니다.</li></ul><br/>MobileFirst Analytics v8.0에서는 다중 인덱스를 사용하여 이벤트 데이터를 저장합니다.</p>
         </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq2">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq2" aria-expanded="true" aria-controls="collapse-mfp-faq2"><b>2. MobileFirst Analytics v8.0에서 <code>server.xml</code>의 구성에는 샤드가 3개 설정되어 있지만 Analytics Operations 콘솔 관리 페이지에는 15개 이상의 샤드가 표시됩니다.</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq2">
            <div class="panel-body">
                  <p>MobileFirst Analytics v8.0에서 Elasticsearch 데이터 저장소에는 다중 인덱스가 있습니다. 단일 인덱스 기반 데이터 저장소가 아닙니다. 인덱스는 분석에 유입되는 이벤트의 유형에 따라 동적으로 작성됩니다. 그러므로 일반 사용자는 다중 인덱스에 대해 염려할 필요가 없습니다. 여기서 Elasticsearch의 모든 인덱스는 구성 파일에 설정된 샤드의 수로 분할됩니다.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq3">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq3" aria-expanded="true" aria-controls="collapse-mfp-faq3"><b>3. 내 Analytics Operations 콘솔이 매우 느리게 렌더링되는 이유가 무엇입니까?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq3" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq3">
            <div class="panel-body">
                  <p><a href="https://mobilefirstplatform.ibmcloud.com/learn-more/scalability-and-hardware-sizing-8-0/">하드웨어 사이징 계산기</a>를 사용하여 데이터 및 고객 요구사항에 적합한 하드웨어를 확인하십시오. 몇 가지 요인이 하드웨어, 분석 서버에 들어오는 데이터 이벤트의 유형이나 크기 및 이벤트의 볼륨을 포함하여 시스템의 성능에 영향을 미칩니다.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq4">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq4" aria-expanded="true" aria-controls="collapse-mfp-faq4"><b>4. 제거된 데이터를 복구할 수 있습니까?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq4" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq4">
            <div class="panel-body">
                <p>아니오. 일단 데이터가 제거되면 복구할 수 없습니다.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq5">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq5" aria-expanded="true" aria-controls="collapse-mfp-faq5"><b>5. TTL 값 설정과 관계없이 데이터 제거가 올바르게 수행되지 않습니다.</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq5" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq5">
            <div class="panel-body">
                <p>TTL 특성은 Analytics 플랫폼에 있는 데이터에 적용되지 않습니다. 데이터를 추가하기 전에 TTL 특성을 설정해야 합니다.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq6">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq6" aria-expanded="true" aria-controls="collapse-mfp-faq6"><b>6. Analytics Operations 콘솔에 데이터가 표시되지 않습니다.</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq6" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq6">
            <div class="panel-body">
              <p>올바른 Analytics 엔드포인트를 구성하는 데 MobileFirst Server JNDI 특성이 사용되는지 확인하십시오. 데이터가 렌더링되도록 날짜 필터가 올바르게 설정되었는지 확인하십시오.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq7">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq7" aria-expanded="true" aria-controls="collapse-mfp-faq7"><b>7. Elasticsearch 클러스터 REST API를 호출할 수 없습니다.</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq7" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq7">
            <div class="panel-body">
                  <p>Elasticsearch REST API를 호출하려면 Analytics 서버의 <code>server.xml</code>에서 <b>analytics/http.enabled</b> 특성을 <b>true</b>로 설정해야 합니다.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq8">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq8" aria-expanded="true" aria-controls="collapse-mfp-faq8"><b>8.	Analytics에서 오픈 JDK를 IBM WebSphere Application Server ND(또는 전체 프로파일)와 함께 사용할 수 있습니까?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq8" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq8">
            <div class="panel-body">
                  <p>아니오. IBM WebSphere Application Server 전체 프로파일 또는 ND(Network Deployment)를 사용하는 동안 WebSphere Application Server와 함께 제공되는 바로 사용할 수 있는 IBM JDK를 사용해야 합니다.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq9">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq9" aria-expanded="true" aria-controls="collapse-mfp-faq9"><b>9.	언제 <b>앱 세션</b> 수가 증가하기 시작합니까?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq9" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq9">
            <div class="panel-body">
                  <p>처음 애플리케이션을 열면 <b>앱 세션</b>이 0입니다. 일반 사용자가 모바일 앱을 백그라운드로 가져와 다시 포그라운드로 가져오면, 이 조치는 <b>앱 세션</b>을 1로 증가시킵니다. 추가로 동일한 조치를 반복하면 <b>앱 세션</b>이 계속 증가합니다.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq10">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq10" aria-expanded="true" aria-controls="collapse-mfp-faq10"><b>10.	Analytics 클러스터 상태에서 노란색을 표시하면 무슨 의미입니까?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq10" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq10">
            <div class="panel-body">
                  <p>클러스터 상태가 노란색이면 문제가 되지 않을 수 있습니다. 대부분 지정되지 않은 샤드가 있는 경우 클러스터 상태가 노란색으로 표시됩니다. 새 노드가 클러스터에 결합되면 Elasticsearch에서 지정되지 않은 샤드를 새 노드에 재할당하고 그런 다음 클러스터 상태가 초록색으로 변경됩니다. 때로는 너무 많은 샤드 개수로 인해 샤드가 노드 중 하나에 지정되지 않고 남게 되어 클러스터 상태가 노란색으로 표시됩니다. 클러스터의 모든 노드가 활성 상태이고 정상적으로 작동하며 샤드가 시작됨/활성 상태인지 확인하십시오.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq11">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq11" aria-expanded="true" aria-controls="collapse-mfp-faq11"><b>11.	앱 세션은 웹 앱에 대해 무엇을 의미합니까?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq11" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq11">
            <div class="panel-body">
                  <p>웹 앱의 경우 AppSession 개수는 브라우저 세션에 따라 증가하며 브라우저(앱)에서 MFP 서버로의 연결을 기준으로 합니다.</p>

                  <p>브라우저가 일반 창/탭을 사용하고 서버에 연결을 수행하면 앱 세션 개수가 1씩 증가한다고 가정합니다. 동일한 브라우저에서 사용자가 다른 탭에서 앱을 열고 연결을 수행하면 세션이 증가하지 않습니다. 세션은 30분 동안 비활성 상태로 유지됩니다. 다시 연결하려고 하면 1씩 증가합니다.</p>

                  <p>사용자가 브라우저 캐시를 지우고 연결을 시도하면 디바이스는 새 것으로 간주되어 디바이스 개수가 증가합니다. 브라우저에는 실제 디바이스 ID가 없으므로 오프라인 파일/캐시가 지워질 때까지 브라우저 앱에 대한 ID가 생성됩니다.</p>

                  <p>이는 시크릿 모드(incognito) 브라우저 창에도 적용되고 시크릿 모드 브라우저 창을 사용하여 연결을 시도하면 각 탭에서 연결하는 데 사용된 앱이 새 세션으로 간주되어 세션 개수가 증가합니다. 사용자가 두 개의 다른 브라우저를 사용하고 앱을 액세스하여 MFP 서버에 연결하면 디바이스 수는 2씩 증가합니다.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq12">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq12" aria-expanded="true" aria-controls="collapse-mfp-faq12"><b>12.	Analytics 대시보드에서 <i>활성 사용지</i>는 무엇을 의미합니까?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq12" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq12">
            <div class="panel-body">
                  <p><i>활성 사용자</i>는 앱을 사용하는 사용자의 수입니다. 모든 고유 사용자는 앱을 사용하는 사용자로 간주됩니다. 기본적으로 deviceID는 userID입니다. 그러나 앱 개발자는 <code>setUserContext(userid)</code> API를 사용할 수 있습니다. 그러면 userID가 앱 개발자가 설정한 값으로 대체됩니다.</p>

                  <p>하나의 솔루션/접근법은 사용자가 WebApp에 액세스 할 때 컴퓨터에서 uniqueID를 생성하고 이를 customData로 전송하는 것입니다. 이 데이터는 사용자가 앱에 액세스하는 실제 머신(또는 컴퓨터/브라우저)에 대한 통계를 계산하는 데 사용할 수 있으며 <code>setUserContext</code>를 사용하여 userID를 설정합니다. 이 데이터를 사용하여 사용자 정의 차트를 생성할 수도 있습니다.</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq13">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq13" aria-expanded="true" aria-controls="collapse-mfp-faq13"><b>13.	앱 세션은 기본/Cordova 앱에 대해 무엇을 의미합니까?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq13" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq13">
            <div class="panel-body">
                  <p>Analytics 8.0에서는 앱 세션 계산이 이전 버전의 MFP Analytics와 완전히 다릅니다.</p>

                  <p>앱 세션 개수는 앱을 백그라운드에서 포그라운드로 가져올 때 1씩 증가합니다. Cordova 앱에서 사용하려면 CLIENT APP LIFECYCLE 이벤트를 사용으로 설정해야 합니다. 자세한 정보는 <a href="https://mobilefirstplatform.ibmcloud.com/tutorials/ru/foundation/8.0/analytics/analytics-api/#client-lifecycle-events">여기</a>를 참조하십시오.</p>
            </div>
        </div>      
    </div>
</div>       
