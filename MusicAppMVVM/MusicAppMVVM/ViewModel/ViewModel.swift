//
//  ViewModel.swift
//  MusicAppMVVM
//
//  Created by Consultant on 11/28/22.
//

import Foundation



class MusicAppViewModel {
    typealias UpdateHandler = (() -> Void)
    let network = Network()
    let coreDataMusic = CoreDataMusic()
    var refreshData = {() -> () in }
    let myGlobalConstants = MyGlobalConstats()
    var updateHandler: UpdateHandler?
    var results1 : [Songs] = []{
        didSet{
            refreshData()
        }
    }
    var Likelist : [Int : Bool] = [:]{
        didSet{
            refreshData()
        }
    }

    var images : [Data] = []
    
//
    
    func litleFunc(){
        print("View wiil appear this moment")
        self.network.fetchResults(){allAboutMusic in
            guard let results = allAboutMusic?.feed.results else {return}
            self.results1 = results
        }

    }
    
    
    // Let try
    
    func sendinfor(){
         
    }
    
    func forSwitch(senderIsOn : Bool, senderTag:Int) {

        //        self.Likelist[sender.tag]!.toggle()

        if (senderIsOn == true){
            print("UISwitch state is now ON")
            let generes = self.results1[senderTag].genres.compactMap{$0.name}
            let generesStr = String(describing: generes)
            var _ : Song = {
                let sn = Song(context: coreDataMusic.contexto)
                sn.name = self.results1[senderTag].name
                sn.id = self.results1[senderTag].id
                sn.releaseDate = self.results1[senderTag].releaseDate
                sn.imgUrl = self.results1[senderTag].artworkUrl100
                sn.genres = generesStr
                sn.like = true
                sn.kind = self.results1[senderTag].kind
//                self.coreDataMusic.contexto.delete(sn)
                self.coreDataMusic.mySaveContex()//                self.Likelist[senderTag]?.toggle()
                return sn
            }()
        }
        else{
             print("UISwitch state is now Off")
//            self.Likelist[senderTag]?.toggle()

        }
    }
    
    
}

//    func deleteAllData(_ entity:String) {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
//        fetchRequest.returnsObjectsAsFaults = false
//        do {
//            let results = try self.coreDataMusic.contexto.fetch(fetchRequest)
//            for object in results {
//                guard let objectData = object as? NSManagedObject else {continue}
//                self.coreDataMusic.contexto.delete(objectData)
//            }
//        } catch let error {
//            print("Detele all data in \(entity) error :", error)
//        }
//    }



//    lazy var Song2 : Song = {
//        let sn = Song(context: self.coreDataMusic.contexto)
//        sn.name = "LaBamba"
//        sn.id = "2"
//
//        coreDataMusic.mySaveContex()
//        return sn
//    }()

//if (sender.isOn == true){
//            //            print("UISwitch state is now ON")
//
////            self.Likelist[sender.tag]?.toggle()
//            var _ : Song = {
//                let sn = Song(context: self.coreDataMusic.contexto)
//                sn.name = self.musicAppViewModel.results1[sender.tag].name
//                sn.id = self.musicAppViewModel.results1[sender.tag].id
//                coreDataMusic.mySaveContex()
//                return sn
//            }()
//
//        }
//        else{
//            // print("UISwitch state is now Off")
//            self.Likelist[sender.tag]?.toggle()
//
//        }
