//
//  FilmDetailTableViewController.swift
//  HotMovies_UTE
//
//  Created by Duy Bùi on 6/6/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit

class FilmDetailTableViewController: UITableViewController {

    var filmInfo: FilmInfo!
    
    @IBOutlet weak var txtMovieTitle: UILabel!
    @IBOutlet weak var txtType: UILabel!
    @IBOutlet weak var txtFilmType: UILabel!
    @IBOutlet weak var txtContent: UITextView!
   
    @IBOutlet weak var txtDirector: UILabel!
    @IBOutlet weak var txtActor: UILabel!
    @IBOutlet weak var txtReleaseDay: UILabel!
    
    @IBOutlet weak var imgPoster: UIImageView!
    var type: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        initData()
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    @IBAction func btn850(_ sender: Any) {
        let srcBuyTicket = self.storyboard?.instantiateViewController(withIdentifier: "buyTicketId") as! BuyTicketViewController
        srcBuyTicket.filmInfo = filmInfo
        srcBuyTicket.time = "8:50"
        navigationController?.pushViewController(srcBuyTicket, animated: true)
    }
    
}
