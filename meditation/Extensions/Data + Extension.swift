//
//  Data + Extension.swift
//  meditation
//
//  Created by Ilya Medvedev on 08.08.2023.
//

import Foundation

extension Data {
    func convertToURL() -> URL {
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(NSUUID().uuidString).appendingPathExtension("mp4")
        do {
            try self.write(to: tempURL, options: [.atomic])
        } catch {
            print()
        }
        return tempURL
    }
}
