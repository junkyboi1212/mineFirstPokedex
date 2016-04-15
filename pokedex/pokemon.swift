//
//  pokemon.swift
//  pokedex
//
//  Created by Deepak Gaire  on 4/8/16.
//  Copyright © 2016 Deepak Gaire. All rights reserved.
//

import Foundation





class Pokemon {
    
    
    private var _name : String!
    private var _pokedexId : Int!
    private var _description : String!
    private var _type : String!
    private var _defense : String!
    private var _height : String!
    private var _weight : String!
    private var _attack : String!
    private var _nextEvoTxt : String!
    private var _pokemonUrl : String!
    

    
    var name : String {
        return _name
    }
    
    
    var pokedexId : Int {
        
        return _pokedexId
        }
    
    
    init(name : String , pokedexId : Int) {
        
        self._name = name
        self._pokedexId = pokedexId
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)/"
        
        
        
    }
    
    //and here we are passing the certain bunch of code that has been downloaded as per the user clicked the items ......
    func downloadPokemonDetails(completed : DownloadComplete) {
        
        
        
        
        
    }
    
    
    
    
    
}