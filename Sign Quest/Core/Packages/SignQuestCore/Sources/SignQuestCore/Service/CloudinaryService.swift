//
//  CloudinaryService.swift
//  SignQuestCore
//
//  Created by Ezra Arya Wijaya on 08/06/25.
//

import Cloudinary
import SwiftUI

public class CloudinaryService: @unchecked Sendable {
    public static let shared = CloudinaryService()
    
    private var cloudinary: CLDCloudinary?
    private let secretManager = SecretManager.shared
    
    private init() {}
    
    private func ensureConfigured() async throws {
        if cloudinary != nil { return }
        
        let config = try await secretManager.getCloudinaryConfig()
        
        let cldConfig = CLDConfiguration(
            cloudName: config.cloudName,
            apiKey: config.apiKey,
            apiSecret: config.apiSecret
        )
        
        self.cloudinary = CLDCloudinary(configuration: cldConfig)
    }
    
    public func uploadProfileImage(_ image: UIImage, userId: String) async throws -> String {
        try await ensureConfigured()
        
        guard let cloudinary,
              let imageData = image.jpegData(compressionQuality: 0.7) else {
            throw cloudinary == nil ? CloudinaryError.notConfigured : CloudinaryError.imageProcessing
        }
        
        let params = CLDUploadRequestParams()
        params.setPublicId("profile_\(userId)")
        params.setOverwrite(true)
        params.setFolder("profile_images")
        
        return try await withCheckedThrowingContinuation { continuation in
            cloudinary.createUploader()
                .upload(data: imageData, uploadPreset: "profile_images", params: params)
                .response { result, error in
                    switch (result, error) {
                    case (let result?, nil):
                        if let secureUrl = result.secureUrl {
                            continuation.resume(returning: secureUrl)
                        } else {
                            continuation.resume(throwing: CloudinaryError.uploadFailed)
                        }
                    case (_, let error?):
                        print("Upload failed: \(error.localizedDescription)")
                        continuation.resume(throwing: CloudinaryError.uploadFailed)
                    case (nil, nil):
                        continuation.resume(throwing: CloudinaryError.uploadFailed)
                    }
                }
        }
    }
}

enum CloudinaryError: Error, LocalizedError {
    case notConfigured
    case imageProcessing
    case uploadFailed
    
    var errorDescription: String? {
        switch self {
        case .notConfigured:
            return "Cloudinary not configured"
        case .imageProcessing:
            return "Failed to process image"
        case .uploadFailed:
            return "Upload failed"
        }
    }
}
