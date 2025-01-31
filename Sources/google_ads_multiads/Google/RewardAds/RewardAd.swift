import ObjectiveC
import GoogleMobileAds
import MultiAdsInterface
@available(iOS 13.0, *)
class RewardAd: NSObject, GADFullScreenContentDelegate {
    
    @MainActor static let sharedInstance = RewardAd(adModuleCallBacks: nil)
   
   var adModuleCallBacks:AdModuleWithCallBacks?
   
    init(adModuleCallBacks: AdModuleWithCallBacks?) {
       self.adModuleCallBacks = adModuleCallBacks
     }
   
    private var reward: GADRewardedAd?
  

    
    func loadReward() {
        print("Google Reward Loading Started 🔥")
        let request = GADRequest()
        GADRewardedAd.load(withAdUnitID: ServerConfig.sharedInstance.adNetworkIds?["google"]?.rewardId ?? "", request: request, completionHandler: { [self] ad, error in
            
            if ad != nil { reward = ad }
            reward?.fullScreenContentDelegate = self
            showRewardAd()
        })
    }
    
    func showRewardAd() {
        print("Google Rewards Show Triggered 🔥")
        if reward != nil, let root = rootController {
            reward?.present(fromRootViewController: root){
            }
        }
    }
    
    
    func ad(_ ad: any GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: any Error) {
       print("Google Reward Ad Failed ❌")
       adModuleCallBacks?.onFailed?()
   }
   
   
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
     
       print("Google Reward Ad Presented🔥")
       adModuleCallBacks?.onAdStarted?()
     }
   
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
     
       print("Google Reward DiD Dismissed 🔥")
        reward = nil
       adModuleCallBacks?.onCloseEvent?()
   }
   
    func adWillDismissFullScreenContent(_ ad: any GADFullScreenPresentingAd) {
       print("Google Reward Will Dismissed 🔥")
        reward = nil
       adModuleCallBacks?.onCloseEvent?()
   }
}


