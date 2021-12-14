//
//  tabar.swift
//  sideMenu
//
//  Created by virendra kumar on 31/08/21.
//

import UIKit

class TabBarVC: UITabBarController, UIGestureRecognizerDelegate {
    
    static private (set) var shared : TabBarVC?
    @IBOutlet weak var sideMenuContainer:UIView!
    @IBOutlet weak var sideMenuView:UIView!
    var isOpen = false
    
    var initialCenter = CGPoint()
    var widthSize : CGFloat = 270.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TabBarVC.shared = self
        
        
        
        addSideMenu()
        addAllGestures()
        
    }
    
    func addSideMenu(){
        
        sideMenuContainer.backgroundColor =  .clear
        sideMenuContainer.isHidden = true
        
        view.addSubview(sideMenuContainer)
        sideMenuContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sideMenuContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            sideMenuContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            sideMenuContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            sideMenuContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
    }
    
    func addAllGestures(){
        
        let edgeGestureRecognizer = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(EdgeGestureHandler))
        edgeGestureRecognizer.edges = UIRectEdge.left
        self.view.addGestureRecognizer(edgeGestureRecognizer)
        
        
        let panGestureRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(panGestureHandler))
        panGestureRecognizer.delegate = self
        self.sideMenuContainer.addGestureRecognizer(panGestureRecognizer)
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(didTapped))
        tapGesture.delegate = self
        sideMenuContainer.addGestureRecognizer(tapGesture)
        
    }
    
    //MARK:- Tap UITapGestureRecognizer Handler
    @objc func didTapped(_ sender:UITapGestureRecognizer){
        closeSideMenu()
    }
    
    //MARK:- Tap UIScreenEdgePanGestureRecognizer Handler
    @objc func EdgeGestureHandler(sender: UIScreenEdgePanGestureRecognizer) {
        let translation = sender.translation(in: sender.view!)
        
        if !isOpen{
            if sender.edges == UIRectEdge.left {
                if translation.x <= widthSize{
                    let al = (((100 * translation.x) / widthSize)/100)/2
                    sideMenuView.frame.origin.x = -(widthSize - translation.x)
                    sideMenuContainer.isHidden = false
                    sideMenuContainer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(al)
                }
            }
            if sender.state == .ended{
                let velocity = sender.velocity(in: view)
                if velocity.x > 400{
                    //MARK:- Open Side Menu
                    openSideMenu()
                }else if velocity.x < -400{
                    //MARK:- Close Side Menu
                    closeSideMenu()
                }else{
                    if translation.x < 100 {
                        //MARK:- Close Side Menu
                        closeSideMenu()
                    }else{
                        //MARK:- Open Side Menu
                        openSideMenu()
                    }
                }
            }
        }
    }
    
    //MARK:- Tap UIPanGestureRecognizer Handler
    @objc func panGestureHandler(sender: UIPanGestureRecognizer) {
        
        guard sender.view != nil else {return}
        let piece = sender.view!
        let translation = sender.translation(in: sender.view!)
        
        let newCenter = CGPoint(x: widthSize + translation.x, y: initialCenter.y + translation.y)
        
        if isOpen{
            if sender.state == .began {
                // Save the view's original position.
                self.initialCenter = piece.center
            }
            if sender.state != .ended {
                // Add the X and Y translation to the view's original position.
                if newCenter.x <= widthSize{
                    let al = (((100 * newCenter.x) / widthSize)/100)/2
                    sideMenuView.frame.origin.x = -(widthSize - newCenter.x)
                    sideMenuContainer.isHidden = false
                    sideMenuContainer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(al)
                }
            }
            else if sender.state == .ended{
                let velocity = sender.velocity(in: view)
                if velocity.x > 400{
                    //MARK:- Open Side Menu
                    openSideMenu()
                }else if velocity.x < -400{
                    //MARK:- Close Side Menu
                    closeSideMenu()
                }else{
                    if newCenter.x < 100 {
                        //MARK:- Close Side Menu
                        closeSideMenu()
                    }else{
                        //MARK:- Open Side Menu
                        openSideMenu()
                    }
                }
            }
        }
    }
    
    func openSideMenu(){
        UIView.animate(withDuration: 0.2) {
            self.isOpen = true
            self.sideMenuContainer.isHidden = false
            self.sideMenuView.frame.origin.x = 0
            self.sideMenuContainer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.5)
            self.view.layoutIfNeeded()
        }
    }
    
    func closeSideMenu(){
        
        UIView.animate(withDuration: 0.2) {
            self.isOpen = false
            self.sideMenuView.frame.origin.x = -self.widthSize
            self.sideMenuContainer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.0)
            self.view.layoutIfNeeded()
            
        } completion: { (isCompleted) in
            self.sideMenuContainer.isHidden = true
        }
    }
    
 
}
