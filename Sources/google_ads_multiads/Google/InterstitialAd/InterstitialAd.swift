import ObjectiveC
import GoogleMobileAds
import UIKit
import MultiAdsInterface

@available(iOS 13.0, *)
class InterstitialAd: NSObject, GADFullScreenContentDelegate {
     
     
     @MainActor static let sharedInstance = InterstitialAd(adModuleCallBacks: nil)
    
    var adModuleCallBacks:AdModuleWithCallBacks?
    
     init(adModuleCallBacks: AdModuleWithCallBacks?) {
        self.adModuleCallBacks = adModuleCallBacks
    }
    
    private var interstitial: GADInterstitialAd?
    
     func loadInterstitial() {
        print("Google Inter Loading Started 🔥")
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: ServerConfig.sharedInstance.adNetworkIds?["google"]?.interId ?? "", request: request, completionHandler: { [self] ad, error in
            if ad != nil { interstitial = ad }
            interstitial?.fullScreenContentDelegate = self
            adModuleCallBacks?.onAdLoaded?()
            showInterstitialAds()
        })
    }

     func showInterstitialAds() {
        print("Google Inter Show Triggered 🔥")
        if interstitial != nil, let root = rootController {
            interstitial?.present(fromRootViewController: root)
        }
    }

    
     func ad(_ ad: any GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: any Error) {
        print("Google Inter Ad Failed ❌")
        adModuleCallBacks?.onFailed?()
    }
    
    
     func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      
        print("Google Inter Ad Presented🔥")
        adModuleCallBacks?.onAdStarted?()
      }
    
     func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      
        print("Google Inter DiD Dismissed 🔥")
        interstitial = nil
        adModuleCallBacks?.onCloseEvent?()
    }
    
     func adWillDismissFullScreenContent(_ ad: any GADFullScreenPresentingAd) {
        print("Google Inter Will Dismissed 🔥")
        interstitial = nil
        adModuleCallBacks?.onCloseEvent?()
    }
}

