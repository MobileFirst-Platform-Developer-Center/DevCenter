---
layout: tutorial
title: Windows 8.1 および Windows 10 開発環境のセットアップ
breadcrumb_title: Windows
relevantTo: [windows,javascript]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## 概説
{: #overview }
このチュートリアルでは、Windows 8.1 Universal アプリケーションおよび Windows 10 UWP アプリケーションを開発およびテストできるようにするために開発者が従う必要のあるステップを説明します。

**前提条件:** iOS 開発環境をセットアップする際には、 [{{site.data.keys.product }} 開発環境のセットアップ](../mobilefirst/)のチュートリアルも必ずお読みください。

### 登録
{: #registration }
1. Windows 開発者として登録します。

- 組織/チーム管理者が使用する [Microsoft アカウントを作成します](https://signup.live.com/)。
- Microsoft ID を使用して、[Windows Dev Center](https://dev.windows.com/en-us/programs/join) にサインインします。

> [Windows developer support](https://dev.windows.com/en-us/support) Web サイトに詳細の説明があります。

### 開発
{: #development }
Windows 8.1 Universal または Windows 10 UWP のアプリケーション開発には、Windows 8.1 オペレーティング・システムまたは Windows 10 オペレーティング・システムで稼働する PC ワークステーションと Microsoft Visual Studio 2013 または 2015 が必要です。

#### Windows 8.1 Universal
{: #windows-81-universal }
Windows 8.1 Universal アプリケーションのソリューションは、以下の 3 つのプロジェクトから構成されます。

- ビジネス・ロジックの共有コード
- Windows デスクトップ/タブレット・アプリケーションのプロジェクト
- Windows Phone アプリケーションのプロジェクト

Windows 8.1 Universal には、以下が必要です。

- Windows OS 8.1 以上
- Visual Studio 2013 または 2015

#### Windows 10 UWP
{: #windows-10-uwp }
Windows 10 UWP (Universal Windows Platform) アプリケーションのソリューションは、以下を含む単一プロジェクトから構成されます。

- ビジネス・ロジックの共有コード
- アダプティブ UI (デスクトップ/タブレットおよび Phone の両方の場合) 

Windows 10 UWP には、以下が必要です。

- Windows OS 8.1 以上
- Visual Studio 2015

## 次のステップ
{: #whats-next }
{{site.data.keys.product }} および Windows 開発環境がセットアップされたため、[クイック・スタート](../../../quick-start/windows-8-10/)のカテゴリーで {{site.data.keys.product }} を使用してみるか、[すべてのチュートリアル](../../../all-tutorials)で {{site.data.keys.product }} 開発の個々の側面について理解を深めてください。
