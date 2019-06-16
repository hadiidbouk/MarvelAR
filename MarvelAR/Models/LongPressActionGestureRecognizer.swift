//
//  LongPressActionGestureRecognizer.swift
//  MarvelAR
//
//  Created by Hadi Dbouk on 6/16/19.
//  Copyright © 2019 hadiidbouk. All rights reserved.
//

import UIKit

class LongPressActionGestureRecognizer : UILongPressGestureRecognizer {
    
    let actionType: ActionType
    
    init(actionType: ActionType, target: Any?, action: Selector?) {
        self.actionType = actionType
        super.init(target: target, action: action)
    }
}
