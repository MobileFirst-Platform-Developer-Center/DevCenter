---
layout: tutorial
breadcrumb_title: Mobile Foundation Analytics データのバックアップおよびリカバリー
title: Mobile Foundation Analytics データのバックアップおよびリカバリー
weight: 1
show_in_nav: false
---
<!-- NLS_CHARSET=UTF-8 -->
## Mobile Foundation Analytics データのバックアップおよびリカバリー
{: #backup-recovery-mf-analytics-data}

Mobile Foundation Analytics データは、Kubernetes [PersistentVolume または PersistentVolumeClaim](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#introduction) の一部として使用可能です。 [Kubernetes が提供するボリューム・プラグイン](https://kubernetes.io/docs/concepts/storage/volumes/#types-of-volumes)のいずれかを使用できます。

バックアップおよびリストアは、使用するボリューム・プラグインに基づきます。 各種のツールおよびメカニズムがあり、それらを使用してボリュームをバックアップおよびリストアできます。

Kubernetes は、[VolumeSnapshot、VolumeSnapshotContent、および Restore](https://kubernetes-csi.github.io/docs/snapshot-restore-feature.html#snapshot--restore-feature) のオプションを提供しています。 管理者がプロビジョンした[クラスター内のボリューム](https://kubernetes.io/docs/concepts/storage/volume-snapshots/#introduction)のコピーを作成できます。

スナップショット機能をテストするために、Kubernetes の資料にあるさまざまな[サンプル yaml ファイル](https://github.com/kubernetes-csi/external-snapshotter/tree/master/examples/kubernetes)を使用できます。

また、ボリュームをバックアップし、その同じボリュームをリストアするために、[AppsCode Stash](https://appscode.com/products/kubed/0.9.0/guides/disaster-recovery/stash/) など、その他のツールも利用できます。
