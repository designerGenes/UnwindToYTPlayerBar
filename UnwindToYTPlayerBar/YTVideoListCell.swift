//
//  YTVideoListCell.swift
//  UnwindToYTPlayerBar
//
//  Created by Jaden Nation on 6/23/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import UIKit
import DKChainableAnimationKit

class YTVideoListCell: UITableViewCell {
  // MARK: outlets
  @IBOutlet weak var imgVideo: UIImageView!
  
  @IBOutlet weak var btnHeart: UIButton!
  
  // MARK: variables
  var assocURL: String!
  
  // MARK: custom methods
  func toggleButton() {
    let direction: Double = btnHeart.selected == true ? -360 : 360
    
    btnHeart.animation.rotate(direction).animateWithCompletion(0.35) {
      self.btnHeart.selected = !self.btnHeart.selected
    }
  }
  
  
  // MARK: init methods
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
  }
  
  
    override func awakeFromNib() {
        super.awakeFromNib()
        btnHeart.addTarget(self, action: #selector(toggleButton), forControlEvents: .TouchUpInside)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
