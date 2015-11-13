---
layout: tutorial
title: Hello World
weight: 0
show_children: true
show_disqus: false
---
Home for Hello World

Testing code blocks here:

{% highlight objective-c linenos %}
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  NSURL* url = [NSURL URLWithString:@"/adapters/MyAdapter/getFeed"];
  WLResourceRequest* request = [WLResourceRequest requestWithURL:url method:WLHttpMethodGet];
  [request setQueryParameterValue:@"['technology']" forName:@"params"];

  [request sendWithCompletionHandler:^(WLResponse *response, NSError *error) {
      if(error != nil){
           NSLog(@"%@",error.description);
      }
      else{
          NSLog(@"%@",response.responseJSON);
      }
  }];

  return YES;
}
{% endhighlight %}
