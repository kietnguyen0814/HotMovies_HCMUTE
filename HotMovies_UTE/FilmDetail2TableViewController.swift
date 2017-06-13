//
//  FilmDetail2TableViewController.swift
//  HotMovies_UTE
//
//  Created by Duy Bùi on 6/13/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit

class FilmDetail2TableViewController: UITableViewController {
    
    @IBOutlet weak var txtMovieTitle: UILabel!
    @IBOutlet weak var txtDirector: UILabel!
    @IBOutlet weak var txtFilmType: UILabel!
    
    @IBOutlet weak var txtContent: UITextView!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var txtActor: UILabel!
    @IBOutlet weak var txtType: UILabel!
    @IBOutlet weak var txtReleaseDay: UILabel!
    
    var type: String = ""
    var filmInfo: FilmInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
         //initData()
    }
    
    func initData() {
        txtMovieTitle.text = filmInfo.filmName
        txtType.text = filmInfo.type
        txtContent.text = filmInfo.content
        txtDirector.text = filmInfo.director
        txtActor.text = filmInfo.actor
        txtReleaseDay.text = filmInfo.openningDay
        if (filmInfo.filmType == "isShowing") {
            type = "Đang chiếu"
        }
        else if (filmInfo.filmType == "commingSoon") {
            type = "Sắp chiếu"
        }
        else {
            type = "Đã chiếu"
        }
        txtFilmType.text = type
        imgPoster.image = Downloader.downloadImageWithURL(filmInfo.posterUrl)
        
    }
    
    @IBAction func imgPlay(_ sender: Any) {
        let srcYoutobe = self.storyboard?.instantiateViewController(withIdentifier: "youtobeId") as! YoutubeViewController
        srcYoutobe.videoUrl = filmInfo.videoUrl
        self.navigationController?.pushViewController(srcYoutobe, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if (filmInfo.filmType != "isShowing"){
            return 1
        }
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
}
