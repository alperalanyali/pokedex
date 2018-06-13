//
//  Pokemon.swift
//  pokedex
//
//  Created by alper alanyali on 13.04.2018.
//  Copyright © 2018 alper alanyali. All rights reserved.
//

import Foundation
import Alamofire



class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _hP: String!
    private var _height: String!
    private var _weight:String!
    private var _type: String!
    private var _defense:String!
    private var _attack: String!
    private var _nextEvolutionText: String!
    private var _pokemonURL: String!
    private var _evolutionId: String!
    
    // Data Protection
    var name: String {
        return _name.capitalized
    }
    var pokedexId: Int {
        return _pokedexId
    }
    var hP: String {
        return _hP ?? "Empty"
    }
    var height: String {
        return _height ?? "Empty"
    }
    var weight: String {
        return _weight ?? "Empty"
    }
    var type: String {
        return _type ?? "Empty"
    }
    var defense: String {
        return _defense ?? "Empty"
    }
    var attack: String {
        return _attack ?? "Empty"
    }
    var nextEvolutionText: String {
        return _nextEvolutionText ?? "Empty"
    }
    var pokemunURL: String {
        return _pokemonURL ?? "Empty"
    }
    var evolutionId: String {
        return _evolutionId ?? "Empty"
    }
    init(name:String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonURL = "\(pokemonURL)\(self.pokedexId)/"
    }
    func evolutionCSV() {
        let path = Bundle.main.path(forResource: "pokemon_evolution", ofType: "csv")!
        do{
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            for row in rows {
                let currentPoke = Int(row["pokemon_id"]!)
                let evolPoke = Int(row["evolution_species_id"]!)
                if currentPoke == evolPoke {
                    self._evolutionId = "\(evolPoke ?? 0)"
                } else {
                    self._evolutionId = " "
                }
            }
            
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            //            print("DATA FROM URL:\(response.result.value)")
            if let dict = response.result.value as? Dictionary<String, AnyObject>{
                if let weight1 = dict["weight"] as? Int {
                    self._weight = "\(weight1)"
                   
                }
                if let height1 = dict["height"] as? Int {
                    self._height = "\(height1)"
                    
                }
               
                if let name1 = dict["name"] as? String {
                    self._name = name1.capitalized
                }
                if let stat = dict["stats"] as? [Dictionary<String,AnyObject>] {
                    if let attack1 = stat[4]["base_stat"] as? Int {
                        self._attack = "\(attack1)"
                    }
                    if let defense1 = stat[3]["base_stat"] as? Int {
                        self._defense = "\(defense1)"
                    }
                    if let hp1 = stat[5]["base_stat"] as? Int {
                        self._hP = "\(hp1)"
                    }
                }
            
                if let types = dict["types"] as? [Dictionary<String,AnyObject>] {
                    if let type = types[0]["type"]{
                        if let name = type["name"] as? String {
                            self._type = name.capitalized
                        }
                    }
                    if types.count > 0 {
                        for x in 1..<types.count {
                            if let type1 = types[x]["type"] {
                                if let name1 = type1["name"] as? String {
                                    self._type! += "/\(name1.capitalized)"
                                }
                            }
                        }
                    }
                }
              
                print("POKEMON: \(self._name!)")
                print("ATTACK: \(self._attack)")
                print("DEFENSE: \(self._defense)")
                print("HP:\(self._hP)")
                print("HEIGHT: \(self._height)")
                print("WEIGHT: \(self._weight)")
                print("TYPES: \(self._type)")
            }
            completed()
        }
    }
    
}
