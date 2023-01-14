//
//  swifty_companionApp.swift
//  swifty-companion
//
//  Created by Kyllian on 11/12/2022.
//

import SwiftUI

private var client_id: String {
  get {
	// 1
	guard let filePath = Bundle.main.path(forResource: "env", ofType: "plist") else {
	  fatalError("Couldn't find file 'env.plist'.")
	}
	// 2
	let plist = NSDictionary(contentsOfFile: filePath)
	guard let value = plist?.object(forKey: "API_CLIENT_ID") as? String else {
	  fatalError("Couldn't find key 'API_CLIENT_ID' in 'env.plist'.")
	}
	return value
  }
}

private var client_secret: String {
  get {
	// 1
	guard let filePath = Bundle.main.path(forResource: "env", ofType: "plist") else {
	  fatalError("Couldn't find file 'env.plist'.")
	}
	// 2
	let plist = NSDictionary(contentsOfFile: filePath)
	guard let value = plist?.object(forKey: "API_CLIENT_SECRET") as? String else {
	  fatalError("Couldn't find key 'API_CLIENT_SECRET' in 'env.plist'.")
	}
	return value
  }
}


@main
struct swifty_companionApp: App {
	@State var token: String = ""
	@State var loading: Bool = true
	
	func apiCall() {
		guard let myUrl = URL(string: "https://api.intra.42.fr/oauth/token") else {
			return
		}

		var request = URLRequest(url: myUrl)
		request.httpMethod = "POST"
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		
		let parameters: [String: String] = [
			"grant_type" : "client_credentials",
			"client_id" : client_id,
			"client_secret" : client_secret,
		]
		request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
				
		let task = URLSession.shared.dataTask(with: request) { data, _, error in
			guard let data = data, error == nil else {
				return
			}
			
			do {
				let response = try JSONDecoder().decode(ResponseToken.self, from: data)
//					print("Response \(response)")
				self.token = response.access_token
				self.loading = false
			}
			catch {
				print("Error \(error)")
			}
		}
		task.resume()
	}
	
    var body: some Scene {
        WindowGroup {
			ZStack() {
				backgroundGradient
					.ignoresSafeArea()
				if loading {
					ProgressView() {
						Text("Loading...")
							.font(.title)
					}
					.onAppear(perform: apiCall)
				}
				if !loading {
					Home(token: $token)
				}
			}
        }
    }
}
