//
//  EpisodeDetailsViewController.swift
//  RickyAndMorty
//
//  Created by hmullapudi on 2019-07-28.
//  Copyright © 2019 HNOrg. All rights reserved.
//

import UIKit

class EpisodeDetailsViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var characterList: UICollectionView!
    var selected: EpisodeDetailCollectionViewCell?
    
    var shouldLoad = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    var episode: Episode?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = episode?.name
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.shouldLoad = true
        self.characterList.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "characterDetails" {
            let vc = segue.destination as! CharacterInformationViewController
            vc.character = selected?.char
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EpisodeDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let episode = self.episode else { return 0 }
        return episode.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! EpisodeDetailCollectionViewCell
        cell.indexPath = indexPath
        cell.detailVc = self
        cell.charUrl = episode?.characters[indexPath.item]
        cell.loadCharacter()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = self.characterList.cellForItem(at: indexPath) as! EpisodeDetailCollectionViewCell
        self.selected = cell
        self.performSegue(withIdentifier: "characterDetails", sender: self)
    }
}

extension EpisodeDetailsViewController {
    func loadChar(url: String?, cell: EpisodeDetailCollectionViewCell, indexPath: IndexPath) {
        guard let url = url else {
            return 
        }
        NetworkManager.sharedInstance.loadCharacter(from: url) { [weak self] (success, wasCached) in
            guard let `self` = self else { return }
            if wasCached || self.characterList.cellForItem(at: indexPath) == cell {
                let detailedChar = NetworkManager.sharedInstance.getChar(urlString: url)
                cell.char = detailedChar
                cell.showCharacter()
            }
        }
    }
    
    func loadImage(char: Character, cell: EpisodeDetailCollectionViewCell, indexPath: IndexPath) {
        cell.indicatorView.startAnimating()
        NetworkManager.sharedInstance.loadImage(for: char) { [weak self] (image, wasCached) in
            guard let `self` = self else { return }
            if wasCached || self.characterList.cellForItem(at: indexPath) == cell {
                cell.imageView.image = image
                cell.indicatorView.stopAnimating()
            }
        }
    }
}


