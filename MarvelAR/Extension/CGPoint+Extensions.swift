//
//  CGPoint+Extensions.swift
//  MarvelAR
//
//  Created by Hadi Dbouk on 6/14/19.
//  Copyright © 2019 hadiidbouk. All rights reserved.
//

import UIKit

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(self.x - point.x, 2) + pow(self.y - point.y, 2))
    }
}
