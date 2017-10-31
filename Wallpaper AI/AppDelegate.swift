//
//  AppDelegate.swift
//  Wallpaper AI
//
//  Created by Abhi C on 26/10/17.
//  Copyright © 2017 MindFuzz. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
//            button.action = #selector(changeWallpaper(_:))
        }
        constructMenu()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @objc func changeWallpaper(_ sender: Any?) {
        if let path = Bundle.main.resourcePath {
            
            let imagePath = path + "/Images"
            let url = NSURL(fileURLWithPath: imagePath)
            let fileManager = FileManager.default
            
            let properties = [URLResourceKey.localizedNameKey,
                              URLResourceKey.creationDateKey, URLResourceKey.localizedTypeDescriptionKey]
            
            do {
                let imageURLs = try fileManager.contentsOfDirectory(at: url as URL, includingPropertiesForKeys: properties, options:FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)
                
//              print(imageURLs.count)
                let imgurl = imageURLs[Int(arc4random_uniform(245))]
                let workspace = NSWorkspace.shared
                if let screen = NSScreen.main  {
                    try workspace.setDesktopImageURL(imgurl, for: screen, options: [:])
                }
                
            } catch {
                print(error)
        }
    }
    }
    
    @objc func openPreferences(_ sender: Any?) {
        
    }
    
    func constructMenu() {
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Change Wallpaper", action: #selector(AppDelegate.changeWallpaper(_:)), keyEquivalent: "c"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Preferences...", action: #selector(AppDelegate.openPreferences(_:)), keyEquivalent: "p"))
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        statusItem.menu = menu
    }


}

