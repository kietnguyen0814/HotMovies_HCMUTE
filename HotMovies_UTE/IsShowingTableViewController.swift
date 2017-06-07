//
//  IsShowingTableViewController.swift
//  HotMovies_UTE
//
//  Created by Duy Bùi on 6/6/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit
import Firebase
import MBProgressHUD


class IsShowingTableViewController: UITableViewController {

    var mDatabase: DatabaseReference!
    var films = [FilmInfo]()
    var searchFilms = [FilmInfo]()
    let searchController = UISearchController(searchResultsController: nil)
    var progressDialog: MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mDatabase = Database.database().reference()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.leftBarButtonItem = editButtonItem
        
        getAllMoviesIsShowing()
        //register xib file
        tableView.register(UINib(nibName: "DesignTableViewCell", bundle: nil), forCellReuseIdentifier: "FilmRow")
        //setup searchcontroller
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false;
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func showProgress() {
        progressDialog = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressDialog.mode = MBProgressHUDMode.indeterminate
        progressDialog.label.text = "Đang tải..."
    }
    
    func hideProgress() {
        progressDialog.hide(animated: true)
    }
    
    func getAllMoviesIsShowing() {
        //show progress dialog
        showProgress()
        mDatabase.child("films").child("isShowing").observe(.childAdded, with: { (snapshot) -> Void in
            
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
                self.hideProgress()
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
        if (searchController.isActive && searchController.searchBar.text != "") {
            return searchFilms.count
        }
        return films.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmRow", for: indexPath) as! DesignTableViewCell
        let filmInfo: FilmInfo
        if (searchController.isActive && searchController.searchBar.text != "") {
            filmInfo = searchFilms[indexPath.row]
        }
        else {
            filmInfo = films[indexPath.row]
        }
        cell.configWithCell(filmInfo: filmInfo)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let srcDetailFilm = self.storyboard?.instantiateViewController(withIdentifier: "filmDetailId") as! FilmDetailTableViewController
        let filmInfo: FilmInfo
        if (searchController.isActive && searchController.searchBar.text! != "") {
            filmInfo = searchFilms[indexPath.row]
        }
        else {
            filmInfo = films[indexPath.row]
        }
        srcDetailFilm.filmInfo = filmInfo
        navigationController?.pushViewController(srcDetailFilm, animated: true)
        
    }
    
    //delete film
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let filmInfo = films[indexPath.row]
            films.remove(at: indexPath.row)
            //delete in database
            mDatabase.child("films").child(filmInfo.filmType).child(filmInfo.filmId).removeValue()
            //delete and update row
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }

    
    //drag and drop
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //remove souce
        let film = films[sourceIndexPath.row]
        films.remove(at: sourceIndexPath.row)
        //add to des
        films.insert(film, at: destinationIndexPath.row)
    }
    
    //search
    func searchFilmByName(_ filmName: String) {
        searchFilms = films.filter({ (filmInfo: FilmInfo) -> Bool in
            return filmInfo.filmName.lowercased().contains(filmName.lowercased())
        })
        self.tableView.reloadData()
    }
}

extension IsShowingTableViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        searchFilmByName(searchBar.text!)
    }
}

extension IsShowingTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        searchFilmByName(searchController.searchBar.text!)
    }
}

