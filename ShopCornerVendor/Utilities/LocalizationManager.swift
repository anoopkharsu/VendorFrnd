//
//  LocalizationUtils.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 04/12/24.
//

import Foundation



enum SCSupportedLanguage: String {
    case hi = "hindi"
    case en = "english"
}

import Foundation

class LocalizationManager {
    static let shared = LocalizationManager()
    private var localizedStrings: [String: String] = [:]

    private init() {
        loadLocalizedStrings()
    }
    
    private func getFileName() -> String {
        let languageCode = Locale.current.languageCode ?? "en"
        let fileName = "Localizable_\(languageCode)"
        return fileName
    }

    private func loadLocalizedStrings() {
        let fileName = getFileName()

        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("Error: Could not find \(fileName).json")
            loadFallbackLanguage()
            return
        }

        do {
            let data = try Data(contentsOf: url)
            localizedStrings = try JSONDecoder().decode([String: String].self, from: data)
        } catch {
            print("Error: Could not load or parse \(fileName).json - \(error)")
            loadFallbackLanguage()
        }
    }

    private func loadFallbackLanguage() {
        let fallbackFileName = "Localizable_en"
        guard let url = Bundle.main.url(forResource: fallbackFileName, withExtension: "json") else {
            print("Error: Could not find fallback \(fallbackFileName).json")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            localizedStrings = try JSONDecoder().decode([String: String].self, from: data)
        } catch {
            print("Error: Could not load or parse fallback \(fallbackFileName).json - \(error)")
        }
    }

    func localizedString(forKey key: String) -> String {
        return localizedStrings[key] ?? key
    }
}

extension String {
    var localized: String {
        return LocalizationManager.shared.localizedString(forKey: self)
    }
}
