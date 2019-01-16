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
Database is required to store the data required for the running of Mobile Foundation applications. See [here](https://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.installconfig.doc/admin/r_internal_ibm_worklight_database_tables.html), for more information on the database tables used by Mobile Foundation server.

Mobile Foundation runtime transactions like device registration, app registration, security checks, and OAuth flow update two tables, which are *MFP_PERSISTENT_DATA* and *MFP_TRANSIENT_DATA*.

*MFP_TRANSIENT_DATA* stores the application transactions, security checks and their security states, including the expiry time of the security states. *MFP_PERSISTENT_DATA* holds the device to application relations, application access time in the device and maintains the version informations of the applications.

Data in *MFP_TRANSIENT_DATA* table is deleted upon successful logout and on the expiry of security checks when the same application is accessed again. Similarly, the *MFP_PERSISTENT_DATA* entries also gets updated during a proper app upgrade.
However, due to different reasons like incorrect usage of application or while doing an application delete and install instead of app upgrade, stale entries gets accumulated in the table and this can cause performance issues over time.

Mobile Foundation runs a daily job, which currently takes care of tracking, archiving, decommissioning and deleting records for customers who use [license tracking](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/administering-apps/license-tracking/) feature.
This is controlled by the flags for license tracking and device decommissioning. License tracking is enabled by default. See [here](https://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.installconfig.doc/admin/r_JNDI_entries_for_production.html), for more information.

For customers who do not use license tracking, there is a possibility of accumulation of stale records in the above mentioned tables.

The Mobile Foundation job is now enhanced to take care of archiving and deleting expired records from the tables, for those who do not enable license tracking.

This feature is driven by two new JNDI properties:
* **mfp.purgedata.enabled:**
    When this property is enabled, expired records from *MFP_TRANSIENT_DATA*  and *MFP_PERSISTENT_DATA* is deleted. Default value is true.
* **mfp.purgeOldData.age:**
    When this property is set to any non negative integer value, records from  *MFP_PERSISTENT_DATA* with last_activity_time field value prior to the given number of days is removed from the table. The records are archived into MobileFirst Server `home\devices_archive` directory.  Default value for this property is 0 and the recommended value for this is a number bigger than 90 days. Setting the number of days to less than 90 may cause active applications to go for re registration and can change client id.

By default, when the customer is at the following iFix level, runtime deletes all stale records of *MFP_TRANSIENT_DATA*. However, delete of records in *MFP_PERSISTENT_DATA* is enabled only if `mfp.purgeOldData.age` is set by customer.

This feature is available from [iFix 8.0.0.0-MFPF-IF201810040631](https://mobilefirstplatform.ibmcloud.com/blog/2018/05/18/8-0-master-ifix-release/).
<!--This feature has a dependency on SDK fix level.-->

The number of expired records in the tables may be very high and enabling the feature may cause the queries to run for a long time. The job is triggered after 1 AM of server local time. The job is scheduled to start a few random minutes after 1 AM and is limited to run for a maximum of one hour. Any transaction during this time may face a delay. To avoid this, we recommend that the customer does an initial clean up of the tables before using this feature. This will ensure the job runs only for a few seconds or minutes and that there is minimal impact to any transaction.

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

>For IBM Cloud Private (ICP) customers, to enable JNDI properties, follow the ICP documentation for [jndiConfigurations](https://mobilefirstplatform.ibmcloud.com/tutorials/it/foundation/8.0/bluemix/mobilefirst-server-on-icp/#env-mf-server).
