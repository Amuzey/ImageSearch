//
//  DetailViewController.swift
//  ImageSearch
//
//  Created by Алексей on 06.02.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet var detailImageView: UIImageView!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    //MARK: - Public properties
    var curentIndexPath = IndexPath()
    var images = Image(imageResults: [])
    private lazy var link = URL(string: images.imageResults[curentIndexPath.item].link)
    
    //MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        detailImageView.downloadImage(from: images.imageResults[curentIndexPath.item].original, activityIndicator: activityIndicator)
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let webViewVC = segue.destination as? WebViewController else { return }
        webViewVC.link = self.link
    }
    
    //MARK: - @IBActions
    @IBAction func prevButtonPress(_ sender: Any) {
        if curentIndexPath.item != 0 {
            curentIndexPath.item -= 1
            detailImageView.downloadImage(from: images.imageResults[curentIndexPath.item].original, activityIndicator: activityIndicator)
        }
    }
    
    @IBAction func nextButtonPress(_ sender: Any) {
        if curentIndexPath.item != images.imageResults.count - 1 {
            curentIndexPath.item += 1
            detailImageView.downloadImage(from: images.imageResults[curentIndexPath.item].original, activityIndicator: activityIndicator)
        }
    }
    
    @IBAction func webViewButtonPress(_ sender: Any) {
        performSegue(withIdentifier: "webViewSegue", sender: self)
    }
}
