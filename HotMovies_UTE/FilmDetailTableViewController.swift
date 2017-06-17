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
    
    //load Data
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
    
    //event click icon play
    @IBAction func imgPlay(_ sender: Any) {
        let srcYoutobe = self.storyboard?.instantiateViewController(withIdentifier: "youtubeId") as! YoutubeViewController
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

    //event click showTime
    @IBAction func btn850(_ sender: Any) {
        let srcBuyTicket = self.storyboard?.instantiateViewController(withIdentifier: "buyTicketId") as! BuyTicketViewController
        srcBuyTicket.filmInfo = filmInfo
        srcBuyTicket.time = "850"
        navigationController?.pushViewController(srcBuyTicket, animated: true)
    }
    
    @IBAction func btn1000(_ sender: Any) {
        let srcBuyTicket = self.storyboard?.instantiateViewController(withIdentifier: "buyTicketId") as! BuyTicketViewController
        srcBuyTicket.filmInfo = filmInfo
        srcBuyTicket.time = "1000"
        navigationController?.pushViewController(srcBuyTicket, animated: true)
    }
    
    @IBAction func btn1125(_ sender: Any) {
        let srcBuyTicket = self.storyboard?.instantiateViewController(withIdentifier: "buyTicketId") as! BuyTicketViewController
        srcBuyTicket.filmInfo = filmInfo
        srcBuyTicket.time = "1125"
        navigationController?.pushViewController(srcBuyTicket, animated: true)
    }
    
    @IBAction func btn1400(_ sender: Any) {
        let srcBuyTicket = self.storyboard?.instantiateViewController(withIdentifier: "buyTicketId") as! BuyTicketViewController
        srcBuyTicket.filmInfo = filmInfo
        srcBuyTicket.time = "1400"
        navigationController?.pushViewController(srcBuyTicket, animated: true)
    }
    
    @IBAction func btn1635(_ sender: Any) {
        let srcBuyTicket = self.storyboard?.instantiateViewController(withIdentifier: "buyTicketId") as! BuyTicketViewController
        srcBuyTicket.filmInfo = filmInfo
        srcBuyTicket.time = "1635"
        navigationController?.pushViewController(srcBuyTicket, animated: true)
    }
    
    @IBAction func btn1900(_ sender: Any) {
        let srcBuyTicket = self.storyboard?.instantiateViewController(withIdentifier: "buyTicketId") as! BuyTicketViewController
        srcBuyTicket.filmInfo = filmInfo
        srcBuyTicket.time = "1900"
        navigationController?.pushViewController(srcBuyTicket, animated: true)
    }
}
