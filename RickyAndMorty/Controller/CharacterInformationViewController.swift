//
//  CharacterInformationViewController.swift
//  RickyAndMorty
//
//  Created by hmullapudi on 2019-07-29.
//  Copyright © 2019 HNOrg. All rights reserved.
//

import UIKit

class CharacterInformationViewController: UIViewController {

    var character: Character?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var species: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var episodesList: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var changeStatus: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        
        
        // Do any additional setup after loading the view.
    }
    
    func configUI() {
        self.imageView.image = NetworkManager.sharedInstance.getCharacterImage(url: character?.url)
        self.name.text = self.character?.name
        self.species.text = self.character?.species
        self.gender.text = self.character?.gender
        configStatus()
        configEpisodeList()
    }
    
    func configStatus() {
        let charStatus = character?.status
        var color: UIColor = .gray
        if charStatus == Status.alive.rawValue {
            color = .green
        } else if charStatus == Status.dead.rawValue {
            color = .red
        }
        self.statusLabel.textColor = color
        if let status = charStatus {
            self.statusLabel.text = "Status: \(status)"
        }
        
        changeStatus.isOn = charStatus == Status.alive.rawValue ? true : false

    }
    
    func configEpisodeList() {
        
        let prefixToRemove = "https://rickandmortyapi.com/api/episode/"
        let episodes = self.character?.episode.map { $0.deletingPrefix(prefixToRemove) }
        let jointEpisodes = episodes?.joined(separator: ", ")
        self.episodesList.text = jointEpisodes
        
    }
    
    @IBAction func changeStatusToggled() {
        let isAlive = self.changeStatus.isOn
        guard let char = self.character else { return }
        var newStatus = char.status
        if isAlive {
            newStatus = Status.alive.rawValue
        } else {
           newStatus = Status.dead.rawValue
        }
        let updatedChar = Character(with: newStatus, character: char)
        self.character = updatedChar
        configStatus()

        guard var dict = NetworkManager.sharedInstance.charsDict[char.url] else { return }
        dict["character"] = updatedChar
        NetworkManager.sharedInstance.charsDict[char.url] = dict

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
