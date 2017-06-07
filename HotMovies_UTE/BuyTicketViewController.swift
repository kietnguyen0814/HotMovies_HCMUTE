//
//  BuyTicketViewController.swift
//  HotMovies_UTE
//
//  Created by Cntt03 on 6/7/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit
import MBProgressHUD
import Firebase

class BuyTicketViewController: UIViewController {

    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var txtFilmName: UILabel!
    @IBOutlet weak var txtActor: UILabel!
    
    @IBOutlet weak var lblMoney: UILabel!
    @IBOutlet weak var txtTime: UILabel!
    @IBOutlet weak var txtNumberTicket: BorderLabel!
    
    @IBOutlet weak var txtPrice: UILabel!
    var mDatabase: DatabaseReference!
    var progressDialog: MBProgressHUD!
    
    var filmInfo: FilmInfo!
    var time: String = ""
    var ticketNumber: Int64  = 0
    var priceFilm: Int64 = 0
    var money: Int64 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mDatabase = Database.database().reference()
        // Do any additional setup after loading the view.
        loadData()
        loadDataFromDB()
    }
    
    func loadDataFromDB() {
        //show progress
        showProgress()
        mDatabase.child("films").child(filmInfo.filmType).child(filmInfo.filmId).child("showTimes").child(time).child("showTimeInfo").observeSingleEvent(of: .value, with: { (snapshot) in
            self.hideProgress()
            if let showTimeInfo = snapshot.value as? [String: AnyObject] {
                let price = showTimeInfo["price"] as? Int64 ?? 0
                let type = showTimeInfo["type"] as? String ?? ""
                let timeShow = showTimeInfo["time"] as? String ?? ""
                //load data
                self.txtPrice.text = String(price) + "VND"
                self.txtTime.text = type + " - " + timeShow
                self.priceFilm = price
                
            }
        })
    }
    
    func showProgress() {
        progressDialog = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressDialog.mode = MBProgressHUDMode.indeterminate
        progressDialog.label.text = "Đang tải..."
    }
    
    func hideProgress() {
        progressDialog.hide(animated: true)
    }
    
    func loadData() {
        imgPoster.image = Downloader.downloadImageWithURL(filmInfo.posterUrl)
        txtFilmName.text = filmInfo.filmName
        txtActor.text = filmInfo.actor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnMinus(_ sender: Any) {
        if (ticketNumber > 0) {
            ticketNumber = ticketNumber - 1;
            txtNumberTicket.text = String(ticketNumber)
            money = priceFilm * ticketNumber
            lblMoney.text = String(money) + "VND"
        }
    }

    @IBAction func btnAdd(_ sender: Any) {
        ticketNumber = ticketNumber + 1;
        txtNumberTicket.text = String(ticketNumber)
        money = priceFilm * ticketNumber
        lblMoney.text = String(money) + " VND"
    }
    
    @IBAction func btnNext(_ sender: Any) {
    }
    
}
