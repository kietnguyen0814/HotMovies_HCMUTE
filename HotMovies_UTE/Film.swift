//
//  Film.swift
//  HotMovies_UTE
//
//  Created by Cntt03 on 6/3/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import Foundation

class Film {
    var filmInfo: FilmInfo
    var showTime: ShowTime
    
    init(filmInfo: FilmInfo, showTime: ShowTime) {
        self.filmInfo = filmInfo
        self.showTime = showTime
    }
}
