import ObjectiveC
import GoogleMobileAds
import MultiAdsInterface
@available(iOS 13.0, *)
public class RewardAd: NSObject, GADFullScreenContentDelegate {
    
    @MainActor public static let sharedInstance = RewardAd(adModuleCallBacks: nil)
   
    public var adModuleCallBacks:AdModuleWithCallBacks?
   
    public   init(adModuleCallBacks: AdModuleWithCallBacks?) {
       self.adModuleCallBacks = adModuleCallBacks
     }
   
    public var reward: GADRewardedAd?
  

    
    @MainActor  public func loadReward() {
        print("Google Reward Loading Started 🔥")
        let request = GADRequest()
        GADRewardedAd.load(withAdUnitID: ServerConfig.sharedInstance.adNetworkIds?["google"]?.rewardId ?? "", request: request, completionHandler: { [self] ad, error in
            
            if ad != nil { reward = ad }
            reward?.fullScreenContentDelegate = self
            showRewardAd()
        })
    }
    
    @MainActor public func showRewardAd() {
        print("Google Rewards Show Triggered 🔥")
        if reward != nil, let root = rootController {
            reward?.present(fromRootViewController: root){
            }
        }
    }
    
    
    public  func ad(_ ad: any GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: any Error) {
       print("Google Reward Ad Failed ❌")
       adModuleCallBacks?.onFailed?()
   }
   
   
    public func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
     
       print("Google Reward Ad Presented🔥")
       adModuleCallBacks?.onAdStarted?()
     }
   
    public func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
     
       print("Google Reward DiD Dismissed 🔥")
        reward = nil
       adModuleCallBacks?.onCloseEvent?()
   }
   
    public func adWillDismissFullScreenContent(_ ad: any GADFullScreenPresentingAd) {
       print("Google Reward Will Dismissed 🔥")
        reward = nil
       adModuleCallBacks?.onCloseEvent?()
   }
}


