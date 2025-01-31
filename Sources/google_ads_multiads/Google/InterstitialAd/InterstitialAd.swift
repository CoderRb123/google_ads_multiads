import ObjectiveC
import GoogleMobileAds
import UIKit
import MultiAdsInterface

@available(iOS 13.0, *)
public class InterstitialAd: NSObject, GADFullScreenContentDelegate {
     
     
     @MainActor public static let sharedInstance = InterstitialAd(adModuleCallBacks: nil)
    
    public var adModuleCallBacks:AdModuleWithCallBacks?
    
    public init(adModuleCallBacks: AdModuleWithCallBacks?) {
        self.adModuleCallBacks = adModuleCallBacks
    }
    
    public var interstitial: GADInterstitialAd?
    
    public func loadInterstitial() {
        print("Google Inter Loading Started 🔥")
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: ServerConfig.sharedInstance.adNetworkIds?["google"]?.interId ?? "", request: request, completionHandler: { [self] ad, error in
            if ad != nil { interstitial = ad }
            interstitial?.fullScreenContentDelegate = self
            adModuleCallBacks?.onAdLoaded?()
            showInterstitialAds()
        })
    }

    public func showInterstitialAds() {
        print("Google Inter Show Triggered 🔥")
        if interstitial != nil, let root = rootController {
            interstitial?.present(fromRootViewController: root)
        }
    }

    
    public func ad(_ ad: any GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: any Error) {
        print("Google Inter Ad Failed ❌")
        adModuleCallBacks?.onFailed?()
    }
    
    
    public func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      
        print("Google Inter Ad Presented🔥")
        adModuleCallBacks?.onAdStarted?()
      }
    
    public  func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      
        print("Google Inter DiD Dismissed 🔥")
        interstitial = nil
        adModuleCallBacks?.onCloseEvent?()
    }
    
    public  func adWillDismissFullScreenContent(_ ad: any GADFullScreenPresentingAd) {
        print("Google Inter Will Dismissed 🔥")
        interstitial = nil
        adModuleCallBacks?.onCloseEvent?()
    }
}

