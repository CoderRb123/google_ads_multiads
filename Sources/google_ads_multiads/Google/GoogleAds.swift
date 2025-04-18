//
//  GoogleAds.swift
//  testplugin
//
//  Created by Khusnud Zehra on 30/01/25.
//

import MultiAdsInterface
import UIKit

import GoogleMobileAds
import SwiftUICore

@available(iOS 13.0, *)
public class GoogleAds : @preconcurrency NetworkInterface{
    @MainActor public func getNativeAd(height: Double?, width: Double?, from: String?) -> ViewWrapper {
       
        return ViewWrapper(v: GoogleNativeAd(height: height ?? 200.0, width: width ?? 300.0,
                                             from: from ?? "default"))
    }
    
    public func getBannerAd(from: String?) -> ViewWrapper {
       
        return ViewWrapper(v: VStack{})
    }
    
    public func initNetwork()  -> Bool {
        DispatchQueue.main.async {
            MobileAds.shared.start(completionHandler: nil)
        }
        return true
    }
    
    public func getAdUnits() -> [Any] {
      
        return []
    }
    
    public func isNetworkInit() -> Bool {
       
        return false
    }
    
    public func loadInterAd(adModuleCallBacks: AdModuleWithCallBacks?) {
       
    }
    
    public func showInterAd(adModuleCallBacks: AdModuleWithCallBacks?) {
      
    }
    
    public  func isInterAdLoaded() -> Bool {
        return false
    }
    
    @MainActor public func loadAndShowInterAd(adModuleCallBacks: AdModuleWithCallBacks?) {
       
        let inter = InterstitialAdGoogle.sharedInstance
        inter.adModuleCallBacks = adModuleCallBacks
        inter.loadInterstitial()
//        InterstitialAd(adModuleCallBacks: adModuleCallBacks).loadInterstitial()
    }
    
    public func loadRewardAd(adModuleCallBacks: AdModuleWithCallBacks?) {
       
    }
    
    public  func showRewardAd(adModuleCallBacks: AdModuleWithCallBacks?) {
       
    }
    
    public func isRewardAdLoaded() -> Bool {
        return false
    }
    
    @MainActor public func loadAndShowRewardAd(adModuleCallBacks:AdModuleWithCallBacks?) {
        let rewards = RewardAd.sharedInstance
        rewards.adModuleCallBacks = adModuleCallBacks
        rewards.loadReward()
    }
    
    public func loadRewardInter(adModuleCallBacks: AdModuleWithCallBacks?) {
        
    }
    
    public func showRewardInter(adModuleCallBacks: AdModuleWithCallBacks?) {
       
    }
    
    public  func isRewardInterAdLoaded() -> Bool {
        return false
    }
    
    @MainActor public  func loadAndShowRewardInter(adModuleCallBacks: AdModuleWithCallBacks?) {
        let rewards = RewardInterAd.sharedInstance
        rewards.adModuleCallBacks = adModuleCallBacks
        rewards.loadReward()
    }
    
  
    
}
