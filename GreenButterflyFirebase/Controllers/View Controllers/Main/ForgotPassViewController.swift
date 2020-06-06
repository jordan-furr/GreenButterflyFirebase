//
//  ForgotPassViewController.swift
//  GreenButterflyFirebase
//
//  Created by Jordan Furr on 6/5/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class ForgotPassViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.addCornerRadius()
        submitButton.addTarget(self, action: #selector(self.animateButton(sender:)), for: .touchUpInside)
    }
    
    @IBAction func resetTapped(_ sender: Any) {
        guard let email = emailTextfield.text, email != "" else  { return}
        UserController.shared.sendResetPasswordLink(withEmail: email)
        emailTextfield.text = ""
        print("reset")
    }
    
    @objc fileprivate func animateButton(sender:UIButton){
          print("tapped")
          self.animateView(sender)
      }
      
      fileprivate func animateView(_ viewToAnimate:UIView){
          UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
              viewToAnimate.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
              
          }) { (_) in
              print("animation complete")
              UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
                  viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
              }, completion: nil)
          }
      }
    
    @IBAction func donetapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backgroundTapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    
}
