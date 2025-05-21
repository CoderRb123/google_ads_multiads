//
//  GADNativeViewWrapper.swift
//  AdmobNativeSample
//
//  Created by Sakura on 2021/05/07.
//

import UIKit
import SwiftUI
import MultiAdsInterface

@available(iOS 13.0, *)
public struct GADNativeViewControllerWrapper : UIViewControllerRepresentable {

    public func makeUIViewController(context: Context) -> UIViewController {
    let viewController = GADNativeViewController()
    return viewController
  }

    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }

}



@available(iOS 13.0, *)
public struct GoogleNativeAd : View{
    
    public  var height:CGFloat
    public   var width:CGFloat
    public   var from:String?
    public   var paddingFrame =  10.0
    public  var paddingDottedLine =  UIDevice.current.userInterfaceIdiom == .pad ? 10.0 :8.0
    public  var yellowTilePadding =  UIDevice.current.userInterfaceIdiom == .pad ? 20.0 :8.0
    
    
    
    
    @State public var adLoader = false
    @State public var config:AdConfigDataModel?
    public  init(height: CGFloat, width: CGFloat,from:String?) {
        self.height = height
        self.width = width
        self.from = from ?? "default"
        self.adLoader = true
        if(from != nil){
            let defaultConfig = ServerConfig.sharedInstance.screenConfig?["default"]
            print("fething from : \(self.from!)")
            let server = ServerConfig.sharedInstance.screenConfig?[self.from!]
            
            print("fething server object : \(String(describing: server ?? nil))")
            print("fething default object : \(String(describing: defaultConfig ?? nil))")

            self.config = server ?? defaultConfig
           
        } else{
            config =  ServerConfig.sharedInstance.screenConfig?["default"]
            print("From is null - [Google Native]")
        }
        doLater()
    }
    public func doLater (){
       DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
           DispatchQueue.main.async {
               self.adLoader = false
           }
      }
    }
    

    @available(iOS 13.0, *)
    public var body: some View{
        let calPadding = min(width * 1.5 / 100, 10)
        if(adLoader || config == nil){
            VStack {
                Spacer()
                Text("Ad Loading...")
                Spacer()
            }.frame(width: .infinity, height: 500)
        }else{
            VStack {
                if(!ServerConfig.sharedInstance.globalAdStatus){
                    VStack {}
                }else{
                    if(config!.showAds){
                        if(config!.native == 0){
                            ZStack {
                                RoundedRectangle(cornerRadius: 18)
                                    .fill(.white)
                                    .shadow(
                                           color: Color.black.opacity(0.3),
                                           radius: 0,                           x: 0,
                                           y: 5
                                    )
                                
                                
                                Group{
                                    Rectangle()
                                        .strokeBorder(Color(ColorFunctions.hexStringToUIColor(hex: "#ffce64")),style: StrokeStyle(lineWidth: 3, dash: [10]))
                                               .clipShape(RoundedRectangle(cornerRadius: 15.0))
                                               .padding(.vertical,paddingDottedLine)
                                               .padding(.horizontal,calPadding)
                                              
                                    
                                    // Yellow Tile

                                    GADNativeViewControllerWrapper() .padding(.vertical,yellowTilePadding).background(Color(ColorFunctions.hexStringToUIColor(hex: "#ffce64")).opacity(0.3))
                                        .clipShape(RoundedRectangle(cornerRadius: 15.0))
                                        .padding(.vertical,10)
                                        .padding(.horizontal,calPadding)
                                }
                               
                            }.frame(height: 320)
                                .padding(10)
                        }else{
                            VStack {}
                        }
                       
                    }else{
                        VStack {}
                    }
                }
            }
        }
        
    }
}
