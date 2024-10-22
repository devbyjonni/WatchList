//
//  PhotoLoader.swift
//  WatchList
//
//  Created by Jonni Akesson on 2024-09-30.
//

import Kingfisher
import SwiftUI

struct PhotoLoader: View {
    let urlStr: String
    
    var body: some View {
        KFImage(URL(string: urlStr))
            .resizable()
            .placeholder {
                ProgressView()
            }
            .scaledToFit()
    }
}
