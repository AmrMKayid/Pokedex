//
//  Pokemon.swift
//  Pokedex
//
//  Created by Amr M. Kayid on 8/31/17.
//  Copyright © 2017 AmrMKayid. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String! //
    private var _pokedexID: Int!
    private var _description: String!
    private var _type: String! //
    private var _defense: String! //
    private var _height: String! //
    private var _weight: String! //
    private var _attack: String! //
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionID: String!
    private var _nextEvolutionLevel: String!
    private var _pokemonURL: String!
    
    
    var name: String {
        return _name
    }
    
    var pokedexID: Int {
        return _pokedexID
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionTxt: String {
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
    var nextEvolutionID: String {
        if _nextEvolutionID == nil {
            _nextEvolutionID = ""
        }
        return _nextEvolutionID
    }
    
    var nextEvolutionLevel: String {
        if _nextEvolutionLevel == nil {
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }

    
    init(name: String, pokedexID: Int) {
        self._name = name
        self._pokedexID = pokedexID
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexID)/"
    }
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            
            if let dict = response.result.value as? Dictionary<String, Any> {
                
                if let name = dict["name"] as? String {
                    self._name = name
                    //print(self._name)
                }
                
                if let pkdx_id = dict["pkdx_id"] as? Int {
                    self._pokedexID = pkdx_id
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                    //print(self._height)
                }
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                    //print(self._weight)
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>], types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        for i in 1..<types.count {
                            if let name = types[i]["name"] {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                    
                    //print(self._type)
                } else {
                    self._type = ""
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                    //print(self._defense)
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                    //print(self._attack)
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>], descArr.count > 0 {
                    
                    if let url = descArr[0]["resource_uri"] {
                        
                        let descURL = "\(URL_BASE)\(url)"
                        Alamofire.request(descURL).responseJSON(completionHandler: { (response) in
                            
                            if let descDict = response.result.value as? Dictionary<String, Any> {
                                
                                if let description = descDict["description"] as? String {
                                    self._description = description
                                }
                            }
                            completed()
                        })
                    }
                } else {
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, Any>], evolutions.count > 0 {
                    
                    if let nextEvo = evolutions[0]["to"] as? String {
                        
                        if nextEvo.range(of: "mega") == nil {
                            
                            self._nextEvolutionName = nextEvo
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoID = newStr.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvolutionID = nextEvoID
                                
                                if let lvlExist = evolutions[0]["level"] {
                                    self._nextEvolutionLevel = "\(lvlExist)" 
                                } else {
                                    self._nextEvolutionLevel = ""
                                }
                                
                            }
                        }
                    }
                }
 
            }
            completed()
        }
    }
    
}
