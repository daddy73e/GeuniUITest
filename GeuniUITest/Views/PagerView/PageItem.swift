//
//  PageItem.swift
//  GeuniUITest
//
//  Created by 60157085 on 2022/06/02.
//

import Foundation

struct PageItem {
    var title:String?
    var images:[String]?
    var url:[String]?
    
    init(images:[String]? = [],
         url:[String]? = [] ) {
        self.images = images
        self.url = url
    }
}
