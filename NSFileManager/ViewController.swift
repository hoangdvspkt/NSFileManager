//
//  ViewController.swift
//  NSFileManager
//
//  Created by hoangdv on 5/19/17.
//  Copyright © 2017 com.hoangdv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var fileManagaer:FileManager?
    var filePath:NSString?
    var documentDir:NSString?
    
    @IBAction func btnCreateFile(_ sender: Any) {
        filePath = documentDir?.appendingPathComponent("file1.txt") as NSString?
        fileManagaer?.createFile(atPath: filePath! as String, contents: nil, attributes: nil)
        
        filePath = documentDir?.appendingPathComponent("file2.txt") as NSString?
        fileManagaer?.createFile(atPath: filePath! as String, contents: nil, attributes: nil)
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "File created successfully")
    }
    @IBAction func btnCreateDirectory(_ sender: Any) {
        filePath=documentDir?.appendingPathComponent("/folder1") as NSString?
        do {
            try fileManagaer?.createDirectory(atPath: filePath! as String, withIntermediateDirectories: false, attributes: nil)
        }
        catch let error as NSError {
            print(error)
        }
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "Directory created successfully")
    }
    @IBAction func btnEqualityCheck(_ sender: Any) {
        let filePath1=documentDir?.appendingPathComponent("temp.txt")
        let filePath2=documentDir?.appendingPathComponent("copy.txt")
        if(fileManagaer? .contentsEqual(atPath: filePath1!, andPath: filePath2!))!
        {
            self.showSuccessAlert(titleAlert: "Message", messageAlert: "Files are equal.")
        }
        else
        {
            self.showSuccessAlert(titleAlert: "Message", messageAlert: "Files are not equal.")
        }
    }
    @IBAction func btnWriteFile(_ sender: Any) {
        let content:NSString=NSString(string: "hello how are you?")
        let fileContent:NSData=content.data(using: String.Encoding.utf8.rawValue)! as NSData
        fileContent .write(toFile: (documentDir?.appendingPathComponent("file1.txt"))!, atomically: true)
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "Content written successfully")
    }
    @IBAction func btnReadFile(_ sender: Any) {
        filePath = documentDir?.appendingPathComponent("/file1.txt") as! String as NSString
        var fileContent: Data?
        fileContent = fileManagaer?.contents(atPath: filePath! as String)
        let str: NSString = NSString(data: fileContent!, encoding: String.Encoding.utf8.rawValue)!
        self.showSuccessAlert(titleAlert: "Success", messageAlert: ("data : \(str)" as NSString) as String as String as NSString)
    }
    @IBAction func btnMoveFile(_ sender: Any) {
        let oldFilePath: String = documentDir!.appendingPathComponent("file1.txt") as! String
        let newFilePath: String = documentDir!.appendingPathComponent("/folder1/file1.txt") as String
        do {
            try fileManagaer?.moveItem(atPath: oldFilePath, toPath: newFilePath)
        }
        catch let error as NSError {
            print(error)
        }
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "File moved successfully")
    }
    @IBAction func btnCopyFile(_ sender: Any) {
        let originalFile=documentDir?.appendingPathComponent("file1.txt")
        let copyFile=documentDir?.appendingPathComponent("copy.txt")
        try? fileManagaer?.copyItem(atPath: originalFile!, toPath: copyFile!)
        self.showSuccessAlert(titleAlert: "Success", messageAlert:"File copied successfully")
    }
    @IBAction func btnFilePermissions(_ sender: Any) {
        filePath=documentDir?.appendingPathComponent("temp.txt") as! NSString
        var filePermissions:NSString = ""
        if(fileManagaer?.isWritableFile(atPath: filePath! as String))!
        {
            filePermissions=filePermissions.appending("file is writable. ") as NSString
        }
        if(fileManagaer?.isReadableFile(atPath: filePath! as String))!
        {
            filePermissions=filePermissions.appending("file is readable. ") as NSString
        }
        if(fileManagaer?.isExecutableFile(atPath: filePath! as String))!
        {
            filePermissions=filePermissions.appending("file is executable.") as NSString
        }
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "\(filePermissions)" as NSString)
    }
    @IBAction func btnDirectoryContents(_ sender: Any) {
        var error: NSError? = nil
        do {
            let arrDirContent = try fileManagaer!.contentsOfDirectory(atPath: filePath! as String)
            self.showSuccessAlert(titleAlert: "Success", messageAlert: "Content of directory \(arrDirContent)" as NSString)
        }
        catch let error as NSError {
            
        }
    }
    @IBAction func btnRemoveFile(_ sender: Any) {
        filePath = documentDir?.appendingPathComponent("file1.txt") as! NSString
        try? fileManagaer?.removeItem(atPath: filePath as! String)
        self.showSuccessAlert(titleAlert: "Message", messageAlert: "File removed successfully.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fileManagaer = FileManager.default
        let dirPaths:NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        documentDir = dirPaths[0] as? NSString
        print("path : \(String(describing: documentDir))")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showSuccessAlert(titleAlert:NSString,messageAlert:NSString)
    {
        let alert:UIAlertController=UIAlertController(title:titleAlert as String, message: messageAlert as String, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
        }
        alert.addAction(okAction)
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            self.present(alert, animated: true, completion: nil)
        }
    }

}

