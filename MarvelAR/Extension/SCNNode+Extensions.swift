//
//  SCNNode+Extensions.swift
//  MarvelAR
//
//  Created by Hadi Dbouk on 6/12/19.
//  Copyright © 2019 hadiidbouk. All rights reserved.
//

import SceneKit

extension SCNNode {
    
    func rotateAroundSelf(initialPosition: SCNVector3, duration: Double) {
        let action = SCNAction.rotate(by: .pi, around: SCNVector3(initialPosition.x, initialPosition.y + 1, initialPosition.z), duration: duration)
        let rotateForever = SCNAction.repeatForever(action)
        runAction(rotateForever)
    }
    
    func centerPivot() {
        
        let minVec = boundingBox.min
        let maxVec = boundingBox.max
        
       let bound = SCNVector3(x: maxVec.x - minVec.x,
                              y: maxVec.y - minVec.y,
                              z: maxVec.z - minVec.z)
            
        pivot = SCNMatrix4MakeTranslation(bound.x / 2,
                                          bound.y / 2,
                                          bound.z / 2)
    }
}
