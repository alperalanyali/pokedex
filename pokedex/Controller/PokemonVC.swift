//
//  ViewController.swift
//  pokedex
//
//  Created by alper alanyali on 13.04.2018.
//  Copyright © 2018 alper alanyali. All rights reserved.
//

import UIKit
import AVFoundation

class PokemonVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
   
    var pokemon: Pokemon!
    // MARK: CollectionView Outlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    // MARK: Variables
    var pokemonArray = [Pokemon]()
    var filteredPokemonArray = [Pokemon]()
    var inSearchMode = false
    var musicPlayer: AVAudioPlayer!
    
    //MARK: viewDidLoad Function
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        parsePokemonCSC()
        initAudio()
    
        
    }
    
    
    func initAudio(){
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    //MARK: Music Button Pressed Action
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying {
                musicPlayer.pause()
                sender.alpha = 0.2
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
        
    }
    
    //MARK: Parse PokemonCSC function
    func parsePokemonCSC() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        do{
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
//            print("POKEMON DATA: \(rows) END")
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                let poke = Pokemon(name: name, pokedexId: pokeId)
                pokemonArray.append(poke)
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    
    
    
    // MARK: functions for creating CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemonArray.count
        }
            return pokemonArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokemonCell {
            
            let poke: Pokemon!
            if inSearchMode {
                poke =  filteredPokemonArray[indexPath.row]
                cell.configureCell(pokemon: poke)
            } else {
                poke = pokemonArray[indexPath.row]
                cell.configureCell(pokemon: poke)
            }
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var poke: Pokemon!
        if inSearchMode {
            poke = filteredPokemonArray[indexPath.row]
        } else {
            poke = pokemonArray[indexPath.row]
        }
        performSegue(withIdentifier:"Detail",sender: poke)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            if let detailsVC = segue.destination as? DetailVC {
                if let poke = sender as? Pokemon {
                    detailsVC.pokemon = poke
                }
            }
        }

    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            collectionView.reloadData()
            view.endEditing(true)
        } else {
            inSearchMode = true
            let lower = searchBar.text!
            filteredPokemonArray = pokemonArray.filter({$0.name.range(of: lower) != nil })
            collectionView.reloadData()
        }
    }
}

