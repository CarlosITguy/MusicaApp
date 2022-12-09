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
    var recoverdata : [Song]?
    
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    lazy var persistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MusicAppMVVM")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Something Went Terribly Wrong. Check container name.")
            }
        }
        return container
    }()
    
    
    
    
    func delete() {
        contexto.delete(NSManagedObject())
        self.mySaveContex()
    }
    
//    func makeDataStruct() -> Song {
//        let song1 = Song(context: self.contexto)
//        song1.name = "name1"
//        song1.id = "1"
//        self.mySaveContex()
//
//        return song1
//
//    }
    
    func mySaveContex(){
        print("my save is runing")
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
    func delAll() {
        let storeContainer =
        self.persistantContainer.persistentStoreCoordinator
        
        // Delete each existing persistent store
        do {
            for store in storeContainer.persistentStores {
                try storeContainer.destroyPersistentStore(
                    at: store.url!,
                    ofType: store.type,
                    options: nil
                )
            }}catch{print("No se puede borrar todo")}
        
        // Re-create the persistent container
        self.persistantContainer = NSPersistentContainer(
            name: "MusicAppMVVM" // the name of
            // a .xcdatamodeld file
        )
        
        // Calling loadPersistentStores will re-create the
        // persistent stores
        self.persistantContainer.loadPersistentStores {
            (store, error) in
            // Handle errors
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



//let storeContainer =
//self.persistentContainer.persistentStoreCoordinator
//
//// Delete each existing persistent store
//do {
//    for store in storeContainer.persistentStores {
//        try storeContainer.destroyPersistentStore(
//            at: store.url!,
//            ofType: store.type,
//            options: nil
//        )
//    }}catch{print("No se puede borrar todo")}
//
//// Re-create the persistent container
//self.persistentContainer = NSPersistentContainer(
//    name: "MusicAppMVVM" // the name of
//    // a .xcdatamodeld file
//)
//
//// Calling loadPersistentStores will re-create the
//// persistent stores
//self.persistentContainer.loadPersistentStores {
//    (store, error) in
//    // Handle errors
//}
