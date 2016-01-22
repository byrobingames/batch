## Stencyl Batch Extension (Openfl)

For Stencyl 3.4

Stencyl extension for "Batch" (http://www.batch.com) on iOS and Android. This extension allows you to easily integrate Batch on your Stencyl game / application. (http://www.stencyl.com)

Many thanks to riki82 (Riccardo Mattavelli) for the block examples and iOS Publish turorial

## Main Features

  * Register to batch.
  * Unlock Feature and Ressource
  * Push Notification service.

## How to Install

Step 1- Download zip file on the right of the screen. ![download](http://www.byrobingames.com/stencyl/heyzap/download.png) on this page  https://github.com/byrobingames/batch<br />

Step 2- Install the zip file: Go to : http://community.stencyl.com/index.php/topic,30432.0.html

## Documentation

Make an account and certificates at batch.com:<br/>
Documentation: https://dashboard.batch.com/doc

iOS Only:<br/>
The .ipa that is created by Stencyl will not allow you to upload it to the App Store, you get this error:<br/>
![uploaderror](http://www.byrobingames.com/stencyl/batch/wiki/upload_error.png)<br/>
<br/>
If you are ready to publish your game to the App Store, follow this tutorial how to upload your game to the App Store.<br/>
(Testing your game with Stencyl is no problem)<br/>
https://github.com/byrobingames/batch/wiki/IOS-Build-and-Publish-to-iTunes-Connect-with-Xcode]https://github.com/byrobingames/batch/wiki/IOS-Build-and-Publish-to-iTunes-Connect-with-Xcode<br/>

## Blocks Example
Step 1: Follow the install instructions if you did not install the extension yet.

Step 2: Create an account maak een account on http://www.batch.com and add your game(s).

Step 3:Init Batch SDK on your first (loading) scene  (This will enable Push Notification and Unlock Service)
![batchload](http://www.byrobingames.com/stencyl/batch/batchloadingscene.jpg)

Step 4: Create your unlock reference on Batch Dashboard (only if you want to use the Unlock service else skip step 4 and 5):
![batchdashboard](http://www.byrobingames.com/stencyl/batch/batchdashboard.jpg)

Step 5: Setting up unlock blocks on your game:
![batchstartscene](http://www.byrobingames.com/stencyl/batch/batchstartscene.jpg)

##Version History
-0.5 release 2016-01-19<br/>
-0.6 release 2016-01-22 - IOS: You must build and create .ipa for publish with Xcode. See tutorial:https://github.com/byrobingames/batch/wiki/IOS-Build-and-Publish-to-iTunes-Connect-with-Xcode

## Donate

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=HKLGFCAGKBMFL)<br />

## Disclaimer

Batch is a registered trademark of Google Inc. http://unibrander.com/united-states/6554293US/batch-com.html

## License

The MIT License (MIT) - [LICENSE.md](LICENSE.md)

Copyright © 2014 byRobinGames (http://www.byrobingames.com)

Author: Robin Schaafsma
