//
//  PokeCell.swift
//  Pokedex
//
//  Created by Amr M. Kayid on 8/31/17.
//  Copyright © 2017 AmrMKayid. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 25.0
    }
    
    
    func configureCell(pokemon: Pokemon) {
        
        self.pokemon = pokemon
        
        nameLabel.text = pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexID)")
        
    }
}
