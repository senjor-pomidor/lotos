//
//  FileManager.swift
//  TTEnigma
//
//  Created by Andrey Torlopov on 02/05/16.
//  Copyright © 2016 Andrey Torlopov. All rights reserved.
//

import UIKit

class FileManager: NSObject {

    class func saveImage(image: UIImage, withName name: String) {
        if !FileManager.isDirecyoryExists(FileManager.userDirectory()) {
            FileManager.setupUserDirectory()
        }
        
        let path = FileManager.userDirectory()
        let fullPath = path.stringByAppendingString("/\(name)")
        let imgData = UIImageJPEGRepresentation(image,1);        
        imgData?.writeToFile(fullPath, atomically: true)
        
    }
    
    class func loadLocalImage(name: String) -> UIImage? {
        if !FileManager.isDirecyoryExists(FileManager.userDirectory()) {
            FileManager.setupUserDirectory()
        }
        //имя файла добавить!
        let path = FileManager.userDirectory()
        let fullPath = path.stringByAppendingString("/\(name)")
        if let data = NSData(contentsOfFile: fullPath) {
            return UIImage(data: data)!
        }
        return nil
    }
    
    class func setupUserDirectory() {
        let dataPath = FileManager.userDirectory()
        do {
            try NSFileManager.defaultManager().createDirectoryAtPath(dataPath, withIntermediateDirectories: false, attributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription);
        }
    }
    
    class func userDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDirectory: AnyObject = paths[0]
        return documentsDirectory.stringByAppendingPathComponent(Constants.userFolder)
    }
    
    //TODO: extend method
    class func isDirecyoryExists(fullPath: String) -> Bool {
        var isDir : ObjCBool = false
        if NSFileManager.defaultManager().fileExistsAtPath(fullPath, isDirectory:&isDir) {
            if isDir {
                // file exists and is a directory
                return true
            } else {
                // file exists and is not a directory
                return false
            }
        } else {
            // file does not exist
            return false
        }
    }
    
    
    class func deleteFilesInDirectory(path: String) {
        if let enumerator = NSFileManager.defaultManager().enumeratorAtPath(path) {
            while let fileName = enumerator.nextObject() as? String {
                do {
                    try NSFileManager.defaultManager().removeItemAtPath("\(path)/\(fileName)")
                }
                catch let e as NSError {
                    print(e)
                }
                catch {
                    print("error")
                }
            }
        }
    }
}
