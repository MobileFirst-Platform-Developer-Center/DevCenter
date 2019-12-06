---
layout: tutorial
breadcrumb_title: Backup and recovery of Mobile Foundation Analytics data
title: Sicherung und Wiederherstellung von Mobile-Foundation-Analytics-Daten
weight: 1
show_in_nav: false
---
<!-- NLS_CHARSET=UTF-8 -->
## Sicherung und Wiederherstellung von Mobile-Foundation-Analytics-Daten
{: #backup-recovery-mf-analytics-data}

Mobile-Foundation-Analytics-Daten sind im Rahmen eines Kubernetes-[PV oder -PVC](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#introduction) verfügbar. Möglicherweise verwenden Sie eines der von [Kubernetes angebotenen Volume-Plug-ins](https://kubernetes.io/docs/concepts/storage/volumes/#types-of-volumes).

Sicherung und Wiederherstellung sind von den verwendeten Volume-Plug-ins abhängig. Es gibt verschiedene Tools und Mechanismen für die Sicherung oder Wiederherstellung des Dateträgers (Volume).

Kubernetes bietet die Optionen [VolumeSnapshot, VolumeSnapshotContent und Restore](https://kubernetes-csi.github.io/docs/snapshot-restore-feature.html#snapshot--restore-feature) an. Sie können eine Kopie des [Clusterdatenträgers](https://kubernetes.io/docs/concepts/storage/volume-snapshots/#introduction) erstellen, der von einem Administrator bereitgestellt wurde.

In der Kubernetes-Dokumentation sind mehrere [YAML-Beispieldateien](https://github.com/kubernetes-csi/external-snapshotter/tree/master/examples/kubernetes) verfügbar, um das Feature für Momentaufnahmen zu testen.

Sie können auch andere Tools wie [AppsCode Stash](https://appscode.com/products/kubed/0.9.0/guides/disaster-recovery/stash/) für die Sicherung und Wiederherstellung des Datenträgers nutzen.
