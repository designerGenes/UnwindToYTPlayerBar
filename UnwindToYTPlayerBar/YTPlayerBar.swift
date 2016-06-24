//
//  YTPlayerBar.swift
//  UnwindToYTPlayerBar
//
//  Created by Jaden Nation on 6/23/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
import DKChainableAnimationKit
import ChameleonFramework

class YTPlayerBar: UIView, YTPlayerViewDelegate {

    // MARK: outlets
  @IBOutlet weak var btnWind: UIButton!
  @IBOutlet weak var lblVideoDesc: UILabel!
  @IBOutlet weak var lblVideoOwner: UILabel!
  @IBOutlet weak var YTPlayerMini: YTPlayerView!
  
  
  @IBAction func clickedWind(sender: AnyObject) {
     doClickedWind()
  }
  
    // MARK: variables
  var view: UIView!
  var focusURL: String?
  var focusTitle: String?
  var focusTimeSig: Float?
  var focusSnapshot: CGImage?
  
  weak var master: ListVideosVC?
  
    // MARK: custom methods
  func kickstartVideo() {
    if let fURL = focusURL {
      var paramDict = YTPlayerBar_Params
      if let fTime = focusTimeSig {
        print("time is \(fTime)") // apply buffer here?
        paramDict["start"] = fTime
      }
      YTPlayerMini.loadWithVideoId(fURL, playerVars: paramDict)
//      YTPlayerMini.playVideo()
    }
  }
  
  
  func doClickedWind() {
    btnWind.animation.rotate(180).animateWithCompletion(0.5) {
      if let master = self.master {
        master.loadPlayerView(self.focusURL!, self.focusTitle!)
        
        self.setAnchorPoint(CGPoint(x: 0, y: 0))
        self.animation.makeAlpha(0).animate(0.7)
        self.animation.moveY(-(self.center.y - 16)).animateWithCompletion(0.35) {
          self.removeFromSuperview()
        }
      }
    }
  }
  
  func loadVideoWithOptions(url: String, options: [String: AnyObject]) {
    
  }
  
    // MARK: Youtube Delegate Methods
    func playerViewDidBecomeReady(playerView: YTPlayerView) {
      YTPlayerMini.playVideo()
    }
  
    // MARK: init methods
  func xibSetup() {
    view = loadViewFromNib()
    view.frame = bounds
    view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    
    addSubview(view)
    YTPlayerMini.delegate = self
    
    if let fTitle = focusTitle {
      lblVideoDesc.text = fTitle
    }
    
  }
  
  func loadViewFromNib() -> UIView {
    let bundle = NSBundle(forClass: self.dynamicType)
    let nib = UINib(nibName: "YTPlayerBar", bundle: bundle)
    let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
    
    return view
  }
  
  
  init(YTPlayer: YTPlayerView, fURL: String, fTitle: String, fTime: Float?, fSnapshot: CGImage? = nil) {
    super.init(frame: CGRectMake(0, 0, 375, 40))
    YTPlayerMini = YTPlayer
    focusTitle = fTitle
    focusURL = fURL
    focusTimeSig = fTime
    xibSetup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    xibSetup()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    xibSetup()
  }
  

}
