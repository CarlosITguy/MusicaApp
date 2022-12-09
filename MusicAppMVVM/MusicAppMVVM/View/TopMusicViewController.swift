//
//  TopMusicViewController.swift
//  MusicAppMVVM
//
//  Created by Consultant on 11/22/22.
//

import UIKit
import CoreData

class TopMusicViewController: UIViewController {
    
    var collectionView1 : UICollectionView?
    
    var dicIdResults : [Int : Songs] = [:]
    //   For the segue
    var sendindex : Int = Int()
    var sendId : Int?
    //  For the like bottom
    //    var musicAppViewModel.Likelist : [Int : Bool] = [:]
    
    //    Call instance for other class
    let coreDataMusic = CoreDataMusic()
    let myGlobaConstants = MyGlobalConstats()
    let network = Network()
    let musicAppViewModel = MusicAppViewModel()
    let detalViewControler = DetailViewController()
    //    This part is for triing to do some variable tipe COREDATA
    
    private func bindf (){
        
        self.musicAppViewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.collectionView1?.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.coreDataMusic.myFetchStruc()

        self.musicAppViewModel.Makea100FalseDictList()
//        self.coreDataMusic.delAll()

        self.bindf()
        self.musicAppViewModel.litleFunc()
        print(self.coreDataMusic.recoverdata?.compactMap{$0.name}.count as Any)
        if self.coreDataMusic.recoverdata?.count != nil{
            //            print(self.coreDataMusic.recoverdata?[1])
        }
        setUpCV()
        view.addSubview(self.collectionView1!)
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
        
        self.collectionView1 = collectionView
    }
    
    
    
}
extension TopMusicViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.musicAppViewModel.results1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cel  = self.collectionView1?.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? MusicCollectionViewCell  else {return UICollectionViewCell ()}
        
        cel.songNameLabel.text = self.musicAppViewModel.results1[indexPath.row].name
        cel.likeButtom.isOn = musicAppViewModel.Likelist[indexPath.row] ?? false
        cel.likeButtom.tag = indexPath.row
        self.musicAppViewModel.litleImageFunc(indexpath: indexPath.row)
        guard let data2 = self.musicAppViewModel.imagedata[indexPath.row] else {return cel}
        cel.songImage.image = UIImage(data: data2)
        
        
  
        cel.likeButtom.addTarget(self, action: #selector(self.switchStateDidChange(_:)), for: .valueChanged)
        
        return cel
        
    }
    
}

extension TopMusicViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let uwId = self.musicAppViewModel.results1[indexPath.row].id
        self.sendId = Int(uwId)
        self.sendindex = indexPath.row
        guard let islike = self.musicAppViewModel.Likelist[indexPath.row] else {return}
        self.detalViewControler.likeButtom.isOn = islike
        self.performSegue(withIdentifier: "normalSegue", sender: self)
        
        
        
    }
    
    override func  prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let info = segue.destination as! DetailViewController
        info.Geneder.text = String(describing:musicAppViewModel.results1[sendindex].genres.compactMap{$0.name} )
        info.songImage.image = UIImage(data: musicAppViewModel.imagedata[sendindex] ?? Data())
        info.releaseDate.text = musicAppViewModel.results1[sendindex].releaseDate
        info.artistName.text = musicAppViewModel.results1[sendindex].artistName
        info.Likelist1 = musicAppViewModel.Likelist[sendindex] ?? false
        info.songNameLabel.text = musicAppViewModel.results1[sendindex].name
        info.likeButtom.isOn =  musicAppViewModel.Likelist[sendindex] ?? false
        info.index = sendindex
    }
    
    
    @objc func switchStateDidChange(_ sender : UISwitch)   {
        
        self.musicAppViewModel.forSwitch(senderIsOn: sender.isOn, senderTag: sender.tag)
        
    }
    
}
