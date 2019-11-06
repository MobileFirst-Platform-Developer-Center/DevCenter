---
layout: tutorial
title: よくある質問
breadcrumb_title: FAQs
weight: 18
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #faq }

このトピックでは、IBM Digital App Builder に関連するよく寄せられる質問のリストについて説明します。

<div class="panel-group accordion" id="mfp-dab-faqs" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-dab-faq1">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-dab-faqs" href="#collapse-mfp-dab-faq1" aria-expanded="true" aria-controls="collapse-mfp-dab-faq1"><b>A. プラットフォーム API 鍵の作成方法は?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-dab-faq1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-dab-faq1">
            <div class="panel-body">
                <p>
                    <ol>
                        <li>IBM Cloud へのログイン後、<a href="https://cloud.ibm.com/iam#/users" target="_blank">https://cloud.ibm.com/iam#/users</a> にアクセスします。</li>
                        <li><b>「ユーザー」</b>にナビゲートし、リストから自分の名前をクリックして、<b>「ユーザーの詳細」</b>オプションを選択します。</li>
                        <li><b>「IBM Cloud API キーの作成」</b>ウィンドウをクリックします。</li>
                        <li>新しい API キーの<b>「名前」</b>と<b>「説明」</b>を入力します。</li>
                        <li><b>「作成」</b>をクリックします。</li>
                        <li>次に、<b>「表示」</b>をクリックして API キーを表示し、後で使用するためにコピーして保存するか、または<b>「ダウンロード」</b>をクリックします。</li>
                    </ol>
                    <b>注</b>: 安全上の理由により、API キーをコピーまたはダウンロードできるのは作成時のみになります。 API キーを紛失した場合は、新しい API キーを作成する必要があります。 ユーザー API キーについて詳しくは、<a href="https://cloud.ibm.com/docs/iam/userid_keys.html#userapikey">https://cloud.ibm.com/docs/iam/userid_keys.html#userapikey</a> を参照してください。
                </p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-dab-faq2">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-dab-faqs" href="#collapse-mfp-dab-faq2" aria-expanded="true" aria-controls="collapse-mfp-dab-faq2"><b>B. 共有サーバーの制限事項</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-dab-faq2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-dab-faq2">
            <div class="panel-body">
                  <p>共有プレイグラウンド・サーバーは、多数の開発者で共有された共通サーバーです。 このサーバーは、実動アプリケーションには使用しないでください。 このサーバー内のデータは、予告なく削除されることがあります。 サーバーのアップタイムは保証されません。</p>
            </div>
        </div>      
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="mfp-dab-faq3">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#mfp-dab-faqs" href="#collapse-mfp-dab-faq3" aria-expanded="true" aria-controls="collapse-mfp-dab-faq3"><b>C. Digital App Builder を完全にアンインストールする方法は?</b></a>
            </h4>
        </div>
        <div id="collapse-mfp-dab-faq3" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mfp-dab-faq3">
            <div class="panel-body">
                  <p>以下のステップに従って、Digital App Builder を完全にアンインストールできます。
                  <ol><li>各 OS の通常の方法で Digital App Builder をアンインストールします。</li>
                      <li>ご使用の OS に応じて以下のファイルを手動で削除します。
                      <ul><li><b>Windows</b> - <i>Users\worklight\AppData\Roaming\IBM Digital App Builder</i></li>
                          <li><b>MacOS</b> - <i>Users/&lt;systemname&gt;/Library/Application Support/IBM Digital App Builder</i></li>
                      </ul></li>
                  </ol></p>
            </div>
        </div>      
    </div>
</div>
<p>&nbsp;</p>       
