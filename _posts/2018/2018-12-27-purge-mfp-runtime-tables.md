---
title: Purge and archive Mobile Foundation runtime tables
date: 2018-12-27
version:
- 8.0
tags:
- MobileFirst_Foundation
- Runtime_Tables
- Purge
- Archive
author:
  name: Smitha TV
---
Mobile Foundation runtime supports relational databases such as IBM DB2, Oracle and MySQL.
Database is required to store the data required for the running of Mobile Foundation applications. See [Internal runtime databases](https://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.installconfig.doc/admin/r_internal_ibm_worklight_database_tables.html), for more information on the database tables used by Mobile Foundation server.

Mobile Foundation runtime transactions like device registration, app registration, security checks, and OAuth flow update two tables, which are *MFP_PERSISTENT_DATA* and *MFP_TRANSIENT_DATA*.

*MFP_TRANSIENT_DATA* stores the application transactions, security checks and their security states, including the expiry time of the security states. *MFP_PERSISTENT_DATA* holds the device to application relations, application access time in the device and maintains the version informations of the applications.

Mobile Foundation runs a daily job, which currently takes care of tracking, archiving, decommissioning and deleting records for customers who use [license tracking](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/administering-apps/license-tracking/) feature.
This is controlled by the flags for license tracking and device decommissioning. License tracking is enabled by default. See [List of JNDI properties for MobileFirst runtime](https://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.installconfig.doc/admin/r_JNDI_entries_for_production.html), for more information.

For customers who do not use license tracking, there is a possibility of accumulation of stale records in the above mentioned tables.

The Mobile Foundation job is now enhanced to take care of archiving and deleting expired records from the tables, for those who do not enable license tracking.

This feature is driven by two new JNDI properties:

<blockquote>
<h4>mfp.purgedata.enabled:</h4>
    When this property is enabled, expired records from <b>MFP_TRANSIENT_DATA</b> and <b>MFP_PERSISTENT_DATA</b> is deleted. Default value is true.
<h4>mfp.purgeOldData.age:</h4>
    When this property is set to a value greater than 0, records from <b>MFP_PERSISTENT_DATA</b> with last_activity_time field value prior to the given number of days is removed from the table. The records are archived into MobileFirst Server <filepath>home\devices_archive</filepath> directory. Customers are not recommended to have this property value less than 90. Default value: 0.
</blockquote>

By default, for customers who do not use license tracking and are at MobileFirst iFix Level *8.0.0.0-MFPF-IF201812191602-CDUpdate-04* or above, runtime deletes all stale records of MFP_TRANSIENT_DATA.  Enabling mfp.purgeOldData.age for deleting records from MFP_PERSISTENT_DATA has dependency on SDK level iFix *8.0.0.0-MFPF-IF201810040631*. Customer's  MobileFirst plugin `cordova-plugin-mfp` version needs to be at this iFix level or  higher than this iFix level.

>The feature and jndi properties discussed here is applicable only for customers who have not enabled license tracking.


The number of expired records in the tables may be very high and enabling the feature may cause the queries to run for a long time. To avoid this, we recommend that the customer does an initial clean up of the tables before using this feature. This will ensure that the job runs only for a few seconds or minutes and that there is minimal impact to any transaction.

The delete query for MFP_TRANSIENT_DATA will be modified to show 5 days instead of 1 day.

>**Warning:** When old records from MFP_PERSISTENT_DATA are deleted, users who got deleted will need to re-register their applications. If the application is using custom attributes, this may result in losing these attributes. During registration, the application logic will need to take care of adding these attributes.

For the initial clean up, connect to Mobile Foundation runtime database.

**MFP_PERSISTENT_DATA table**:<br/>
Choose the number of days of records that needs to be persisted. See the date corresponding to this and get the timestamp of this date. All records with *LAST_ACTIVITY_TIME* less than this will be deleted from *MFP_PERSISTENT_DATA* with the following query:

```sql
select * from MFPDATA.MFP_PERSISTENT_DATA where last_activity_time < <timestamp of the day of purge>
```

Back up the selected records in case it is needed.
```sql
delete from MFPDATA.MFP_PERSISTENT_DATA where last_activity_time < <timestamp of the day of purge>
```

For example,
Consider today’s date is December 19, 2018 and data for last 100 days need to be retained.
100 days before this date will be September 10, 2018
Timestamp corresponding to September 10, 2018 1AM: 1536714000000
Queries for the above sample data is as below:

```sql
select * from MFPDATA.MFP_PERSISTENT_DATA where LAST_ACTIVITY_TIME < 1536714000000
delete from MFPDATA.MFP_PERSISTENT_DATA where LAST_ACTIVITY_TIME < 1536714000000
```

**MFP_TRANSIENT_DATA table**:<br/>
Any record with an *EXPIRESAT* less than current time is a stale record in this table.
Get the timestamp corresponding to the current day's starting hour ( This is to avoid any JVM and DB time mismatch. Make sure you are deleting only records prior to current time of server).

```sql
delete from MFP_TRANSIENT_DATA where expiresat < <timestamp for current day 12 AM>
```

For example,
Consider today’s date is December 19, 2018.
Time in millis for 12 AM today is 1545177600000

```sql
delete from MFP_TRANSIENT_DATA where EXPIRESAT < 1545177600000
```

>For IBM Cloud Private (ICP) customers, to enable JNDI properties, follow the ICP documentation for [jndiConfigurations](https://mobilefirstplatform.ibmcloud.com/tutorials/it/foundation/8.0/ibmcloud/mobilefirst-server-on-icp/#env-mf-server).
