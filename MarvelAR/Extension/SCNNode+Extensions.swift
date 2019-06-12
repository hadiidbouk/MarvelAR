//
//  SCNNode+Extensions.swift
//  MarvelAR
//
//  Created by Hadi Dbouk on 6/12/19.
//  Copyright © 2019 hadiidbouk. All rights reserved.
//

import SceneKit

extension SCNNode {
    
    func rotateInPlace(duration: Double) {
        centerPivotWithoutMoving()
        let loop = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 5, z: 0, duration: 2.5))
        runAction(loop)
    }
    
    func centerPivotWithoutMoving() {
        
        let min = boundingBox.min
        let max = boundingBox.max
        
        let x = Float(min.x + (max.x - min.x)/2)
        let y = Float(min.y + (max.y - min.y)/2)
        let z = Float(min.z + (max.z - min.z)/2)
        
        pivot = SCNMatrix4MakeTranslation(x, y, z)
        
        position = SCNVector3(x, y, z)
    }
}

extension float4x4 {
    init(translation vector: float3) {
        self.init(float4(1, 0, 0, 0),
                  float4(0, 1, 0, 0),
                  float4(0, 0, 1, 0),
                  float4(vector.x, vector.y, vector.z, 1))
    }
}
