---
layout: tutorial
title: Node.js 验证器
breadcrumb_title: Node.js 验证器
relevantTo: [android,ios,windows,javascript]
weight: 3
downloads:
  - name: 下载样本
    url: https://github.com/MobileFirst-Platform-Developer-Center/NodeJSValidator/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## 概述
{: #overview }
{{ site.data.keys.product_full }} 提供 Node.js 框架以对外部资源实施安全功能。  
提供了 Node.js 框架作为 npm 模块 (**passport-mfp-token-validation**)。

本教程显示如何使用作用域 (`accessRestricted`) 来保护简单 Node.js 资源 `GetBalance`。

**先决条件：**  

* 阅读[使用 {{ site.data.keys.mf_server }} 来认证外部资源](../)教程。
* 了解 [{{ site.data.keys.product }} 安全框架](../../)。

## passport-mfp-token-validation 模块
{: #the-passport-mfp-token-validation-module }
passport-mfp-token-validation 模块提供认证机制以验证 {{ site.data.keys.mf_server }} 发出的访问令牌。

要安装该模块，请运行：

```bash
npm install passport-mfp-token-validation@8.0.X
```

## 用法
{: #usage }
* 该样本使用 `express` 和 `passport-mfp-token-validation` 模块：

  ```javascript
  var express = require('express');
  var passport = require('passport-mfp-token-validation').Passport;
  var mfpStrategy = require('passport-mfp-token-validation').Strategy;
  ```

* 如下所示设置 `Strategy`：

  ```javascript
  passport.use(new mfpStrategy({
    authServerUrl: 'http://localhost:9080/mfp/api',
    confClientID: 'testclient',
    confClientPass: 'testclient',
    analytics: {
        onpremise: {
            url: 'http://localhost:9080/analytics-service/rest/v3',
            username: 'admin',
            password: 'admin'
        }
    }
  }));
  ```
  
 * `authServerUrl`：将 `localhost:9080` 替换为您的 {{ site.data.keys.mf_server }} IP 地址和端口号。
 * `confClientID` 和 `confClientPass`：将保密客户机标识和密码替换为在 {{ site.data.keys.mf_console }} 中定义的项。
 * `analytics`：分析项为可选，仅在想要将分析事件记录到 {{ site.data.keys.product }} 时才是必需的。  
 将 `localhost:9080`、`username` 和 `password` 替换为分析服务器 IP 地址、端口号、用户名和密码。

* 通过调用 `passport.authenticate` 来认证请求：

  ```javascript
  var app = express();
  app.use(passport.initialize());

  app.get('/getBalance', passport.authenticate('mobilefirst-strategy', {
      session: false,
      scope: 'accessRestricted'
  }),
  function(req, res) {
      res.send('17364.9');
  });

  var server = app.listen(3000, function() {
      var port = server.address().port
      console.log("Sample app listening at http://localhost:%s", port)
  });
  ```

 * 要采用的 `Strategy` 应当是 `mobilefirst-strategy`。
 * 将 `session` 设置为 `false`。
 * 指定 `scope` 名称。

## 样本应用程序 
{: #sample-application }
[下载 Node.js 样本](https://github.com/MobileFirst-Platform-Developer-Center/NodeJSValidator/tree/release80)。

### 样本用法
{: #sample-usage }
1. 导航至样本的根文件夹并运行命令：`npm install`，后跟：`npm start`。
2. 确保[更新保密客户机](../#confidential-client)和 {{ site.data.keys.mf_console }} 中的密钥值。
3. 部署安全性检查：**[UserLogin](../../user-authentication/security-check/)** 或 **[PinCodeAttempts](../../credentials-validation/security-check/)**。
4. 注册匹配应用程序。
5. 将 `accessRestricted` 作用域映射到安全性检查。
6. 更新客户机应用程序以针对 servlet URL 生成 `WLResourceRequest`。
