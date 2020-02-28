---
layout: tutorial
title: Anmeldeformular hinzufügen
weight: 9
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Anmeldeformular hinzufügen
{: #dab-login-form }

### Anmeldeformular zur App im Entwurfsmodus hinzufügen
{: #add-login-form-design-mode }

Gehen Sie wie folgt vor, um ein Anmeldeformular zu Ihrer App hinzuzufügen:

1. Nehmen Sie die folgenden Änderungen in Mobile Foundation Server vor:
    * Implementieren Sie einen Adapter für Sicherheitsüberprüfungen, der einen Benutzernamen und ein Kennwort als Eingaben akzeptiert. Sie können den Beispieladapter von [hier](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80) verwenden.
    * Öffnen Sie in der Mobile Foundation Operations Console die Registerkarte "Sicherheit" für die App und fügen Sie unter "Obligatorischer Anwendungsbereich" die oben erstellte Sicherheitsdefinition als Bereichselement hinzu.
2. Konfigurieren Sie wie folgt Ihre App mit dem App Builder:
    * Fügen Sie zu einer Seite im Erstellungsbereich das Steuerelement **Anmeldung** (d. h. das Anmeldeformular) hinzu.
    * Geben Sie auf der Registerkarte **Eigenschaften** den **Namen der Sicherheitsüberprüfung** an sowie die Seite, zu der bei erfolgreicher Anmeldung navigiert werden soll.
    * Führen Sie die App aus.
