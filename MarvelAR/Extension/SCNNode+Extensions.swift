//
//  SCNNode+Extensions.swift
//  MarvelAR
//
//  Created by Hadi Dbouk on 6/12/19.
//  Copyright © 2019 hadiidbouk. All rights reserved.
//

import SceneKit

extension SCNNode {
    
    func getTopMostParentNode() -> SCNNode {
        
        if let name = name,
            name == HeroNode.shapeName || name == HeroNode.ringName {
            return parent!
        }
        
        if let topMostParentNode = parent {
            
            return topMostParentNode.getTopMostParentNode()
        }
        
        return self
    }
    
    func rotateInPlace(duration: Double) {
        let loop = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 5, z: 0, duration: 2.5))
        runAction(loop)
    }
    
    func defaultPivotAndPosition() {
        
        pivot = SCNMatrix4MakeTranslation(0, 0, 0)
        position = SCNVector3Zero
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
