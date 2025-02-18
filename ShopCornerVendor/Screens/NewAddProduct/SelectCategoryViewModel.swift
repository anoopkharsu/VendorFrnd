//
//  SelectCategoryViewModel.swift
//  ShopCornerVendor
//
//  Created by Anoop Kharsu on 11/01/25.
//

import SwiftUI

class SelectCategoryViewModel: ObservableObject {
    @Published var items: [[SelectCategoryModel.Item]] = []
    @Published var selectedItems: [SelectCategoryModel.Item] = []
    @Published var showSelectedItems: Bool = false
    var isPushed = false
    
    init() {
        if let jsonData = data.data(using: .utf8) {
            do {
                let productCatalog = try JSONDecoder().decode([SelectCategoryModel.Item].self, from: jsonData)
                items = [productCatalog]
            } catch {
                print("Decoding error: \(error)")
            }
        }
    }
    
    func selectItem(_ item: SelectCategoryModel.Item) {
        if selectedItems.contains(where: { $0 == item }) {
            selectedItems.removeAll { $0 == item }
        } else {
            selectedItems.append(item)
        }
    }
   
    func isItemSelected(_ item: SelectCategoryModel.Item) -> Bool {
        selectedItems.contains(where: { $0 == item })
    }
    
    
    let data = """
    [{
        "english_name": "other",
        "category": "other",
        "indian_name": "",
        "hindi_name": "",
        "icon": null,
        "type": "product",
            "products": []
    },
      {
        "english_name": "vegetables",
        "category": "vegetables",
        "indian_name": "",
        "hindi_name": "",
        "icon": null,
        "type": "category",
        "products": [
          {
            "english_name": "Yam",
            "category": "vegetables",
            "indian_name": "Sooran",
            "hindi_name": "सूरन",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Turnip",
            "category": "vegetables",
            "indian_name": "Shalgam",
            "hindi_name": "शलगम",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Tapioca",
            "category": "vegetables",
            "indian_name": "Kachalu",
            "hindi_name": "कचालू",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Sweet Potato",
            "category": "vegetables",
            "indian_name": "Shakarkand",
            "hindi_name": "शकरकंद",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Snake Gourd",
            "category": "vegetables",
            "indian_name": "Chichinda",
            "hindi_name": "चिचिंडा",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Water Chestnut",
            "category": "vegetables",
            "indian_name": "Singhara",
            "hindi_name": "सिंघाड़ा",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Ridged Gourd",
            "category": "vegetables",
            "indian_name": "Torai",
            "hindi_name": "तोरी",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Purple Yam",
            "category": "vegetables",
            "indian_name": "Surti Kand",
            "hindi_name": "सुरती कंद",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Pointed Gourd",
            "category": "vegetables",
            "indian_name": "Parwal",
            "hindi_name": "परवल",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Bitter Gourd",
            "category": "vegetables",
            "indian_name": "Karela",
            "hindi_name": "करेला",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Bottle Gourd",
            "category": "vegetables",
            "indian_name": "Lauki",
            "hindi_name": "लौकी",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Brinjal (Eggplant)",
            "category": "vegetables",
            "indian_name": "Baingan",
            "hindi_name": "बैंगन",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Lady Finger (Okra)",
            "category": "vegetables",
            "indian_name": "Bhindi",
            "hindi_name": "भिंडी",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Cabbage",
            "category": "vegetables",
            "indian_name": "Patta Gobhi",
            "hindi_name": "पत्ता गोभी",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Cauliflower",
            "category": "vegetables",
            "indian_name": "Phool Gobhi",
            "hindi_name": "फूल गोभी",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Carrot",
            "category": "vegetables",
            "indian_name": "Gajar",
            "hindi_name": "गाजर",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Radish",
            "category": "vegetables",
            "indian_name": "Mooli",
            "hindi_name": "मूली",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Spinach",
            "category": "vegetables",
            "indian_name": "Palak",
            "hindi_name": "पालक",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Fenugreek Leaves",
            "category": "vegetables",
            "indian_name": "Methi",
            "hindi_name": "मेथी",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Green Peas",
            "category": "vegetables",
            "indian_name": "Matar",
            "hindi_name": "मटर",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Pumpkin",
            "category": "vegetables",
            "indian_name": "Kaddu",
            "hindi_name": "कद्दू",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Tomato",
            "category": "vegetables",
            "indian_name": "Tamatar",
            "hindi_name": "टमाटर",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Onion",
            "category": "vegetables",
            "indian_name": "Pyaaz",
            "hindi_name": "प्याज",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Garlic",
            "category": "vegetables",
            "indian_name": "Lahsun",
            "hindi_name": "लहसुन",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Ginger",
            "category": "vegetables",
            "indian_name": "Adrak",
            "hindi_name": "अदरक",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Green Chili",
            "category": "vegetables",
            "indian_name": "Hari Mirch",
            "hindi_name": "हरी मिर्च",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Coriander Leaves",
            "category": "vegetables",
            "indian_name": "Dhaniya",
            "hindi_name": "धनिया",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Mint Leaves",
            "category": "vegetables",
            "indian_name": "Pudina",
            "hindi_name": "पुदीना",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Cucumber",
            "category": "vegetables",
            "indian_name": "Kheera",
            "hindi_name": "खीरा",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Mushroom",
            "category": "vegetables",
            "indian_name": "Khumb",
            "hindi_name": "कुम्भ",
            "icon": null,
            "type": "product",
            "products": []
          }
        ]
      },
      {
        "english_name": "fruits",
        "category": "fruits",
        "indian_name": "",
        "hindi_name": "",
        "icon": null,
        "type": "category",
        "products": [
          {
            "english_name": "Mango",
            "category": "fruits",
            "indian_name": "Aam",
            "hindi_name": "आम",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Banana",
            "category": "fruits",
            "indian_name": "Kela",
            "hindi_name": "केला",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Apple",
            "category": "fruits",
            "indian_name": "Seb",
            "hindi_name": "सेब",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Grapes",
            "category": "fruits",
            "indian_name": "Angoor",
            "hindi_name": "अंगूर",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Orange",
            "category": "fruits",
            "indian_name": "Santra",
            "hindi_name": "संतरा",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Pineapple",
            "category": "fruits",
            "indian_name": "Ananas",
            "hindi_name": "अनानास",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Papaya",
            "category": "fruits",
            "indian_name": "Papita",
            "hindi_name": "पपीता",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Guava",
            "category": "fruits",
            "indian_name": "Amrood",
            "hindi_name": "अमरूद",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Pomegranate",
            "category": "fruits",
            "indian_name": "Anaar",
            "hindi_name": "अनार",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Watermelon",
            "category": "fruits",
            "indian_name": "Tarbooz",
            "hindi_name": "तरबूज",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Muskmelon",
            "category": "fruits",
            "indian_name": "Kharbooja",
            "hindi_name": "खरबूजा",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Lychee",
            "category": "fruits",
            "indian_name": "Litchi",
            "hindi_name": "लीची",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Chikoo (Sapodilla)",
            "category": "fruits",
            "indian_name": "Chikoo",
            "hindi_name": "चीकू",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Custard Apple",
            "category": "fruits",
            "indian_name": "Sitaphal",
            "hindi_name": "सीताफल",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Jackfruit",
            "category": "fruits",
            "indian_name": "Kathal",
            "hindi_name": "कटहल",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Strawberry",
            "category": "fruits",
            "indian_name": "Strawberry",
            "hindi_name": "स्ट्रॉबेरी",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Blueberry",
            "category": "fruits",
            "indian_name": "Neelbadri",
            "hindi_name": "नीलबदरी",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Blackberry",
            "category": "fruits",
            "indian_name": "Jamun",
            "hindi_name": "जामुन",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Peach",
            "category": "fruits",
            "indian_name": "Aadoo",
            "hindi_name": "आड़ू",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Plum",
            "category": "fruits",
            "indian_name": "Aloo Bukhara",
            "hindi_name": "आलू बुखारा",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Apricot",
            "category": "fruits",
            "indian_name": "Khubani",
            "hindi_name": "खुबानी",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Pear",
            "category": "fruits",
            "indian_name": "Nashpati",
            "hindi_name": "नाशपाती",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Fig",
            "category": "fruits",
            "indian_name": "Anjeer",
            "hindi_name": "अंजीर",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Dates",
            "category": "fruits",
            "indian_name": "Khajoor",
            "hindi_name": "खजूर",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Coconut",
            "category": "fruits",
            "indian_name": "Nariyal",
            "hindi_name": "नारियल",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Lemon",
            "category": "fruits",
            "indian_name": "Nimbu",
            "hindi_name": "नींबू",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Tamarind",
            "category": "fruits",
            "indian_name": "Imli",
            "hindi_name": "इमली",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Gooseberry",
            "category": "fruits",
            "indian_name": "Amla",
            "hindi_name": "आंवला",
            "icon": null,
            "type": "product",
            "products": []
          },
          {
            "english_name": "Mulberry",
            "category": "fruits",
            "indian_name": "Shahtoot",
            "hindi_name": "शहतूत",
            "icon": null,
            "type": "product",
            "products": []
          }
        ]
      }
    ]
    """
}
