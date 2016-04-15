//
//  constants.swift
//  pokedex
//
//  Created by Deepak Gaire  on 4/14/16.
//  Copyright © 2016 Deepak Gaire. All rights reserved.
//

import Foundation

// here we created the base url
let URL_BASE = "http://pokeapi.co"

// here we pass the pokemon url ....>>>

let URL_POKEMON = "/api/v2//pokemon/"


// here we are making our own custom func that contains block of code inside it and whenever we needed the particular bunch of code it gonna pass it ........according to the user desire

typealias DownloadComplete = () -> ()
