//
//  MainTapBarController.swift
//  photoLib
//
//  Created by Anastasiia Gachkovskaya on 19/08/2019.
//  Copyright © 2019 Anastasia Gachkovskaya. All rights reserved.
//

import UIKit

class MainTapBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue

        let photosCV = PhotosCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())

        viewControllers = [
            geneateNavigationController(rootViewController: photosCV, title: "Photos", image: #imageLiteral(resourceName: "photos")),
            geneateNavigationController(rootViewController: ViewController(), title: "Favourite", image: #imageLiteral(resourceName: "heart"))
        ]
    }

    private func geneateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {

        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC

    }


}
