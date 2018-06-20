//
//  Note.swift
//  Ukol_iOS_2018
//
//  Created by Péter Karsai on 2018.06.19..
//  Copyright © 2018. My Web Kft. All rights reserved.
//

import Foundation

class Note: NSObject {
    
    var id: Int?
    var title: String?
    
    init(id: Int?, title: String?) {
        self.id = id
        self.title = title
        super.init()
    }
    
    convenience init?(fromJSON json: [String: Any]) {
        guard let id = json["id"] as? Int, let title = json["title"] as? String else {
            return nil
        }
        self.init(id: id, title: title)
    }
    
}
