//
//  ListingModel.swift
//  city-views
//
//  Created by Michael Nienaber on 4/22/19.
//  Copyright © 2019 Michael Nienaber. All rights reserved.
//

import Foundation

class ListingModel: NSObject {

  class func sharedInstance() -> ListingModel {
    struct Singleton {
      static var sharedInstance = ListingModel()
    }
    return Singleton.sharedInstance
  }
}
