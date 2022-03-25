//
//  DataPersistentManager.swift
//  iosTestApp1
//
//  Created by sangdon kim on 2022/03/10.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager {
    
    enum DatabasError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
        
    }
    
    static let shared = DataPersistenceManager()
    
    func downloadTitleWith(model : Title, completion: @escaping (Result<Void, Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = Titleitem(context: context)
        
        item.original_title = model.original_title
        item.original_name = model.original_name
        item.id = Int64(model.id)
        item.overview = model.overview
        item.poster_path = model.poster_path
        item.media_type = model.media_type
        item.release_date = model.release_date
        item.vote_count = Int64(model.vote_count)
        item.vote_average = model.vote_average
        
        do {
            try context.save()
            NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
            completion(.success(()))
        } catch {
            completion(.failure(DatabasError.failedToSaveData))
        }
    }
    
    func fetchingTitlesFromDataBase(completion: @escaping (Result<[Titleitem],Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<Titleitem>
        
        request = Titleitem.fetchRequest()
        
        do {
            let titles = try context.fetch(request)
            completion(.success(titles))
        } catch {
            completion(.failure(DatabasError.failedToFetchData))
        }
    }
    
    func deleteTitleWith(model: Titleitem, completion: @escaping (Result<Void,Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabasError.failedToDeleteData))
        }
    }
}
