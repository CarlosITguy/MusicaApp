//
//  TopMusicViewController.swift
//  MusicAppMVVM
//
//  Created by Consultant on 11/22/22.
//

import UIKit

class TopMusicViewController: UIViewController {
    let SongsUrl : String = "https://rss.applemarketingtools.com/api/v2/us/music/most-played/100/albums.json"
    var collectionView1 : UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCV()

        view.addSubview(self.collectionView1!)

        Network().fetchMainStruct(url1: self.SongsUrl) { mainStruct in
            print(mainStruct)
        }
        
    }
    
    
    func setUpCV(){
        let layoutCV = UICollectionViewFlowLayout()
        
        layoutCV.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layoutCV.sectionInset = .init(top: 8, left: 8, bottom: 8, right: 8)
        
//        layoutCV.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutCV)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .red
        collectionView.register(MusicCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        
        self.collectionView1 = collectionView
    }
    
    
    
}
extension TopMusicViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cel  = self.collectionView1?.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? MusicCollectionViewCell  else {return UICollectionViewCell ()}
        
        
        return cel
        
    }
    
    
    
    
}
