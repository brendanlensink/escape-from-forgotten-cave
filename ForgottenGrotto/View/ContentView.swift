//
//  ContentView.swift
//  ForgottenGrotto
//
//  Created by Brendan on 2021-08-13.
//

import NiceComponents
import SwiftUI

struct ContentView: View {
    @ObservedObject var manager = NFCManager()

    var body: some View {
        Color.themeColors.background
            .ignoresSafeArea()
            .overlay (
                ZStack {
                    Image("cave")
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()

                    VStack {
                        if manager.current.id == 0 {
                            showIntroScreen()
                        } else {
                            showStoryScreen(manager.current)
                        }
                    }.padding(.horizontal, 40)
                }
            )
    }

    private func showIntroScreen() -> some View {
        return AnyView(VStack {
            Text("Escape From The")
                .foregroundColor(Color.themeColors.onPrimary)
                .font(Font.custom("VT323", size: 32))
                .fixedSize(horizontal: false, vertical: true)
            Text("FORGOTTEN CAVE")
                .foregroundColor(Color.themeColors.onPrimary)
                .font(Font.custom("VT323", size: 62))
                .fixedSize(horizontal: false, vertical: true)

            Spacer().frame(height: 50)
            Spacer().frame(height: 50)

            Text("Scan START to begin")
                .foregroundColor(Color.themeColors.onPrimary)
                .font(Font.custom("VT323", size: 33))
                .fixedSize(horizontal: false, vertical: true)

            ScanButton(manager: manager)
        })
    }

    private func showStoryScreen(_ content: StoryContent) -> some View {
        return AnyView(
            VStack {
                Spacer().frame(height: 50)

                Text("\(content.content)")
                    .foregroundColor(Color.themeColors.onPrimary)
                    .font(Font.custom("VT323", size: 20))
                    .fixedSize(horizontal: false, vertical: true)

                Spacer().frame(height: 50)

                if !manager.current.nextOptions.isEmpty {
                    Text("Scan one of the following tiles to continue")
                        .foregroundColor(Color.themeColors.onPrimary)
                        .font(Font.custom("VT323", size: 16))
                        .fixedSize(horizontal: false, vertical: true)

                    ForEach(manager.current.nextOptions, id: \.self.id) { option in
                        TileView(option: option)
                    }
                    .background(Color.clear)

                    Spacer().frame(height: 50)

                    ScanButton(manager: manager)
                } else {
                    if manager.current.isGameOver {
                        Text("GAME OVER")
                            .foregroundColor(Color.themeColors.onPrimary)
                            .font(Font.custom("VT323", size: 66))
                            .fixedSize(horizontal: false, vertical: true)
                    } else {
                        Text("YOU HAVE SURVIVED")
                            .foregroundColor(Color.themeColors.onPrimary)
                            .font(Font.custom("VT323", size: 66))
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    Spacer().frame(height: 50)

                    Button(action: { manager.restart()}) {
                        Text("NEW GAME")
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
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
