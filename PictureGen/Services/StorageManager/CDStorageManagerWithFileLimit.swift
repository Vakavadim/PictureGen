//
//  CDStorageManagerWithFileLimit.swift
//  PictureGen
//
//  Created by Вадим Гамзаев on 08.05.2023.
//

import Foundation

/// CDStorageManagerAdapterWithFileLimit класс взаимодействия с базой данных CoreData,
/// с возможностью ограничения кол-ва хранимых объектов.
final class CDStorageManagerWithFileLimit: Repository {
	
	// MARK: - Private properties
	private let storageManager: ICDStorageManager
	private let fileLimit: UInt8
	private var storedPictures: [Picture] = []
	
	// MARK: - Lifecycle
	
	init(
		storageManager: ICDStorageManager,
		fileLimit: UInt8
	) {
		self.storageManager = storageManager
		self.fileLimit = fileLimit
	}
	
	// MARK: - Internal methods
	
	/// Метод fetchData производит запрос на получения массива Picture из базы данных.
	/// - Parameter completion: completion блок возвращает массив Picture.
	func fetchData(completion: ([Picture]) -> Void) {
		storageManager.fetchData(completion: completion)
	}
	
	/// Метод save создает и сохраняет объект Picture в базу данных с учетом лимита хранимых объектов.
	/// Если лимит превышается, самый старый объект удаляется.
	/// - Parameters:
	///   - requestString: requestString тектовый запрос по которому изображение было получено от сервера.
	///   - imageData: изображение закодированное в тип данных Data.
	func save(_ requestString: String, imageData: Data, completion: (Picture) -> Void) {
		storageManager.fetchData { [unowned self] pictures in
			if pictures.count != Int.zero && pictures.count >= fileLimit {
				guard let oldestPicRequestString = pictures.last?.requestString else { return }
				self.storageManager.delete(oldestPicRequestString)
				self.storageManager.save(
					requestString,
					imageData: imageData,
					completion: completion
				)
			}
		}
	}
	
	func delete(_ requestString: String) {
		storageManager.delete(requestString)
	}
}
