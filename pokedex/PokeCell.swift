//
//  PokeCell.swift
//  pokedex
//
//  Created by Deepak Gaire  on 4/10/16.
//  Copyright © 2016 Deepak Gaire. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    // this class is the custom class of the UICollectionViewCell for all the image and labels to edit and  pop up automatically ......
    
    @IBOutlet weak var thumbImg : UIImageView!
    
    @IBOutlet weak var nameLbl : UILabel!
    
    var pokemon : Pokemon!
    
    
    
    // we need to initialize inorder to change in the layer of the image....
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
        layer.cornerRadius = 5.0
        
        
        
    }
    
    func configureCell(pokemon : Pokemon) {
        
        self.pokemon = pokemon
        self.nameLbl.text = self.pokemon.name.capitalizedString
        
        // this method let the image to be pop up automatically according to the pokedex id ....
        
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
        
        
        
    }
    
    
    
}
