---
title: Using Watson Speech To Text with IBM MobileFirst Foundation 8.0
date: 2017-01-04
tags:
- MobileFirst_Foundation
- Cognitive
- Watson
version: 8.0
author:
  name: Mike Billau
---
## Overview
By this point you have heard of IBM's Watson, the Cognitive Computer that can do more than just win at Jeopardy! In this blog post, we will show how you can quickly and easily get started with using Watson services in your IBM MobileFirst Foundation hybrid application. This blog post is based on a new Lab (link) that uses a MobileFirst Java adapter to communicate with the [Watson Developer Cloud](http://www.ibm.com/watson/developercloud/) SDK to send an audio file over to the [Watson Speech to Text service](https://speech-to-text-demo.mybluemix.net/) and receive a transcript that we will use to quickly fill out a form.  The techniques in this lab can easily be adapted to use other Watson services that involve sending a chunk of data, such as the image recognition service. If at any point you get stuck, head on over to the Lab for a complete and working example.

## Recording audio with Cordova
The first thing that we need to do is augment our Cordova based hybrid application with the ability to record audio data. To do this, we can use the [Cordova media capture plugin](https://github.com/apache/cordova-plugin-media-capture). This will use the default recording application on a device to record an audio file and save it to the device. The audio file will be saved in whatever default format your device uses - for iOS, this is a *.wav* file, but for Android, it seems like this can vary between various *.oog* formats. To overcome this and achieve consistency, we decided to use a [third-party Cordova plugin](https://github.com/petrica/wav-recorder) to record in *.wav* format on Android. This may not strictly be necessary, as you will see, since you could convert the *.oog* format into whatever format you want on the server side with various Java libraries.

First, install the necessary Cordova plugins into your application:
```
cordova plugin add cordova-plugin-device
cordova plugin add cordova-plugin-media-capture
cordova plugin add https://github.com/petrica/wav-recorder.git
```

Perhaps the most difficult part of this entire process is using the Cordova File API, since different operating systems have completely different file structures. For the *wav-recoder* plugin, we need to provide a file path when creating the recorder object - this is not necessary for iOS and the regular cordova-plugin-media-capture. *Note:* This code is based on our [Ionic app](http://ionicframework.com/) but can easily be applied to a non-ionic project, however, you will have to make changes, most notably adapting the *cordova-plugin-device* code to determine which platform your code is running on. Instead of `ionicPlatform.is("Android")` you should use something like `device.platform==="Android"`, see the [plugin documentation](https://github.com/apache/cordova-plugin-device).


```
$ionicPlatform.ready(function(){
    window.requestFileSystem(LocalFileSystem.PERSISTENT, 5*1024*1024, function (fs) {
        var f = "watsonSTT-"+Date.now()+".wav"; // Create unique filename
        createFile(fs.root, f, false);
    },function(err){
        console.log("Error opening file system: " + JSON.stringify(err));
    });
},false);

function createFile(dirEntry, fileName, isAppend) {
     dirEntry.getFile(fileName, {create: true, exclusive: false}, function(fileEntry) {
         $scope.audioFile = fileEntry.toURL();
         try{
           if( $ionicPlatform.is("Android")){
             $scope.recorder = new martinescu.Recorder($scope.audioFile , { sampleRate: 22050 }, recorderStatusChangeCallback, bufferCallback);
           }else{
             // Need to "stub out" the wav recorder functionality here with the MediaCapture API
             // These are the only recorder() methods we use
             $scope.recorder = {};
             $scope.recorder.release = {};
           }
       }catch(e){alert(e)};
         return fileEntry.toInternalURL(); //fullPath;//fileEntry
     }, function(createFileError){
       console.log("Error creating a file" + JSON.stringify(createFileError));
     });
 };
```

The *media-capture* plugin will open up the standard recording application on iOS, which provides buttons to start and stop recording. We need to add this functionality to the Android version of our application. You could create a simple UI for this. We chose to create a Start button that will then open a pop up with some instructions. When the user closes the popup, we call the close() method:

```
var recorderStatusChangeCallback = function (mediaStatus, error) {
    if(mediaStatus == martinescu.Recorder.STATUS_READY){
      // When we call the record() method on the Recorder, the state will be
      // STATUS_READY at first, create an alert that will stop() when dismissed
      var t = 'Recording Now! Say these keywords:\n\n';
      t += keywords.toString().replace(/,/g, "\n\n");
      t+='\n\nHit STOP to save and upload!';
      var alertPopup = $ionicPopup.alert({
              title: 'Recording now!',
              template: t
          });
          alertPopup.then(function(res) {
          $scope.recorder.stop();
      });
    }else if(mediaStatus == martinescu.Recorder.STATUS_STOPPED){
      console.log("Recorder has stopped! Uploading now...");
      uploadToAdapter($scope.audioFile);
    }
  }
}
```

Finally, we need to create a button to actually let the user record his or however voice. Here we will again have to do something different depending on which platform we are running on. *Note:* The *cordovaCapture* object is just an [Ionic/Angular wrapper](http://ngcordova.com/docs/plugins/capture/) for the *media-capture* plugin:

```
$scope.record = function(){
  if( $ionicPlatform.is("Android")){
      $scope.recorder.record();
  }else{
    var options = { limit: 1};
    $cordovaCapture.captureAudio(options).then(function(audioData) {
    uploadToAdapter(audioData[0].localURL);
   }, function(err) {
     alert("Error occurred recording from iOS:" + err);
   });
 }
}
```

## Sending audio file with wlResourceRequest.sendFormParamaters()
Once we have the location of an audio file that we want to send to our adapter, we need to convert it to a base64 string and send it as a form parameter. This is how the wlResourceRequest and adapter architecture was designed. If you try to use something like [Cordova-file-transfer](https://github.com/apache/cordova-plugin-file-transfer) plugin, it wont work. This is true for any type of data file that you want to send to an adapter, be it an audio file, or an image the user selects, or anything else. See the [documentation for adapters](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/resource-request/javascript/#sendformparametersjson) and also the [MobileFirst blog post about large files](https://mobilefirstplatform.ibmcloud.com/blog/2016/12/05/howto-handle-large-files-with-ibm-mobilefirst-foundation/).

We will again be using the FileReader API to convert the audio file into a base64 encoded string using [readAsDataURL() method](https://developer.mozilla.org/en-US/docs/Web/API/FileReader/readAsDataURL). We will attach it to the WLResourceRequest as a form parameter. We will also use the *setQueryParameter()* API to attach a list of keywords that we want the Watson service to recognize. In our lab example, these keywords correspond to specific form fields, such as "age" or "first name."

```
function uploadToAdapter(path) {
    // This method uses WL.client to send the audio file directly to our Java adapter
    window.resolveLocalFileSystemURL(path, function(fileEntry) {
      fileEntry.file(function(fileObj) {
        console.log("Size = " + fileObj.size);
        try {
          var reader = new FileReader();
          var req = new WLResourceRequest('/adapters/WatsonJava/uploadBase64Wav', WLResourceRequest.POST);
          reader.readAsDataURL(fileObj);
          reader.onloadend = function() {
              var data = reader.result;
              var params = {};
              params.audioFile = data;
              //Attach the Keywords as query paramaters
              req.setQueryParameter("keywords", ['age', 'name']);
              req.sendFormParameters(params).then(function(response) {
                  alert("Transcript from Watson received: " + response);
              }, function(e) {
                  alert("No recording could be parsed by Watson, please try again");
              });
          }
        } catch (e) {
          console.log("error:" + e)
        }
      });
    });
}
```

## Provision the Watson Speech to Text service on Bluemix
Before we can build the adapter, we need to first provision an instance of the Watson Speech to Text service on Bluemix.

Head over to the Bluemix catalog, [click on Watson](https://console.ng.bluemix.net/catalog/?taxonomyNavigation=services&category=watson), and search for *Speech to Text.* Click the *Create* button to provision an instance on the *Standard Plan.* You should not bind this service to any specific application. After you create the service, click on the *Service Credentials* tab on the next page, then the name of the default credentials, and write down your username and password. If your username or password is ever exposed, you can come here to disable access and create a new set of credentials.

## Creating the audio adapter
Now that we have provisioned an instance of the Watson Speech to Text service, we can start creating an adapter that will send our audio file to Watson. There are a number of ways that you could extend this adapter, such as converting the audio file to a specific format using third party audio libraries, or saving the audio for later data analysis, or anything else.

To interact with Watson, we will be using the [Watson Developer Cloud Java SDK](https://github.com/watson-developer-cloud/java-sdk). The SDK is packaged as a Maven artifact, which makes it very easy for our adapter to consume. We can find the Maven artifact from the [Speech to Text Readme](https://github.com/watson-developer-cloud/java-sdk/tree/master/speech-to-text). We need to add it to our adapters *pom.xml* file.

First, create a standard Java adapter from the `mfpdev` CLI:
`mfpdev adapter create WatsonJava -t Java -g com.ibm.test -p com.ibm.test`

Then open up *pom.xml* and add the Speech to Text artifact:

```
<dependency>
    <groupId>com.ibm.watson.developer_cloud</groupId>
    <artifactId>speech-to-text</artifactId>
    <version>3.5.3</version>
</dependency>
```

Next, open up the *adapter.xml* file so that we can add some [custom  properties](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/adapters/java-adapters/#custom-properties) that we can pull from the server side. This is useful for passing in the Watson username/password:

```
<property name="Username" defaultValue=""/>
<property name="Password" defaultValue=""/>
```

Now we can add the endpoint code to our main *WatsonJava/src/main/java/com/ibm/test1/WatsonJavaResource.java* file. Create a new endpoint with the path */uploadBase64Wav* to match the path we call in the JavaScript. Also, notice how we are using both a FormParam and QueryParam. Finally, because we are sending the audio file as a base64 encoded string, we need to convert it to a *byte[]* which will later be written to a temporary *.wav* file:
```
@POST
@OAuthSecurity(enabled = false)
@Path("/uploadBase64Wav")
public Response handleUpload(@FormParam("audioFile") String base64wav, @QueryParam("keywords") String keywords) throws Exception {
    // Convert the base64 string back into a wav file
    // http://stackoverflow.com/questions/23979842/convert-base64-string-to-image
    String base64 = base64wav.split(",")[1]; // remove the "data:audio/x-wav;base64" header
    byte[] wavBytes = javax.xml.bind.DatatypeConverter.parseBase64Binary(base64);
    return callWatson(wavBytes, keywords);
}
```

Now, our *callWatson()* method, which will write a temporary wav file and then use the Watson SDK to recognize() this file. This is done in a single synchronous call that will block until Watson returns with a transcript. There are other ways to use Watson, such as opening a session and continuously sending audio to be transcribed - be sure to explore the [various options from the API](http://www.ibm.com/watson/developercloud/speech-to-text/api/v1/?java#introduction).

```
private Response callWatson(byte[] body, String keywords) {

    SpeechToText service = new SpeechToText();

    // Get our username/password for Watson from the Adapter configuration api
    // See the MobileFirst docs. Be sure to set these values in your mfp dashboard
    service.setUsernameAndPassword(configApi.getPropertyValue("Username"), configApi.getPropertyValue("Password"));
    service.setEndPoint("https://stream.watsonplatform.net/speech-to-text/api");

    String[] arr = keywords.split(",");
    logger.warning("Keyword array:" + arr.toString());

    // Save the audio byte[] to a wav file
    String result = "";
    File soundFile = null;
    try {
        logger.warning("Have speech file, creating temp file to send to Watson");
        logger.warning("Using these keywords:" + keywords);
        soundFile = File.createTempFile("voice", ".wav");
        FileUtils.writeByteArrayToFile(soundFile, body);
    } catch (IOException e) {
        logger.warning("No audio file received");
        e.printStackTrace();
        return Response.status(400).entity("No audio file received").build();
    }

    // Transcribe the wav file using Watson's recognize() API
    try {
        if (soundFile.exists()) {
            logger.warning("Sound file exists!");
            List < Transcript > transcripts = service.recognize(soundFile, "audio/wav").getResults();

            logger.warning("Got some results!");
            for (Transcript transcript: transcripts) {
                for (SpeechAlternative alternative: transcript.getAlternatives()) {
                    result = alternative.getTranscript() + " ";
                    logger.warning("result:" + result);
                }
            }
            return Response.ok().entity(result).build();
        } else {
            return Response.status(400).entity("Sound file could not be saved to server").build();
        }
    } catch (Exception e) {
        e.printStackTrace();
        return Response.status(400).entity(e.getMessage()).build();
    }
}
```

That's it! When the adapter receives an audio file as a base64 string, it will decode that to a *.wav* byte array, then save that to a temporary file and send that file off to Watson.


## Conclusion
In this blog post, we showed how to record data in a hybrid application using a third party Cordova plugin and then send that data off to the Watson Speech to Text service. The techniques used in this blog post can be easily adapted to send any type of large file to any other Watson service, such as the image recognition service. The tricky part about this procedure is that we need to convert the file to a base64 string and send it using *sendFormParameters* API.

For more information and a more complete example, head on over to the [Utilities lab](https://mobilefirstplatform.ibmcloud.com/labs/developers/8.0/advancedutilityservice/).
