//
//  NewHabitTableViewCell.swift
//  GreenButterflyFirebase
//
//  Created by Jordan Furr on 5/28/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class NewHabitTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
   override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left:  8, bottom: 5, right: 8))
        contentView.layer.cornerRadius = 5
        //contentView.backgroundColor = .darkGreen
        backgroundColor = .clear // very important
        layer.masksToBounds = false
        layer.shadowOpacity = 0.23
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
    }
    
    var habit: Habit?
    
    func setHabit(habit: Habit){
        self.habit = habit
           updateUI()
       }
    
       @objc func updateUI(){
           guard let habit = habit else {return}
           titleLabel.text = habit.title
           let image = UIImage(named: habit.iconUID)
           iconImageView.image = image
        iconImageView.setImageColor(color: .white)
       }

}
