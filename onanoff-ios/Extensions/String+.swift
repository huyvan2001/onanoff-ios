//
//  String+.swift
//  DescendantsDNA
//
//  Created by Dmytro Davydenko on 23/07/2023.
//

import Foundation
import CryptoKit
extension String {
	subscript(idx: Int) -> String {
		String(self[index(startIndex, offsetBy: idx)])
	}
	
	func convertToDateString() -> String {
		let inputFormatter = ISO8601DateFormatter()
		inputFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
		if let date = inputFormatter.date(from: self) {
			let outputFormatter = DateFormatter()
			outputFormatter.dateFormat = "MM/dd/yyyy"
			let outputDateString = outputFormatter.string(from: date)
			return outputDateString
		} else {
			return ""
		}
	}
}

extension Array where Element == String {
    func toKitCode() -> String {
        return self.joined(separator: "")
    }
}

// Needed for Sign in With Apple
extension String {
	var sha256: String {
		let inputData = Data(self.utf8)
		let hashedData = SHA256.hash(data: inputData)
		let hashString = hashedData.compactMap {
			return String(format: "%02x", $0)
		}.joined()
		return hashString
	}
	
	// Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
	static func randomNonceString(length: Int = 32) -> String {
		precondition(length > 0)
		let charset: Array<Character> =
			Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
		var result = ""
		var remainingLength = length
		
		while remainingLength > 0 {
			let randoms: [UInt8] = (0 ..< 16).map { _ in
				var random: UInt8 = 0
				let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
				if errorCode != errSecSuccess {
					fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
				}
				return random
			}
			
			randoms.forEach { random in
				if length == 0 {
					return
				}
				if random < charset.count {
					result.append(charset[Int(random)])
					remainingLength -= 1
				}
			}
		}
		return result
	}
}


//Convert to RiskLevel
extension String {
	func ConvertToRiskLevel() -> RiskLevel {
		if self == "low" {
			return .low
		}
		else if self == "moderate" {
			return .moderate
		}
		return .high
	}
}

