//
//  BuyTicketViewController.swift
//  HotMovies_UTE
//
//  Created by Cntt03 on 6/7/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit

class BuyTicketViewController: UIViewController {

    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var txtFilmName: UILabel!
    @IBOutlet weak var txtActor: UILabel!
    @IBOutlet weak var btnMoney: UIButton!
    @IBOutlet weak var txtTime: UILabel!
    @IBOutlet weak var txtNumberTicket: BorderLabel!
    
    
    var filmInfo: FilmInfo!
    var time: String = ""
    var ticketNumber: Int  = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadData()
    }
    
    func loadData() {
        imgPoster.image = Downloader.downloadImageWithURL(filmInfo.posterUrl)
        txtFilmName.text = filmInfo.filmName
        txtActor.text = filmInfo.actor
        txtTime.text = time
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnMinus(_ sender: Any) {
        if (ticketNumber > 0) {
            ticketNumber = ticketNumber - 1;
            txtNumberTicket.text = String(ticketNumber)
        }
    }

    @IBAction func btnAdd(_ sender: Any) {
        ticketNumber = ticketNumber + 1;
        txtNumberTicket.text = String(ticketNumber)
    }
    
    @IBAction func btnNext(_ sender: Any) {
    }
    
}
