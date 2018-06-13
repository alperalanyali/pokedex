//
//  PokemonCell.swift
//  pokedex
//
//  Created by alper alanyali on 13.04.2018.
//  Copyright © 2018 alper alanyali. All rights reserved.
//

import UIKit

class PokemonCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
        
    }
    func configureCell(pokemon: Pokemon){
        
        self.pokemon = pokemon
        nameLbl.text = self.pokemon.name
        thumbImage.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
}
