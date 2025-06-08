//
//  SecretManager.swift
//  SignQuestCore
//
//  Created by Ezra Arya Wijaya on 08/06/25.
//

import Foundation

struct CloudinaryConfig {
    let cloudName: String
    let apiKey: String
    let apiSecret: String
}

struct DopplerResponse: Codable {
    let secrets: [String: DopplerSecret]
}

struct DopplerSecret: Codable {
    let computed: String
}

class SecretManager: @unchecked Sendable {
    static let shared = SecretManager()
    
    private let serviceToken = Secret.dopplerServiceToken
    
    private var cachedCredentials: CloudinaryConfig?
    private var lastFetch: Date?
    private let cacheExpiry: TimeInterval = 3600
    
    private init() {}
    
    func getCloudinaryConfig() async throws -> CloudinaryConfig {
        if let cached = cachedCredentials,
           let lastFetch = lastFetch,
           Date().timeIntervalSince(lastFetch) < cacheExpiry {
            return cached
        }
        
        let config = try await fetchFromDoppler()
        
        self.cachedCredentials = config
        self.lastFetch = Date()
        
        return config
    }
    
    private func fetchFromDoppler() async throws -> CloudinaryConfig {
        let url = URL(string: "https://api.doppler.com/v3/configs/config/secrets")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(serviceToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw DopplerError.networkError
        }
        
        let dopplerResponse = try JSONDecoder().decode(DopplerResponse.self, from: data)
        
        guard let cloudName = dopplerResponse.secrets["CLOUDINARY_CLOUD_NAME"]?.computed,
              let apiKey = dopplerResponse.secrets["CLOUDINARY_API_KEY"]?.computed,
              let apiSecret = dopplerResponse.secrets["CLOUDINARY_API_SECRET"]?.computed else {
            throw DopplerError.missingSecrets
        }
        
        return CloudinaryConfig(
            cloudName: cloudName,
            apiKey: apiKey,
            apiSecret: apiSecret
        )
    }
    
    func clearCache() {
        cachedCredentials = nil
        lastFetch = nil
    }
}

enum DopplerError: Error, LocalizedError {
    case networkError
    case missingSecrets
    
    var errorDescription: String? {
        switch self {
        case .networkError:
            return "Failed to fetch secrets from Doppler"
        case .missingSecrets:
            return "Required Cloudinary secrets not found in Doppler"
        }
    }
}
