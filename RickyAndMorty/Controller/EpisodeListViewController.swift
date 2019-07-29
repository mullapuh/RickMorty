//
//  ViewController.swift
//  RickyAndMorty
//
//  Created by hmullapudi on 2019-07-25.
//  Copyright © 2019 HNOrg. All rights reserved.
//

import UIKit

class EpisodeListViewController: UIViewController {

    @IBOutlet weak var episodesList: UITableView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var selected: Episode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeRight))
        swipe.direction = .right
        self.view.addGestureRecognizer(swipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeLeft))
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
        
        showEpisodesList()
        self.episodesList.tableFooterView = UIView(frame: .zero)
    }

    func showEpisodesList() {
        indicator.startAnimating()
        NetworkManager.sharedInstance.loadEpisodes { [weak self] (success) in
            guard let `self` = self else { return }
            self.indicator.stopAnimating()
            self.episodesList.reloadData()
            guard let episodes = NetworkManager.sharedInstance.episodes else {
                self.pageControl.numberOfPages = 0
                return
            }
            self.pageControl.numberOfPages = episodes.info.pages
        }
    }
    
    func showEpisodesList(page: Int) {
        NetworkManager.sharedInstance.loadEpisodes(with: page) { [weak self]  (success) in
            guard let `self` = self else { return }
            self.episodesList.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "episodeDetail" {
            let vc = segue.destination as! EpisodeDetailsViewController
            vc.episode = self.selected
        }
    }
    
    
}

extension EpisodeListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let episode = NetworkManager.sharedInstance.episodes else {
            return 0
        }
        return episode.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeListCell", for:  indexPath) as! EpisodesListTableViewCell
        guard let episodes = NetworkManager.sharedInstance.episodes else {
            return cell
        }
        let episode = episodes.results[indexPath.row]
        cell.loadCell(with: episode)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let episodes = NetworkManager.sharedInstance.episodes else {
            return
        }
        self.selected = episodes.results[indexPath.row]
        self.performSegue(withIdentifier: "episodeDetail", sender: self)
        return
    }
}

extension EpisodeListViewController {
    @IBAction func swipeRight() {
        let currentPage = self.pageControl.currentPage
        let total = self.pageControl.numberOfPages
        
        if currentPage == total - 1 {
            self.pageControl.currentPage = 0
        } else {
            self.pageControl.currentPage = currentPage + 1
        }
        
        showEpisodesList(page: self.pageControl.currentPage + 1)
    }
    
    @IBAction func swipeLeft() {
        let currentPage = self.pageControl.currentPage
        let total = self.pageControl.numberOfPages
        
        if currentPage == 0 {
            self.pageControl.currentPage = total - 1
        } else {
            self.pageControl.currentPage = currentPage - 1
        }
        
        showEpisodesList(page: self.pageControl.currentPage + 1)
    }
}
