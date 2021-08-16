//
//  TileView.swift
//  ForgottenGrotto
//
//  Created by Brendan on 2021-08-13.
//

import NiceComponents
import SwiftUI

struct TileView: View {
    let option: NextOption

    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .foregroundColor(Color.themeColors.onPrimary)
                    .frame(width: 30, height: 30, alignment: .center)

                Text("\(option.id)")
                    .foregroundColor(Color.themeColors.primary)
                    .font(Font.custom("VT323", size: 20))
                    .fixedSize(horizontal: false, vertical: true)
            }

            Text("\(option.content)")
                .foregroundColor(Color.themeColors.onPrimary)
                .font(Font.custom("VT323", size: 20))
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}
