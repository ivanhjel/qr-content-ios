//
//  URL+Extension.swift
//  quick-response
//
//  Created by Ivan Hjelmeland on 15/08/2022.
//

import Foundation

extension URL {
    func valueOf(_ queryParameterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParameterName })?.value
    }
}
