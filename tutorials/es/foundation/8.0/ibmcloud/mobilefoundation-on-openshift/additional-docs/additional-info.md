---
layout: tutorial
breadcrumb_title: Backup and recovery of Mobile Foundation Analytics data
title: Copia de seguridad y recuperación de datos de Mobile Foundation Analytics
weight: 1
show_in_nav: false
---
<!-- NLS_CHARSET=UTF-8 -->
## Copia de seguridad y recuperación de datos de Mobile Foundation Analytics
{: #backup-recovery-mf-analytics-data}

Los datos de Mobile Foundation Analytics están disponibles como parte de [PersistentVolume o PersistentVolumeClaim](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#introduction) de Kubernetes. Es posible que esté utilizando uno de los [plugins de volumen que ofrece Kubernetes](https://kubernetes.io/docs/concepts/storage/volumes/#types-of-volumes).

La copia de seguridad y la restauración depende de los plugins de volumen que utilice. Hay diferentes herramientas y mecanismos mediante los cuales puede realizar la copia de seguridad o restauración del volumen.

Kubernetes proporciona las opciones [VolumeSnapshot, VolumeSnapshotContent y Restore](https://kubernetes-csi.github.io/docs/snapshot-restore-feature.html#snapshot--restore-feature). Puede realizar una copia del [volumen del clúster](https://kubernetes.io/docs/concepts/storage/volume-snapshots/#introduction) suministrada por un administrador.

Existen varios [archivos yaml de ejemplo](https://github.com/kubernetes-csi/external-snapshotter/tree/master/examples/kubernetes) disponibles en la documentación de Kubernetes para probar la característica de instantánea.

También puede utilizar otras herramientas, como [AppsCode Stash](https://appscode.com/products/kubed/0.9.0/guides/disaster-recovery/stash/) para realizar la copia de seguridad y restauración del volumen. 
