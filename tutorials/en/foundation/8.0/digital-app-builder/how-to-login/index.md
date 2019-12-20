---
layout: tutorial
title: Adding a Login Form
weight: 9
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Adding a Login Form
{: #dab-login-form }

### Adding Login Form to your app in Design mode
{: #add-login-form-design-mode }

To add Login Form in your app, perform the following steps:

1. Make the following changes on Mobile Foundation Server
    * Deploy a security check adapter which would take username and password as input. You can use the sample adapter from [here](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80).
    * In the Mobile Foundation Operation console, go to app's security tab and under Mandatory Application Scope, add the above created security definition as scope element.
2. Make the following configuration in your App using the Builder.
    * Add **Login Form** control to a page in the canvas.
    * In **Properties** tab, provide the **Security check name** and the page to navigate **On Login Success**.
    * Run the app.
