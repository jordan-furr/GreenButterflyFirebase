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

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8))
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
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var co2label: UILabel!
    
    @IBOutlet weak var plusButton: UIButton!
    
    
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
        co2label.text = "\(count)"
        let image = UIImage(named: habit.iconUID)
        iconImageView.image = image
        iconImageView.setImageColor(color: .white)
        plusButton.addTarget(self, action: #selector(self.animateNumber(sender:)), for: .touchUpInside)
    }
    
    @objc fileprivate func animateNumber(sender:UIButton){
        self.animateView(sender)
        self.animateView(co2label)
    }
    
    fileprivate func animateView(_ viewToAnimate:UIView){
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            viewToAnimate.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            
        }) { (_) in
            print("animation complete")
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
    }
}
