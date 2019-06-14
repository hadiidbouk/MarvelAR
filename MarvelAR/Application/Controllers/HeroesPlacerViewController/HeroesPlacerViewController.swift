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

    var heroesPickerViewController: HeroesPickerViewController?
    var selectedHeroName: HeroName?
    var selectionRingsNodes = [SCNNode]()
    var inEditMode = false
    var boundingView: UIView?
    var cameraNode: SCNNode!
    var lastSelectedNode: HeroNode?
    
    //UI
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var actionView: UIView!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var rotateBtn: UIButton!
    @IBOutlet weak var downBtn: UIButton!
    @IBOutlet weak var upBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var editModeLbl: UILabel!
    @IBOutlet weak var heroPickerBtn: UIButton!
    @IBOutlet weak var closeEditModeBtn: UIButton!
    
    var focusPoint: CGPoint {
        return CGPoint(
            x: sceneView.bounds.size.width / 2,
            y: sceneView.bounds.size.height - (sceneView.bounds.size.height / 1.618))
    }
    
    var focusView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.alpha = 0.8
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.frame.size = CGSize(width: 20, height: 20)
        imageView.image = #imageLiteral(resourceName: "focus")
        imageView.center = view.center
        
        view.addSubview(imageView)
        
        UIView.animate(withDuration: 1.0, delay: 0, options: [.repeat, .autoreverse], animations: {
            
            imageView.transform = imageView.transform.scaledBy(x: 1.5, y: 1.5)
            
        }, completion: nil)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    @IBAction func onPickAHeroBtnPressed(_ sender: Any) {
        heroesPickerViewController = HeroesPickerViewController(size: CGSize(width: view.bounds.width, height: 300))
        heroesPickerViewController!.modalPresentationStyle = .popover
        heroesPickerViewController!.popoverPresentationController?.delegate = self
        heroesPickerViewController!.heroesPlacerViewController = self
        present(heroesPickerViewController!, animated: true, completion: nil)
        heroesPickerViewController!.popoverPresentationController?.sourceView = sender as? UIView
    }
    
    func onHeroSelected(selectedHeroName: HeroName) {
        self.selectedHeroName = selectedHeroName
        heroesPickerViewController?.dismiss(animated: true, completion: nil)
    }
    
    func placeHero(position: SCNVector3) {
        guard let nodeName = selectedHeroName else { return }
        let node = HeroNode(name: nodeName)
        node.position = position
        node.scale = SCNVector3(0.1, 0.1, 0.1)
        sceneView.scene.rootNode.addChildNode(node)
        selectedHeroName = nil
        selectionRingsNodes.append(node.ringNode)
    }
    @IBAction func onEditBtnPressed(_ sender: Any) {
        hideEditBtn()
        hideHeroPickerBtn()
        showEditModeLbl()
        showFocusView()
        showCloseEditModeBtn()
        inEditMode = true
    }
    
    @IBAction func onCloseEditModeBtnPressed(_ sender: Any) {
        showEditBtn()
        showHeroPickerBtn()
        hideEditModeLbl()
        hideFocusView()
        hideCloseEditModeBtn()
        inEditMode = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if heroesPickerViewController?.isViewLoaded ?? false && (heroesPickerViewController?.view.window != nil) {
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

//MARK: UI
extension HeroesPlacerViewController {
    
    private func setupUI() {
        setupSceneView()
        setupActionView()
    }
    
    private func setupSceneView() {
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        sceneView.scene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(0, 0, 8)
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .spot
        lightNode.position = SCNVector3(0, 5, 5)
        sceneView.scene.rootNode.addChildNode(lightNode)
        
        focusView.isHidden = true
        focusView.center = focusPoint
        sceneView.addSubview(focusView)
        
        sceneView.delegate = self
    }
    
    private func setupActionView() {
        actionView.layer.cornerRadius = 15
        actionView.isHidden = true
    }
}

//MARK: UIPopoverPresentationControllerDelegate
extension HeroesPlacerViewController : UIPopoverPresentationControllerDelegate {
    
}

//MARK: ARSCNViewDelegate
extension HeroesPlacerViewController : ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
        DispatchQueue.main.async { [weak self] in
            
            guard let strongSelf = self else { return }
            
            if !strongSelf.inEditMode { return }
            
            for node in strongSelf.selectionRingsNodes {
                
                let position = node.convertPosition(SCNVector3Zero, to: nil)
                let projectedPoint = renderer.projectPoint(position)
                let projectedCGPoint = CGPoint(x: CGFloat(projectedPoint.x), y: CGFloat(projectedPoint.y))
                let distance = projectedCGPoint.distance(to: strongSelf.focusPoint)
                if distance < 50 {
                    if let heroNode = node.getTopMostParentNode() as? HeroNode {
                        strongSelf.lastSelectedNode?.onDeselectNode()
                        heroNode.onSelectNode()
                        strongSelf.showToast(message: node.getTopMostParentNode().name!, font: .systemFont(ofSize: 30))
                        strongSelf.lastSelectedNode = heroNode
                    }
                }
            }
        }
    }
}

