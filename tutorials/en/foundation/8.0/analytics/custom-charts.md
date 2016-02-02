---
title: Creating Custom Charts
---
### Creating Custom Charts
Creating a custom chart is simple. The following example walks you through creating a pie chart, based on the user pressing three buttons.

The messages that are logged to the Operational Analytics server in this example are hard-coded buttons. Those messages look like this:

```javascript
WL.Analytics.log({buttonPress: "buttonA"}, "press");
WL.Analytics.log({buttonPress: "buttonB"}, "press");
WL.Analytics.log({buttonPress: "buttonC"}, "press");
```

> **Note**: Remember to always send data to the analytics server by using `WL.Analytics.send();`

To create a chart, follow these steps.

1. Go to the **Custom Charts** tab

       <img src="{{ site.baseurl }}/assets/backup/custom-chart-1-1024x275.png" alt="Create Custom Chart" style="max-width:100%!important;" class="aligncenter size-large wp-image-15081" />

2. click **Create Chart**.

       <img src="{{ site.baseurl }}/assets/backup/custom-chart-2-1024x713.png" alt="custom-chart-2" style="max-width:100%!important;" class="aligncenter size-large wp-image-15082" />

3. Enter a **Chart Title**

4. Select **Custom Data** as the **Event Type**

5. Select a **Chart Type**. This example uses a **Pie Chart**.

       <img src="{{ site.baseurl }}/assets/backup/custom-chart-type-1024x627.png" alt="custom-chart-type" width="980" height="600" class="aligncenter size-large wp-image-15090" />

6. Click on the **Chart Definition** tab.

       <img src="{{ site.baseurl }}/assets/backup/custom-chart-3-e1437662521800-1024x404.png" alt="custom-chart-3" style="max-width:100%!important;" class="aligncenter size-large wp-image-15083" />

7. Select a **Property**. This example uses ```buttonPress```.

       <img src="{{ site.baseurl }}/assets/backup/custom-chart-4-1024x693.png" alt="custom-chart-4" style="max-width:100%!important;" class="aligncenter size-large wp-image-15084" />

8. Click **Save**. The chart is saved under the **Custom Charts** tab in the main dashboard.

       <img src="{{ site.baseurl }}/assets/backup/custom-chart-5-1024x642.png" alt="custom-chart-5" style="max-width:100%!important;" class="aligncenter size-large wp-image-15085" />
