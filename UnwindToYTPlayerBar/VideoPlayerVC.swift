//
//  VideoPlayerVC.swift
//  UnwindToYTPlayerBar
//
//  Created by Jaden Nation on 6/23/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
import DKChainableAnimationKit

class VideoPlayerVC: ExtendedVC, YTPlayerViewDelegate {
  // MARK: outlets
  @IBOutlet weak var btnUnwind: UIButton!
  @IBOutlet weak var btnPerson: UIButton!
  @IBOutlet weak var lblVideoTitle: UILabel!
  @IBOutlet weak var YTPlayer: YTPlayerView!
  @IBOutlet weak var lblTimeSig: UILabel!
  
  @IBAction func clickedUnwind(sender: AnyObject) { doClickedUnwind() }
  @IBAction func clickedPerson(sender: AnyObject) { doClickedPerson() }
  
  @IBAction func clickedPlay(sender: AnyObject) {
    YTPlayer.playVideo()
  }
  
  // MARK: variables
  var focusURL: String?
  var focusTitle: String?
  var focusTimeSig: Float?
  
  

  // MARK: custom methods
  func doClickedUnwind() {
    btnUnwind.animation.rotate(180).animateWithCompletion(0.35) {
      self.performSegueWithIdentifier(Segue.UnwindSegue.unwindToMain.rawValue, sender: self)
    }
  }
  
  func doClickedPerson() {
    
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let id = segue.identifier {
      if id == Segue.UnwindSegue.unwindToMain.rawValue {
        let dest = segue.destinationViewController as! ListVideosVC
        dest.playerBar = YTPlayerBar(YTPlayer: YTPlayer, fURL: focusURL!, fTitle: focusTitle!, fTime: focusTimeSig) // bad code, fix this
        
        if let fTime = focusTimeSig {
          print("sending time \(fTime)")
        }
      }
    }
  }
  
  // MARK: Youtube Player Delegate Methods 
  func playerViewDidBecomeReady(playerView: YTPlayerView) {
    playerView.playVideo()
  }
  
  func playerView(playerView: YTPlayerView, didPlayTime playTime: Float) {
    lblTimeSig.text = "\(playTime) seconds"
    focusTimeSig = playTime
  }
  
  
  // MARK: init methods
  func didLoadStuff() {
    
  }
  
  func didAppearStuff() {
    YTPlayer.delegate = self
  }
  
  func willAppearStuff() {
    if let fURL = focusURL {
      print("loading video")
      var pVars = VideoPlayerVC_Params
      pVars["start"] = 30
      YTPlayer.loadWithVideoId(fURL, playerVars: pVars)
      YTPlayer.playVideo()
    }
    
    if let fTitle = focusTitle {
      lblVideoTitle.text = fTitle
    }
    
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    didLoadStuff()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    didAppearStuff()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    willAppearStuff()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}  // END OF VC