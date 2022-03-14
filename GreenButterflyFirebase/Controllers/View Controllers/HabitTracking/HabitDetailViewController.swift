//
//  HabitDetailViewController.swift
//  GreenButterflyFirebase
//
//  Created by Jordan Furr on 5/21/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

protocol ModalDismissed: AnyObject {
    func modaldismissed()
}
class HabitDetailViewController: UIViewController {

    //MARK: PROPERTIES
    var habit: Habit?
    weak var delegate: ModalDismissed?
    
    //MARK: IB OUTLETS
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var factLabel: UILabel!
    @IBOutlet weak var totalKWHLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var kwhLabel: UILabel!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var sourceButton: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var resetButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        decrementButton.addCornerRadius()
        sourceButton.addCornerRadius()
        resetButton.addCornerRadius()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.modaldismissed()
    }

    func setUpViews(){
        guard let habit = habit, let user = UserController.shared.currentUser else {return}
         let counts = user.counts[habit.identifier]
        countLabel.text = "\(counts)"
        titleLabel.text = habit.title
        
        factLabel.text = habit.fact
       
        kwhLabel.text = "co2 saved per action:   \(habit.co2Value)kg"
        let totalCO2 = Double(round((Double(counts) * habit.co2Value) * 1000) / 1000)
        totalKWHLabel.text = "Total co2 saved by actions:   \(totalCO2)kg"
        iconImageView.image = UIImage(named: habit.iconUID)
        iconImageView.setImageColor(color: UIColor.lightGreen!)
        decrementButton.addTarget(self, action: #selector(self.animateNumber(sender:)), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(self.animateButton(sender:)), for: .touchUpInside)
        sourceButton.addTarget(self, action: #selector(self.animateButton(sender:)), for: .touchUpInside)
    }
    
    //MARK: IB ACTIONS

    @IBAction func decrementTapped(_ sender: Any) {
        guard let habit = habit else {return}
        let newCount = HabitController.shared.decrementHabitCounter(habit: habit)
        countLabel.text = "\(newCount)"
        print("tapped")
        HabitController.shared.fetchUserHabits()
    }
    
    
    @IBAction func sourceTapped(_ sender: Any) {
        guard let habit = habit else {return}
        if let url = URL(string: habit.source){
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func resetTapped(_ sender: Any) {
        guard let habit = habit else {return}
        let alertController = UIAlertController(title: "Reset Count?", message: "Are you sure you want to reset your count for this action to 0?", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Yes", style: .default, handler: { action in
            HabitController.shared.resetHabit(habit: habit)
            self.setUpViews()
        })
        alertController.addAction(defaultAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    @objc fileprivate func animateNumber(sender:UIButton){
           self.animateView(countLabel)
        self.animateView(sender)
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
    
}
