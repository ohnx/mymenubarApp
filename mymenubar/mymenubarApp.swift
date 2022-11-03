//
//  mymenubarApp.swift
//  mymenubar
//
//  Created by Mason on 11/2/22.
//

import SwiftUI

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

@main
struct mymenubarApp: App {
    @State var scripts : [URL]
    let kbs = [KeyboardShortcut("1"), KeyboardShortcut("2"), KeyboardShortcut("3"), KeyboardShortcut("4"), KeyboardShortcut("5"), KeyboardShortcut("6"), KeyboardShortcut("7"), KeyboardShortcut("8"), KeyboardShortcut("9"), KeyboardShortcut("0")]
    
    var body: some Scene {
        MenuBarExtra("MMBA", systemImage: "hammer") {
            VStack {
                ForEach (scripts.indices) { i in
                    Button("\(scripts[i].lastPathComponent)") {
                        do {
                            try Process.run(scripts[i], arguments: []) {_ in
                                
                            }
                        } catch {
                            
                        }
                    }.keyboardShortcut(kbs[safe: i])
                }
            }
            Divider()
            Button("Refresh") {
                print("TODO")
            }
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
        }
    }

    init() {
        do {
            let documentURL = FileManager.default.homeDirectoryForCurrentUser
            let path = documentURL.appendingPathComponent(".config").appendingPathComponent("mmba").absoluteURL
            scripts = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil, options: [])
        } catch {
            print(error.localizedDescription)
            scripts = []
        }
    }
}
