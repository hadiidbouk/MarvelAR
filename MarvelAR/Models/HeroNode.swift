//
//  HeroNode.swift
//  MarvelAR
//
//  Created by Hadi Dbouk on 6/14/19.
//  Copyright © 2019 hadiidbouk. All rights reserved.
//

import SceneKit

class HeroNode : SCNNode {
    
    var ringNode: SCNNode = {
       
        let selectionGeometry = SCNTorus(ringRadius: 0.1, pipeRadius: 0.02)
        selectionGeometry.ringSegmentCount = 100
        selectionGeometry.firstMaterial?.diffuse.contents = #colorLiteral(red: 0.9578504265, green: 0.9529653119, blue: 1, alpha: 0.6693867723)
        
        let ringNode = SCNNode(geometry: selectionGeometry)
        ringNode.name = HeroNode.ringName
        ringNode.light = SCNLight()
        ringNode.light?.type = SCNLight.LightType.ambient
        ringNode.eulerAngles = SCNVector3(90.0.degreesToRadians, 0, 0)
        return ringNode
    }()
    
    var isRingHidden: Bool = true {
        didSet {
            ringNode.isHidden = isRingHidden
        }
    }
    
    private(set) var shapeNode: SCNNode!
    
    var heroName: HeroName!
    
    static let shapeName = "shape"
    static let ringName = "ring"
    
    init(name: HeroName, position: SCNVector3 = SCNVector3Zero) {
        super.init()
        
        self.name = name.rawValue
        self.position = position
        
        shapeNode = getShapeNode(by: name.rawValue)
        addChildNode(shapeNode)
        
        ringNode.isHidden = isRingHidden
        ringNode.position = SCNVector3(0, boundingBox.max.y + 0.1, 1)
        addChildNode(ringNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onSelectNode() {
        isRingHidden = false
        ringNode.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
    }
    
    func onDeselectNode() {
        isRingHidden = true
        ringNode.geometry?.firstMaterial?.diffuse.contents = UIColor.white
    }
}

//MARK: UI
extension HeroNode {
    
    private func getShapeNode(by name: String) -> SCNNode {
        switch name {
        case "ironMan":
            return getShapeNode(name: name, eulerAngles: SCNVector3(5, 0, 0))
        case "hulk":
            return getShapeNode(name: name, eulerAngles: SCNVector3(0, 0.3, 0))
        default:
            return getShapeNode(name: "captainAmerica", eulerAngles: SCNVector3(5, -0.3, 0))
        }
    }
    
    private func getShapeNode(name: String, eulerAngles: SCNVector3) -> SCNNode {
        
        let scene: SCNScene = SCNScene(named: "heroes.scnassets/\(name)/\(name).dae")!
        
        let shapeNode = scene.rootNode
        shapeNode.eulerAngles = eulerAngles
        shapeNode.position = position
        shapeNode.name = HeroNode.shapeName
        
        shapeNode.defaultPivotAndPosition()
        
        return shapeNode
    }
}
