//
//  swifty_companionApp.swift
//  swifty-companion
//
//  Created by Kyllian on 11/12/2022.
//

import SwiftUI


@main
struct swifty_companionApp: App {
	@State var token: String = ""
	@State var loading: Bool = true
	@State var error: Bool = false
	
	func apiCall() {
		guard let myUrl = URL(string: "https://api.intra.42.fr/oauth/token") else {
			return
		}

		var request = URLRequest(url: myUrl)
		request.httpMethod = "POST"
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		let clientID: String? = ProcessInfo.processInfo.environment["API42_CLIENT_ID"] ?? nil
		let clientSecret: String? = ProcessInfo.processInfo.environment["API42_CLIENT_SECRET"] ?? nil
		if (clientID != nil && clientSecret != nil) {
			let parameters: [String: String] = [
				"grant_type" : "client_credentials",
				"client_id" : clientID!,
				"client_secret" : clientSecret!,
			]
			request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
					
			let task = URLSession.shared.dataTask(with: request) { data, _, error in
				guard let data = data, error == nil else {
					return
				}
				
				do {
					let response = try JSONDecoder().decode(ResponseToken.self, from: data)
					print("Response \(response)")
					self.token = response.access_token
					self.loading = false
				}
				catch {
					print("Error \(error)")
				}
			}
			task.resume()
		} else {
			self.error = true
			self.loading = false
		}
	}
	
    var body: some Scene {
        WindowGroup {
			if loading {
				ProgressView() {
					Text("Loading...")
						.font(.title)
				}
				.onAppear(perform: apiCall)
			}
			
			if (!loading && error) {
				Text("Error with API KEYS")
			}
			
			if !loading && !error {
				ContentView(token: $token)
			}
        }
    }
}
