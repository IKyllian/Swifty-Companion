//
//  ContentView.swift
//  swifty-companion
//
//  Created by Kyllian on 11/12/2022.
//

import SwiftUI

struct ContentView: View {
	@Binding var token: String
	
	init(token: Binding<String>) {
		self._token = token
	}
    var body: some View {
        VStack {
			SearchBar(token: $token)
        }
        .padding()
    }
}

//struct ContentView_Previews: PreviewProvider {
 //   static var previews: some View {
   //     ContentView()
    //}
//}
