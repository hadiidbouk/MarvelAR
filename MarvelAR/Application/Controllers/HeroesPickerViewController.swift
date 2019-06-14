//
//  HeroesPickerViewController.swift
//  MarvelAR
//
//  Created by Hadi Dbouk on 6/11/19.
//  Copyright © 2019 hadiidbouk. All rights reserved.
//

import UIKit
import SceneKit

class HeroesPickerViewController: UIViewController {
    
    var cameraNode: SCNNode!
    var scene: SCNScene!
    var sceneView: SCNView!
    var size: CGSize!
    
    weak var heroesPlacerViewController: HeroesPlacerViewController?
    
    init(size: CGSize) {
        super.init(nibName: nil, bundle: nil)
        self.size = size
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preferredContentSize = size
        setupScene()
        addHerosNodes()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneView.addGestureRecognizer(tap)
    }
    
    private func setupScene() {
        
        view.frame = CGRect(origin: .zero, size: size)
        sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        view.insertSubview(sceneView, at: 0)
        scene = SCNScene(named: "heroes.scnassets/picker.scn")
        sceneView.scene = scene
        
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene?.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(0, 0, 8)
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .spot
        lightNode.position = SCNVector3(0, 5, 5)
        scene?.rootNode.addChildNode(lightNode)
    }
    
    private func addHerosNodes() {
    
        let ironManNode = HeroNode(name: .ironMan, position: SCNVector3(0, -2, 0))
        ironManNode.rotateInPlace(duration: 8)
        scene.rootNode.addChildNode(ironManNode)
        
        let captainAmericaNode = HeroNode(name: .captainAmerica, position: SCNVector3(3.2, -2.1, 0))
        captainAmericaNode.rotateInPlace(duration: 8)
        scene.rootNode.addChildNode(captainAmericaNode)
        
        let hulkNode = HeroNode(name: .hulk, position: SCNVector3(-3.5, -2, 0))
        hulkNode.rotateInPlace(duration: 8)
        scene.rootNode.addChildNode(hulkNode)
    }
    
    @objc func handleTap(_ gestureRecognizer: UIGestureRecognizer) {
        let p = gestureRecognizer.location(in: sceneView)
        let hitResults = sceneView.hitTest(p, options: [:])
        
        if hitResults.count > 0 {
            
            let node = hitResults[0].node
            let parentNode = node.getTopMostParentNode()
            guard let parentName = parentNode.name,
                  let heroName = HeroName(rawValue: parentName) else { return }
            
            heroesPlacerViewController?.onHeroSelected(selectedHeroName: heroName)
        }
    }
}
