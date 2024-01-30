//
//  SwiftUITest.swift
//  NetworkingPractice
//
//  Created by 武林慎太郎 on 2024/01/30.
//

import SwiftUI

struct SwiftUITest: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("hi")
                ForEach(0..<100) {
                    Text("\($0)")
                }
            }
        }
    }
}

#Preview {
    SwiftUITest()
}
