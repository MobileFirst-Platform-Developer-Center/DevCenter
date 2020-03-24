---
layout: tutorial
breadcrumb_title: Mobile Foundation Custom Resource (CR) の構成
title: IBM Mobile Foundation Custom Resource (CR) の構成
weight: 3
show_in_nav: false
---
<!-- NLS_CHARSET=UTF-8 -->

### パラメーター

| 修飾子 | パラメーター  | 定義 | 使用可能な値 |
|---|---|---|---|
| global.arch |  amd64    | ハイブリッド・クラスター内の amd64 ワーカー・ノード・スケジューラー設定 | amd64 |
| global.image     | pullPolicy | イメージ・プル・ポリシー | Always、Never、または IfNotPresent デフォルト: **IfNotPresent** |
|      |  pullSecret    | イメージ・プル秘密 | イメージが OCP イメージ・レジストリーでホストされていない場合にのみ必要です。 |
| global.ingress | hostname | 外部クライアントで使用される外部ホスト名または IP アドレス | ブランクのままにすると、デフォルトではクラスター・プロキシー・ノードの IP アドレスが設定されます。|
|         | secret | TLS 秘密名| 入口定義で使用する必要のある証明書の秘密の名前を指定します。 関連する証明書と鍵を使用して秘密を事前に作成する必要があります。 SSL/TLS が有効の場合は必須です。 ここに名前を指定する前に証明書と鍵を使用して秘密を事前に作成します。 [ここ](#optional-creating-tls-secret-for-ingress-configuration)を参照してください。 |
|         | sslPassThrough | SSL パススルーの有効化 | SSL 要求を Mobile Foundation サービスにパススルーする必要があることを指定します。Mobile Foundation サービスで SSL の終了が発生します。  **false** (デフォルト) または true|
| global.dbinit | enabled | Server、Push、および Application Center のデータベースの初期化の有効化 | Server、Push、および Application Center デプロイメント用のデータベースを初期化し、スキーマ/表を作成します (Analytics では不要)。  **true** (デフォルト) または false |
|  | repository | データベース初期化用の Docker イメージ・リポジトリー | Mobile Foundation データベース Docker イメージのリポジトリー。 プレースホルダー REPO_URL が正しい Docker レジストリー URL に置き換えられていることを確認してください。 |
|           | tag          | Docker イメージ・タグ | Docker タグの説明を参照 |
| mfpserver | enabled          | Server を有効にするためのフラグ | **true** (デフォルト) または false |
| mfpserver.image | repository | Docker イメージ・リポジトリー | Mobile Foundation サーバー Docker イメージのリポジトリー。 プレースホルダー REPO_URL が正しい Docker レジストリー URL に置き換えられていることを確認してください。 |
|           | tag          | Docker イメージ・タグ | Docker タグの説明を参照 |
|           | consoleSecret | ログイン用に事前に作成された秘密 | [ここ](#optional-creating-custom-defined-console-login-secrets)を参照してください。
|  mfpserver.db | type | サポートされているデータベース・ベンダー名。 | **DB2** (デフォルト)/MySQL/Oracle |
|               | host | Mobile Foundation サーバー表を構成する必要があるデータベースの IP アドレスまたはホスト名 | |
|                       | port | 	データベースがセットアップされているポート | |
|                       | secret | データベース資格情報が含まれる事前に作成された秘密| |
|                       | name | Mobile Foundation サーバー・データベースの名前 | |
|                       | schema | 作成する Server DB スキーマ | スキーマが既に存在する場合、そのスキーマが使用されます。 それ以外の場合、作成されます。 |
|                       | ssl | データベース接続タイプ  | データベース接続が http と https のいずれであるかを指定します。 デフォルト値は **false** (http) です。 データベース・ポートも同じ接続モード用に構成されていることを確認してください。 |
|                       | driverPvc | JDBC データベース・ドライバーにアクセスするための永続ボリューム要求| JDBC データベース・ドライバーをホストする永続ボリューム要求の名前を指定します。 選択したデータベース・タイプが DB2 ではない場合は必須です。 |
|                       | adminCredentialsSecret | MFPServer DB 管理秘密 | DB の初期化を有効にした場合、Mobile Foundation コンポーネント用のデータベース表およびスキーマを作成するために秘密を指定します。 |
| mfpserver | adminClientSecret | 管理クライアント秘密 | 作成したクライアント秘密の名前を指定します。 [ここ](#optional-creating-secrets-for-confidential-clients)を参照してください。  |
|  | pushClientSecret | Push クライアント秘密 | 作成したクライアント秘密の名前を指定します。 [ここ](#optional-creating-secrets-for-confidential-clients)を参照してください。 |
| mfpserver.replicas |  | 作成する必要がある Mobile Foundation サーバーのインスタンス (ポッド) の数 | 正整数 (デフォルト: **3**) |
| mfpserver.autoscaling     | enabled | Horizontal Pod Autoscaler (HPA) をデプロイするかどうかを指定します。 このフィールドを有効にすると、replicas フィールドが無効になるので注意してください。 | **false** (デフォルト) または true |
|           | minReplicas  | Autoscaler によって設定できるポッド数の下限値 | 正整数 (デフォルトは **1**) |
|           | maxReplicas | Autoscaler によって設定できるポッド数の上限値。 下限値より小さくすることはできません。 | 正整数 (デフォルトは **10**) |
|           | targetCPUUtilizationPercentage | すべてのポッドの目標平均 CPU 使用率 (要求された CPU のパーセンテージで表す) | 1 から 100 までの整数 (デフォルトは **50**) |
| mfpserver.pdb     | enabled | PDB を有効にするか無効にするかを指定します。 | **true** (デフォルト) または false |
|           | min  | 使用可能な最小ポッド数 | 正整数 (デフォルトは 1) |
|    mfpserver.customConfiguration |  |  カスタム・サーバー構成 (オプション)  | 事前に作成した構成マップに対して Server 固有の追加構成リファレンスを提供します。 [ここ](#optional-custom-server-configuration)を参照してください。|
| mfpserver.jndiConfigurations | mfpfProperties | デプロイメントをカスタマイズするための Mobile Foundation サーバー JNDI プロパティー | 名前と値のペアをコンマで区切って指定します。 |
| mfpserver | keystoreSecret | [構成セクション](#optional-creating-custom-keystore-secret-for-the-deployments)を参照して、鍵ストアとそのパスワードを使用して秘密を事前に作成してください。|
| mfpserver.resources | limits.cpu  | 許可される CPU の最大量を記述します。  | デフォルトは **2000m** です。 Kubernetes の [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) を参照してください。 |
|                  | limits.memory | 許可されるメモリーの最大量を記述します。 | デフォルトは **2048Mi** です。 Kubernetes の [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) を参照してください。|
|           | requests.cpu  | 必要な CPU の最小量を記述します。指定されない場合、最大量が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。  | デフォルトは **1000m** です。 Kubernetes の [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) を参照してください。 |
|           | requests.memory | 必要なメモリーの最小量を記述します。 指定されない場合、メモリー量は、最大量が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。 | デフォルトは **1536Mi** です。 Kubernetes の [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) を参照してください。 |
| mfppush | enabled          | Mobile Foundation Push を有効にするためのフラグ | **true** (デフォルト) または false |
|           | repository   | Docker イメージ・リポジトリー |Mobile Foundation Push Docker イメージのリポジトリー。 プレースホルダー REPO_URL が正しい Docker レジストリー URL に置き換えられていることを確認してください。 |
|           | tag          | Docker イメージ・タグ | Docker タグの説明を参照 |
| mfppush.replicas | | 作成する必要がある Mobile Foundation サーバーのインスタンス (ポッド) の数 | 正整数 (デフォルト: **3**) |
| mfppush.autoscaling     | enabled | Horizontal Pod Autoscaler (HPA) をデプロイするかどうかを指定します。 このフィールドを有効にすると、replicaCount フィールドが無効になるので注意してください。 | **false** (デフォルト) または true |
|           | minReplicas  | Autoscaler によって設定できるポッド数の下限値 | 正整数 (デフォルトは **1**) |
|           | maxReplicas | Autoscaler によって設定できるポッド数の上限値。 minReplicas より小さくすることはできません。 | 正整数 (デフォルトは **10**) |
|           | targetCPUUtilizationPercentage | すべてのポッドの目標平均 CPU 使用率 (要求された CPU のパーセンテージで表す) | 1 から 100 までの整数 (デフォルトは **50**) |
| mfppush.pdb     | enabled | PDB を有効にするか無効にするかを指定します。 | **true** (デフォルト) または false |
|           | min  | 使用可能な最小ポッド数 | 正整数 (デフォルトは 1) |
| mfppush.customConfiguration |  |  カスタム構成 (オプション)  | 事前に作成した構成マップに対して Push 固有の追加構成リファレンスを提供します。 [ここ](#optional-custom-server-configuration)を参照してください。 |
| mfppush.jndiConfigurations | mfpfProperties | デプロイメントをカスタマイズするための Mobile Foundation サーバー JNDI プロパティー | 名前と値のペアをコンマで区切って指定します。 |
| mfppush | keystoresSecretName | [構成セクション](#optional-creating-custom-keystore-secret-for-the-deployments)を参照して、鍵ストアとそのパスワードを使用して秘密を事前に作成してください。|
| mfppush.resources | limits.cpu  | 許可される CPU の最大量を記述します。  | デフォルトは **1000m** です。 Kubernetes の [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) を参照してください。 |
|                  | limits.memory | 許可されるメモリーの最大量を記述します。 | デフォルトは **2048Mi** です。 Kubernetes の [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) を参照してください。|
|           | requests.cpu  | 必要な CPU の最小量を記述します。指定されない場合、最大量が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。  | デフォルトは **750m** です。 Kubernetes の [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) を参照してください。 |
|           | requests.memory | 必要なメモリーの最小量を記述します。 指定されない場合、メモリー量は、最大量が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。 | デフォルトは **1024Mi** です。 Kubernetes の [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) を参照してください。 |
| mfpanalytics | enabled          | Analytics を有効にするためのフラグ | **false** (デフォルト) または true |
| mfpanalytics.image | repository          | Docker イメージ・リポジトリー | Mobile Foundation Operational Analytics Docker イメージのリポジトリー。 プレースホルダー REPO_URL が正しい Docker レジストリー URL に置き換えられていることを確認してください。 |
|           | tag          | Docker イメージ・タグ | Docker タグの説明を参照 |
|           | consoleSecret | ログイン用に事前に作成された秘密 | [ここ](#optional-creating-custom-defined-console-login-secrets)を参照してください。|
| mfpanalytics.replicas |  | 作成する必要がある Mobile Foundation Operational Analytics のインスタンス (ポッド) の数 | 正整数 (デフォルト: **2**) |
| mfpanalytics.autoscaling     | enabled | Horizontal Pod Autoscaler (HPA) をデプロイするかどうかを指定します。 このフィールドを有効にすると、replicaCount フィールドが無効になるので注意してください。 | **false** (デフォルト) または true |
|           | minReplicas  | Autoscaler によって設定できるポッド数の下限値 | 正整数 (デフォルトは **1**) |
|           | maxReplicas | Autoscaler によって設定できるポッド数の上限値。 minReplicas より小さくすることはできません。 | 正整数 (デフォルトは **10**) |
|           | targetCPUUtilizationPercentage | すべてのポッドの目標平均 CPU 使用率 (要求された CPU のパーセンテージで表す) | 1 から 100 までの整数 (デフォルトは 50) |
|  mfpanalytics.shards|  | Mobile Foundation Analytics の Elasticsearch シャードの数 | デフォルトは 2|             
|  mfpanalytics.replicasPerShard|  | Mobile Foundation Analytics のシャードごとに維持する Elasticsearch レプリカの数 | デフォルトは **2**|
| mfpanalytics.persistence | enabled         | PersistentVolumeClaim を使用してデータを永続化します。                        | **true** |                                                 |
|            |useDynamicProvisioning      | storageclass を指定するか、空のままにします。  | **false**  |                                                  |
|           |volumeName| ボリューム名を指定します。  | **data-stor** (デフォルト) |
|           |claimName| 既存の PersistentVolumeClaim を指定します。  | nil |
|           |storageClassName     | バッキング PersistentVolumeClaim のストレージ・クラス | nil |
|           |size             | データ・ボリュームのサイズ      | 20Gi |
| mfpanalytics.pdb     | enabled | PDB を有効にするか無効にするかを指定します。 | **true** (デフォルト) または false |
|           | min  | 使用可能な最小ポッド数 | 正整数 (デフォルトは **1**) |
|    mfpanalytics.customConfiguration |  |  カスタム構成 (オプション)  | 事前に作成した構成マップに対して Analytics 固有の追加構成リファレンスを提供します。 [ここ](#optional-custom-server-configuration) を参照してください。 |
| mfpanalytics.jndiConfigurations | mfpfProperties | Operational Analytics をカスタマイズするために指定する Mobile Foundation JNDI プロパティー| 名前と値のペアをコンマで区切って指定します。  |
| mfpanalytics | keystoreSecret | [構成セクション](#optional-creating-custom-keystore-secret-for-the-deployments)を参照して、鍵ストアとそのパスワードを使用して秘密を事前に作成してください。|
| mfpanalytics.resources | limits.cpu  | 許可される CPU の最大量を記述します。  | デフォルトは **1000m** です。 Kubernetes の [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) を参照してください。 |
|                  | limits.memory | 許可されるメモリーの最大量を記述します。 | デフォルトは **2048Mi** です。 Kubernetes の [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) を参照してください。|
|           | requests.cpu  | 必要な CPU の最小量を記述します。指定されない場合、最大量が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。  | デフォルトは **750m** です。 Kubernetes の [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) を参照してください。 |
|           | requests.memory | 必要なメモリーの最小量を記述します。 指定されない場合、メモリー量は、最大量が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。 | デフォルトは 1024Mi です。 Kubernetes の [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) を参照してください。 |
| mfpappcenter | enabled          | Application Center を有効にするためのフラグ | **false** (デフォルト) または true |  
| mfpappcenter.image | repository          | Docker イメージ・リポジトリー | Mobile Foundation Application Center Docker イメージのリポジトリー。 プレースホルダー REPO_URL が正しい Docker レジストリー URL に置き換えられていることを確認してください。 |
|           | tag          | Docker イメージ・タグ | Docker タグの説明を参照 |
|           | consoleSecret | ログイン用に事前に作成された秘密 | [ここ](#optional-creating-custom-defined-console-login-secrets)を参照してください。|
|  mfpappcenter.db | type | サポートされているデータベース・ベンダー名。 | **DB2** (デフォルト)/MySQL/Oracle |
|                   | host | Appcenter データベースを構成する必要があるデータベースの IP アドレスまたはホスト名	| |
|                       | port | 	データベースのポート  | |             
|                       | name | 使用するデータベースの名前 | データベースを事前に作成する必要があります。|
|                       | secret | データベース資格情報が含まれる事前に作成された秘密| |
|                       | schema | 作成する Application Center データベース・スキーマ | スキーマが既に存在する場合、そのスキーマが使用されます。 存在しない場合は、作成されます。 |
|                       | ssl |データベース接続タイプ  | データベース接続が http と https のいずれであるかを指定します。 デフォルト値は **false** (http) です。 データベース・ポートも同じ接続モード用に構成されていることを確認してください。 |
|                       | driverPvc | JDBC データベース・ドライバーにアクセスするための永続ボリューム要求| JDBC データベース・ドライバーをホストする永続ボリューム要求の名前を指定します。 選択したデータベース・タイプが DB2 ではない場合は必須です。 |
|                       | adminCredentialsSecret | Application Center DB 管理秘密 | DB の初期化を有効にした場合、Mobile Foundation コンポーネント用のデータベース表およびスキーマを作成するために秘密を指定します。 |
| mfpappcenter.autoscaling     | enabled | Horizontal Pod Autoscaler (HPA) をデプロイするかどうかを指定します。 このフィールドを有効にすると、replicaCount フィールドが無効になるので注意してください。 | **false** (デフォルト) または true |
|           | minReplicas  | Autoscaler によって設定できるポッド数の下限値 | 正整数 (デフォルトは **1**) |
|           | maxReplicas | Autoscaler によって設定できるポッド数の上限値。 minReplicas より小さくすることはできません。 | 正整数 (デフォルトは **10**) |
|           | targetCPUUtilizationPercentage | すべてのポッドの目標平均 CPU 使用率 (要求された CPU のパーセンテージで表す) | 1 から 100 までの整数 (デフォルトは **50**) |
| mfpappcenter.pdb     | enabled | PDB を有効にするか無効にするかを指定します。 | **true** (デフォルト) または false |
|           | min  | 使用可能な最小ポッド数 | 正整数 (デフォルトは **1**) |
| mfpappcenter.customConfiguration |  |  カスタム構成 (オプション)  | 事前に作成した構成マップに対して Application Center 固有の追加構成リファレンスを提供します。 [ここ](#optional-custom-server-configuration)を参照してください。 |
| mfpappcenter | keystoreSecret | [構成セクション](#optional-creating-custom-keystore-secret-for-the-deployments)を参照して、鍵ストアとそのパスワードを使用して秘密を事前に作成してください。|
| mfpappcenter.resources | limits.cpu  | 許可される CPU の最大量を記述します。  | デフォルトは **1000m** です。 Kubernetes の [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) を参照してください。 |
|                  | limits.memory | 許可されるメモリーの最大量を記述します。 | デフォルトは **2048Mi** です。 Kubernetes の [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) を参照してください。|
|           | requests.cpu  | 必要な CPU の最小量を記述します。指定されない場合、最大量が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。  | デフォルトは **750m** です。 Kubernetes の [meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) を参照してください。 |
|           | requests.memory | 必要なメモリーの最小量を記述します。 指定されない場合、メモリー量は、最大量が指定されていれば、それがデフォルトになり、そうでなければ実装定義の値がデフォルトになります。 | デフォルトは **1024Mi** です。 Kubernetes の [meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) を参照してください。 |

## (オプション) カスタム定義コンソール・ログイン秘密の作成

デフォルトでは、デプロイメント中にすべての Mobile Foundation コンポーネントのコンソール・ログイン秘密が自動的に作成されます。 オプションで、Server、Analytics、および Application Center コンソールにアクセスするための**ログイン秘密**を作成することを明示的に選択できます。 以下に例を示します。

Server の場合:

```
kubectl create secret generic serverlogin --from-literal=MFPF_ADMIN_USER=admin --from-literal=MFPF_ADMIN_PASSWORD=admin
```

Analytics の場合:

```
kubectl create secret generic analyticslogin --from-literal=MFPF_ANALYTICS_ADMIN_USER=admin --from-literal=MFPF_ANALYTICS_ADMIN_PASSWORD=admin
```

Application Center の場合:

```
kubectl create secret generic appcenterlogin --from-literal=MFPF_APPCNTR_ADMIN_USER=admin --from-literal=MFPF_APPCNTR_ADMIN_PASSWORD=admin
```

> 注: これらの秘密が提供されていない場合、Mobile Foundation のインストール時に、デフォルトのユーザー名とパスワード (admin/admin) を使用して作成されます。

## (オプション) 入口構成のための TLS 秘密の作成

外部クライアントがホスト名を使用して Mobile Foundation コンポーネントに到達できるようにするために、ホスト名ベースの入口を使用してそれらの Mobile Foundation コンポーネントを構成できます。 この入口は、TLS の秘密鍵と証明書を使用することで保護できます。 TLS の秘密鍵と証明書は、`tls.key` および `tls.crt` という鍵名を使用して秘密で定義する必要があります。

以下のコマンドを使用すると、入口リソースと同じ名前空間に秘密 **mf-tls-secret** が作成されます。

```
kubectl create secret tls mf-tls-secret --key=/path/to/tls.key --cert=/path/to/tls.crt
```

その後、カスタム・リソース構成 yaml の *global.ingress.secret* フィールドに秘密の名前を指定します。

## (オプション) デプロイメントのためのカスタム鍵ストア秘密の作成

独自の鍵ストアとトラストストアを使用する秘密を作成することで、Server、Push、Analytics、および Application Center デプロイメントに対して独自の鍵ストアとトラストストアを提供できます。

リテラル KEYSTORE_PASSWORD および TRUSTSTORE_PASSWORD を使用して鍵ストアおよびトラストストアのパスワードとともに `keystore.jks` および `truststore.jks` を含む秘密を事前に作成し、各構成要素の keystoreSecret フィールドに秘密名を指定します。

以下は、`keystore.jks`、`truststore.jks` およびそのパスワードを使用してサーバー・デプロイメントのための鍵ストア秘密を作成する例です。
```
kubectl create secret generic server-secret --from-file=./keystore.jks --from-file=./truststore.jks --from-literal=KEYSTORE_PASSWORD=worklight --from-literal=TRUSTSTORE_PASSWORD=worklight
```

> 注: ファイルおよびリテラルの名前は、上記のコマンドで示したものと同じでなければなりません。	Helm チャートの構成時にデフォルトの鍵ストアをオーバーライドするには、各構成要素の `keystoresSecretName` 入力フィールドにこの秘密名を指定します。


## (オプション) 機密クライアントのための秘密の作成

Mobile Foundation サーバーを、管理サービスの機密クライアントを使用して事前定義します。 これらのクライアントの資格情報は、`mfpserver.adminClientSecret` フィールドと `mfpserver.pushClientSecret` フィールドに指定します。

これらの秘密は、以下のように作成できます。

```
kubectl create secret generic mf-admin-client --from-literal=MFPF_ADMIN_AUTH_CLIENTID=admin --from-literal=MFPF_ADMIN_AUTH_SECRET=admin

kubectl create secret generic mf-push-client --from-literal=MFPF_PUSH_AUTH_CLIENTID=admin --from-literal=MFPF_PUSH_AUTH_SECRET=admin
```

Helm チャートのインストール時に `mfpserver.pushClientSecret` フィールドと `mfpserver.adminClientSecret` フィールドの値を指定しなかった場合、以下のように資格情報を使用してデフォルトのクライアント秘密がそれぞれ作成されます。

* `mfpserver.adminClientSecret` の場合、`admin/nimda`
* `mfpserver.pushClientSecret` の場合、`push/hsup`

## (オプション) カスタム・サーバー構成

構成をカスタマイズするには (例: ログ・トレース設定を変更する、新しい jndi プロパティーを追加するなど)、構成 XML ファイルを使用して configmap を作成する必要があります。 これにより、新しい構成設定を追加することや、Mobile Foundation コンポーネントの既存の構成をオーバーライドすることができます。

Mobile Foundation コンポーネントは、configMap (mfpserver-custom-config) を介してカスタム構成にアクセスします。これは、以下のように作成できます。

```
kubectl create configmap mfpserver-custom-config --from-file=<configuration file in XML format>
```

上記のコマンドを使用して作成した configmap を、Mobile Foundation のデプロイ時に Helm チャートの**カスタム・サーバー構成**で指定する必要があります。

以下は、mfpserver-custom-config configmap を使用してトレース・ログ仕様を「warning」に設定する例です (デフォルト設定は「info」)。

- サンプル構成 XML (logging.xml)

```
<server>
        <logging maxFiles="5" traceSpecification="com.ibm.mfp.*=debug:*=warning"
        maxFileSize="20" />
</server>
```

- configmap を作成し、Helm チャートのデプロイメント時に同じ内容を追加する

```
kubectl create configmap mfpserver-custom-config --from-file=logging.xml
```

- (Mobile Foundation コンポーネントの) messages.log の変更に注意してください - ***プロパティー traceSpecification を com.ibm.mfp.=debug:\*=warning に設定します。***

## (オプション) カスタム生成 LTPA 鍵の使用

デフォルトでは、Mobile Foundation のイメージには、各 Mobile Foundation コンポーネントの一連の `ltpa.keys` がバンドルされます。 実稼働環境で、すぐに使用可能な `ltpa.keys` をカスタム生成したもので更新する必要がある場合、カスタム構成を使用して、config xml とともにカスタム生成した `ltpa.keys` を追加できます。

以下は、構成のサンプル `ltpa.xml` です。

```xml
<server description="mfpserver">
    <ltpa
        keysFileName="ltpa.keys" />
    <webAppSecurity ssoUseDomainFromURL="true" />
</server>
```

以下は、カスタム LTPA 鍵を追加するコマンドの例です。

```bash
kubectl create configmap mfpserver-custom-config --from-file=ltpa.xml --from-file=ltpa.keys
```

LTPA 鍵の生成の詳細、およびその他の詳細については、[Libertyの資料](https://www.ibm.com/support/knowledgecenter/en/SSEQTP_liberty/com.ibm.websphere.wlp.doc/ae/twlp_sec_ltpa.html)を参照してください。

**注:** カスタム構成を追加するために複数の custom-configmaps を使用することはサポートされていません。代わりに、以下のようにカスタム構成 *configmap* を作成することをお勧めします。

```bash
kubectl create configmap mfpserver-custom-config --from-file=ltpa.xml --from-file=ltpa.keys --from-file=moreconfig.xml
```
