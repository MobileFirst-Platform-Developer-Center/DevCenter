---
layout: tutorial
breadcrumb_title: Mobile Foundation Analytics 데이터의 백업 및 복구
title: Mobile Foundation Analytics 데이터의 백업 및 복구
weight: 1
show_in_nav: false
---
<!-- NLS_CHARSET=UTF-8 -->
## Mobile Foundation Analytics 데이터의 백업 및 복구
{: #backup-recovery-mf-analytics-data}

Mobile Foundation Analytics 데이터는 Kubernetes [PersistentVolume 또는 PersistentVolumeClaim](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#introduction)의 일부로 사용 가능합니다. [Kubernetes에서 제공하는 볼륨 플러그인](https://kubernetes.io/docs/concepts/storage/volumes/#types-of-volumes) 중 하나를 사용할 수 있습니다.

백업 및 복원은 사용하는 볼륨 플러그인에 따라 다릅니다. 다양한 도구 및 메커니즘을 통해 볼륨을 백업 또는 복원할 수 있습니다.

Kubernetes는 [VolumeSnapshot, VolumeSnapshotContent, Restore](https://kubernetes-csi.github.io/docs/snapshot-restore-feature.html#snapshot--restore-feature) 옵션을 제공합니다. 관리자가 프로비저닝하는 [클러스터의 볼륨](https://kubernetes.io/docs/concepts/storage/volume-snapshots/#introduction)에 대한 사본을 가져올 수 있습니다.

스냅샷 기능을 테스트하기 위해 다양한 [예제 yaml 파일](https://github.com/kubernetes-csi/external-snapshotter/tree/master/examples/kubernetes)을 Kubernetes 문서에서 사용할 수 있습니다.

또한 [AppsCode Stash](https://appscode.com/products/kubed/0.9.0/guides/disaster-recovery/stash/)와 같은 다른 도구를 사용하여 볼륨을 백업하고 동일한 볼륨을 복원할 수 있습니다.
