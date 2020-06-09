//
//  ExtraViewController.swift
//  GreenButterflyFirebase
//
//  Created by Jordan Furr on 5/27/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class ExtraViewController: UIViewController {
    
    
    //MARK: IB OUTLETS
    @IBOutlet weak var logoutbutton: UIButton!
    @IBOutlet weak var sharebutton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "titleSmall")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 20, width: 80, height: 30))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView
        logoutbutton.addCornerRadius()
        logoutbutton.addTarget(self, action: #selector(self.animateButton(sender:)), for: .touchUpInside)
        sharebutton.addCornerRadius()
        sharebutton.addTarget(self, action: #selector(self.animateButton(sender:)), for: .touchUpInside)
    }
    
    @IBAction func logouttapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Logout Now", message: "Are you sure you want to log out?", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Go ahead", style: .default, handler: { action in
            
            UserController.shared.signoutCurrentUser()
            
            
            let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login") as! AuthentificationViewController
            self.present(loginVC, animated: true, completion: nil)
            
        })
        alertController.addAction(defaultAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return .portrait
        }
    }
    
    @objc fileprivate func animateButton(sender:UIButton){
        self.animateView(sender)
    }
    
    fileprivate func animateView(_ viewToAnimate:UIView){
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.93, y: 0.93)
            
        }) { (_) in
            print("animation complete")
            UIView.animate(withDuration: 0.18, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.2, options: .curveEaseIn, animations: {
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
    }
    
    @IBAction func share(){
        let promo = "Check out Green Butterfly on the AppStore! It helps you track your daily efforts to lower your carbon footprint! 😤"
        let url = URL(string: "https://itunes.apple.com/in/app/green-butterfly/id1515632919")!
        let objectsToShare: [Any] = [promo, url]
        let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.addToReadingList]
        self.present(activityViewController, animated: true, completion: nil)
        
    }
}
