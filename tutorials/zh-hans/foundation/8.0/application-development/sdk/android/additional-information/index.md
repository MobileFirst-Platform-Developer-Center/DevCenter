---
layout: tutorial
title: 其他信息
breadcrumb_title: 其他信息
relevantTo: [android]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
### 将 Javadocs 注册到 Android Studio Gradle 项目
{: #registering-javadocs-to-an-android-studio-gradle-project }
{{ site.data.keys.product_adj }} Android Javadocs 包含在 Gradle 导入的 *.aar 文件中。但是，您必须将其链接到 Android Studio 中的相关库。

1. 在 Android Studio 中，确保您位于**项目**视图中。
2. 在**外部库**节点下查找库名（Javadoc 文件显示在该节点下）。
3. 右键单击库名并选择**库属性**。
4. 从“库属性”对话框中选择“+”按钮
5. 浏览至 **..\app\build\intermediates\exploded-aar\ibmmobilefirstplatformfoundation\jars\assets** 下已下载的 Javadoc JAR 文件 (**ibmmobilefirstplatformfoundation-javadoc.jar**) 并选择该文件。
6. 单击**确定**。Javadocs 现在将在您的项目中可用。

### 注意
{: #notes }

* 无法在 Android 服务中激活 {{ site.data.keys.product_adj }} API。
