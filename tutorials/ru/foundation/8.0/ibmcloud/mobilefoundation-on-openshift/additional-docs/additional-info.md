---
layout: tutorial
breadcrumb_title: Backup and recovery of Mobile Foundation Analytics data
title: Backup and recovery of Mobile Foundation Analytics data
weight: 1
show_in_nav: false
---
<!-- NLS_CHARSET=UTF-8 -->
## Backup and recovery of Mobile Foundation Analytics data
{: #backup-recovery-mf-analytics-data}

Mobile Foundation Analytics data is available as part of Kubernetes [PersistentVolume or PersistentVolumeClaim](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#introduction). You may be using one of the [volume plugins that Kubernetes offers](https://kubernetes.io/docs/concepts/storage/volumes/#types-of-volumes).

Backup and restore depends on the volume plugins that you use. There are different tools and mechanisms through which the volume can be backed up or restored.

Kubernetes provides [VolumeSnapshot, VolumeSnapshotContent and Restore](https://kubernetes-csi.github.io/docs/snapshot-restore-feature.html#snapshot--restore-feature) options. You may take a copy of the [volume in the cluster](https://kubernetes.io/docs/concepts/storage/volume-snapshots/#introduction) that has been provisioned by an administrator.

Various [example yaml files](https://github.com/kubernetes-csi/external-snapshotter/tree/master/examples/kubernetes) are available in the Kubernetes documentation to test the snapshot feature.

You may also leverage other tools like [AppsCode Stash](https://appscode.com/products/kubed/0.9.0/guides/disaster-recovery/stash/) to take a backup of the volume and restore the same.
