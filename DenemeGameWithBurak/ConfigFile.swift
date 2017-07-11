//
//  ConfigFile.swift
//  JetPackChallenge
//
//  Created by sabri emre esen on 09/12/15.
//  Copyright © 2015 emre esen. All rights reserved.
//

import Foundation



// If "iAP_Enabled" value is set "true", you have to set "iAP_ID" value. This iAP provides RemoveAds. So you should get product_id from iTunesConnect for Non-Consumable iAP.

var iAP_Enabled = false
var iAP_ID = "Your product_id here for iAP"




// You should set your game link instead of  below link is mine

var YourGameLinkOnAppleStore = "https://itunes.apple.com/us/app/sharkrun/id1255655128?ls=1&mt=8"




// You should set your link instead of  below link which is mine

var YourLinkOnAppleStore = "https://itunes.apple.com/us/developer/jupitertechs/id920238293"





// If you want to show AdMob Ads you should set "AdMob_Enabled" to True. Then set your AdMob_ID instead of below id. 
// "Show_AdMobAd_TimePerFinishGame" value is very powerfull property. You can set what you want. I sugguest below setting. You should avoid showing ads each end of game.

//ca-app-pub-6771802840325573/7685692915

var AdMob_Enabled = true
var AdMob_ID = "ca-app-pub-6771802840325573/7685692915"
var Show_AdMobAd_TimePerFinishGame = 1




// If you want to use PushNotification, you should set "Parse_SetApplicationId" and "Parse_ClientKey" instead of below values which are mines.
// If you dont want to use Push Notification, you just set "PushNotification_Enabled" value to false

var PushNotification_Enabled = true
var Parse_SetApplicationId = "73J06jyuABnCixNLIFllfmf4CwgL91T665PF6FAH"
var Parse_ClientKey = "gomnQg7Qgrf1mNFdqyBNJdFRJ76CqTstT1SmIeLU"




// You should set "LeaderBoard_ID" . Below value is mine.

var LeaderBoard_ID = "grp.sharkrun.leaderboard"


// You can configure when levels will be open with below values.

var level2UnlockValue = 500
var level3UnlockValue = 1500
var level4UnlockValue = 2500
var level5UnlockValue = 3500
var level6UnlockValue = 4500
var level7UnlockValue = 5500



