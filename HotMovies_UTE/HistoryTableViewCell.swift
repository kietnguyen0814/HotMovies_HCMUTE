//
//  HistoryTableViewCell.swift
//  HotMovies_UTE
//
//  Created by Cntt03 on 6/14/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

   
    @IBOutlet weak var txtReleaseDay: UILabel!
    @IBOutlet weak var txtMovieTitle: UILabel!
    
    @IBOutlet weak var txtMoney: UILabel!
    @IBOutlet weak var txtLocation: UILabel!
    @IBOutlet weak var txtNumberOfChair: UILabel!
    @IBOutlet weak var txtShowTime: UILabel!
    @IBOutlet weak var txtBookDay: UILabel!
    
    var history: History!
    
    
    func configWithCell(history: History) {
        txtReleaseDay.text! = history.releaseDay
        txtMovieTitle.text! = history.movieTitle
        txtMoney.text! = String(history.money) + "VND"
        txtLocation.text! = history.location
        txtNumberOfChair.text! = String(history.numberOfChair)
        if (history.showTime == "850") {
            txtShowTime.text = "08:50"
        }
        else if (history.showTime == "1000"){
            txtShowTime.text = "10:00"
        }
        else if (history.showTime == "1125"){
            txtShowTime.text = "11:25"
        }
        else if (history.showTime == "1400"){
            txtShowTime.text = "14:00"
        }
        else if (history.showTime == "1635"){
            txtShowTime.text = "16:35"
        }
        else {
            txtShowTime.text = "19:00"
        }
        txtBookDay.text = history.bookDay
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
