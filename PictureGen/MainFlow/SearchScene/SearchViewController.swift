//
//  SearchViewController.swift
//  PictureGen
//
//  Created by Вадим Гамзаев on 07.05.2023.
//

import UIKit
import SwiftUI

protocol ISearchViewController: AnyObject {
	func render(viewModel: SearchModel.ViewModel)
}

class SearchViewController: UIViewController {
	
// MARK: - Dependencies
	
	var interactor: ISearchInteractor?
	var router: ISearchRouter?

// MARK: - Private properties
	
	private let searchController = UISearchController(searchResultsController: nil)
	private var timer: Timer?
	
	private lazy var imageView: UIImageView = makeImageView(
		accessibilityIdentifier: AccessibilityIdentifier.Search.imageView
	)
	private lazy var saveButton: UIButton = makeSaveButton(
		accessibilityIdentifier: AccessibilityIdentifier.Search.saveButton
	)
	private lazy var loader: UIActivityIndicatorView = makeLoader(
		accessibilityIdentifier: AccessibilityIdentifier.Search.loader
	)
	private lazy var infoLabel: UILabel = makeLabel(
		accessibilityIdentifier: AccessibilityIdentifier.Search.infoLabel
	)

// MARK: - View lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupSearchBar()
		self.layout()
		view.backgroundColor = Theme.backgroundColor
	}
	
	@objc
	func save() {
		if let image = imageView.image, let term = searchController.searchBar.text {
			let picture = SearchModel.Request.Picture(
				searchTerm: term,
				image: image
			)
			interactor?.makeRequest(request: .savePicture(picture: picture))
		}
	}
	
// MARK: - Private methods
	
	private func setupSearchBar() {
		navigationItem.searchController = searchController
		searchController.hidesNavigationBarDuringPresentation = false
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.delegate = self
		searchController.searchBar.accessibilityIdentifier = AccessibilityIdentifier.Search.searchBar
	}
}

// MARK: - Layout

private extension SearchViewController {
	
	func makeImageView(accessibilityIdentifier: String) -> UIImageView {
		let imageView = UIImageView()
		imageView.image = UIImage()
		imageView.layer.cornerRadius = Sizes.cornerRadius
		imageView.accessibilityIdentifier = accessibilityIdentifier
		imageView.backgroundColor = Theme.elementBackgroundColor
		imageView.clipsToBounds = true
		
		imageView.translatesAutoresizingMaskIntoConstraints = false
		
		return imageView
	}
	
