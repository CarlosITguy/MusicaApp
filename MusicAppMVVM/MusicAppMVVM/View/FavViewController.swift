//
//  TopMusicViewController.swift
//  MusicAppMVVM
//
//  Created by Consultant on 11/22/22.
//

import UIKit
import CoreData

class FavMusicViewController: UIViewController {
    
    
    
    var collectionView1 : UICollectionView?
    
    var dicIdResults : [Int : Songs] = [:]
    //   For the segue
    var sendindex : Int?
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
                self?.collectionView1?.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        self.coreDataMusic.delAll()
        
        print ("Estoy en favoritos")
        self.bindf()
//        self.musicAppViewModel.litleFunc()
        self.coreDataMusic.myFetchStruc()
        print(self.coreDataMusic.recoverdata?.compactMap{$0.name}.count as Any)
        print(self.coreDataMusic.recoverdata?[1])
        
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
        collectionView.backgroundColor = .purple
        self.collectionView1 = collectionView
    }
    
    
    
}
extension FavMusicViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //        return self.results?.count ?? 0
        return self.musicAppViewModel.results1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cel  = self.collectionView1?.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? MusicCollectionViewCell  else {return UICollectionViewCell ()}
        
        cel.songNameLabel.text = self.musicAppViewModel.results1[indexPath.row].name
        
        //
        Network().fetchImageData(path: self.musicAppViewModel.results1[indexPath.row].artworkUrl100 ) { data in
            guard let data = data else {return}
            DispatchQueue.main.async {
                cel.songImage.image = UIImage(data: data)
            }
            
        }
        if self.Likelist.count <= indexPath.row {
            print("we not found # \(indexPath.row)")
//            Likelist[indexPath.row] = false
//            cel.likeButtom.tag = indexPath.row
//            self.dicIdResults[indexPath.row] = self.musicAppViewModel.results1[indexPath.row]
//
        }else {
            
            print("we found likelist # \(indexPath.row)")
            
        }
        cel.likeButtom.isOn = Likelist[indexPath.row] ?? false
        
        
        
        let keyExists = self.Likelist[indexPath.row] != nil
        
        if keyExists{
            //            print("The key is present in the dictionary")
            guard let state = self.Likelist[indexPath.row] else {return UICollectionViewCell()}
            cel.likeButtom.isOn = state
           
            
            print(self.Likelist)
            
        } else {
            //            print("The key is not present in the dictionary")
            self.Likelist[indexPath.row] = false
            self.dicIdResults[indexPath.row] = self.musicAppViewModel.results1[indexPath.row]
            cel.likeButtom.tag = indexPath.row
            cel.likeButtom.isOn = false
            
        }
        
        cel.likeButtom.addTarget(self, action: #selector(self.switchStateDidChange(_:)), for: .valueChanged)
        
        return cel
        
    }
    
}

extension FavMusicViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //        print("\(indexPath.row)")
        let uwId = self.musicAppViewModel.results1[indexPath.row].id
        self.sendId = Int(uwId)
        self.sendindex = indexPath.row
        self.performSegue(withIdentifier: "favsSegue", sender: self)
        
    }
    override func  prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let info = segue.destination as! DetailViewController
        info.results1 =  self.musicAppViewModel.results1
        info.index = sendindex
        info.idRecived = sendId
        info.dicIdResultsRec = dicIdResults
        info.Likelist1 = Likelist
        
    }
    
    
    @objc func switchStateDidChange(_ sender : UISwitch)   {
        self.musicAppViewModel.forSwitch(senderIsOn: sender.isOn, senderTag: sender.tag)
        self.Likelist[sender.tag]?.toggle()
        
    }
    
}
