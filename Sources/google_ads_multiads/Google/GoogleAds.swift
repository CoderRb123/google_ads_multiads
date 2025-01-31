//
//  GoogleAds.swift
//  testplugin
//
//  Created by Khusnud Zehra on 30/01/25.
//

import MultiAdsInterface
import UIKit

import GoogleMobileAds

class GoogleAds : NetworkInterface{
    func initNetwork()  -> Bool {
        DispatchQueue.main.async {
            GADMobileAds.sharedInstance().start(completionHandler: nil)
        }
        return true
    }
    
    func getAdUnits() -> [Any] {
      
        return []
    }
    
    func isNetworkInit() -> Bool {
       
        return false
    }
    
    func loadInterAd(adModuleCallBacks: AdModuleWithCallBacks?) {
       
    }
    
    func showInterAd(adModuleCallBacks: AdModuleWithCallBacks?) {
      
    }
    
    func isInterAdLoaded() -> Bool {
        return false
    }
    
    func loadAndShowInterAd(adModuleCallBacks: AdModuleWithCallBacks?) {
       
        let inter = InterstitialAd.sharedInstance
        inter.adModuleCallBacks = adModuleCallBacks
        inter.loadInterstitial()
//        InterstitialAd(adModuleCallBacks: adModuleCallBacks).loadInterstitial()
    }
    
    func loadRewardAd(adModuleCallBacks: AdModuleWithCallBacks?) {
       
    }
    
    func showRewardAd(adModuleCallBacks: AdModuleWithCallBacks?) {
       
    }
    
    func isRewardAdLoaded() -> Bool {
        return false
    }
    
    func loadAndShowRewardAd(adModuleCallBacks:AdModuleWithCallBacks?) {
        let rewards = RewardAd.sharedInstance
        rewards.adModuleCallBacks = adModuleCallBacks
        rewards.loadReward()
    }
    
    func loadRewardInter(adModuleCallBacks: AdModuleWithCallBacks?) {
        
    }
    
    func showRewardInter(adModuleCallBacks: AdModuleWithCallBacks?) {
       
    }
    
    func isRewardInterAdLoaded() -> Bool {
        return false
    }
    
    func loadAndShowRewardInter(adModuleCallBacks: AdModuleWithCallBacks?) {
        
    }
    
    func getNativeAd() -> UIView? {
//        return GoogleNativeAd(height: 200.0, width: 300.0, from: AdConfigDataModel?)
        
        return nil
    }
    
    func getBannerAd() -> UIView? {
        return nil
    }
    
    
}
