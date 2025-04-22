//
//  SQTextFieldUtil.swift
//  SignQuestUI
//
//  Created by Ezra Arya Wijaya on 22/04/25.
//

import SwiftUI

public class SQTextFieldUtil {
    public static func setTextFieldStyle(isActive: Bool, hasError: Bool) -> SQTextFieldStyle {
        if hasError {
            return .error
        } else if isActive {
            return .focused
        } else {
            return .default
        }
    }
}
