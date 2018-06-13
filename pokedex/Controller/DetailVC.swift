//
//  DetailVC.swift
//  pokedex
//
//  Created by alper alanyali on 16.04.2018.
//  Copyright © 2018 alper alanyali. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    var pokemon: Pokemon!
    // MARK: Outlets for UI
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var hpLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexIDLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let img = UIImage(named: String(pokemon.pokedexId))
        mainImage.image = img
        currentEvoImage.image = img
        pokedexIDLbl.text = String(pokemon.pokedexId)
        nameLbl.text = pokemon.name
        pokemon.downloadPokemonDetail{
            print("Did arrive here")
            self.updateUI()
        }
        pokemon.evolutionCSV()
    }


    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    

 

    func updateUI() {
        baseAttackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        typeLbl.text = pokemon.type
        hpLbl.text = pokemon.hP
        
        
    }


}
