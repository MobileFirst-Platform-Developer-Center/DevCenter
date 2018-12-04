---
layout: tutorial
title: Adición de iconos y pantallas iniciales personalizados a aplicaciones Cordova
breadcrumb_title: Adding images and icons
relevantTo: [cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Si utilizó el plugin **cordova-plugin-mfp** y no utilizó la plantilla de {{ site.data.keys.product_adj }} o añadió el plugin **cordova-plugin-splashscreen** de Cordova en su aplicación, puede sustituir las imágenes de iconos y pantallas de inicio que {{ site.data.keys.product_full }} proporciona con sus propias imágenes.
Si ha utilizado la plantilla, puede sustituir las imágenes iniciales que utiliza la aplicación Cordova, puesto que son archivos que se visualizan.


Debe crear una nueva carpeta para alojar las imágenes de inicio y los iconos, y modificar el archivo de configuración **config.xml** para que apunte a ellos.


1. Cree una carpeta dentro del directorio raíz de su proyecto Cordova.
La carpeta puede estar en cualquier nivel de subcarpeta anidado siempre que se encuentre bajo la raíz del proyecto Cordova.

2. Coloque su imagen inicial e imágenes de icono propias en esta carpeta.

3. Actualice el archivo de configuración **config.xml** para que apunte a sus archivos personalizados.


### Android
{: #android }
Si tiene una aplicación Android, los requisitos para identificar las imágenes iniciales dependen de si la aplicación se creó con o sin la plantilla de {{ site.data.keys.product_adj }}.


#### Pantallas iniciales
{: #splash-screens }
Si *no* utilizó la plantilla {{ site.data.keys.product_adj }} al crear la aplicación, las imágenes de inicio que se visualizan son aquellas que se recuperan desde la ubicación de imágenes de {{ site.data.keys.product_adj }}.
Los nombres de archivo y las vías de acceso de archivo de destino deben permanecer exactamente igual que en el ejemplo cuando no utilice la plantilla.
Cambie los nombres de archivo y las vías de acceso de origen (`src`) con las vías de acceso de los archivos que desea visualizar.
Añada líneas similares a las del ejemplo siguiente entre las etiquetas
`<platform name="android">` y `</platform>` en el archivo **config.xml**:


```xml
<update src="res/screen/android/splash-hdpi.9.png" target="res/drawable-hdpi/splash.9.png" />
<update src="res/screen/android/splash-ldpi.9.png" target="res/drawable-ldpi/splash.9.png" />
<update src="res/screen/android/splash-mdpi.9.png" target="res/drawable-mdpi/splash.9.png" />
<update src="res/screen/android/splash-xhdpi.9.png" target="res/drawable-xhdpi/splash.9.png" />
<update src="res/screen/android/splash-xxhdpi.9.png" target="res/drawable-xxhdpi/splash.9.png" /> 
```

Si utilizó la plantilla de {{ site.data.keys.product_adj }} para crear su aplicación, debe actualizar las imágenes de bienvenida que Cordova utiliza.
Cambie los nombres de archivo y las vías de acceso de origen (src) con las vías de acceso de los archivos que desea visualizar.

Añada líneas similares a las del siguiente ejemplo entre las etiquetas <platform name="android"> y </platform> en el archivo config.xml:


```xml
<splash density="land-hdpi" src="res/screen/android/screen-hdpi-landscape.png" />
<splash density="land-ldpi" src="res/screen/android/screen-ldpi-landscape.png" />
<splash density="land-mdpi" src="res/screen/android/screen-mdpi-landscape.png" />
<splash density="land-xhdpi" src="res/screen/android/screen-xhdpi-landscape.png" />
<splash density="hdpi" src="res/screen/android/screen-hdpi-portrait.png" />
<splash density="ldpi" src="res/screen/android/screen-ldpi-portrait.png" />
<splash density="mdpi" src="res/screen/android/screen-mdpi-portrait.png" />
<splash density="xhdpi" src="res/screen/android/screen-xhdpi-portrait.png" />
```

#### Iconos
{: #icons }
Los nombres de archivo de los archivos de icono deben ser los mismos que las entradas en el siguiente ejemplo. Las vías de acceso pueden ser cualesquiera.
El nombre de cada imagen corresponde a su tamaño.

```xml
<icon src="res/icon/android/icon-96-xhdpi.png" />
<icon density="mdpi" src="res/icon/android/icon-48-mdpi.png" />
<icon density="hdpi" src="res/icon/android/icon-72-hdpi.png" />
<icon density="xhdpi" src="res/icon/android/icon-96-xhdpi.png" />
<icon density="xxhdpi" src="res/icon/android/icon-144-xxhdpi.png" />
<icon density="xxxhdpi" src="res/icon/android/icon-192-xxxhdpi.png" />
```

### iOS
{: #ios }
Si tiene una aplicación iOS, añada líneas similares a las del ejemplo siguiente entre las etiquetas
`<platform name="ios">` y `</platform>`: 

#### Pantallas iniciales
{: #splash-screens-ios }
Los nombres de archivo y las vías de acceso de los archivos de pantallas iniciales deben ser los mismos que los nombres en el siguiente ejemplo.
El nombre de cada imagen corresponde a su tamaño.

```xml
<splash height="480" src="res/screen/ios/Default˜iphone.png" width="320" />
<splash height="1024" src="res/screen/ios/Default-Portrait˜ipad.png" width="768" />
<splash height="2048" src="res/screen/ios/Default-Portrait@2x˜ipad.png" width="1536" />
<splash height="768" src="res/screen/ios/Default-Landscape˜ipad.png" width="1024" />
<splash height="1536" src="res/screen/ios/Default-Landscape@2x˜ipad.png" width="2048" />
<splash height="1136" src="res/screen/ios/Default-568h@2x˜iphone.png" width="640" />
<splash height="1334" src="res/screen/ios/Default-667h˜iphone.png" width="750" />
<splash height="2208" src="res/screen/ios/Default-736h˜iphone.png" width="1242" />
<splash height="1242" src="res/screen/ios/Default-736h-Landscape˜iphone.png" width="2208" />
```

#### Iconos
{: #icons-ios}
Los nombres de archivo de los archivos de icono deben ser los mismos que los nombres en el siguiente ejemplo.
Las vías de acceso pueden ser cualesquiera.
El nombre de cada imagen corresponde a su tamaño.

```xml
<icon height="167" src="res/icon/ios/icon-83.5@2x.png" width="167"/>
<icon height="57" src="res/icon/ios/icon.png" width="57" />
<icon height="114" src="res/icon/ios/icon@2x.png" width="114" />
<icon height="40" src="res/icon/ios/icon-40.png" width="40" />
<icon height="80" src="res/icon/ios/icon-40@2x.png" width="80" />
<icon height="50" src="res/icon/ios/icon-50.png" width="50" />
<icon height="100" src="res/icon/ios/icon-50@2x.png" width="100" />
<icon height="60" src="res/icon/ios/icon-60.png" width="60" />
<icon height="120" src="res/icon/ios/icon-60@2x.png" width="120" />
<icon height="180" src="res/icon/ios/icon-60@3x.png" width="180" />
<icon height="72" src="res/icon/ios/icon-72.png" width="72" />
<icon height="144" src="res/icon/ios/icon-72@2x.png" width="144" />
<icon height="76" src="res/icon/ios/icon-76.png" width="76" />
<icon height="152" src="res/icon/ios/icon-76@2x.png" width="152" />
<icon height="29" src="res/icon/ios/icon-small.png" width="29" />
<icon height="58" src="res/icon/ios/icon-small@2x.png" width="58" />
<icon height="87" src="res/icon/ios/icon-small@3x.png" width="87" />
```

A partir de la versión 8.0.2017102406 del plugin cordoba de MobileFirstPlatform Foundation, se ha realizado un cambio a `AppDelegate.m` que provoca un parpadeo de la pantalla negra cuando se carga una aplicación de cordova con
el plugin `cordova-plugin-mfp` instalado. Si un usuario no quiere ver esta pantalla inicial, pueden añadir un nuevo `ViewController` y hacer algunos cambios en la carga de `AppDelegate.m` para evitar la pantalla inicial. Los pasos para el proceso son como siguen:

1. En su proyecto XCode, pulse el botón derecho (del ratón) en la pantalla **Classes** y seleccione la opción **Nuevo archivo**.
2. Seleccione la plantilla **Cocoa Touch Class**. Pulse **Siguiente**.
3. Deje los valores predeterminados (el nombre de clase será *ViewController*). Pulse **Siguiente**.
4. Pulse **Crear**. Los archivos `ViewController.m` y `ViewController.h` se añaden a la carpeta **Clases**.
5. Vuelva a pulsar el botón derecho (del ratón) en la carpeta **Classes** y seleccione la opción **Nuevo archivo**.
6. Seleccione la plantilla **Storyboard**. Pulse **Siguiente**, guárdelo con el nombre `ViewController` y pulse **Crear**.
7. Abra `ViewController.storyboard` y añada un nuevo objeto de `ViewController`. Y añada los atributos *Clase* en la ficha **Clase personalizada** como *ViewController*. En la ficha **Identidad** defina el **ID del Storyboard** y el **ID de restauración** como *ViewController*.
8. Modifique su `AppDelegate.m` como a continuación y ejecute la aplicación. Ahora en lugar de pantalla inicial, aparecerá una pantalla blanca que se puede personalizar en *ViewController.storyboard* .

```
  /*
   Material bajo licencia - Propiedad de IBM

   (C) Copyright 2017 IBM Corp.

A menos que lo requiera la legislación vigente o se acuerde por escrito,
el software distribuido bajo la licencia se distribuye "TAL CUAL", SIN GARANTÍAS NI CONDICIONES DE NINGÚN TIPO, ya sean expresas o implícitas.
   Consulte la Licencia para
ver los permisos aplicables específicos del idioma y las limitaciones
bajo la Licencia.*/
  /*
   Con licencia para Apache Software Foundation (ASF) de conformidad con uno o
   más acuerdos de licencia de colaborador.  Consulte el archivo de AVISO
   distribuido con este trabajo para obtener más información en relación con
   la propiedad del copyright.  ASF le otorga la licencia según la Licencia de Apache, Versión 2.0
   (la "Licencia"); no deberá utilizar este archivo, excepto de conformidad con
   la licencia.  Puede obtener una copia de la licencia en

   http://www.apache.org/licenses/LICENSE-2.0

   A menos que lo requiera la legislación vigente o se acuerde por escrito,
   el software distribuido bajo la Licencia se distribuye
   "TAL CUAL", SIN GARANTÍAS NI CONDICIONES DE NINGÚN TIPO,
   ya sean expresas o implícitas.  Consulte la Licencia para ver
   los permisos aplicables específicos del idioma y las limitaciones bajo la Licencia.
   */
  #import "AppDelegate.h"
  #import <IBMMobileFirstPlatformFoundationHybrid/IBMMobileFirstPlatformFoundationHybrid.h>
  #import <IBMMobileFirstPlatformFoundation/WLAnalytics.h>
  #import "MainViewController.h"
  #import "ViewController.h"
  @implementation AppDelegate
  NSString* const MFP_INITIALIAZATION = @"WLInitSuccess";
  NSString* const OPEN_URL_COMPLETED = @"OpenURLCompleted";
  - (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
  {
      if (NSClassFromString(@"CDVSplashScreen") == nil) {
          [[WL sharedInstance] showSplashScreen];
      }
      // Se ocultará la pantalla automáticamente de forma predeterminada cuando se complete el entorno Worklight JavaScript.
      // Para sustituir este comportamiento, establezca la propiedad autoHideSplash en initOptions.js a falso y utilice la API WL.App.hideSplashScreen().
      self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

     // UIViewController* rootViewController = self.window.rootViewController;

      ViewController *loginController = [[UIStoryboard storyboardWithName:@"ViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"]; //or the homeController
      UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
      self.window.rootViewController = navController;

      [self.window makeKeyAndVisible];

       [[WL sharedInstance] initializeWebFrameworkWithDelegate:self];
  //    __block __weak id observer =  [[NSNotificationCenter defaultCenter]addObserverForName:MFP_INITIALIAZATION object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * note) {
  //        self.viewController = [[MainViewController alloc] init];
  //        self.viewController.startPage = [[WL sharedInstance] mainHtmlFilePath];
  //        [super application:application didFinishLaunchingWithOptions:launchOptions];
  //        [[NSNotificationCenter defaultCenter] removeObserver:observer name:MFP_INITIALIAZATION object:nil];
  //    }];
      return YES;
  }
  -(void)wlInitWebFrameworkDidCompleteWithResult:(WLWebFrameworkInitResult *)result
  {
      if ([result statusCode] == WLWebFrameworkInitResultSuccess) {
          [[WLAnalytics sharedInstance] addDeviceEventListener:NETWORK];
          [[WLAnalytics sharedInstance] addDeviceEventListener:LIFECYCLE];
          [self wlInitDidCompleteSuccessfully];
          //[[NSNotificationCenter defaultCenter] postNotificationName:MFP_INITIALIAZATION object:nil];
      } else {
          [self wlInitDidFailWithResult:result];
      }
  }
  -(void)wlInitDidCompleteSuccessfully
  {
      UIViewController* rootViewController = self.window.rootViewController;

      // Create a Cordova View Controller
      CDVViewController* cordovaViewController = [[CDVViewController alloc] init] ;

      cordovaViewController.startPage = [[WL sharedInstance] mainHtmlFilePath];

      // Ajuste el marco de visualización del controlador de vista de Cordova para que coincida con los límites de la vista principal
      cordovaViewController.view.frame = rootViewController.view.bounds;

      // Mostrar la vista de Cordova
      [rootViewController addChildViewController:cordovaViewController];
      [rootViewController.view addSubview:cordovaViewController.view];
  }
  -(void)wlInitDidFailWithResult:(WLWebFrameworkInitResult *)result
  {
      UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"ERROR"
                                                          message:[result message]
                                                         delegate:self
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
      [alertView show];
  }
  - (void)applicationWillResignActive:(UIApplication *)application
  {
      // Se envía cuando la aplicación está a punto de cambiar del estado activo al inactivo. Esto no puede ocurrir cuando hay determinadas interrupciones momentáneas (como llamadas o mensajes SMS entrantes) o cuando el usuario deja la aplicación y pasa a la transición al estado en segundo plano.
      // Utilice este método para pausar tareas entrantes, deshabilite los temporizadores, y regule la velocidad de
fotogramas de OpenGL ES. Los juegos deberían utilizar este método para pausar el juego.
  }
  - (void)applicationDidEnterBackground:(UIApplication *)application
  {
      // Utilice este método para publicar los recursos compartidos, guardar datos de usuario, invalidar temporizadores, y almacene suficiente información del estado de las aplicaciones para restaurar su aplicación a su estado actual en caso de que se termine más adelante.
      // Si su aplicación soporta la ejecución de fondo, se llama a este método en lugar de applicationWillTerminate: cuando el usuario sale. }
  - (void)applicationWillEnterForeground:(UIApplication *)application
  {
      // Se llama como parte de la transición desde el fondo al estado inactivo; puede deshacer muchos cambios realizados al entrar en el fondo.
      //wi 116840 - Al añadir una notificación de una publicación en mfp_intialization después de que se ejecute openurl y que se reciba una notificación de observador.
      //Esto es para manejar el inicio en caliente correctamente
      __block __weak id observer = [[NSNotificationCenter defaultCenter]addObserverForName:OPEN_URL_COMPLETED object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * note) {
          [[NSNotificationCenter defaultCenter] postNotificationName:MFP_INITIALIAZATION object:nil];
          [[NSNotificationCenter defaultCenter] removeObserver:observer name:OPEN_URL_COMPLETED object:nil];
      }];

  }
  - aplicación (void)applicationDidBecomeActive:(UIApplication *)
  {
      // Reinicie las tareas que se han pausado (o que aun no se han iniciado) mientras la aplicación estaba inactiva. Si la aplicación había estadopreviamente en segundo plano, puede actualizar la interfaz de usuario. }
  - aplicación (void)applicationWillTerminate:(UIApplication *)
  {
      // Se llama cuando la aplicación está a punto de finalizar. Guarde los datos si es necesario. Consulte también applicationDidEnterBackground:. }
  //wi 116840 - Los cambios a continuación son para arreglar el inicio en frío en handleopenurl. Solo después de la devolución del observador MFP_INITIALIZATION, se llama al plugin handleopenurl.
  //Esto garantiza que el comportamiento de inicio en frío no tenga ningún problema.
  // Después, un se inicia un observador para open_url_completed. Esto garantiza que en "applicationWillEnterForeground", la acción para enviar la notificación se completa después de que se ejecute openurl.
  - (BOOL)application:(UIApplication*)application openURL:(NSURL*)url sourceApplication:(NSString*)sourceApplication annotation:(id)annotation
  {
      if (!url) {
          return NO;
      }
      __block __weak id observer = [[NSNotificationCenter defaultCenter]addObserverForName:MFP_INITIALIAZATION object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * note) {
          [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:CDVPluginHandleOpenURLNotification object:url]];
          [[NSNotificationCenter defaultCenter] removeObserver:observer name:MFP_INITIALIAZATION object:nil];
      }];
      [[NSNotificationCenter defaultCenter] postNotificationName:OPEN_URL_COMPLETED object:nil];
      return YES;
  }
  @end
```


>**Nota:** Estos cambios están destinados a perderse si se elimina y se añade la plataforma ios. Por lo tanto, asegúrese de
que se realicen estos cambios cómo y cuándo se necesitan.

### Windows
{: #windows }
Si tiene una aplicación Windows, añada líneas similares a las del ejemplo siguiente entre las etiquetas `<platform name="windows">` y `</platform>`: 

#### Pantallas iniciales
{: #splash-screens-windows }
Los nombres de archivo y las vías de acceso de los archivos de pantallas iniciales deben ser los mismos que los nombres en el siguiente ejemplo.
El nombre de cada imagen corresponde a su tamaño.

```xml
<splash src="res/screen/windows/SplashScreen.scale-100.png" width="620" height="300"/>
<splash src="res/screen/windows/SplashScreenPhone.scale-240.png" width="1152" height="1920"/>
<splash src="res/screen/windows/Wide310x150Logo.scale-100.png" width="310" height="150"/>
<splash src="res/screen/windows/Wide310x150Logo.scale-240.png" width="744" height="360"/>
```

#### Iconos
{: #icons-windows }
Los nombres de archivo de los archivos de icono deben ser los mismos que los nombres en el siguiente ejemplo.
Las vías de acceso pueden ser cualesquiera.
El nombre de cada imagen corresponde a su tamaño.

```xml
<icon src="res/icon/windows/Square30x30Logo.scale-100.png" width="30" height="30" />
<icon src="res/icon/windows/Square44x44Logo.scale-100.png" width="44" height="44" />
<icon src="res/icon/windows/Square44x44Logo.scale-240.png" width="106" height="106" />
<icon src="res/icon/windows/Square70x70Logo.scale-100.png" width="70" height="70" />
<icon src="res/icon/windows/Square71x71Logo.scale-100.png" width="71" height="71" />
<icon src="res/icon/windows/Square71x71Logo.scale-240.png" width="170" height="170" />
<icon src="res/icon/windows/Square150x150Logo.scale-100.png" width="150" height="150" />
<icon src="res/icon/windows/Square150x150Logo.scale-240.png" width="360" height="360" />
<icon src="res/icon/windows/Square310x310Logo.scale-100.png" width="310" height="310" />
<icon src="res/icon/windows/StoreLogo.scale-100.png" width="50" height="50" />
<icon src="res/icon/windows/StoreLogo.scale-240.png" width="120" height="120" />
```
