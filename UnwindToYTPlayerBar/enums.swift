//
//  enums.swift
//  YTViewTranslations
//
//  Created by Jaden Nation on 6/21/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import Foundation

enum VideoCode: String {
  case StonedAlone = "ep_3ZePna0E"
  case Drowning = "HzGHgQBPyV0"
  case BodyWork = "QHe1PvKALaY"
  case TheWalker = "nGBLlFMn9Xc"
  case WeOwnTheNight = "Qq_caFxzKqg"
}

enum Segue {
  enum ForwardSegue: String {
    case from_ListVideos_VideoPlayer = "from_ListVideos_VideoPlayer"
  }
  enum UnwindSegue: String {
    case unwindToMain = "unwindToMain"
  }  
}

enum YTPlayerVar: String {
    case autohide = "autohide"
    case autoplay = "autoplay"
    case cc_load_policy = "cc_load_policy"
    case color = "color"
    case controls = "controls"
    case disableKB = "disablekb"
    case enableJSAPI = "enablejsapi"
    case end = "end"
    case fs = "fs"
    case hl = "hl"
    case iv_load_policy = "iv_load_policy"
    case list = "list"
    case listType = "listType"
    case loop = "loop"
    case modestbranding = "modestbranding"
    case origin = "origin"
    case playerapiid = "playerapiid"
    case playlist = "playlist"
    case playsinline = "playsinline"
    case rel = "rel"
    case showinfo = "showinfo"
    case start = "start"
    case theme = "theme"
}

var VideoPlayerVC_Params: [String: AnyObject] = [
  YTPlayerVar.enableJSAPI.rawValue: 1,
  YTPlayerVar.autoplay.rawValue: 1,
  YTPlayerVar.controls.rawValue: 0,
  YTPlayerVar.playsinline.rawValue: 1,
  YTPlayerVar.showinfo.rawValue: 0,
  YTPlayerVar.start.rawValue: 0,
  YTPlayerVar.rel.rawValue: 0,
  YTPlayerVar.origin.rawValue: "https://google.com",
  YTPlayerVar.modestbranding.rawValue: 1,
  YTPlayerVar.iv_load_policy.rawValue: 1,
]

var YTPlayerBar_Params: [String: AnyObject] = [
  YTPlayerVar.enableJSAPI.rawValue: 1,
  YTPlayerVar.autoplay.rawValue: 1,
  YTPlayerVar.controls.rawValue: 0,
  YTPlayerVar.playsinline.rawValue: 1,
  YTPlayerVar.showinfo.rawValue: 0,
  YTPlayerVar.start.rawValue: 0,
  YTPlayerVar.rel.rawValue: 0,
  YTPlayerVar.origin.rawValue: "https://google.com",
  YTPlayerVar.modestbranding.rawValue: 1,
  YTPlayerVar.iv_load_policy.rawValue: 1,
]



