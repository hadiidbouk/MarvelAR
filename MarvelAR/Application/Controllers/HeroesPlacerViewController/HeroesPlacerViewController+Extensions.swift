//
//  HeroesPlacerViewController+Extensions.swift
//  MarvelAR
//
//  Created by Hadi Dbouk on 6/13/19.
//  Copyright © 2019 hadiidbouk. All rights reserved.
//

import UIKit

//MARK: Animation Handling
extension HeroesPlacerViewController {
    
    func hideActionView() {
        let transition = CATransition()
        transition.timingFunction = CAMediaTimingFunction(name : .easeInEaseOut)
        transition.duration = 0.2
        transition.type = .push
        transition.subtype = .fromBottom
        actionView.layer.add(transition, forKey: kCATransition)
        actionView.isHidden = true
    }
    
    func showActionView() {
        if actionView.isHidden == false { return }
        let transition = CATransition()
        transition.timingFunction = CAMediaTimingFunction(name : .easeInEaseOut)
        transition.duration = 0.2
        transition.type = .push
        transition.subtype = .fromTop
        actionView.layer.add(transition, forKey: kCATransition)
        actionView.isHidden = false
    }
    
    func hideEditBtn() {
        let transition = CATransition()
        transition.timingFunction = CAMediaTimingFunction(name : .easeIn)
        transition.duration = 0.2
        transition.type = .push
        transition.subtype = .fromLeft
        editBtn.layer.add(transition, forKey: kCATransition)
        editBtn.isHidden = true
    }
    
    func showEditBtn() {
        let transition = CATransition()
        transition.timingFunction = CAMediaTimingFunction(name : .easeInEaseOut)
        transition.duration = 0.2
        transition.type = .push
        transition.subtype = .fromRight
        editBtn.layer.add(transition, forKey: kCATransition)
        editBtn.isHidden = false
    }
    
    func hideHeroPickerBtn() {
        let transition = CATransition()
        transition.timingFunction = CAMediaTimingFunction(name : .easeInEaseOut)
        transition.duration = 0.2
        transition.type = .push
        transition.subtype = .fromLeft
        heroPickerBtn.layer.add(transition, forKey: kCATransition)
        heroPickerBtn.isHidden = true
    }
    
    func showHeroPickerBtn() {
        let transition = CATransition()
        transition.timingFunction = CAMediaTimingFunction(name : .easeInEaseOut)
        transition.duration = 0.2
        transition.type = .push
        transition.subtype = .fromRight
        heroPickerBtn.layer.add(transition, forKey: kCATransition)
        heroPickerBtn.isHidden = false
    }
    
    func showEditModeLbl() {
        let transition = CATransition()
        transition.timingFunction = CAMediaTimingFunction(name : .easeInEaseOut)
        transition.duration = 0.2
        transition.type = .push
        transition.subtype = .fromBottom
        editModeLbl.layer.add(transition, forKey: kCATransition)
        editModeLbl.isHidden = false
    }
    
    func hideEditModeLbl() {
        let transition = CATransition()
        transition.timingFunction = CAMediaTimingFunction(name : .easeInEaseOut)
        transition.duration = 0.2
        transition.type = .push
        transition.subtype = .fromTop
        editModeLbl.layer.add(transition, forKey: kCATransition)
        editModeLbl.isHidden = true
    }
    
    func showFocusView() {
        
        let transition = CATransition()
        transition.duration = 0.2
        transition.timingFunction = CAMediaTimingFunction(name : .easeInEaseOut)
        transition.type = .push
        transition.subtype = .fromBottom
        focusView.layer.add(transition, forKey: nil)
        focusView.isHidden = false
    }
    
    func hideFocusView() {
        
        let transition = CATransition()
        transition.duration = 0.2
        transition.timingFunction = CAMediaTimingFunction(name : .easeInEaseOut)
        transition.type = .push
        transition.subtype = .fromTop
        focusView.layer.add(transition, forKey: nil)
        focusView.isHidden = true
    }
    
    func showCloseEditModeBtn() {
        let transition = CATransition()
        transition.timingFunction = CAMediaTimingFunction(name : .easeInEaseOut)
        transition.duration = 0.2
        transition.type = .push
        transition.subtype = .fromLeft
        closeEditModeBtn.layer.add(transition, forKey: kCATransition)
        closeEditModeBtn.isHidden = false
    }
    
    func hideCloseEditModeBtn() {
        let transition = CATransition()
        transition.timingFunction = CAMediaTimingFunction(name : .easeInEaseOut)
        transition.duration = 0.2
        transition.type = .push
        transition.subtype = .fromRight
        closeEditModeBtn.layer.add(transition, forKey: kCATransition)
        closeEditModeBtn.isHidden = true
    }
}
