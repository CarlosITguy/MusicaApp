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
    
    // For the fetch
    var results : [Songs]?
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
    var recoverdata : [Song]?
        
//    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    lazy var Song2 : Song = {
        let sn = Song(context: self.coreDataMusic.contexto)
        sn.name = "LaBamba"
        sn.id = "2"
        coreDataMusic.mySaveContex()
        return sn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.coreDataMusic.myFetchStruc()
        print(self.coreDataMusic.recoverdata?.compactMap{$0.name}.count as Any)
        
       
        
        
        self.network.fetchMainStruct(url1: self.myGlobaConstants.songsUrl) { mainStruct in
            //            print(mainStruct?.feed.results[1].genres)
            guard let mainStruct = mainStruct?.feed.results else {return}
            
            self.results = mainStruct
            DispatchQueue.main.async {
                self.collectionView1?.reloadData()
                guard let imagUrl = self.results?[1].artworkUrl100 else {return}
                print(imagUrl)
            }
            
        }
        self.musicAppViewModel.imageData(for: 1) { Data in
            DispatchQueue.main.async {
                print("this is the data")
            }
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cel  = self.collectionView1?.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? MusicCollectionViewCell  else {return UICollectionViewCell ()}
        cel.songNameLabel.text = self.results![indexPath.row].name
        //
        Network().fetchImageData(path: self.results?[indexPath.row].artworkUrl100 ??  self.myGlobaConstants.defaultURL) { data in
            guard let data = data else {return}
            DispatchQueue.main.async {
                cel.songImage.image = UIImage(data: data)
            }
            
        }
        guard let newVar = self.results?[indexPath.row].id else {return UICollectionViewCell()}
        guard Int(newVar) != nil else {return UICollectionViewCell()}
        let keyExists = self.Likelist[indexPath.row] != nil
        
        if keyExists{
//            print("The key is present in the dictionary")
            guard let state = self.Likelist[indexPath.row] else {return UICollectionViewCell()}
            cel.likeButtom.isOn = state
            cel.likeButtom.isOn = self.Likelist[indexPath.row]!
            
            print(self.Likelist)
            
        } else {
//            print("The key is not present in the dictionary")
            self.Likelist[indexPath.row] = false
            self.dicIdResults[indexPath.row] = self.results?[indexPath.row]
            cel.likeButtom.tag = indexPath.row
            cel.likeButtom.isOn = false
            
             
            
            
            
            
        }
        
        cel.likeButtom.addTarget(self, action: #selector(self.switchStateDidChange(_:)), for: .valueChanged)
                
        return cel
        
    }
    
}

extension TopMusicViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("\(indexPath.row)")
        guard let uwId = self.results?[indexPath.row].id else {return}
        self.sendId = Int(uwId)
        
        self.sendindex = indexPath.row
        self.performSegue(withIdentifier: "normalSegue", sender: self)
        let vc = DetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        vc.results1 = results
        vc.index = sendindex
        vc.idRecived = sendId
        vc.dicIdResultsRec = dicIdResults
        vc.Likelist1 = Likelist
    }
    override func  prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let info = segue.destination as! DetailViewController
        info.results1 = results
        info.index = sendindex
        info.idRecived = sendId
        info.dicIdResultsRec = dicIdResults
        info.Likelist1 = Likelist
        
    }
    
    @objc func switchStateDidChange(_ sender : UISwitch)   {
        
//        self.Likelist[sender.tag]!.toggle()

        if (sender.isOn == true){
            //            print("UISwitch state is now ON")
            self.Likelist[sender.tag]?.toggle()
            var _ : Song = {
               let sn = Song(context: self.coreDataMusic.contexto)
                sn.name =  self.results![sender.tag].name
                sn.id = self.results![sender.tag].id
               coreDataMusic.mySaveContex()
               return sn
            }()

            print(sender.tag)

        }
        else{
            // print("UISwitch state is now Off")
            self.Likelist[sender.tag]?.toggle()
            
        }
    }
//    func makeFavStruct(indx : Int) -> Song {
//        let song1 = Song(context: self.coreDataMusic.contexto)
//        song1.name = self.results?[indx].name
//        song1.id = self.results?[indx].id
////        self.saveSong()
//        self.coreDataMusic.mySaveContex()
//        self.coreDataMusic.myFetchStruc()
//        //        printContent(self.recoverdata?.compactMap{$0.id})
//
//        return song1
//
//    }
    func deleteAllData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try self.coreDataMusic.contexto.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                self.coreDataMusic.contexto.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
}


