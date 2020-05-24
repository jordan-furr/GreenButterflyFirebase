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

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6.8, left: 5, bottom: 0, right: 5))
        contentView.layer.cornerRadius = 7
        backgroundColor = .clear // very important
        layer.masksToBounds = false
        layer.shadowOpacity = 0.23
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
    }
    
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
