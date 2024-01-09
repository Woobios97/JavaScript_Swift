//
//  ContentView.swift
//  JavaScript_SwiftUI
//
//  Created by woosub kim  on 1/8/24.
//

import SwiftUI

struct ContentView: View {
    @State private var address = "Label"
    @State private var showingModal = false

    var body: some View {
        VStack(spacing: 20) {
            Text(address)
                .font(.system(size: 20))
            Button("Get Address") {
                self.showingModal = true
            }
            .sheet(isPresented: $showingModal) {
                KakaoZipCodeView(address: $address)
            }
        }
    }
}


#Preview {
    ContentView()
}


