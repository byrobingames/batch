## Stencyl Batch Extension (Openfl)

For Stencyl 3.4

Stencyl extension for "Batch" (http://www.batch.com) on iOS and Android. This extension allows you to easily integrate Batch on your Stencyl game / application. (http://www.stencyl.com)

### Important!!

This extension is using a custom "PROJ.xcodeproj" file to enable Push Notification in Xcode. It wil no harm for your game.

Does not work with the following extensions:
- Heyzap Extension
- Tapdaq Extension

If you want to create a game with this and with above extension, you can ask me and i make it happen for your. Not for FREE.

## Main Features

  * Register to batch.
  * Unlock Feature and Ressource
  * Push Notification service.


## How to Install in 6 Steps

Step 1- Download zip file on the right of the screen. ![download](http://www.byrobingames.com/stencyl/heyzap/download.png) on this page  https://github.com/byrobingames/batch<br />

Step 2- Install the zip file: Go to : http://community.stencyl.com/index.php/topic,30432.0.html

IOS ONLY step 3-5 will enable Push Notification in Xcode (For ANDROID go to Step 6.)<br/>
Step 3- Go to https://developer.apple.com/membercenter/index.action#accountSummary to get your Team Id from your account. 

Step 4- Go to batch extension folder ../stencylworks/engine-extensions/batch-master

Step 5- Open incluce.xml file and replace "YOUR_TEAM_ID" with your real Team Id from Step 3.

Step 6- ready to build..

## Documentation and Blocks Example

Documentation: https://dashboard.batch.com/doc

Step 1: Follow the install instructions if you did not install the extension yet.

Step 2: Create an account maak een account on http://www.batch.com and add your game(s).

Step 3:Init Batch SDK on your first (loading) scene  (This will enable Push Notification and Unlock Service)
![batchload](http://www.byrobingames.com/stencyl/batch/batchloadingscene.jpg)

Step 4: Create your unlock reference on Batch Dashboard (only if you want to use the Unlock service else skip step 4 and 5):
![batchdashboard](http://www.byrobingames.com/stencyl/batch/batchdashboard.jpg)

Step 5: Setting up unlock blocks on your game:
![batchstartscene](http://www.byrobingames.com/stencyl/batch/batchstartscene.jpg)

## Donate

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=HKLGFCAGKBMFL)<br />

## Disclaimer

Batch is a registered trademark of Google Inc. http://unibrander.com/united-states/6554293US/batch-com.html

## License

The MIT License (MIT) - [LICENSE.md](LICENSE.md)

Copyright © 2014 byRobinGames (http://www.byrobingames.com)

Author: Robin Schaafsma
