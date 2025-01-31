import ObjectiveC
import GoogleMobileAds
import MultiAdsInterface
@available(iOS 13.0, *)
class RewardInterAd: NSObject, GADFullScreenContentDelegate {
    private var reward: GADRewardedInterstitialAd?
    @MainActor static var shared: RewardInterAd = RewardInterAd()
    let common:CommonChangables = CommonChangables.shared

//    override init() {
//        super.init()
//        loadReward()
//    }
    
    func loadReward(config:AdConfigDataModel?,onComplete:@escaping ()->Void) {
        common.onComplete = onComplete
        var localConfig = config
        if(localConfig == nil){
            localConfig = ServerConfig.sharedInstance.screenConfig?["default"]
        }
        
        if(ServerConfig.sharedInstance.globalAdStatus){
            if(localConfig!.showAds){
                common.adLoader = true
                let request = GADRequest()
                GADRewardedInterstitialAd.load(withAdUnitID: ServerConfig.sharedInstance.adNetworkIds?["google"]?.interRewardId  ?? "", request: request, completionHandler: { [self] ad, error in
                    
                    if ad != nil { reward = ad }
                    reward?.fullScreenContentDelegate = self
                    showRewardAd(onComplete: onComplete)
                })
              
                
                return;
            }
            return;
        }
       
    }
    
    func showRewardAd(onComplete:@escaping ()->Void) {
        if reward != nil, let root = rootController {
            reward?.present(fromRootViewController: root){

            }
        }
    }
    
    
    func adWillPresentFullScreenContent(_ ad: any GADFullScreenPresentingAd) {
        common.adLoader = false

    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        common.adLoader = false
        print("On Ad Dismiss")
        common.onComplete()
    }
}


