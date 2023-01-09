//
//  Home.swift
//  swifty-companion
//
//  Created by Kyllian on 09/01/2023.
//

import SwiftUI

struct Home: View {
	@State private var searchText = ""
	@State var userDatas: UserType?
	@State var hasData: Bool = false
	@State var hasError: Bool = false
	@Binding var token: String

	init(token: Binding<String>) {
		self._token = token
		self.hasData = false
	}

	func handleSubmit() {
		if (self.hasError == true) {
			self.hasError = false
		}
		guard let myUrl = URL(string: "https://api.intra.42.fr/v2/users/\(self.searchText.lowercased())") else {
			return
		}

		var request = URLRequest(url: myUrl)
		request.httpMethod = "GET"
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.setValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")

		let task = URLSession.shared.dataTask(with: request) { data, _, error in
			guard let data = data, error == nil else {
				return
			}

			do {
				let response = try JSONDecoder().decode(UserType.self, from: data)
				//print("Response \(response)")
				self.userDatas = response
				self.hasData = true
			}
			catch {
				self.hasError = true
				print("Error \(error)")
			}
		}
		task.resume()
	}

    var body: some View {
		NavigationStack {
			VStack() {
				if (hasError == true) {
					Text("User Not found")
						.foregroundColor(.red)
				}
				HStack {
					Image(systemName: "magnifyingglass")
					TextField("Login...", text: $searchText)
					Button(/*@START_MENU_TOKEN@*/"Search"/*@END_MENU_TOKEN@*/, action: {
						handleSubmit()
					})
				}
				.textFieldStyle(RoundedBorderTextFieldStyle())
				.padding()
				.navigationTitle("Search 42 Student")
			}
			.navigationDestination(isPresented: $hasData) {
				ProfilePage(userDatas: $userDatas)
//				ProfilePage()
			}
		}
    }
}
