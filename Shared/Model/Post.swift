//
//  Post.swift
//  Post
//
//  Created by nyannyan0328 on 2021/09/04.
//

import SwiftUI

struct Post: Identifiable {
    var id = UUID().uuidString
    var userImage : String
    var isLiked : Bool = false
}



