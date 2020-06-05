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
    
    
    override func viewWillAppear(_ animated: Bool) {
        let total = HabitController.shared.getUsertotalCO2() //kg
        totalCo2 = total
        let numberOfBalloons = Int((total * 1000) / 30)
        balloonsCount = numberOfBalloons
        setUpViews()
        collectionView.reloadData()
        animateView(totalco2Label)
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
    }
    
    func setUpViews() {
        guard let balloonsCount = balloonsCount, let total = totalCo2 else {return}
        let balloonCount = "\(balloonsCount)"
        balloonLabel.text = balloonCount
        totalco2Label.text = "\(Double(round(total * 100)) / 100)kg of co2"
        collectionView.contentInset = UIEdgeInsets(top: 4, left: 8, bottom: 10, right: 8)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 2.8)
        collectionView.layer.cornerRadius = 10
        collectionView.layer.masksToBounds = true
        collectionView.layer.shadowColor = UIColor.black.cgColor
        collectionView.layer.shadowOpacity = 0.23
        collectionView.layer.shadowRadius = 4
        collectionView.layer.shadowOffset = CGSize(width: 2, height: 2)
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
        cell.imageViewCell.setImageColor(color: UIColor.lightGreen!)
        return cell
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return .portrait
        }
    }
          
          fileprivate func animateView(_ viewToAnimate:UIView){
            UIView.animate(withDuration: 0.3, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            viewToAnimate.transform = CGAffineTransform(scaleX: 1.12, y: 1.12)
                  
              }) { (_) in
                  print("animation complete")
                UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.2, options: .curveEaseIn, animations: {
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

class MyCell: UICollectionViewCell{
    @IBOutlet weak var imageViewCell: UIImageView!
    
}
