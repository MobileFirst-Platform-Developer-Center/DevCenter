---
title: Announcing Mobile Foundation Migration Studio
date: 2020-04-23
tags:
- MobileFirst_Platform
- Mobile_Foundation
- Migration
version:
- 8.0
author:
  name: Krishnakumar Balachandar
---

We have a great news to share with our MobileFirst Platform Foundation v7.1 customers. Today, we are happy to announce the release of Mobile Foundation Migration Studio. Migration Studio tremendously eases the MobileFirst Platform Foundation v7.1 hybrid applications to Mobile Foundation v8.0 migration effort. Migration Studio is an all too familiar Eclipse plugin very similar to the MobileFirst Platform Foundation v7.1 Studio plugin.

> [Download Mobile Foundation Migration Studio](https://github.com/MobileFirst-Platform-Developer-Center/Mobile-Foundation-Migration-Studio/releases/download/20200421-1300/Mobile-Foundation-Migration-Studio-20200421-1300.zip).

Import your existing v7.1 hybrid projects into the Migration Studio to turn them into augmented new apps on Mobile Foundation v8.0. You can read more about the Migration Studio in our [documentation]({{site.baseurl}}/tutorials/en/foundation/8.0/upgrading/migration-studio/).
Currently, the Migration Studio supports the migration of apps for the Android, iPhone and iPad environments. When imported and built using the Migration Studio, existing v7.1 hybrid apps will be upgraded in-place to v8.0 SDKs while retaining the legacy hybrid structure of the project. The new apps will then be able to connect to an instance of Mobile Foundation v8.0 server.

**What about the server artifacts?**

That's definitely the next obvious question. The [*mfpmigrate* CLI](https://www.npmjs.com/package/mfpmigrate-cli) has been improved to automatically migrate existing v7.1 adapters to v8.0 adapters. This includes the following.
* Migrating Java and JavaScript adapters.
* Converting your existing authentication & login modules to v8.0 Security Check adapters.

With the Migration Studio and improved *mfpmigrate* CLI, we have lowered the barrier to entry for customers wanting to migrate from v7.1 to Mobile Foundation v8.0. You no longer have to rewrite your app, which eliminates a major portion of cost & effort incurred in the migration process.

Have a question, comment, feedback, or feature request? We are listening, open an issue [here](https://github.com/MobileFirst-Platform-Developer-Center/Mobile-Foundation-Migration-Studio/issues).
