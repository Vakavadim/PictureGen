//
//  Repository.swift
//  PictureGen
//
//  Created by Вадим Гамзаев on 08.05.2023.
//

import Foundation
import CoreData

protocol Repository {
	func fetchData(completion: ([Picture]) -> Void)
	func save(_ requestString: String, imageData: Data, completion: (Picture) -> Void)
	func delete(_ requestString: String)
}
