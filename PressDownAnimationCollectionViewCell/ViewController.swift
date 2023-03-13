//
//  ViewController.swift
//  PressDownAnimationCollectionViewCell
//
//  Created by Salman Biljeek on 3/12/23.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        self.collectionView.backgroundColor = .systemOrange.withAlphaComponent(0.3)
        
        self.collectionView.register(MyCell.self, forCellWithReuseIdentifier: myCellId)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.collectionViewLayout = createLayout()
        
        self.view.addSubview(self.collectionView)
        
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    private let myCellId = "myCellId"
    var items: [[String: String]] = [
        ["username": "hackhero", "profileImageName": "profileImage1", "text": "Tap and hold the item to see the press-down effect in action.", "imageName": "image1", "timestamp": "16m ago"],
        ["username": "swiftpro", "profileImageName": "profileImage2", "text": "The cell shrinks and the opacity is reduced. When released, it animates back to its original state.", "imageName": "image2", "timestamp": "2h ago"]
    ]
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.myCellId, for: indexPath) as! MyCell
        guard self.items.indices.contains(indexPath.item) else { return cell }
        let item = items[indexPath.item]
        cell.item = item
        return cell
    }
    
    fileprivate func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            let estimatedHeight = CGFloat(100)
            let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(estimatedHeight))
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(estimatedHeight)))
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: layoutSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 8
            section.contentInsets.top = 10
            section.contentInsets.leading = 16
            section.contentInsets.trailing = 16
            section.contentInsets.bottom = 22
            return section
        }
    }
}

