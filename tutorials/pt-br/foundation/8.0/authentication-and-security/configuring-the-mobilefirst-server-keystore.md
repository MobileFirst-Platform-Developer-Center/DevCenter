---
layout: tutorial
title: Configuring the MobileFirst Server Keystore
breadcrumb_title: Configuring the Server Keystore
weight: 14
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
A keystore is a repository of security keys and certificates that is used to verify and authenticate the validity of parties involved in a network transaction. The {{ site.data.keys.mf_server }} keystore defines the identity of {{ site.data.keys.mf_server }} instances, and is used to digitally sign OAuth tokens and Direct Update packages. In addition, when an adapter communicates with a back-end server using mutual HTTPS (SSL) authentication, the keystore is used to validate the SSL-client identity of the {{ site.data.keys.mf_server }} instance.

For production-level security, during the move from development to production the administrator must configure {{ site.data.keys.mf_server }} to use a user-defined keystore. The default {{ site.data.keys.mf_server }} keystore is intended to be used only during development.

### Notes
{: #notes }
* To use the keystore to verify the authenticity of a Direct Update package, statically bind the application with the public key of the {{ site.data.keys.mf_server }} identity that is defined in the keystore. See [Implementing secure Direct Update on the client side](../../application-development/direct-update).
* Reconfiguring the {{ site.data.keys.mf_server }} keystore after production should be considered carefully. Changing the configuration has the following potential effects:
    * The client might need to acquire a new OAuth token in place of a token signed with the previous keystore. In most cases, this process is transparent to the application.
    * If the client application is bound to a public key that does not match the {{ site.data.keys.mf_server }} identity in the new keystore configuration, Direct Update fails. To continue getting updates, bind the application with the new public key, and republish the application. Alternatively, change the keystore configuration again to match the public key to which the application is bound. See [Implementing secure Direct Update on the client side](../../application-development/direct-update).
    *  For mutual SSL authentication, if the SSL-client identity alias and password that are configured in the adapter are not found in the new keystore, or do not match the SSL certifications, SSL authentication fails. See the adapter configuration information in Step 2 of the following procedure.

## Setup
{: #setup }
1. Create a Java keystore (JKS) or PKCS 12 keystore file with an alias that contains a key pair that defines the identity of your {{ site.data.keys.mf_server }}. If you already have an appropriate keystore file, skip to the next step.

   > **Note:** The type of the alias key-pair algorithm must be RSA. The following instructions explain how to set the algorithm type to RSA when using the **keytool** utility.

   You can use a third-party tool to create the keystore file. For example, you can generate a JKS keystore file by running the Java **keytool** utility with the following command (where `<keystore name>` is the name of your keystore and `<alias name>` is your selected alias):

   ```bash
   keytool -keystore <keystore name> -genkey -alias <alias name> -keylag RSA
   ```

   The following sample command generates a **my_company.keystore** JKS file with a `my_alias` alias:

   ```bash
   keytool -keystore my_company.keystore -genkey -alias my_alias -keyalg RSA
   ```

   The utility prompts you to provide different input parameters, including the passwords for your keystore file and alias.

   > **Note:** You must set the `-keyalg RSA` option to set the type of the generated key algorithm to RSA instead of the default DSA.

   To use the keystore for mutual SSL authentication between an adapter and a back-end server, also add a {{ site.data.keys.product }} SSL-client identity alias to the keystore. You can do this by using the same method that you used to create the keystore file with the {{ site.data.keys.mf_server }} identity alias, but provide instead the alias and password for the SSL-client identity.

2. Configure {{ site.data.keys.mf_server }} to use your keystore:
   Follow the steps below to configure {{ site.data.keys.mf_server }} to use your keystore:

      * **Javascript adapter**
        In the {{ site.data.keys.mf_console }} navigation sidebar, select **Runtime Settings**, and then select the **Keystore** tab. Follow the instructions on this tab to configure your user-defined {{ site.data.keys.mf_server }} keystore. The steps include uploading your keystore file, indicating its type and providing your keystore password, the name of your {{ site.data.keys.mf_server }} identity alias, and the alias password.
        When configured successfully, the **Status** changes to *User Defined*, else an error is displayed and the status remains *Default*.
        The SSL-client identity alias (if used) and its password are configured in the descriptor file of the relevant adapter, within the `<sslCertificateAlias>` and `<sslCertificatePassword>` subelements of the `<connectionPolicy>` element. See [HTTP adapter connectionPolicy element](../../adapters/javascript-adapters/js-http-adapter/#the-xml-file).

      * **Java adapter**
        To configure mutual SSL authentication for Java adapter the server's keystore needs to be updated. This can be done by following the steps below:

        * Copy the keystore file to `<ServerInstallation>/mfp-server/usr/servers/mfp/resources/security`

        * Edit `server.xml` file `<ServerInstallation>/mfp-server/usr/servers/mfp/server.xml`.

        * Update the keysore configuration with the right file name, password and type
        `<keyStore id=“defaultKeyStore” location=<Keystore name> password=<Keystore password> type=<Keystore type> />`

If you are deploying using {{ site.data.keys.mf_bm_short}} service on Bluemix, you can upload the keystore file under **Advanced settings** before deploying the server.
