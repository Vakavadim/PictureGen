//
//  SearchViewController.swift
//  PictureGen
//
//  Created by Вадим Гамзаев on 07.05.2023.
//

import UIKit

protocol ISearchViewController: AnyObject {
	func render(viewModel: SearchModel.ViewModel)
}

class SearchViewController: UIViewController {
	
	// MARK: - Internal Properties
	
	var viewModel: SearchModel.ViewModel = SearchModel.ViewModel(someData: " ")
	var interactor: ISearchInteractor?

	// MARK: - Private properties
	
	// MARK: Object lifecycle
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	// MARK: View lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .red
	}
}

extension SearchViewController: ISearchViewController {
	func render(viewModel: SearchModel.ViewModel) {
		self.viewModel = viewModel
	}
}
