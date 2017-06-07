//
//  HasBeenScreenedTableViewController.swift
//  HotMovies_UTE
//
//  Created by Duy Bùi on 6/6/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit
import Firebase

class HasBeenScreenedTableViewController: UITableViewController {

    var mDatabase: DatabaseReference!
    var films = [FilmInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mDatabase = Database.database().reference()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        getAllMoviesHasBeenScreened()
        
        //register xib file
        tableView.register(UINib(nibName: "DesignTableViewCell", bundle: nil), forCellReuseIdentifier: "FilmRow")
    }
    
    func getAllMoviesHasBeenScreened() {
        mDatabase.child("films").child("hasBeenScreened").observe(.childAdded, with: { (snapshot) -> Void in
            var film: [String: AnyObject] = (snapshot.value as? [String: AnyObject])!
            var filmInfo = film["filmInfo"] as? [String: AnyObject]
            //get data filmInfo
            let actor: String = filmInfo!["actor"] as? String ?? ""
            let content: String = filmInfo!["content"] as? String ?? ""
            let director: String = filmInfo!["director"] as? String ?? ""
            let duration: Int = filmInfo?["duration"] as? Int ?? 0
            let filmId: String = filmInfo!["filmId"] as? String ?? ""
            let filmName: String = filmInfo!["filmName"] as? String ?? ""
            let openningDay: String = filmInfo!["openningDay"] as? String ?? ""
            let posterUrl: String = filmInfo!["posterUrl"] as? String ?? ""
            let type: String = filmInfo!["type"] as? String ?? ""
            let videoUrl: String = filmInfo!["videoUrl"] as? String ?? ""
            let filmType: String = filmInfo!["filmType"] as? String ?? ""
            
            let filmInfoData: FilmInfo  = FilmInfo.init(actor: actor, content: content, director: director, duration: duration, filmId: filmId, filmName: filmName, openningDay: openningDay, posterUrl: posterUrl, type: type, videoUrl: videoUrl, filmType: filmType)
            self.films.append(filmInfoData)
            //show into main thread
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return films.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = Bundle.main.loadNibNamed("DesignTableViewCell", owner: self, options: nil)?.first as! DesignTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmRow", for: indexPath) as! DesignTableViewCell
        let filmInfo = films[indexPath.row]
        
        cell.configWithCell(filmInfo: filmInfo)
        
        return cell
    }

}
