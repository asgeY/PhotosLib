//
//  PhotosCollectionViewController.swift
//  photoLib
//
//  Created by Anastasiia Gachkovskaya on 19/08/2019.
//  Copyright © 2019 Anastasia Gachkovskaya. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {

    

    var networkDataFetcher = NetworkDataFetcher()
    private var timer: Timer?

    private lazy var addBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonTapped))
    }()

    private lazy var actionBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(actionBarButtonTapped))

    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .orange

        setUpCollectionView()
        setUpNavigationBar()
        setUpSearchBar()
    }

// MARK: - NavigationItems action

    @objc private func addBarButtonTapped() {
        print(#function)
    }

    @objc private func actionBarButtonTapped() {
        print(#function)
    }

// MARK: - Setup UI Elements

    private func setUpCollectionView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellId")
    }

    private func setUpNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "PHOTOS"
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        titleLabel.textColor = #colorLiteral(red: 0.5019607843, green: 0.4980392157, blue: 0.4980392157, alpha: 1)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)

        navigationItem.rightBarButtonItems = [actionBarButtonItem, addBarButtonItem]
    }

    private func setUpSearchBar() {

        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false

        searchController.searchBar.delegate = self
    }



    // MARK: - UICollectionViewDataSourse, UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath)
        cell.backgroundColor = .black
        return cell
    }
}


// MARK: - UISearchBarDelegate

extension PhotosCollectionViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)

        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.networkDataFetcher.fetchImages(searchTerm: searchText) { (searchResults) in
                searchResults?.results.map({ (photo) in
                    print(photo.urls["small"])
                })
            }
        })
    }
}
