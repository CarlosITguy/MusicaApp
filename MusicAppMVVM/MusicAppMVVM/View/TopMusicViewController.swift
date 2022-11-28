//
//  TopMusicViewController.swift
//  MusicAppMVVM
//
//  Created by Consultant on 11/22/22.
//

import UIKit

class TopMusicViewController: UIViewController {
    var results : [Songs]?
    var state : [String : Bool]?
    let songsUrl : String =
    "https://rss.applemarketingtools.com/api/v2/us/music/most-played/100/albums.json"
    var collectionView1 : UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCV()

        view.addSubview(self.collectionView1!)
// "Remember this is to go in the view model also de variables"
        Network().fetchMainStruct(url1: self.songsUrl) { mainStruct in
//            print(mainStruct?.feed.results[1].genres)
            guard let mainStruct = mainStruct?.feed.results else {return}
            
            self.results = mainStruct
            DispatchQueue.main.async {
                self.collectionView1?.reloadData()

            }
            
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
        
        return self.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cel  = self.collectionView1?.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? MusicCollectionViewCell  else {return UICollectionViewCell ()}
        cel.songNameLabel.text = self.results?[indexPath.row].name
        cel.songImage.image = UIImage(named: "ImgDemo2" )
        cel.likeButtom.isOn = true
        print(cel.likeButtom.isOn == true)
        return cel
        
    }
}

extension TopMusicViewController : UICollectionViewDelegate{
    
    
}
