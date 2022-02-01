//
//  NetworkLayer.swift
//  SignUpDemo
//
//  Created by Ashis Laha on 14/01/22.
//

import Foundation

// data request type
enum NetworkRequestType: String {
	case GET = "GET"
	case POST = "POST"
	case PUT = "PUT"
	case DELETE = "DELETE"
}

enum NetworkEndPoint {
	case signup
	case signin
	case profile
	
	var urlString: String {
		switch self {
		case .signup, .signin:
			return "https://postman-echo.com/post"
		case .profile:
			return "https://postman-echo.com/get"
		}
	}
}

typealias successBlock = (([String: Any]) -> Void)
typealias failureBlock = ((String) -> Void)

final class NetworkLayer {
	
	class func postRequest(urlString: String,
						   bodyDict: [String: Any]? = nil,
						   requestType: NetworkRequestType /*NetworkRequest*/,
						   successBlock: successBlock?,
						   failureBlock: failureBlock?) {
		
		guard let url = URL(string: urlString),
			  !urlString.isEmpty,
			  let bodyData = getJsonDataFromDictionary(jsonDict: bodyDict) else { return }
		
		// request
		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = requestType.rawValue
		urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
		
		// session
		let uploadTask = URLSession.shared.uploadTask(with: urlRequest, from: bodyData) { (data, response, error) in
			if let data = data, error == nil {
				
				if let httpResponse = response as? HTTPURLResponse,
				   (200...299).contains(httpResponse.statusCode) {
					
					guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
					else {
						failureBlock?("No data available")
						return
					}
					
					successBlock?(dictionary)
					
				} else {
					failureBlock?("Failed to retrieve data - Status code is out of 2XX")
				}
				
			} else {
				failureBlock?(error?.localizedDescription ?? "Error to fetch data")
			}
		}
		uploadTask.resume()
	}
}

// MARK:- Private Extension of Network Layer

private extension NetworkLayer {
	
	class func getJsonDataFromDictionary(jsonDict httpBody: [String: Any]?) -> Data? {
		var bodyData: Data? = nil
		if let httpBody = httpBody {
			bodyData = try? JSONSerialization.data(withJSONObject: httpBody, options: .prettyPrinted)
		}
		return bodyData
	}
}
