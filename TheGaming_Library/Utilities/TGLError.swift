//
//  TGLError.swift
//  TheGaming_Library
//
//  Created by Joseph Bouhanef on 2022-09-17.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid repsonse from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}
