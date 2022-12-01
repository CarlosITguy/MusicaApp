//
//  CoreDataMusicManager.swift
//  MusicAppMVVM
//
//  Created by Consultant on 11/29/22.
//

import Foundation
import CoreData
import UIKit

class CoreDataMusic {
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var recoverdata : [Song]?
    lazy var persistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MusicAppMVVM")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Something Went Terribly Wrong. Check container name.")
            }
        }
        return container
    }()

    func saveSong() {
        let context = self.persistantContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("The Song was fully saved")
            } catch {
                print(error)
            }
        }
    }
    func delete(song: Song) {
            do{
                try contexto.delete(NSManagedObject() )
                print("The song was safe")
                
            }catch{
                print("error")
            }
            
        
    }
    
    func makeDataStruct() -> Song {
        let song1 = Song(context: self.contexto)
        song1.name = "name1"
        song1.id = "1"
        CoreDataMusic().saveSong()
        
        return song1
        
    }
    
    func mySaveContex(){
        do{
            try contexto.save()
            print("The song was safe")
            
        }catch{
            print("error")
        }
        
    }
    
    
    func myFetchStruc(){
        //        let context = self.contexto
        let request : NSFetchRequest<Song> = Song.fetchRequest()
        do{
            recoverdata = try contexto.fetch(request)
            print("el fetch funciono")
            
            
        }catch{
            print(error)
            
        }
    }
    
//    func makeFavStruct(index : Int) -> Song {
//        let song1 = Song(context: self.contexto)
//        song1.name = TopMusicViewController().results?[index].name
//        song1.id = TopMusicViewController().results?[index].id
////        self.saveSong()
//        self.mySaveContex()
//        self.myFetchStruc()
//        //        printContent(self.recoverdata?.compactMap{$0.id})
//        
//        return song1
//        
//    }
////
}
