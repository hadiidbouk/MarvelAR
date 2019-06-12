//
//  BaseTypes+Extensions.swift
//  MarvelAR
//
//  Created by Hadi Dbouk on 6/12/19.
//  Copyright © 2019 hadiidbouk. All rights reserved.
//

import Foundation

extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}
