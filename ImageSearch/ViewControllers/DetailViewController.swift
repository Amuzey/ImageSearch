//
//  DetailViewController.swift
//  ImageSearch
//
//  Created by Алексей on 06.02.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var detailImageView: UIImageView!
    
    //MARK: Public properties
    var curentIndexPath = IndexPath()
    var image: Image?
    
    //MARK: Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailImageView.downloadImage(from: image?.imageResults[curentIndexPath.item].original ?? "")
        
    }
    
    
    @IBAction func prevButtonPress(_ sender: Any) {
    }
    
    @IBAction func nextButtonPress(_ sender: Any) {
    }
    
    @IBAction func webViewButtonPress(_ sender: Any) {
    }
}
