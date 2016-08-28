---
layout: tutorial
title: Accessibility features for IBM MobileFirst Foundation
breadcrumb_title: Accessibility features
weight: 6
---
<br/>
Accessibility features assist users who have a disability, such as restricted mobility or limited vision, to use information technology content successfully.

### Accessibility features
IBM MobileFirst Foundation includes the following major accessibility features:

* Keyboard-only operation
* Operations that support the use of a screen reader

IBM MobileFirst Foundation uses the latest W3C Standard, [WAI-ARIA 1.0](http://www.w3.org/TR/wai-aria/) to ensure compliance to [US Section 508](http://www.access-board.gov/guidelines-and-standards/communications-and-it/about-the-section-508-standards/section-508-standards), and [Web Content Accessibility Guidelines (WCAG) 2.0](http://www.w3.org/TR/WCAG20/). To take advantage of accessibility features, use the latest release of your screen reader in combination with the latest web browser that is supported by this product.

### Keyboard navigation
This product uses standard navigation keys.

### Interface information
The IBM MobileFirst Foundation user interfaces do not have content that flashes 2 - 55 times per second.

You can use a screen reader with a digital speech synthesizer to hear what is displayed on your screen. Consult the documentation with your assistive technology for details about how to use it with this product and its documentation.

### MobileFirst CLI
By default, status messages that are displayed by the MobileFirst CLI use various colors to indicate success, errors, and warnings. You can use the `--no-color` option on any MobileFirst CLI command to suppress the use of these colors for that command. When `--no-color` is specified, output is displayed in the text display colors that are set for your operating system console.

### Web interface
The IBM MobileFirst Foundation web user interfaces rely on cascading style sheets to render content properly and to provide a usable experience. The application provides an equivalent way for low-vision users to use a users system display settings, including high-contrast mode. You can control font size by using the device or web browser settings.

You can navigate through the different MobileFirst environments and their documentation by using keyboard shortcuts. Eclipse provides accessibility features for its development environments. Internet browsers also provide accessibility features for web applications, such as the IBM MobileFirst Operations Console, the IBM MobileFirst Analytics Console, the IBM MobileFirst Application Center console, and the IBM MobileFirst Application Center mobile client.

The IBM MobileFirst Foundation web user interface includes WAI-ARIA navigational landmarks that you can use to quickly navigate to functional areas in the application.

### Installation and configuration
There are two ways to install and configure IBM MobileFirst Foundation: by graphical user interface (GUI), or by command-line.

Although the graphical user interface (IBM Installation Manager in wizard mode or Server Configuration Tool) does not provide information about user interface objects, equivalent function is available with the command-line interface. All the functions in the GUI are supported through the command-line, and some particular installation and configuration features are only available with the command-line. You can read about the accessibility features of [IBM Installation Manager](http://www.ibm.com/support/knowledgecenter/SSDV2W/im_family_welcome.html?lang=en&view=kc) in the IBM Knowledge Center.

The following topics provide you with the information on how the installation and configuration can be done without GUI:

* Working with sample response files for IBM Installation Manager
This method enables silent installation and configuration of MobileFirst Server and Application Center. You have the possibility to not install Application Center by using the response file named install-no-appcenter.xml. You can then use Ant task to install it at a later stage. See Installing the Application Center with Ant tasks. In this case, the installation and the upgrading of Application Center can be done independently.
* Installing with Ant Tasks
* Installing the Application Center with Ant tasks

### Vendor software
IBM MobileFirst Foundation includes certain vendor software that is not covered under the IBM license agreement. IBM makes no representation about the accessibility features of these products. Contact the vendor for the accessibility information about its products.

### Related accessibility information
In addition to standard IBM help desk and support websites, IBM has established a TTY telephone service for use by deaf or hard of hearing customers to access sales and support services:

TTY service  
800-IBM-3383 (800-426-3383)  
(within North America)

### IBM and accessibility
For more information about the commitment that IBM has to accessibility, see [IBM Accessibility](http://www.ibm.com/able).


