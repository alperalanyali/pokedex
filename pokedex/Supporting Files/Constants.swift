//
//  Constants.swift
//  pokedex
//
//  Created by alper alanyali on 17.04.2018.
//  Copyright © 2018 alper alanyali. All rights reserved.
//

import Foundation

let URL_BASE = "https://pokeapi.co"
let URL_POKEMON = "/api/v2/pokemon/"
let URL_EVOLUTION = "evolution-chain/"
let pokemonURL = "\(URL_BASE)\(URL_POKEMON)"
let evolutionURL = "\(URL_BASE)\(URL_POKEMON)\(URL_EVOLUTION)"
typealias DownloadComplete = () -> ()

