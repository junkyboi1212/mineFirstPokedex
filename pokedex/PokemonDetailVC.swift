//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Deepak Gaire  on 4/13/16.
//  Copyright © 2016 Deepak Gaire. All rights reserved.
//

import UIKit


class PokemonDetailVC: UIViewController {

    
    
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexIdLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    var pokemon : Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemon.name.capitalizedString
        
        // here we passing a variable with the image in it applying the DRY rule....
        
        var img = UIImage(named: "\(pokemon.pokedexId)")
        mainImg.image = img
        currentEvoImg.image = img
       
        
        //** this below method also can be used .....
//        if let height = pokemon.height {
//            heightLbl.text = height
//        }
//       
        
        pokemon.downloadPokemonDetails { () -> () in
            
           //this will be called after the download is done........>>>>>
            
            self.updateUI()
        }
    }
    
    

    func updateUI() {
        descriptionLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        baseAttackLbl.text = pokemon.attack
    pokedexIdLbl.text = "\(pokemon.pokedexId)"
        
        
        if pokemon.nextEvoId == "" {
            evoLbl.text = "No Evolutions"
            nextEvoImg.hidden = true
        } else {
            nextEvoImg.hidden = false
       nextEvoImg.image = UIImage(named: pokemon.nextEvoId)
            var str = "NEXT evolutions : \(pokemon.nextEvoTxt)"
            
            
            if pokemon.nextEvoLvl != " " {
                str += " - LVL \(pokemon.nextEvoLvl)"
            }
        }
       
        
    }
    

    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
       
    
    
    
   
}
}
