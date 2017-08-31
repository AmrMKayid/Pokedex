//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Amr M. Kayid on 9/1/17.
//  Copyright © 2017 AmrMKayid. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = pokemon.name
    }

}
