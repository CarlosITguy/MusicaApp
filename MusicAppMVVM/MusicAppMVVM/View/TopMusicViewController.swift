//
//  TopMusicViewController.swift
//  MusicAppMVVM
//
//  Created by Consultant on 11/22/22.
//

import UIKit

class TopMusicViewController: UIViewController {
    var results : [Songs]?
    var sendindex : Int?
    var state : [String : Bool]?
    let songsUrl : String =
    "https://rss.applemarketingtools.com/api/v2/us/music/most-played/100/albums.json"
    let defaultURL : String = "https://is5-ssl.mzstatic.com/image/thumb/Music112/v4/fe/41/62/fe416296-9eea-eb51-22f0-0c4dbd75490e/dj.jliixcbt.jpg/100x100bb.jpg"
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
                guard let imagUrl = self.results?[1].artworkUrl100 else {return}
                print(imagUrl)
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
        collectionView.backgroundColor = .gray
        collectionView.register(MusicCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
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
        
//        print(imagUrl)
//        var imgUrl :String? = self.results?[indexPath.row].name
//        guard let imgUrl = imgUrl else {return UICollectionViewCell()}
//        var safeimg : Data?
        Network().fetchImageData(path: self.results?[indexPath.row].artworkUrl100 ??  self.defaultURL) { data in
            guard let data = data else {return}
            print(data)
            DispatchQueue.main.async {
                cel.songImage.image = UIImage(data: data)

            }
            
        }
        
//        cel.songImage.image = UIImage(data: safeimg)
        
        cel.songNameLabel.text = self.results?[indexPath.row].name
//        cel.songImage.image = UIImage(named: "ImgDemo2" )
        cel.likeButtom.isOn = true
        print(cel.likeButtom.isOn == true)
        return cel
        
    }
}

extension TopMusicViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("\(indexPath.row)")
        self.sendindex = indexPath.row
        self.performSegue(withIdentifier: "normalSegue", sender: self)
        let vc = DetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        vc.results1 = results
        vc.index = sendindex
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailTableViewcotroller") as? DetailViewController else { return }
//
      
        
    }
    override func  prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let info = segue.destination as! DetailViewController
        info.results1 = results
        info.index = sendindex
        
    }
    
}
