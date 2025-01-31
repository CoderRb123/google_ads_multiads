import ObjectiveC
import GoogleMobileAds
import MultiAdsInterface
@available(iOS 13.0, *)
class RewardInterAd: NSObject, GADFullScreenContentDelegate {
    
    @MainActor public static let sharedInstance = RewardInterAd(adModuleCallBacks: nil)
   
    public var adModuleCallBacks:AdModuleWithCallBacks?
   
    public   init(adModuleCallBacks: AdModuleWithCallBacks?) {
       self.adModuleCallBacks = adModuleCallBacks
     }
    public var reward: GADRewardedInterstitialAd?


//    override init() {
//        super.init()
//        loadReward()
//    }
    
    @MainActor public func loadReward() {
        
        print("Google Reward Inter Loading Started 🔥")
        let request = GADRequest()
        GADRewardedInterstitialAd.load(withAdUnitID: ServerConfig.sharedInstance.adNetworkIds?["google"]?.interRewardId  ?? "", request: request, completionHandler: { [self] ad, error in
            
            if ad != nil { reward = ad }
            reward?.fullScreenContentDelegate = self
            showRewardAd()
        })
       
    }
    
    @MainActor   public  func showRewardAd() {
        if reward != nil, let root = rootController {
            print("Google Rewards Inter Show Triggered 🔥")
            reward?.present(fromRootViewController: root){

            }
        }
    }
    
    public  func ad(_ ad: any GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: any Error) {
       print("Google Reward Inter Ad Failed ❌")
       adModuleCallBacks?.onFailed?()
   }
   
   
    public func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
     
       print("Google Reward Inter Ad Presented🔥")
       adModuleCallBacks?.onAdStarted?()
     }
   
    public func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
     
       print("Google Reward Inter DiD Dismissed 🔥")
        reward = nil
       adModuleCallBacks?.onCloseEvent?()
   }
   
    public func adWillDismissFullScreenContent(_ ad: any GADFullScreenPresentingAd) {
       print("Google Reward Inter Will Dismissed 🔥")
        reward = nil
       adModuleCallBacks?.onCloseEvent?()
   }
}


