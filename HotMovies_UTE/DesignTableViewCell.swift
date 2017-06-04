//
//  DesignTableViewCell.swift
//  HotMovies_UTE
//
//  Created by Kiet Nguyen on 6/3/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit

class DesignTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imgPoster: UIImageView!

    @IBOutlet weak var txtType: UILabel!
    @IBOutlet weak var txtTitle: UILabel!
    
    func configWithCell(filmInfo: FilmInfo) {
        txtType.text! = filmInfo.filmName
        txtTitle.text = filmInfo.type
        imgPoster.image = Downloader.downloadImageWithURL(filmInfo.posterUrl)
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
