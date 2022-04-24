//
//  Extensions.swift
//  My Netflix Clone
//
//  Created by said fatah on 23/4/2022.
//

import Foundation

extension String {
    func trimingTrailingSpaces(using characterSet: CharacterSet = .whitespacesAndNewlines) -> String {
          guard let index = lastIndex(where: { !CharacterSet(charactersIn: String($0)).isSubset(of: characterSet) }) else {
              return self
          }

          return String(self[...index])
    }
    func trimingLeadingSpaces(using characterSet: CharacterSet = .whitespacesAndNewlines) -> String {
         guard let index = firstIndex(where: { !CharacterSet(charactersIn: String($0)).isSubset(of: characterSet) }) else {
             return self
         }

         return String(self[index...])
     }
}
