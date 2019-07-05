---
title: Addressing Security Scan Findings In Mobile Foundation Apps 
date: 2019-07-04
tags:
- MobileFirst_Platform
- MobileFirst_Foundation
- Android
- iOS
- Security Scan
- Vulnerability 
version:
- 7.1
- 8.0
author:
  name: Manjunath Kallannavar
additional_authors :  
  - Srihari Kulkarni
---

Most organizations mandate mobile apps to undergo code scanning and pen tests before they can be uploaded to public app stores. This post is aimed to be a primer for app developers in resolving some of the commonly reported findings of such scan results. Given below is a non-comprehensive list of some such findings reported against Mobile Foundation SDKs. 

<table border="0" cellpadding="0" cellspacing="0" id="sheet0" class="sheet0 gridlines">
        <col class="col0">
        <col class="col1">
        <col class="col2">
        <col class="col3">
        <col class="col4">
        <tbody>
          <tr class="row0">
            <td class="column0 style1 s"><b>CWE ID</b></td>
            <td class="column1 style1 s">  <b>Vulnerability Description</b></td>
            <td class="column2 style2 s style3" colspan="2"> <b>File Name</b></td>
            <td class="column4 style4 s"><b>Remediation Action</b></td>
          </tr>
          <tr class="row1">
            <td class="column0 style5 s">&nbsp;<a href="https://cwe.mitre.org/data/definitions/117.html">117</a><br />
</td>
            <td class="column1 style5 s">Improper Output Neutralization for Logs <br />
</td>
            <td class="column2 style6 s style7" colspan="2">JSONStoreCollection.java </td>
            <td class="column4 style8 s">Install iFix 8.0.0.0-MFPF-IF201808131120
            or later. Fixed through APAR <a href="https://www-01.ibm.com/support/docview.wss?uid=swg1PI99443 ">PI99443</a>.</td>
          </tr>
          <tr class="row2">
            <td class="column0 style9 n style13" rowspan="5"><a href="https://cwe.mitre.org/data/definitions/259.html">259</a></td>
            <td class="column1 style9 s style13" rowspan="5">Use of Hard-coded Password</td>
            <td class="column2 style6 s style7" colspan="2">&nbsp;JSONStoreInitOptions.java </td>
            <td class="column4 style10 s">Initialise <a href="https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/jsonstore/android/#security">JSONStore collection </a>with password.</td>
          </tr>
          <tr class="row3">
            <td class="column2 style6 s style7" colspan="2">JSONStoreLogger.java  </td>
            <td class="column4 style10 s">This is a  false positive. The hard coded string is not a password.</td>
          </tr>
          <tr class="row4">
            <td class="column2 style6 s style7" colspan="2">AESStringEncryption.java </td>
            <td class="column4 style12 s">Install iFix 8.0.0.0-MFPF-IF201807180449-CDUpdate-02 or later. Fixed through APAR <a href="http://www-01.ibm.com/support/docview.wss?uid=swg1PI99445 ">PI99445</a>.</td>
          </tr>
          <tr class="row5">
            <td class="column2 style6 s style7" colspan="2">SecurityPlugin.java </td>
            <td class="column4 style10 s">This is  false positive. The hard coded string is not a password.</td>
          </tr>
          <tr class="row6">
            <td class="column2 style6 s style7" colspan="2">ProvisionActionDispatcher.java  </td>
            <td class="column4 style10 s">Initialise 
            <a href="https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/jsonstore/android/#security" >JSONStore collection </a> with password.</td>
          </tr>
          <tr class="row7">
            <td class="column0 style5 n"><a href="https://cwe.mitre.org/data/definitions/297.html">297</a></td>
            <td class="column1 style5 s">Improper Validation of Certificate with Host Mismatch </td>
            <td class="column2 style6 s style7" colspan="2">TLSEnabledSSLSocketFactory.java </td>
            <td class="column4 style14 s">Make use of <a href="https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/authentication-and-security/certificate-pinning/">Mobile Foundation certificate pinning feature.</a></td>
          </tr>
          <tr class="row8">
            <td class="column0 style5 n"><a href="https://cwe.mitre.org/data/definitions/326.html">326</a></td>
            <td class="column1 style5 s">Inadequate Encryption Strength </td>
            <td class="column2 style6 s style7" colspan="2">WLCertManager.java </td>
            <td class="column4 style15 s">This is a false positive. The key in question is used to sign a JWT token and uses a key size of 512 bytes per industry standards.</td>
          </tr>
          <tr class="row9">
            <td class="column0 style9 n style18" rowspan="2"><a href="https://cwe.mitre.org/data/definitions/331.html">331</a></td>
            <td class="column1 style9 s style18" rowspan="2">Insufficient Entropy </td>
            <td class="column2 style16 s style17" colspan="2">crypt.h </td>
            <td class="column4 style15 s">Install iFix 8.0.0.0-MFPF-IF201901311547 or later.</td>
          </tr>
          <tr class="row10">
            <td class="column2 style19 s style20" colspan="2">WLRequest.java </td>
            <td class="column4 style21 s">This is a false positive. The random number used in the code is not for any cryptographic operations.</td>
          </tr>
          <tr class="row11">
            <td class="column0 style22 n"><a href="https://cwe.mitre.org/data/definitions/321.html">321</a></td>
            <td class="column1 style22 s">Use of Hard-coded Cryptographic Key </td>
            <td class="column2 style19 s style20" colspan="2">SecurityUtils.java </td>
            <td class="column4 style15 s">This is a false positive. The key used in the code is for internal purpose and not used in  any of security codes.</td>
          </tr>
          <tr class="row12">
            <td class="column0 style23 n style26" rowspan="3"><a href="https://cwe.mitre.org/data/definitions/327.html">327</a></td>
            <td class="column1 style23 s style26" rowspan="3">Use of a Broken or Risky Cryptographic Algorithm </td>
            <td class="column2 style19 s style20" colspan="2">SecurityUtils.java </td>
            <td class="column4 style15 s">Install iFix 8.0.0.0-MFPF-IF201811050432-CDUpdate-03 or later. Fixed through APAR <a href=" http://www-01.ibm.com/support/docview.wss?uid=swg1PH03280 ">PH03280</a>.</td>
          </tr>
          <tr class="row13">
            <td class="column2 style19 s style20" colspan="2">AESStringEncryption.java </td>
            <td class="column4 style25 s">Install iFix 8.0.0.0-MFPF-IF201811050432-CDUpdate-03 or later. Fixed through APAR <a href=" http://www-01.ibm.com/support/docview.wss?uid=swg1PH03280">PH03280</a>.</td>
          </tr>
          <tr class="row14">
            <td class="column2 style19 s style20" colspan="2">HttpClientManager.java </td>
            <td class="column4 style15 s">This is a false positive. The message digest generated using SHA1 algorithm is not transmitted over the wire.</td>
          </tr>
        </tbody>
    </table>    
    
