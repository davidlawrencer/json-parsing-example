//
//  ViewController.swift
//  json-parsing-example-app
//
//  Created by David Rifkin on 8/27/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var episodesTableView: UITableView!
    
    var episodes = [Episode](){
        didSet {
            episodesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Do any additional setup after loading the view.
    }
    
    private func loadData() {
        //just the string for the name of the file
        guard let pathToJSONFile = Bundle.main.path(forResource: "episodes", ofType: "json") else {
            fatalError("couldn't find json file")
        }
        print(pathToJSONFile)
        //is a reference to the actual location of the json file
        let url = URL(fileURLWithPath: pathToJSONFile)
        do {
            //turn contents of file into usable data
            let data = try Data(contentsOf: url)
            //decode data to create episodes
            let episodesFromJSON = try Episode.getEpisodes(from: data)
            episodes = episodesFromJSON
        } catch {
            fatalError("Couldn't get episodes from JSON: \(error)")
        }
        //episodes = whatever we decode from the json file
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = episodesTableView.dequeueReusableCell(withIdentifier: "episodeCell")
       
        cell?.textLabel?.text = episodes[indexPath.row].name
        cell?.detailTextLabel?.text = "link: \(episodes[indexPath.row].link)"
        return cell!
    }
}

extension ViewController: UITableViewDelegate {}



