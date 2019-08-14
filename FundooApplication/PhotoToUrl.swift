//
//  PhotoToUrl.swift
//  FundooApplication
//
//  Created by BridgeLabz on 09/08/19.
//  Copyright © 2019 Bridgelabz. All rights reserved.
//

import Foundation
import UIKit

class photoToFile {
static func storeImageToDocumentDirectory(image: UIImage, fileName: String) -> URL? {
    guard let data = image.pngData() else {
        return nil
    }
    let fileURL = self.fileURLInDocumentDirectory(fileName)
    do {
        try data.write(to: fileURL)
        return fileURL
    } catch {
        return nil
    }
}

public static func fileURLInDocumentDirectory(_ fileName: String) -> URL {
    return self.documentsDirectoryURL.appendingPathComponent(fileName)
}
public static var documentsDirectoryURL: URL {
    return FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)[0]
}
}
