//
//  FrontViewController.swift
//  Chapter04-SideBarDIY
//
//  Created by 위대연 on 2021/06/01.
//

import UIKit
class FrontViewController : UIViewController {
    var delegate: RevealViewController?
     
    override func viewDidLoad() {
        super.viewDidLoad()
        let btnSideBar = UIBarButtonItem(image: UIImage(named: "sidemenu.png"), style: .plain, target: self, action: #selector(self.moveSide))
        self.navigationItem.leftBarButtonItem = btnSideBar
        
        let dragLeft = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.moveSide(_:)))
        dragLeft.edges = UIRectEdge.left
        self.view.addGestureRecognizer(dragLeft)
        
        let dragRight = UISwipeGestureRecognizer(target: self, action: #selector(self.moveSide(_:)))
        dragRight.direction = .left
        self.view.addGestureRecognizer(dragRight)
    }
    
    @objc func moveSide(_ sender: Any) {
        if self.delegate?.isSideBarShowing == false {
            self.delegate?.openSideBar(nil)
        } else {
            self.delegate?.closeSideBar(nil)
        }
        
    }
    
}
