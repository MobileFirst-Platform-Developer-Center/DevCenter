---
layout: tutorial
title: Push Notification Messages
breadcrumb_title: Push Notifications
relevantTo: [ios,android,cordova]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
{: #overview }
Find information about error messages encountered while working with JSONStore in mobile applications.


## List of error codes
{: #list-of-error-codes }
List of common error codes and their description:

|Error Code      | Description |
|----------------|-------------|
| -100 UNKNOWN_FAILURE | Unrecognized error. |
| -75 OS\_SECURITY\_FAILURE | This error code is related to the requireOperatingSystemSecurity flag. It can occur if the destroy API fails to remove security metadata that is protected by operating system security (Touch ID with passcode fallback), or the init or open APIs are unable to locate the security metadata. It can also fail if the device does not support operating system security, but operating system security usage was requested. |
| -50 PERSISTENT\_STORE\_NOT\_OPEN | JSONStore is closed. Try calling the open method in the JSONStore class class first to enable access to the store. |
| -48 TRANSACTION\_FAILURE\_DURING\_ROLLBACK | There was a problem with rolling back the transaction. |
| -47 TRANSACTION\\_FAILURE\_DURING\_REMOVE\_COLLECTION |Cannot call removeCollection while a transaction is in progress. |
| -46 TRANSACTION\_FAILURE\_DURING\_DESTROY | Cannot call destroy while there are transactions in progress. |
| -45 TRANSACTION\_FAILURE\_DURING\_CLOSE\_ALL | Cannot call closeAll while there are transactions in place. |
| -44 TRANSACTION\_FAILURE\_DURING\_INIT | Cannot initialize a store while there are transactions in progress. |
| -43 TRANSACTION_FAILURE | There was a problem with transactions. |
| -42 NO\_TRANSACTION\_IN\_PROGRESS | Cannot commit to rolled back a transaction when there is no transaction is progress |
| -41 TRANSACTION\_IN\_POGRESS | Cannot start a new transaction while another transaction is in progress. |
| -40 FIPS\_ENABLEMENT\_FAILURE |Something is wrong with FIPS. |
| -24 JSON\_STORE\_FILE\_INFO\_ERROR | Problem getting the file information from the file system. |
| -23 JSON\_STORE\_REPLACE\_DOCUMENTS\_FAILURE | Problem replacing documents from a collection. |
| -22 JSON\_STORE\_REMOVE\_WITH\_QUERIES\_FAILURE | Problem removing documents from a collection. |
| -21 JSON\_STORE\_STORE\_DATA\_PROTECTION\_KEY\_FAILURE | Problem storing the Data Protection Key (DPK). |
| -20 JSON\_STORE\_INVALID\_JSON\_STRUCTURE | Problem indexing input data. |
| -12 INVALID\_SEARCH\_FIELD\_TYPES | Check that the types that you are passing to the searchFields are stringinteger,number, orboolean. |
| -11 OPERATION\_FAILED\_ON\_SPECIFIC\_DOCUMENT | An operation on an array of documents, for example the replace method can fail while it works with a specific document. The document that failed is returned and the transaction is rolled back. On Android, this error also occurs when trying to use JSONStore on unsupported architectures. |
| -10 ACCEPT\_CONDITION\_FAILED | The accept function that the user provided returned false. |
| -9 OFFSET\_WITHOUT\_LIMIT | To use offset, you must also specify a limit. |
| -8 INVALID\_LIMIT\_OR\_OFFSET | Validation error, must be a positive integer. |
| -7 INVALID_USERNAME | Validation error (Must be [A-Z] or [a-z] or [0-9] only). |
| -6 USERNAME\_MISMATCH\_DETECTED | To log out, a JSONStore user must call the closeAll method first. There can be only one user at a time. |
| -5 DESTROY\_REMOVE\_PERSISTENT\_STORE\_FAILED |A problem with the destroy method while it tried to delete the file that holds the contents of the store. |
| -4 DESTROY\_REMOVE\_KEYS\_FAILED | Problem with the destroy method while it tried to clear the keychain (iOS) or shared user preferences (Android). |
| -3 INVALID\_KEY\_ON\_PROVISION | Passed the wrong password to an encrypted store. |
| -2 PROVISION\_TABLE\_SEARCH\_FIELDS\_MISMATCH | Search fields are not dynamic. It is not possible to change search fields without calling the destroy method or the removeCollection method before you call the init or openmethod with the new search fields. This error can occur if you change the name or type of the search field. For example: {key: 'string'} to {key: 'number'} or {myKey: 'string'} to {theKey: 'string'}. |
| -1 PERSISTENT\_STORE\_FAILURE | Generic Error. A malfunction in native code, most likely calling the init method. |
| 0 SUCCESS | In some cases, JSONStore native code returns 0 to indicate success. |
| 1 BAD\_PARAMETER\_EXPECTED\_INT | Validation error. |
| 2 BAD\_PARAMETER\_EXPECTED\_STRING | Validation error. |
| 3 BAD\_PARAMETER\_EXPECTED\_FUNCTION | Validation error. |
| 4 BAD\_PARAMETER\_EXPECTED\_ALPHANUMERIC\_STRING | Validation error. |
| 5 BAD\_PARAMETER\_EXPECTED\_OBJECT | Validation error. |
| 6 BAD\_PARAMETER\_EXPECTED\_SIMPLE\_OBJECT | Validation error. |
| 7 BAD\_PARAMETER\_EXPECTED\_DOCUMENT | Validation error. |
| 8 FAILED\_TO\_GET\_UNPUSHED\_DOCUMENTS\_FROM\_DB |The query that selects all documents that are marked dirty failed. An example in SQL of the query would be: SELECT * FROM [collection] WHERE _dirty > 0. |
| 9 NO\_ADAPTER\_LINKED\_TO\_COLLECTION | To use functions like the push and load methods in the JSONStoreCollection class, an adapter must be passed to the init method. |
| 10 BAD\_PARAMETER\_EXPECTED\_DOCUMENT\_OR\_ARRAY\_OF\_DOCUMENTS | Validation error |
| 11 INVALID\_PASSWORD\_EXPECTED\_ALPHANUMERIC\_STRING\_WITH\_LENGTH\_GREATER\_THAN\_ZERO | Validation error |
| 12 ADAPTER_FAILURE | Problem calling WL.Client.invokeProcedure, specifically a problem in connecting to the adapter. This error is different from a failure in the adapter that tries to call a backend. |
| 13 BAD\_PARAMETER\_EXPECTED\_DOCUMENT\_OR\_ID | Validation error |
| 14 CAN\_NOT\_REPLACE\_DEFAULT\_FUNCTIONS | Calling the enhance method in the JSONStoreCollection class to replace an existing function (find and add) is not allowed. |
| 15 COULD\_NOT\_MARK\_DOCUMENT\_PUSHED | Push sends the document to an adapter but JSONStore fails to mark the document as not dirty. |
| 16 COULD\_NOT\_GET\_SECURE\_KEY | To initiate a collection with a password there must be connectivity to the {{ site.data.keys.mf_server }} because it returns a 'secure random token'. IBM  Worklight  V5.0.6 and later allows developers to generate the secure random token locally passing {localKeyGen: true} to the init method via the options object. |
| 17 FAILED\_TO\_LOAD\_INITIAL\_DATA\_FROM\_ADAPTER | Could not load data because WL.Client.invokeProcedure called the failure callback. |
| 18 FAILED\_TO\_LOAD\_INITIAL\_DATA\_FROM\_ADAPTER\_INVALID\_LOAD\_OBJ | The load object that was passed to the init method did not pass the validation. |
| 19 INVALID\_KEY\_IN\_LOAD\_OBJECT | There is a problem with the key used in the load object when you call the add method. |
| 20 UNDEFINED\_PUSH\_OPERATION | No procedure is defined for pushing dirty documents to the server. For example: the init method (new document is dirty, operation = 'add') and the push method (finds the new document with operation = 'add') were called, but no add key with the add procedure was found in the adapter that is linked to the collection. Linking an adapter is done inside the init method. |
| 21 INVALID\_ADD\_INDEX\_KEY | Problem with extra search fields. |
| 22 INVALID\_SEARCH\_FIELD | One of your search fields is invalid. Verify that none of the search fields that are passed in are _id,json,_deleted, or _operation. |
| 23 ERROR\_CLOSING\_ALL | Generic Error. An error occurred when native code called the closeAll method. |
| 24 ERROR\_CHANGING\_PASSWORD | Unable to change the password. The old password passed was wrong, for example. |
| 25 ERROR\_DURING\_DESTROY | Generic Error. An error occurred when native code called the destroy method. |
| 26 ERROR\_CLEARING\_COLLECTION | Generic Error. An error occurred in when native code called the removeCollection method. |
| 27 INVALID\_PARAMETER\_FOR\_FIND\_BY\_ID | Validation error. |
| 28 INVALID\_SORT\_OBJECT | The provided array for sorting is invalid because one of the JSON objects is invalid. The correct syntax is an array of JSON objects, where each object contains only a single property. This property searches the field with which to sort, and whether it is ascending or descending. For example: {searchField1 : "ASC"}. |
| 29 INVALID\_FILTER\_ARRAY | The provided array for filtering the results is invalid. The correct syntax for this array is an array of strings, in which each string is either a search field or an internal JSONStore field. For more information, see Store internals. |
| 30 BAD\_PARAMETER\_EXPECTED\_ARRAY\_OF\_OBJECTS | Validation error when the array is not an array of only JSON objects. |
| 31 BAD\_PARAMETER\_EXPECTED\_ARRAY\_OF\_CLEAN\_DOCUMENTS | Validation error. |
| 32 BAD\_PARAMETER\_WRONG\_SEARCH\_CRITERIA | Validation error. |
