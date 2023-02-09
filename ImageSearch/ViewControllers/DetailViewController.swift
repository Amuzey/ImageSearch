//
//  DetailViewController.swift
//  ImageSearch
//
//  Created by Алексей on 06.02.2023.
//

import UIKit

final class DetailViewController: UIViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet private var detailImageView: UIImageView!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    //MARK: - Public properties
    var curentIndexPath: IndexPath!
    var images: Image!
    private lazy var link = URL(string: images.imageResults[curentIndexPath.item].link)
    
    //MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateImage()
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let webViewVC = segue.destination as? WebViewController else { return }
        webViewVC.link = self.link
    }
    
    //MARK: - Private methods
    private func updateImage() {
        detailImageView.image = nil
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        detailImageView.downloadImage(from: images.imageResults[curentIndexPath.item].original, activityIndicator: activityIndicator)
    }
    
    //MARK: - @IBActions
    @IBAction func prevButtonPress() {
        if curentIndexPath.item != 0 {
            curentIndexPath.item -= 1
            updateImage()
        }
    }
    
    @IBAction func nextButtonPress() {
        if curentIndexPath.item != images.imageResults.count - 1 {
            curentIndexPath.item += 1
            updateImage()
        }
    }
    
    @IBAction func webViewButtonPress() {
        performSegue(withIdentifier: "webViewSegue", sender: self)
    }
}
