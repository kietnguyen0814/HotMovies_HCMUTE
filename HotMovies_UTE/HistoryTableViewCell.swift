//
//  HistoryTableViewCell.swift
//  HotMovies_UTE
//
//  Created by Duy Bùi on 6/14/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtReleaseDay: UILabel!
    
    @IBOutlet weak var txtMoney: UILabel!
    @IBOutlet weak var txtLocation: UILabel!
    @IBOutlet weak var txtNumberOfChair: UILabel!
    @IBOutlet weak var txtShowTime: UILabel!
    @IBOutlet weak var txtBookDay: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
