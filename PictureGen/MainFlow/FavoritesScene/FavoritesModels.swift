//
//  FavoritesModels.swift
//  PictureGen
//
//  Created by Вадим Гамзаев on 07.05.2023.
//

import UIKit

enum FavoritesModel {
	enum Request {
		case fetchData
		case deleteActionWasPerformed(String)
	}
	struct Response {
		let pictureEntities: [Picture]
	}
	struct ViewModel {
		let pictures: [Picture]
		
		struct Picture {
			let image: UIImage
			let term: String
		}
	}
}
