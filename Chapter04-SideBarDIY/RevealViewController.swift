//
//  RevealViewController.swift
//  Chapter04-SideBarDIY
//
//  Created by 위대연 on 2021/06/01.
//

import UIKit
class RevealViewController: UIViewController {
    var contentVC: UIViewController?
    var sideVC: UIViewController?
    
    var isSideBarShowing = false
    
    let SLIDE_TIME = 0.3
    let SIDEBAR_WIDTH: CGFloat = 260
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
    }
    
    func setupView() {
        if let vc = self.storyboard?.instantiateViewController(identifier: "sw_front") as? UINavigationController {
            self.contentVC = vc
            self.contentVC?.view.clipsToBounds = false
            self.addChild(vc)
            
            self.view.addSubview(vc.view)
            vc.didMove(toParent: self)
            
            let frontVC = vc.viewControllers[0] as? FrontViewController
            frontVC?.delegate = self
        }
    }
    
    func getSideView(){
        if self.sideVC == nil {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "sw_rear") {
                self.sideVC = vc
                self.addChild(vc)
                self.view.addSubview(vc.view)
                vc.didMove(toParent: self)
                self.view.bringSubviewToFront((self.contentVC?.view)!)
            }
        }
    }
    
    func setShadowEffect(shadow: Bool, offset: CGFloat) {
        if shadow {
            self.contentVC?.view.layer.cornerRadius = 5
            self.contentVC?.view.layer.shadowOpacity = 0.5
            self.contentVC?.view.layer.shadowColor = UIColor.black.cgColor
            self.contentVC?.view.layer.shadowOffset = CGSize(width: offset, height: offset)
        } else {
            self.contentVC?.view.layer.cornerRadius = 0
            self.contentVC?.view.layer.shadowOffset = CGSize.zero
        }
    }
    
    func openSideBar(_ complete: ( () -> Void)? ) {
        self.getSideView()
        self.setShadowEffect(shadow: true, offset: -2)
        let options = UIView.AnimationOptions([.curveEaseInOut, .beginFromCurrentState])
        UIView.animate(withDuration: TimeInterval(self.SLIDE_TIME), delay: TimeInterval(0), options: options) {
            self.contentVC?.view.frame = CGRect(x: self.SIDEBAR_WIDTH, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        } completion: { (result) in
            if result {
                self.isSideBarShowing = true
                complete?()
            }
        }
    }
    
    func closeSideBar(_ complete: ( () -> Void )? ) {
        let options = UIView.AnimationOptions([.curveEaseInOut, .beginFromCurrentState])
        UIView.animate(withDuration: TimeInterval(self.SLIDE_TIME), delay: TimeInterval(0), options: options) {
            self.contentVC?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        } completion: { result in
            if result {
                self.sideVC?.view.removeFromSuperview()
                self.sideVC = nil
                self.isSideBarShowing = false
                self.setShadowEffect(shadow: false, offset: 0)
                complete?()
            }
        }

    }
}
