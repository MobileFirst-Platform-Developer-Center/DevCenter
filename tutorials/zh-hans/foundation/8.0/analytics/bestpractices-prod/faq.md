---
layout: tutorial
title: 常见问题及解答
breadcrumb_title: FAQs
relevantTo: [ios,android,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }

本主题描述了与 {{ site.data.keys.mf_analytics_server }} 相关的一系列常见问题及解答。

<div class="panel-group accordion" id="mfp-analytics-faqs" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq1">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq1" aria-expanded="true" aria-controls="collapse-mfp-faq1"><b>1.	如何为我的分析集群设置 shard 和副本数？</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq1">
            <div class="panel-body">
              <p>在多索引 Elasticsearch 集群中，务必设置以下项：<ul><li>将最小 shard 数设置为集群中的节点数。</li><li>将每个 shard 的副本数最少设置为 2。</li></ul><br/>MobileFirst Analytics V8.0 使用多个索引来存储事件数据。</p>
         </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq2">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq2" aria-expanded="true" aria-controls="collapse-mfp-faq2"><b>2. 在 MobileFirst Analytics V8.0 中，<code>server.xml</code> 中的配置设置了 3 个 shard，但 Analytics Operations 控制台管理页面显示超过 15 个 shard。</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq2">
            <div class="panel-body">
                  <p>在 MobileFirst Analytics V8.0 中，Elasticsearch 的数据存储库具有多个索引。它不是基于单个索引的数据存储库。而是基于流入 Analytics 的事件类型动态创建索引。因此，最终用户无需关注多个索引。此处，Elasticsearch 中的每个索引都被拆分为配置文件中设置的 shard 数。</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq3">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq3" aria-expanded="true" aria-controls="collapse-mfp-faq3"><b>3. 为何我的 Analytics Operations 控制台呈现速度极慢？</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq3" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq3">
            <div class="panel-body">
                  <p>请确保使用<a href="https://mobilefirstplatform.ibmcloud.com/learn-more/scalability-and-hardware-sizing-8-0/">硬件大小计算器</a>根据数据和客户需求来检查硬件硬件是否合适。多个因素会影响到系统性能，包括硬件、进入分析服务器的数据事件的类型或大小以及事件量。</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq4">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq4" aria-expanded="true" aria-controls="collapse-mfp-faq4"><b>4. 我可以恢复已清除的数据吗？</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq4" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq4">
            <div class="panel-body">
                <p>不可以。数据一旦清除，将无法恢复。</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq5">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq5" aria-expanded="true" aria-controls="collapse-mfp-faq5"><b>5. 无论是否设置 TTL 值，数据清除都无法正常进行。</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq5" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq5">
            <div class="panel-body">
                <p>TTL 属性不适用于 Analytics 平台中存在的数据。在添加数据之前必须设置 TTL 属性。</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq6">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq6" aria-expanded="true" aria-controls="collapse-mfp-faq6"><b>6. Analytics Operations 控制台未显示任何数据。</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq6" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq6">
            <div class="panel-body">
              <p>请确保使用 MobileFirst Server JNDI 属性配置正确的 Analytics 端点。请确保为要呈现的数据正确地设置了日期过滤器。</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq7">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq7" aria-expanded="true" aria-controls="collapse-mfp-faq7"><b>7. 无法调用 Elasticsearch 集群 REST API。</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq7" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq7">
            <div class="panel-body">
                  <p>要调用 Elasticsearch REST API，必须在分析服务器的 <code>server.xml</code> 中将属性 <b>analytics/http.enabled</b> 设置为 <b>true</b>。</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq8">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq8" aria-expanded="true" aria-controls="collapse-mfp-faq8"><b>8.	我可以在 Analytics 中将 Open JDK 与 IBM WebSphere Application Server ND（或 Full Profile）一起使用吗？</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq8" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq8">
            <div class="panel-body">
                  <p>不可以。在使用 IBM WebSphere Application Server Full Profile 或 Network Deployment (ND) 时，请确保使用随 WebSphere Application Server 提供的开箱即用 IBM JDK。</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq9">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq9" aria-expanded="true" aria-controls="collapse-mfp-faq9"><b>9.	<b>应用程序会话</b>数何时开始递增？</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq9" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq9">
            <div class="panel-body">
                  <p>首次打开应用程序时，<b>应用程序会话数</b>为零。当最终用户将移动应用程序切换至后台又将其切换至前台时，此操作会将<b>应用程序会话数</b>增加 1。进一步重复相同的操作将使<b>应用程序会话数</b>继续递增。</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq10">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq10" aria-expanded="true" aria-controls="collapse-mfp-faq10"><b>10.	分析集群运行状况显示黄色，这是什么意思？</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq10" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq10">
            <div class="panel-body">
                  <p>集群运行状况显示黄色不一定表示出现问题。大多数情况下，当存在未分配的 shard 时，集群运行状况会显示为黄色。当新节点加入集群时，Elasticsearch 会将未分配的 shard 重新分配给新节点，从而使集群运行状况显示为绿色。有时，shard 数量过多也会使 shard 未分配给任何节点，并因此使集群运行状态显示为黄色。请确保集群中的所有节点都处于活动状态且工作正常，并且 shard 处于已启动/活动状态。</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq11">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq11" aria-expanded="true" aria-controls="collapse-mfp-faq11"><b>11.	应用程序会话数对 Web 应用程序来说意味着什么？</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq11" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq11">
            <div class="panel-body">
                  <p>对于 Web 应用程序，AppSession 计数将根据浏览器会话以及从浏览器（应用程序）到 MFP 服务器的连接递增。</p>

                  <p>我们假设浏览器使用常规窗口/选项卡并执行到服务器的连接，那么应用程序会话计数将增加 1。在同一浏览器中，如果用户在另一个选项卡上打开应用程序并执行连接，那么会话不会递增。会话保持不活动状态 30 分钟。当您再次尝试重新连接时，计数会增加 1。</p>

                  <p>如果用户清除浏览器缓存并尝试连接，那么会认为该设备是新设备，并且设备计数将递增。由于浏览器没有实设备标识，因此会为浏览器应用程序生成标识，直至清除脱机文件/缓存为止。</p>

                  <p>这也适用于隐瞒真实身份的浏览器窗口，如果您使用隐瞒真实身份的浏览器窗口并尝试连接，那么会将用于从每个选项卡进行连接的应用程序视为新会话，并且会话计数会递增。如果用户使用两个不同的浏览器并访问应用程序以连接到 MFP 服务器，那么设备计数会增加 2。</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq12">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq12" aria-expanded="true" aria-controls="collapse-mfp-faq12"><b>12.	分析仪表板上的<i>活动用户数</i>是指什么？</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq12" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq12">
            <div class="panel-body">
                  <p><i>活动用户数</i>是指正在使用应用程序的用户数。每个非重复用户都计为一个使用该应用的用户。缺省情况下，deviceID 是 userID。但应用程序开发人员可以使用 <code>setUserContext(userid)</code> API。这会将 userID 替换为应用程序开发人员设置的值。</p>

                  <p>一种解决方案/方法是在用户访问 WebApp 时通过计算机生成 uniqueID，并将其作为 customData 发送。此数据可用于计算用户在其中访问应用程序并使用 <code>setUserContext</code> 设置 userID 的实际机器（或计算机/浏览器）的统计信息。此数据还可用于生成定制图表。</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-faq13">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-analytics-faqs" href="#collapse-mfp-faq13" aria-expanded="true" aria-controls="collapse-mfp-faq13"><b>13.	应用程序会话数对于原生/Cordova 应用程序意味着什么？</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-faq13" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-faq13">
            <div class="panel-body">
                  <p>在 Analytics 8.0 中，应用程序会话的计算与任何先前版本的 MFP Analytics 完全不同。</p>

                  <p>将应用程序从后台切换至前台时，应用程序会话计数会增加 1。要对 Cordova 应用程序启用此功能，我们需要启用 CLIENT APP LIFECYCLE 事件。请参阅<a href="https://mobilefirstplatform.ibmcloud.com/tutorials/ru/foundation/8.0/analytics/analytics-api/#client-lifecycle-events">此处</a>，以获取更多信息。</p>
            </div>
        </div>      
    </div>
</div>       
