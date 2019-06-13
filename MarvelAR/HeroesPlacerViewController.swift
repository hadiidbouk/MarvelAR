//
//  HeroesPlacer.swift
//  MarvelAR
//
//  Created by Hadi Dbouk on 6/11/19.
//  Copyright © 2019 hadiidbouk. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class HeroesPlacerViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!
    
    var heroesPickerViewController: HeroesPickerViewController!
    var selectedHeroName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    @IBAction func onPickAHeroBtnPressed(_ sender: Any) {
        heroesPickerViewController = HeroesPickerViewController(size: CGSize(width: view.bounds.width, height: 300))
        heroesPickerViewController.modalPresentationStyle = .popover
        heroesPickerViewController.popoverPresentationController?.delegate = self
        heroesPickerViewController.heroesPlacerViewController = self
        present(heroesPickerViewController, animated: true, completion: nil)
        heroesPickerViewController.popoverPresentationController?.sourceView = sender as? UIView
    }
    
    func onHeroSelected(selectedHeroName: String?) {
        self.selectedHeroName = selectedHeroName
        heroesPickerViewController.dismiss(animated: true, completion: nil)
    }
    
    func placeHero(position: SCNVector3) {
        guard let nodeName = selectedHeroName else { return }
        let node = Heroes.getHeroNode(by: nodeName)
        node.position = position
        node.scale = SCNVector3(0.1, 0.1, 0.1)
        sceneView.scene.rootNode.addChildNode(node)
    }
}

//MARK: UIPopoverPresentationControllerDelegate
extension HeroesPlacerViewController : UIPopoverPresentationControllerDelegate {
    
}

//MARK: ARSCNViewDelegate
extension HeroesPlacerViewController : ARSCNViewDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if heroesPickerViewController.isViewLoaded && (heroesPickerViewController.view.window != nil) {
            return
        }
        
        guard let touch = touches.first else { return }
        
        let results = sceneView.hitTest(touch.location(in: sceneView), types: [.featurePoint])
        guard let hitFeature = results.last else { return }
        let hitTransform = SCNMatrix4(hitFeature.worldTransform)
        let hitPosition = SCNVector3Make(hitTransform.m41, hitTransform.m42, hitTransform.m43)
        placeHero(position: hitPosition)
    }
}
