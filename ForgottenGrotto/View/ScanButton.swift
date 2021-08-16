//
//  ScanButton.swift
//  ForgottenGrotto
//
//  Created by Brendan on 2021-08-13.
//

import SwiftUI

struct ScanButton: View {
    let manager: NFCManager
    
    var body: some View {
        Button(action: { manager.startScan()}) {
            Text("SCAN")
                .foregroundColor(Color.themeColors.onSurface)
                .font(Font.custom("VT323", size: 33))
                .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
        }
        .fixedSize(horizontal: false, vertical: true)
        .background(Color.themeColors.surface)
                .overlay(
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(Color.themeColors.onPrimary, lineWidth: 2)
        ).padding(4)
    }
}
