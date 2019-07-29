//
//  EpisodesListTableViewCell.swift
//  RickyAndMorty
//
//  Created by hmullapudi on 2019-07-28.
//  Copyright © 2019 HNOrg. All rights reserved.
//

import UIKit

class EpisodesListTableViewCell: UITableViewCell {

    var episode: Episode? {
        didSet {
            guard let episode = self.episode else { return }
            self.episodeTitle.text = "\(episode.episode) - \(episode.name)"
            self.totalCharacters.text = "Characters: \(episode.characters.count)"
            self.airDate.text = "Air Date: \(episode.airDate)"
        }
    }
    @IBOutlet weak var episodeTitle: UILabel!
    @IBOutlet weak var totalCharacters: UILabel!
    @IBOutlet weak var airDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func loadCell(with episode: Episode?) {
        guard let episode = episode else { return }
        self.episode = episode        
    }
}
