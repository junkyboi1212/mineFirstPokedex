//
//  ViewController.swift
//  pokedex
//
//  Created by Deepak Gaire  on 4/7/16.
//  Copyright © 2016 Deepak Gaire. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire


//uicollectionviewDelegateFlowLayout let the everyimage to

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate{
   
    @IBOutlet weak var Collection : UICollectionView!
    
    @IBOutlet weak var searchBox: UISearchBar!
    
    
    
    
    
    
    
    //** (all the variables) **
    
    
    // here we made a empty class for the pokemon... to pass the data of pokemon from the pokemon.csv file.....>>>>>
    
    var pokemon = [Pokemon]()
    
    // here we are creating the empty pokemon class where all the filtered pokemon are stored >>>
    
    var filteredPokemon = [Pokemon]()
    
    
    var musicPlayer : AVAudioPlayer!
    
    // this is a boolean which confirms whether we are in searchMOde or not.....>>>>>
    
    var inSearchMode = false
    
    //** all the variables end here ***
    

    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Collection.delegate = self
        Collection.dataSource = self
        
        searchBox.delegate = self
        
        
        searchBox.returnKeyType = UIReturnKeyType.Done
        
        
        
        
        
        // we call this funciton here inorder to parse the csv files when the view load for the first time......>>>>
        
        parsePokemonCSV()
    
        initAudio()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    func initAudio() {
        
        
        do {
            musicPlayer =  try AVAudioPlayer(contentsOfURL: NSURL(string: NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!)!)
            
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
            
        } catch let err as NSError {
            print(err.debugDescription)
            
            
        }
    } 
    
    
    
    
    
    
    
    
    
    
    
    
    // this function is used to parse the csv file into our project the actual pokemon characteristics like weight , height , etc.......>>>>>
    
    func parsePokemonCSV() {
        
        // here we letting the computer to know where the file is located so we are creating the path for it........>>>>>
        
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        
        
        // here we are doing the catch function to do the func if it gets crashed so we can get the reason behind the crash.......===>>>
        
        do {
            
            let csv = try CSV(contentsOfURL: path)
            
            
            //here we are grabbing the rows from the csv files .....-->>>>
            
            let rows = csv.rows
         
            
            // its a loop for each row when it is passed .....---->>>>>
            
            for row in rows {
                
                // so here we are grabbing the id and identifier from csv file ... as csv files are format as the dictionary and we are grabbing the value  by sending key of the data......--->>>>>
                
                
                // pokeId  is the id of the of pokemon....---->>>>
                let pokeId = Int(row["id"]!)!
                
                // name is the  identifier or the name of the pokemon.....---->>>>
                let name = row["identifier"]!
                
                
                // here we are grabbing the name and the pokeId and appending it into the empty pokemon class we made above....--->>>>>>
                
                let poke = Pokemon(name: name , pokedexId: pokeId)
                pokemon.append(poke)
                
                
            }
            
            
            
        } catch let err as NSError {
            
            print(err.debugDescription)
            
        }
        
        
        
    }

    
    
    
    
    
    
    
    
    
    
    // this func pass the data of the each cell in each row and section.........---->>>>>
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        
        if let Cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell {
            
            
            let poke : Pokemon!
            
            // if the we are in searchMode than the cell will be created according to the filteredPokemon class....---->>>>>
            
            if inSearchMode {
                 poke = filteredPokemon[indexPath.row]
                
            } else {
                
                // if we are not in search mode than the cell will be created in a regular way ......------>>>>>>
        
               poke = pokemon[indexPath.row]
            
            }
            
            Cell.configureCell(poke)
            
            
            
            return Cell
            
        } else {
            
            
            return UICollectionViewCell()
            
            
        }
        
    }
    
    
    
    
    
    
    
    
    // this func helps to perform the further task after the cell is selected...--->>>>>
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
        let poke : Pokemon!
        
        if inSearchMode {
            
            poke = filteredPokemon[indexPath.row]
            
            
            
        } else {
            
            poke = pokemon[indexPath.row]
            
            
        }
        
        performSegueWithIdentifier("PokemonDetailVC", sender: poke)
        
        
    }
    
    
    
    
    
    
    
    
    
    // this function is used to pass the number of items to pass in each section....^^^>>>>>
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // if in search mode than the cell in each section will be shown according to the result of searchBar  means number of items in the filteredPokemon class ......else number of items in the pokemon class^----...
        
        
        if inSearchMode {
            return filteredPokemon.count
        }
        return pokemon.count
        
    }
    
    
    
    
    
    
    // this func defined the number of section in each collection
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    
    
    
    
    // this func let the each cell to be design as per the desire of the developer.......
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
        
    }
    
    
    
    
    
    
    
    @IBAction func musicBtnPressed(sender: UIButton!) {
        
        if musicPlayer.playing {
            musicPlayer.stop()
            
            // change anyObject to uibutton as we know it is uibutton and than the below method will change the brightness of the images when clicked.....
        sender.alpha = 0.2
            
            
        } else {
            
            musicPlayer.play()
            sender.alpha = 1.0
            
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBox.text == nil || searchBox.text == "" {
            inSearchMode = false
            
            view.endEditing(true)
            Collection.reloadData()
            
            
            
        } else {
            inSearchMode = true
            
            // here it is lowering the every string entered in the searchBox 
            
            let lower = searchBox.text!.lowercaseString
            
            
            // here we are checking the every Pokemon name that contains the alphabet that the user have entered in the searchBar ......{$0.name.rangeOfString(lower) != nil} this type of method is performing a task i.e. $0 is a kind a object of pokemon list and its checking the name and also the range of string in the lower string and if it is nil it means there is no object with that certain alphabet and if it is not nil means it has the matching string......
            
            filteredPokemon = pokemon.filter({$0.name.rangeOfString(lower) != nil})
            
            Collection.reloadData()
            
            
        }
    }
    
    
    
    
    
    
    
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
        
    }
    
    
    
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PokemonDetailVC" {
            
            if let detailVC = segue.destinationViewController as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    detailVC.pokemon = poke
                }
            }
            
            
            
        }
        
    }
    

    
}




