	func makeSaveButton(accessibilityIdentifier: String) -> UIButton {
		let button = UIButton()
		
		button.configuration = .filled()
		button.configuration?.cornerStyle = .medium
		button.configuration?.baseBackgroundColor = Theme.accentColor
		button.configuration?.title = L10n.SearchScene.saveButtonTitle
		button.addTarget(self, action: #selector(save), for: .touchUpInside)
		button.accessibilityIdentifier = accessibilityIdentifier
		
		button.translatesAutoresizingMaskIntoConstraints = false
		
		return button
	}
	
	func makeLoader(accessibilityIdentifier: String) -> UIActivityIndicatorView {
		let loader = UIActivityIndicatorView()
		loader.hidesWhenStopped = true
		loader.accessibilityIdentifier = accessibilityIdentifier
		
		loader.translatesAutoresizingMaskIntoConstraints = false
		return loader
	}
	
	func makeLabel(accessibilityIdentifier: String) -> UILabel {
		let label = UILabel()
		
		label.font = UIFont.preferredFont(forTextStyle: .body)
//		label.adjustsFontForContentSizeCategory = true
		label.textColor = Theme.mainColor
		label.textAlignment = .center
		label.text = L10n.SearchScene.info
		label.accessibilityIdentifier = accessibilityIdentifier

		label.translatesAutoresizingMaskIntoConstraints = false

		return label
	}
	
	// swiftlint:disable all
	func layout() {
		view.addSubview(imageView)
		view.addSubview(saveButton)
		view.addSubview(infoLabel)
		view.addSubview(loader)
		
		NSLayoutConstraint.activate(
			[
				NSLayoutConstraint(item: imageView,
								   attribute: .centerX,
								   relatedBy: .equal,
								   toItem: view,
								   attribute: .centerX,
								   multiplier: 1,
								   constant: 1),
				NSLayoutConstraint(item: imageView,
								   attribute: .centerY,
								   relatedBy: .equal,
								   toItem: view,
								   attribute: .centerY,
								   multiplier: 1,
								   constant: 1),
				NSLayoutConstraint(item: imageView,
								   attribute: .width,
								   relatedBy: .equal,
								   toItem: view,
								   attribute: .width,
								   multiplier: 1,
								   constant: -Sizes.Padding.double),
				NSLayoutConstraint(item: imageView,
								   attribute: .height,
								   relatedBy: .equal,
								   toItem: view,
								   attribute: .width,
								   multiplier: 1,
								   constant: -Sizes.Padding.double),
				NSLayoutConstraint(item: saveButton,
								   attribute: .top,
								   relatedBy: .equal,
								   toItem: imageView,
								   attribute: .bottom,
								   multiplier: 1,
								   constant: Sizes.Padding.normal),
				NSLayoutConstraint(item: saveButton,
								   attribute: .centerX,
								   relatedBy: .equal,
								   toItem: view,
								   attribute: .centerX,
								   multiplier: 1,
								   constant: CGFloat(Int.zero)),
				NSLayoutConstraint(item: saveButton,
								   attribute: .height,
								   relatedBy: .equal,
								   toItem: nil,
								   attribute: .height,
								   multiplier: 1,
								   constant: Sizes.S.height),
				NSLayoutConstraint(item: saveButton,
								   attribute: .width,
								   relatedBy: .equal,
								   toItem: nil,
								   attribute: .width,
								   multiplier: 1,
								   constant: Sizes.S.width),
				NSLayoutConstraint(item: loader,
								   attribute: .centerX,
								   relatedBy: .equal,
								   toItem: imageView,
								   attribute: .centerX,
								   multiplier: 1,
								   constant: 1),
				NSLayoutConstraint(item: loader,
								   attribute: .centerY,
								   relatedBy: .equal,
								   toItem: imageView,
								   attribute: .centerY,
								   multiplier: 1,
								   constant: 1),
				NSLayoutConstraint(item: infoLabel,
								   attribute: .centerY,
								   relatedBy: .equal,
								   toItem: imageView,
								   attribute: .centerY,
								   multiplier: 1,
								   constant: 1),
				NSLayoutConstraint(item: infoLabel,
								   attribute: .centerX,
								   relatedBy: .equal,
								   toItem: imageView,
								   attribute: .centerX,
								   multiplier: 1,
								   constant: 1),
				NSLayoutConstraint(item: infoLabel,
								   attribute: .width,
								   relatedBy: .equal,
								   toItem: imageView,
								   attribute: .width,
								   multiplier: 1,
								   constant: -Sizes.Padding.normal),
				NSLayoutConstraint(item: infoLabel,
								   attribute: .height,
								   relatedBy: .equal,
								   toItem: nil,
								   attribute: .height,
								   multiplier: 1,
								   constant: Sizes.S.height)
				]
			)
	}
	// swiftlint:enable all
}

// MARK: - ISearchViewController
extension SearchViewController: ISearchViewController {
	func render(viewModel: SearchModel.ViewModel) {
		switch viewModel {
		case .success(let picture):
			DispatchQueue.main.async {
				self.imageView.image = picture.image
				self.imageView.layer.masksToBounds = true
				self.loader.stopAnimating()
			}
		case .failure(let errorMessage):
			DispatchQueue.main.async {
				self.loader.stopAnimating()
			}
			router?.showError(message: errorMessage)
		case .saveMessage(let message):
			router?.showMessage(message: message)
		}
	}
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		
		timer?.invalidate()
		timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [unowned self] _ in
			if !searchText.isEmpty && searchText != " "{
				let term = SearchModel.Request.SearchTerm(term: searchText)
				self.infoLabel.isHidden = true
				self.loader.startAnimating()
				self.interactor?.makeRequest(
					request: .getImageWithTerm(searchTerm: term)
				)
			}
		})
	}
}

#if DEBUG
struct ViewControllerProvider: PreviewProvider {
	static var previews: some View {
		Group {
			SearchViewController().preview()
		}
	}
}
#endif
