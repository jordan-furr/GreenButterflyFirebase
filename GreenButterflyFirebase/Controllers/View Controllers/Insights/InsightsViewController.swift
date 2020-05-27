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
    let source = "http://blogs.bath.ac.uk/csct/wp-content/uploads/sites/43/2014/06/weighing-CO2-in-balloons.pdf"
    var totalCo2: Double?
    var balloonsCount: Int?
    
    
    @IBOutlet weak var totalco2Label: UILabel!
    @IBOutlet weak var balloonLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var logout: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        let total = HabitController.shared.getUsertotalCO2() //kg
        totalCo2 = total
        let numberOfBalloons = Int((total * 1000) / 30)
        balloonsCount = numberOfBalloons
        setUpViews()
        collectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        let image = UIImage(named: "titleSmall")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 20, width: 80, height: 30))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView
        totalco2Label.addCornerRadius()
        collectionView.dataSource = self
        collectionView.delegate = self
        logout.addCornerRadius()
    }
    
    func setUpViews() {
        guard let balloonsCount = balloonsCount, let total = totalCo2 else {return}
        let balloonCount = "\(balloonsCount)"
        balloonLabel.text = balloonCount
        totalco2Label.text = "\(Double(round(total * 100)) / 100)kg of co2"
    }
    
    @IBAction func logouttapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Logout?", message: "Are you sure you want to log out?", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Go ahead", style: .default, handler: { action in
            
            UserController.shared.signoutCurrentUser()
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let initial = storyboard.instantiateInitialViewController() else {return}
            self.present(initial, animated: true, completion: nil)
        })
        alertController.addAction(defaultAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension InsightsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let balloons = balloonsCount else {return 0}
        return balloons
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "balloon", for: indexPath) as! MyCell
        cell.imageViewCell.image = UIImage(named: "balloon")
        return cell
    }
}

class MyCell: UICollectionViewCell{
    @IBOutlet weak var imageViewCell: UIImageView!
    
}
