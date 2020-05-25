//
//  InsightsViewController.swift
//  GreenButterflyFirebase
//
//  Created by Jordan Furr on 5/24/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class InsightsViewController: UIViewController {

    //MARK: IB OUTLETS
    let tonsPerKG = 0.00110231
    let acresPerTon = 2.6
    let treesPerAcre = 538
    let source = "http://blogs.bath.ac.uk/csct/wp-content/uploads/sites/43/2014/06/weighing-CO2-in-balloons.pdf"
    
    
    @IBOutlet weak var totalco2Label: UILabel!
    @IBOutlet weak var balloonLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var sourceButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        let image = UIImage(named: "titleSmall")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 20, width: 80, height: 30))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView
        totalco2Label.addCornerRadius()
        sourceButton.addCornerRadius()
    }
    
    func setUpViews() {
        let total = HabitController.shared.getUsertotalCO2() //kg
        let numberOfBalloons = Int((total * 1000) / 30)
        let balloonCount = "\(numberOfBalloons)"
        balloonLabel.text = balloonCount
        totalco2Label.text = "\(Double(round(total * 100)) / 100)kg of co2"
    }
}
