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

enum ResponseStatus: String {
	case notStarted = "notStarted"
	case running = "running"
	case failed = "failed"
	case succeeded = "succeeded"
}

typealias successBlock = ((Any?) -> Void)
typealias failureBlock = ((Any?) -> Void)

final class NetworkLayer {
	
	// MARK:- "POST"/"PUT"/"DELETE"
	
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
					
					print(data)
				} else {
					failureBlock?(nil)
				}
				
			} else {
				failureBlock?(error)
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
