//
//  HomeViewController.swift
//  ImageSearch
//
//  Created by Алексей on 05.02.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet var imageCollectionView: UICollectionView!
    
    //MARK: - private Properties
    private let searchController = UISearchController()
    private var networkManager = NetworkDataFetcher()
    private var image: Image? = nil
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager = NetworkDataFetcher()
        setupSearchBar()
        setupCollectionViewCell()
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController else { return }
        guard let indexPaths = imageCollectionView.indexPathsForSelectedItems else { return }
        guard let indexPath = indexPaths.first else { return }
        detailVC.image = image
        detailVC.curentIndexPath = indexPath
    }
    
    
    //MARK: - private Methods
    private func setupSearchBar() {
        title = "Search"
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
    private func setupCollectionViewCell() {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
    }
    
    private func loadImages(query: String) {
        networkManager.fetchImage(query: query) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let image):
                self.image = image
                self.imageCollectionView.reloadItems(at: self.imageCollectionView.indexPathsForVisibleItems)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        loadImages(query: query)
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        image?.imageResults.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        let urlImage = image?.imageResults[indexPath.item].thumbnail
        cell.configure(urlImage: urlImage ?? "")
                
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 3
        let paddingWidth = 20 * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widhtPerItem = availableWidth / itemsPerRow
        return CGSize(width: widhtPerItem, height: widhtPerItem + widhtPerItem / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
}

