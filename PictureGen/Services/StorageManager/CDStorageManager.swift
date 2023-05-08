//
//  CDStorageManager.swift
//  PictureGen
//
//  Created by Вадим Гамзаев on 08.05.2023.
//

import UIKit
import CoreData

enum CoreDataError: Error {
	case fetchFailed
	case processingFailed
	case entityCreationFailed
	case saveContextFailed
}

protocol ICDStorageManager {
	func fetchData(completion: ([Picture]) -> Void)
	func save(_ requestString: String, imageData: Data, completion: (Picture) -> Void)
	func updateData(_ requestString: String)
	func delete(_ requestString: String)
}

final class CDStorageManager: ICDStorageManager, Repository {
	
	// MARK: - Private properties
	
	private var viewContext: NSManagedObjectContext {
		return persistentContainer.viewContext
	}
	
	// MARK: - Core Data stack
	
	private var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "PictureGen")
		container.loadPersistentStores(completionHandler: { _, error in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		return container
	}()
	
	// MARK: - Public Methods
	
	/// Метод fetchData производит запрос на получения массива Picture.
	/// - Parameter completion: completion блок возвращает массив Picture.
	func fetchData(completion: ([Picture]) -> Void) {
		let fetchRequest: NSFetchRequest<Picture> = Picture.fetchRequest()
		
		do {
			let picture = try viewContext.fetch(fetchRequest)
			completion(picture)
		} catch CoreDataError.fetchFailed {
			fatalError("Failed to fetch data")
		} catch CoreDataError.processingFailed {
			fatalError("Failed to process data")
		} catch {
			fatalError("Unknown error occurred: \(error)")
		}
	}
	
	/// Метод save создает сохраняет объект Picture в базуданных.
	/// - Parameters:
	///   - requestString: requestString тектовый запрос по которому изображение было получено от сервера.
	///   - imageData: изображение закодированное в тип данных Data.
	func save(_ requestString: String, imageData: Data, completion: (Picture) -> Void) {
		guard let entity = NSEntityDescription.entity(
			forEntityName: "Picture",
			in: persistentContainer.viewContext
			) else { return } // Create entity
		
		guard let picture = NSManagedObject(
			entity: entity,
			insertInto: viewContext
		) as? Picture else {
			fatalError("Failed to create picture entity")
		}
		
		picture.requestString = requestString
		picture.imageData = imageData
		
		do {
			try viewContext.save()
			completion(picture)
		} catch CoreDataError.saveContextFailed {
			fatalError("Failed to save context")
		} catch {
			fatalError("An unknown error occurred: \(error)")
		}
	}
	
	/// Метод delete удаляет объект Picture из базы данных.
	/// - Parameter requestString: requestString используется для нахождения объекта в базе данных.
	func delete(_ requestString: String) {
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Picture")
		fetchRequest.predicate = NSPredicate(format: "requestString == %@", requestString)
		do {
			guard let pictures = try? viewContext.fetch(fetchRequest) as? [Picture],
				  let picture = pictures.first else { return }
			viewContext.delete(picture)
		}
		
		do {
			try viewContext.save()
		} catch CoreDataError.saveContextFailed {
			fatalError("Failed to save context")
		} catch {
			fatalError("An unknown error occurred: \(error)")
		}
	}
	
	func updateData(_ requestString: String) {
		fatalError("not implemented")
	}
}
