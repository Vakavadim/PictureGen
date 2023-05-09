//
//  StorageManagerStub.swift
//  PictureGenTests
//
//  Created by Вадим Гамзаев on 09.05.2023.
//

import Foundation
@testable import PictureGen

class StorageManagerStub: Repository {
	
	func fetchData(completion: ([PictureGen.Picture]) -> Void) {
	}
	
	func save(_ requestString: String, imageData: Data, completion: (PictureGen.Picture) -> Void) {
	}
	
	func delete(_ requestString: String) {
	}
}
