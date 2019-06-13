//
//  HeroesCreator.swift
//  MarvelAR
//
//  Created by Hadi Dbouk on 6/13/19.
//  Copyright © 2019 hadiidbouk. All rights reserved.
//

import Foundation
import SceneKit

class Heroes {
    
    static func getHeroNode(by name: String) -> SCNNode {
        switch name {
        case "ironMan":
            return getHeroNode(name: name, eulerAngles: SCNVector3(5, 0, 0))
        case "hulk":
            return getHeroNode(name: name, eulerAngles: SCNVector3(0, 0.3, 0))
        default:
            return getHeroNode(name: "captainAmerica", eulerAngles: SCNVector3(5, -0.3, 0))
        }
    }
    
    private static func getHeroNode(name: String, eulerAngles: SCNVector3) -> SCNNode {
        let scene: SCNScene = SCNScene(named: "heroes.scnassets/\(name)/\(name).dae")!
        let rootNode = scene.rootNode
        rootNode.eulerAngles = eulerAngles
        rootNode.name = name
        return rootNode
    }
}
