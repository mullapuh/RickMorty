//
//  EpisodeDetailCollectionViewCell.swift
//  RickyAndMorty
//
//  Created by hmullapudi on 2019-07-28.
//  Copyright © 2019 HNOrg. All rights reserved.
//

import UIKit

class EpisodeDetailCollectionViewCell: UICollectionViewCell {
    var char: Character?
    var indexPath: IndexPath?
    
    weak var detailVc: EpisodeDetailsViewController?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var charUrl: String?
    
    func loadCharacter() {
        detailVc?.loadChar(url: charUrl, cell: self, indexPath: indexPath!)
        makeCircle(view: self.imageView)

    }
    
    func showCharacter() {
        guard let character = char, let indexPath = indexPath else {
            return
        }
        makeCircle(view: self, color: color(status: character.status))
        detailVc?.loadImage(char: character, cell: self, indexPath: indexPath)
    }
    
    
    func makeCircle(view: UIView) {
        view.layer.masksToBounds = false
        view.layer.cornerRadius = imageView.frame.height / 2
        view.clipsToBounds = true
    }
    
    func makeCircle(view: UIView, color: UIColor) {
        view.layer.masksToBounds = false
        view.layer.cornerRadius = view.frame.height / 2
        view.clipsToBounds = true
        view.layer.borderColor = color.cgColor
        view.layer.borderWidth = 2.0
    }
    
    func color(status: String) -> UIColor {
        if status == Status.alive.rawValue {
            return UIColor.green
        } else if status == Status.dead.rawValue {
            return UIColor.red
        } else {
            return UIColor.gray
        }
    }
}
