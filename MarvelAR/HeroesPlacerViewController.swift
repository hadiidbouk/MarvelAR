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
        let heroesPickerViewController = HeroesPickerViewController(size: CGSize(width: view.bounds.width, height: 300))
        heroesPickerViewController.modalPresentationStyle = .popover
        heroesPickerViewController.popoverPresentationController?.delegate = self
        present(heroesPickerViewController, animated: true, completion: nil)
        heroesPickerViewController.popoverPresentationController?.sourceView = sender as? UIView
    }
}

//MARK: UIPopoverPresentationControllerDelegate
extension HeroesPlacerViewController : UIPopoverPresentationControllerDelegate {
    
}
