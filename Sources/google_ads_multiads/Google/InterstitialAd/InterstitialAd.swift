import ObjectiveC
import GoogleMobileAds
import UIKit
import MultiAdsInterface

@available(iOS 13.0, *)
public class InterstitialAdGoogle: NSObject, FullScreenContentDelegate {
     
     
    @MainActor public static let sharedInstance = InterstitialAdGoogle(adModuleCallBacks: nil)
    
    public var adModuleCallBacks:AdModuleWithCallBacks?
    
    public init(adModuleCallBacks: AdModuleWithCallBacks?) {
        self.adModuleCallBacks = adModuleCallBacks
    }
    
    public var interstitial: InterstitialAd?
    
    @MainActor public func loadInterstitial() {
        print("Google Inter Loading Started 🔥")
        let request = Request()
        InterstitialAd.load(
            with: ServerConfig.sharedInstance.adNetworkIds?["google"]?.interId ?? "", request: request, completionHandler: { [self] ad, error in
                if ad != nil { interstitial = ad }
                interstitial?.fullScreenContentDelegate = self
                adModuleCallBacks?.onAdLoaded?()
                showInterstitialAds()
            }
        )
    }

    @MainActor public func showInterstitialAds() {
        print("Google Inter Show Triggered 🔥")
        if interstitial != nil, let root = rootController {
            print("Google Inter Present Triggered 🔥")
            interstitial?.present(from: root)
        }
    }

    
    public func ad(_ ad: any FullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: any Error) {
        print("Google Inter Ad Failed ❌")
        adModuleCallBacks?.onFailed?()
    }
    
    
    public func adWillPresentFullScreenContent(_ ad: FullScreenPresentingAd) {
      
        print("Google Inter Ad Presented🔥")
        adModuleCallBacks?.onAdStarted?()
      }
    

    
    public  func adWillDismissFullScreenContent(_ ad: any FullScreenPresentingAd) {
        print("Google Inter Will Dismissed 🔥")
        interstitial = nil
        adModuleCallBacks?.onCloseEvent?()
    }
}

