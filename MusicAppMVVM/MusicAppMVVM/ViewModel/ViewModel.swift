//
//  ViewModel.swift
//  MusicAppMVVM
//
//  Created by Consultant on 11/28/22.
//

import Foundation
import UIKit



class MusicAppViewModel {
    typealias UpdateHandler = (() -> Void)
    let network = Network()
    let coreDataMusic = CoreDataMusic()
    var refreshData = {() -> () in }
    let myGlobalConstants = MyGlobalConstats()
    var updateHandler: UpdateHandler?
    var imagedata : [Int : Data] = [:]
    {
        didSet{refreshData()}
    }
    var results1 : [Songs] = []{
        didSet{refreshData()}
    }
    var Likelist : [Int : Bool] = [:]{
        didSet{refreshData()}
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
    
    
    func litleImageFunc( indexpath : Int) {
        guard self.imagedata[indexpath] == nil else { return }
        
        self.network.fetchImageData(path: self.results1[indexpath].artworkUrl100 ) { data in
            guard let data = data else {return}
            self.imagedata[indexpath] = data
            
        }
        
    }
    
    func Makea100FalseDictList(){
        self.coreDataMusic.myFetchStruc()

        for i in 0..<100 {
            self.Likelist[i] = false
        }
        self.coreDataMusic.recoverdata?.forEach({
            self.Likelist[Int($0.indexpath)] = true
        })

        
    }
    
    
    func forSwitch(senderIsOn : Bool, senderTag:Int) {
        self.Likelist[senderTag]?.toggle()
        print("\(senderIsOn)")
        if senderIsOn {
            print("UISwitch state is now ON")
            self.coreDataMusic.myFetchStruc()
            
            print("UISwitch \(String(describing: coreDataMusic.recoverdata?.compactMap({$0.name})))")
//            print("UISwitch \(self.results1[senderTag].name)")
            guard let isInCore = coreDataMusic.recoverdata?.compactMap({$0.name}).contains(self.results1[senderTag].name) else {return}
            print("UISwitch \(isInCore)");
            
            if !(isInCore){
                print("UISwitch is not en core")
                self.coreDataMusic.myFetchStruc()
                let generes = self.results1[senderTag].genres.compactMap{$0.name}
                let generesStr = String(describing: generes)
                var _ : Song = {
                    
                    let sn = Song(context: coreDataMusic.contexto)
                    sn.name = self.results1[senderTag].name
                    sn.id = self.results1[senderTag].id
                    sn.releaseDate = self.results1[senderTag].releaseDate
                    sn.imgUrl = self.results1[senderTag].artworkUrl100
                    sn.genres = generesStr
                    sn.like = self.Likelist[senderTag] ?? true
                    sn.kind = self.results1[senderTag].kind
                    sn.indexpath = Int16(senderTag)
                    sn.image = imagedata[senderTag]
                    sn.artist = self.results1[senderTag].artistName
                    self.coreDataMusic.mySaveContex()
                    return sn
                }()
            }
        }
        
        if senderIsOn == false {
            print("UISwitch state is now Off")
            let cor = self.coreDataMusic
            let corDaMuReComMapNames = coreDataMusic.recoverdata?.compactMap({$0.name})
            guard let isInCore = corDaMuReComMapNames?.contains(self.results1[senderTag].name) else {return}
            print("UISwitch \(isInCore)");
            if isInCore{
                
                guard let deleteIndex = coreDataMusic.recoverdata?.compactMap({$0.name}).firstIndex(of: self.results1[senderTag].name) else { return } // 0
                
                guard let deletedItem =  cor.recoverdata?[deleteIndex] else {return}
                cor.contexto.delete(deletedItem)
                cor.mySaveContex()
            }
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
