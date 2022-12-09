//
//  TopMusicViewController.swift
//  MusicAppMVVM
//
//  Created by Consultant on 11/22/22.
//

import UIKit
import CoreData

class FavMusicViewController: UIViewController {
    
    
    
    var favCollectionView : UICollectionView?
    
    var dicIdResults : [Int : Songs] = [:]
    //   For the segue
    var sendindex : Int = Int()
    var sendId : Int?
    //  For the like bottom
    var Likelist : [Int : Bool] = [:]
    
    //    Call instance for other class
    let coreDataMusic = CoreDataMusic()
    let myGlobaConstants = MyGlobalConstats()
    let network = Network()
    let musicAppViewModel = MusicAppViewModel()
    //    This part is for triing to do some variable tipe COREDATA
    
    private func bindf (){
        self.musicAppViewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.favCollectionView?.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.coreDataMusic.myFetchStruc()
        print("view will apear")
        //        print(self.coreDataMusic.recoverdata)
        print(self.coreDataMusic.recoverdata?.count)
        self.favCollectionView?.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //        self.musicAppViewModel.litleFunc()
        self.bindf()
        self.musicAppViewModel.litleFunc()
        //        print(self.coreDataMusic.recoverdata?.compactMap{$0.name}.count as Any)
        //        print(self.coreDataMusic.recoverdata?[1])
        //
        setUpCV()
        view.addSubview(self.favCollectionView!)
        
    }
    
    
    func setUpCV(){
        let layoutCV = UICollectionViewFlowLayout()
        
        layoutCV.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layoutCV.sectionInset = .init(top: 8, left: 8, bottom: 8, right: 8)
        
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
        
        self.favCollectionView = collectionView
    }
    
    
    
}
extension FavMusicViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //        return self.results?.count ?? 0
        return self.coreDataMusic.recoverdata?.count ?? 0 //self.musicAppViewModel.results1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell  = self.favCollectionView?.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? MusicCollectionViewCell  else {return UICollectionViewCell ()}
        cell.songNameLabel.text = self.coreDataMusic.recoverdata?[indexPath.row].name
        guard let dataI = self.coreDataMusic.recoverdata?[indexPath.row].image else{return cell}
        cell.songImage.image = UIImage(data: dataI)
        DispatchQueue.main.async {
        cell.likeButtom.isOn = self.coreDataMusic.recoverdata![indexPath.row].like}
        //
        cell.likeButtom.addTarget(self, action: #selector(self.switchStateDidChange(_:)), for: .valueChanged)
        return cell
    }
    
}


extension FavMusicViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //        print("\(indexPath.row)")
        self.sendindex = indexPath.row
        self.performSegue(withIdentifier: "FavsSegue", sender: self)
        
    }
    override func  prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let info = segue.destination as! DetailViewController
        //        let base = coreDataMusic.recoverdata?[sendindex]
        let coDatRec = coreDataMusic.recoverdata
        info.Geneder.text    =  coDatRec?[sendindex].genres
        info.Geneder.text    =  coDatRec?[sendindex].genres
        info.artistName.text =  coDatRec?[sendindex].artist
        info.releaseDate.text =  coDatRec?[sendindex].releaseDate
        info.songNameLabel.text = coDatRec?[sendindex].name
        info.songImage.image = UIImage(data: coDatRec?[sendindex].image ?? Data())
        info.index = Int(coDatRec?[sendindex].indexpath ?? 0)
        info.Likelist1       = true
        info.likeButtom.isOn = true
    }
    
    
    @objc func switchStateDidChange(_ sender : UISwitch)   {
        self.musicAppViewModel.forSwitch(senderIsOn: sender.isOn, senderTag: sender.tag)
    }
    
}
