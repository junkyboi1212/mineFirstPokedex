//
//  pokemon.swift
//  pokedex
//
//  Created by Deepak Gaire  on 4/8/16.
//  Copyright © 2016 Deepak Gaire. All rights reserved.
//

import Foundation

import Alamofire



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
    private var _nextEvoId : String!
    private var _nextEvoLvl : String!
    private var _pokemonUrl : String!
    
    // here we making a getter and setter to use the variable publicly anywhere .....
    
    
    var nextEvoId : String {
        if _nextEvoId == nil {
            _nextEvoId = ""
        }
        return _nextEvoId
    }
    
    var nextEvoLvl : String {
        if _nextEvoLvl == nil {
            _nextEvoLvl = " "
        }
        return _nextEvoLvl
    }
    
    var nextEvoTxt : String {
        if _nextEvoTxt == nil {
            _nextEvoTxt = " "
        }
        return _nextEvoTxt
    }
    
    
    var type : String {
        
        if _type == nil {
            _type = " "
        }
        return _type
    }

    
    var defense : String {
        if _defense == nil {
            _defense = " "
        }
        return _defense
    }
    
    var height : String {
        if _height == nil {
             _height = " "
        }
        return _height
        
    }
    
    var weight : String {
        
        if _weight == nil {
             _weight = " "
        }
        return _weight
    }
    
    
    var attack : String {
        if _attack == nil {
            _attack = " "
        }
        return _attack
    }
    
    var name : String {
        return _name
    }
    
    
    var pokedexId : Int {
        return _pokedexId
    }
    
    
    var description : String {
        if _description == nil {
            _description = " "
        }
        return _description
    }
    
    
    
    
    init(name : String , pokedexId : Int) {
        
        self._name = name
        self._pokedexId = pokedexId
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)/"
        
        
        
    }
    
    //and here we are passing the certain bunch of code that has been downloaded as per the user clicked the items ......
    func downloadPokemonDetails(completed : DownloadComplete) {
        
       let url = NSURL(string: _pokemonUrl)!
        
        Alamofire.request(.GET, url)
            .responseJSON { (response:Response<AnyObject, NSError>) in
                
                
                //                print(response.request)  // original URL request
                //                print(response.response) // URL response
                //                print(response.data)     // server data
                //                print(response.result)   // result of response serialization
                //
                //note-- "here we are parsing the data"
                
                
                // here we are JSON dictionary to iOS swift dictionary inorder to pass the data....
                
                
                
             if let dict = response.result.value as? Dictionary<String,AnyObject>  {
                
                
                
                    if let weight = dict["weight"] as? String  {
                        self._weight = weight
                    }
                
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                
                print(self._weight)
                print(self._height)
                print(self._attack)
                print(self._defense)
                
                if let types = dict["types"] as? [Dictionary<String,AnyObject>] where types.count > 0 {
                    
                    // if pokemon contains one types.....
                    if let type = types[0]["name"] {
                        self._type = self.name.capitalizedString
                    }
                    
                    
                    // if pokemon contains more than one types.........
                    if types .count > 1 {
                        for x in 0..<types.count {
                            if let name = types[x]["name"]{
                                self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                } else {
                    self._type = " "
                    
                }
                print(self._type)
                
                
                // here we downloading the dicription of the pokemon .........some time one pokemon has more than one discription so we gonna grab the first discription of every pokemon........
                
                if let descArr = dict["descriptions"] as? [Dictionary<String,String>] where descArr.count > 0 {
                    
                    if let url = descArr[0]["resource_uri"] {
                        let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                        
                        Alamofire.request(.GET, nsurl).responseJSON { (response: Response<AnyObject, NSError>) in
                            
                            if let descdict = response.result.value as? Dictionary<String,AnyObject> {
                                
                                if let description = descdict["description"] as? String {
                                    self._description = description
                                     print(self._description)
                                }
                               
                            }
                            completed()
                        }
                    }
                    
                    if let evolutions = dict["evolutions"] as? [Dictionary<String,AnyObject>] where evolutions.count > 0{
                        
                        if let to = evolutions[0] ["to"] as? String {
                            
                            // the function gonna perform when there is pokemon with mega pokemon in it.....
                            
                            if to.rangeOfString("mega") == nil {
                                
                                
                                if let uri = evolutions[0]["resource_uri"] as? String {
                                    
                                    // here we grabbing the pokemon index number by replacing the other string by using the (stringByReplacingOccurrencesOfString) func........so we can provide the next evolution image ......
                                    
                                    let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: " ")
                                    
                                    let num = newStr.stringByReplacingOccurrencesOfString("/", withString: " ")
                                    
                                    self._nextEvoId = num
                                    self._nextEvoTxt = to
                                    
                                    
                                    if let lvl = evolutions[0]["level"] as? Int {
                                        self._nextEvoLvl = "\(lvl)"
                                    }
                                    
                                    print(self._nextEvoId)
                                    print(self._nextEvoTxt)
                                    print(self._nextEvoLvl)
                                    
                                }
            }
                        }
                        
                    }
                }
                
               
                
                }
           }

                            }
                
            }
        
        
        





        
        



    
    
    
