//
//  History.swift
//  HotMovies_UTE
//
//  Created by Cntt03 on 6/14/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import Foundation

class History {
    var releaseDay: String
    var movieTitle: String
    var money: Int64
    var location: String
    var numberOfChair: Int
    var showTime: String
    var bookDay: String
    
    init(releaseDay: String, movieTitle: String, money: Int64, location: String,
         numberOfChair: Int, showTime: String, bookDay: String) {
        self.releaseDay = releaseDay
        self.movieTitle = movieTitle
        self.money = money
        self.location = location
        self.numberOfChair = numberOfChair
        self.showTime = showTime
        self.bookDay = bookDay
    }
}
