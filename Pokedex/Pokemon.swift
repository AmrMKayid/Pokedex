//
//  Pokemon.swift
//  Pokedex
//
//  Created by Amr M. Kayid on 8/31/17.
//  Copyright © 2017 AmrMKayid. All rights reserved.
//

import Foundation


class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokedexID: Int!
    
    var name: String {
        return _name
    }
    
    var pokedexID: Int {
        return _pokedexID
    }
    
    init(name: String, pokedexID: Int) {
        self._name = name
        self._pokedexID = pokedexID
    }
}
