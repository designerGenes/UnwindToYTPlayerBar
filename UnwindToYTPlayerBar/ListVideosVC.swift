//
//  ViewController.swift
//  UnwindToYTPlayerBar
//
//  Created by Jaden Nation on 6/23/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import DKChainableAnimationKit
import youtube_ios_player_helper

class ListVideosVC: ExtendedVC, UITableViewDelegate, UITableViewDataSource {
  // MARK: outlets
  @IBOutlet weak var tblListVideos: UITableView!
  @IBOutlet weak var tabBarGutter: UITabBar!
  @IBOutlet weak var lblPageTitle: UILabel!
  
  
  @IBAction func unwindToMain(sender: UIStoryboardSegue) {}
  
  
  
  // MARK: variables
  var dataArr = [(url: String, img: UIImage, title: String)]()
  var playerBar: YTPlayerBar? {
    didSet {
      playerBar!.master = self
    }
  }
  
  
  // MARK: custom methods
  func spawnPlayerBar(bar: YTPlayerBar) {
    bar.alpha = 0
    view.insertSubview(bar, belowSubview: self.tabBarGutter)
    view.sendSubviewToBack(self.tblListVideos)
    view.sendSubviewToBack(self.lblPageTitle)
    bar.setAnchorPoint(CGPoint(x: 0, y: 1))
    bar.center = CGPoint(x: 0, y: self.view.bounds.size.height)
    bar.frame.size = CGSize(width: self.view.bounds.size.width, height: 50)
    bar.kickstartVideo()
    wait(2) {
      bar.animation.makeAlpha(1).moveY(-bar.frame.size.height).bounce.animate(0.35)        
    }
  }
  
  func loadPlayerView(url: String, _ title: String) {
    performSegueWithIdentifier(Segue.ForwardSegue.from_ListVideos_VideoPlayer.rawValue, sender: [url, title])
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    removeAnyBarViews()
    if let id = segue.identifier {
      if id == Segue.ForwardSegue.from_ListVideos_VideoPlayer.rawValue {
        if let dest = segue.destinationViewController as? VideoPlayerVC {
          if let vals = sender as? [String] {
            dest.focusURL = vals[0]
            dest.focusTitle = vals[1]  // this is hideous code just btw
           }
        }
      }
    }
  }
  
  
  // MARK: tableview delegate methods
  func removeBlurViews() {
    for cell in tblListVideos.visibleCells {
      let targViews = cell.subviews.filter({$0 is UIVisualEffectView})
      targViews.map { targView in
        targView.removeFromSuperview()
      }
    }
  }
  
  func removeAnyBarViews() {
    if let YTPBars = view.subviews.filter({$0 is YTPlayerBar}) as? [YTPlayerBar] {
      YTPBars.map { bar in
        bar.animation.moveY(bar.frame.size.height).easeIn.animateWithCompletion(0.35) {
          bar.removeFromSuperview()
        }
      }
    }
    
  }
  
  func reloadTable() {
    tblListVideos.reloadData()
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    for (x, cell) in tableView.visibleCells.enumerate() {
      if x != indexPath.row {  // affect everything that is NOT the selected cell
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark))
        blurView.alpha = 0
        blurView.frame = cell.bounds
        cell.addSubview(blurView)
        blurView.animation.makeAlpha(1).animate(0.35)
      }
    }
    
    wait(0.35) {
      let targ = self.dataArr[indexPath.row]
      self.loadPlayerView(targ.url, targ.title)
    }
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataArr.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("YTVideoListCell", forIndexPath: indexPath) as! YTVideoListCell

    cell.imgVideo.image = dataArr[indexPath.row].img
    cell.assocURL = dataArr[indexPath.row].url
    
    return cell
  }
  
  // MARK: init methods
  func didLoadStuff() {
    tblListVideos.rowHeight = 135
  }
  
  func didAppearStuff() {
//    let demoView = UIView()
//    demoView.frame = CGRectMake(0, 0, view.bounds.size.width, 150)
//    demoView.backgroundColor = UIColor.redColor()
//    
//    view.addSubview(demoView)
  }
  
  func willAppearStuff() {
    removeBlurViews()
    
   dataArr = [  // hardcode nonsense
      (VideoCode.StonedAlone.rawValue, UIImage(named: "thumbStonedAlone")!, "Stoned, Alone by Teenage Wrist"),
      (VideoCode.Drowning.rawValue, UIImage(named: "thumbDrowning")!, "Drowning by Banks"),
      (VideoCode.BodyWork.rawValue, UIImage(named: "thumbBodyWork")!, "Body Work by Morgan Page"),
      (VideoCode.TheWalker.rawValue, UIImage(named: "thumbTheWalker")!, "The Walker by Fitz & The Tantrums"),
      (VideoCode.WeOwnTheNight.rawValue, UIImage(named: "thumbWeOwnTheNight")!, "We Own The Night by ..."),
    ]
    reloadTable()
    
    if let pBar = playerBar { spawnPlayerBar(pBar) }
    
    
    
    
    
    
    
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    didLoadStuff()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    willAppearStuff()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    didAppearStuff()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}  // END OF VC

