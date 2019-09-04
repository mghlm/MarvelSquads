//
//  Color.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 03/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit 

enum Color {
    
    case background, cell
    
    var value: UIColor {
        switch self {
        case .background:
            return UIColor(red:0.13, green:0.15, blue:0.17, alpha:1.0)
        case .cell:
            return UIColor(red:0.21, green:0.23, blue:0.27, alpha:1.0)
        }
    }
    
}
