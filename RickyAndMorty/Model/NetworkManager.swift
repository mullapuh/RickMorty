//
//  NetworkManager.swift
//  RickyAndMorty
//
//  Created by hmullapudi on 2019-07-28.
//  Copyright © 2019 HNOrg. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager {
    
    static let sharedInstance = NetworkManager()

    let episodeProvideer = ServiceProvider<EpisodeService>()
    let characterProvider = ServiceProvider<CharacterService>()
//    let locationProvider = ServiceProvider<

    init() {
        
    }
    
    var episodes: Episodes?
    var charsDict: [String: [String: Any]] = [:]
    
    func loadEpisodes(completion: @escaping (Bool) -> Void) {
        let provider = ServiceProvider<EpisodeService>()
        provider.load(service: .allEpisodes(), decodeType: Episodes.self) { (result) in
            switch result {
            case .success(let resp):
                self.episodes = resp
                completion(true)
            case .failure(_):
                completion(false)
            case .empty:
                completion(false)
            }
        }
    }
    
    func loadEpisodes(with page: Int, completion: @escaping (Bool) -> Void) {
        let provider = ServiceProvider<EpisodeService>()
        provider.load(service: .episodesPage(page: page), decodeType: Episodes.self) { (result) in
            switch result {
            case .success(let resp):
                self.episodes = resp
                completion(true)
            case .failure(_):
                completion(false)
            case .empty:
                completion(false)
            }
        }
    }
    
    func loadCharacter(from characterString: String, completion: @escaping (Bool, _ cached: Bool) -> Void) {
        
        let character = getChar(urlString: characterString)
        if character != nil {
            completion(true, true)
        } else {
            let provider = ServiceProvider<CharacterService>()
            provider.load(service: .characterUrl(urlString: characterString), decodeType: Character.self) { (result) in
                switch result {
                case .success(let resp):
                    let tempDict = ["character": resp]
                    self.charsDict[characterString] = tempDict
                    completion(true, false)
                case .failure(_):
                    completion(false, false)
                case .empty:
                    completion(false, false)
                }
            }
        }
    }
    
    func getChar(urlString: String) -> Character? {
        guard let dict = self.charsDict[urlString] else {
            return nil
        }
        return dict["character"] as? Character
    }
    
    func getCharacterImage(url: String?) -> UIImage? {
        guard let url = url else { return nil }
        guard let dict = NetworkManager.sharedInstance.charsDict[url] else {
            return nil
        }
        return dict["charImage"] as? UIImage
    }
    
    func loadImage(for character: Character, completion: @escaping (UIImage?, _ wasCached: Bool) -> Void) {
        
        if let dict = self.charsDict[character.url] {
            let image: UIImage? = dict["charImage"] as? UIImage
            if image != nil {
                completion(image, true)
                return
            }
        }
        
        let provider = ServiceProvider<CharacterService>()
        provider.load(service: .image(urlString: character.image)) { (result) in
            switch result {
            case .success(let resp):
                let image = UIImage(data: resp)
                
                if var dictionary = self.charsDict[character.url] {
                    dictionary["charImage"] = image
                    self.charsDict[character.url] = dictionary
                }
                completion(image, false)
            case .failure(_):
                completion(nil, false)
            case .empty:
                completion(nil, false)
            }
        }
    }
    
}
