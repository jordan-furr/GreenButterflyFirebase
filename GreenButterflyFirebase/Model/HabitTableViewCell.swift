//
//  HabitTableViewCell.swift
//  GreenButterflyFirebase
//
//  Created by Jordan Furr on 5/22/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

protocol HabitTableViewCellDelegate: class {
    func tappedButton(for cell: HabitTableViewCell)
}

class HabitTableViewCell: UITableViewCell {

    var habit: Habit?
    var count: Int?
    weak var delegate: HabitTableViewCellDelegate?
    
    //MARK: - IB Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    
    
    //MARK: - IB Actions
    @IBAction func plusButtonTapped(_ sender: Any) {
        delegate?.tappedButton(for: self)
    }
    
    //MARK: - Helper Funcs
    func setHabitAndCount(habit: Habit, count: Int){
        self.habit = habit
        self.count = count
        updateUI()
    }
    
    @objc func updateUI(){
        guard let habit = habit, let count = count else {return}
        titleLabel.text = habit.title
        counterLabel.text = "\(count)"
        let image = UIImage(named: habit.iconUID)
        iconImageView.image = image
        iconImageView.setImageColor(color: .white)
    }
}
