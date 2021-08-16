//
//  NFCManager.swift
//  ForgottenGrotto
//
//  Created by Brendan on 2021-08-13.
//

import CoreNFC
import SwiftUI

class NFCManager: NSObject, ObservableObject {
    override init() {
        if let path = Bundle.main.path(forResource: "story", ofType: "json") {
            print("got thru path")
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                self.content = try decoder.decode([StoryContent].self, from: data)

                if let first = self.content.first {
                    current = first
                }
            } catch {
                print(error)
                print("failed")
                // handle error
            }
        } else {
            print("cant find story")
        }
    }

    private var session: NFCNDEFReaderSession?
    private let decoder = JSONDecoder()

    @Published var current: StoryContent = StoryContent(id: 0, content: "", isGameOver: false, nextOptions: [NextOption(id: 1, content: "")])
    private var content: [StoryContent] = []

    func startScan() {
        guard session == nil else {
            fatalError("Session wasn't nil")
        }

        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
         session?.alertMessage = "Hold your iPhone near the tag."
         session?.begin()
    }

    func restart() {
        current = StoryContent(id: 0, content: "", isGameOver: false, nextOptions: [NextOption(id: 1, content: "")])
    }
}

extension NFCManager: NFCNDEFReaderSessionDelegate {
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
        print("Reader session started")
    }

    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        guard let payload = messages.first?.records.first?.wellKnownTypeTextPayload(),
              let contentId = Int(payload.0 ?? "") else {
            print("message decode failed")
            self.session = nil
            return
        }

        DispatchQueue.main.async {
            if self.current.nextIds.contains(contentId) {
                self.current = self.content.first(where: { $0.id == contentId }) ?? StoryContent(id: 0, content: "", isGameOver: false, nextOptions: [NextOption(id: 1, content: "")])
            }
        }
        self.session = nil
    }

    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        if let readerError = error as? NFCReaderError {
            print(readerError)
        }

        self.session = nil
    }

}
