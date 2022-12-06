//
//  CustomGridView.swift
//  AwardsCollectionApp
//
//  Created by brubru on 07.03.2022.
//

import SwiftUI

struct CustomGridView<Content, T>: View where Content : View {
    let columns: Int
    let items: [T]
    let content: (T) -> Content
    
    var rows: Int {
        items.count / columns
    }
    
    var body: some View {
        GeometryReader { geometry in
            
            let sideSize = geometry.size.width / CGFloat(columns)
            
            ScrollView {
                VStack {
                    ForEach(0...rows, id: \.self) { rowIndex in
                        HStack {
                            ForEach(0..<columns) { columnIndex in
                                if let index = indexFor(row: rowIndex, column: columnIndex) {
                                    content(items[index])
                                        .frame(width: sideSize, height: sideSize)
                                } else {
                                   Spacer()
                                }
                            }
                        }
                    }
                }
            }
            
        }
        
    }
    private func indexFor(row: Int, column: Int) -> Int? {
        let index = row * columns + column
        return index < items.count ? index : nil
    }
    
}

struct CustomGridView_Previews: PreviewProvider {
    static var previews: some View {
        CustomGridView(columns: 3, items: [11, 3, 4, 7, 76, 2, 1]) { item in
            Text("\(item)")
        }
    }
}
