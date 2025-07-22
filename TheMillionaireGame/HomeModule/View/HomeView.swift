import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.215, green: 0.298, blue: 0.580),
                        Color(red: 0.063, green: 0.055, blue: 0.086)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    
                    Text("Who Wants\nto be a Millionare")
                        .font(
                            .system(
                                size: 32,
                                weight: .bold,
                                design: .rounded
                            )
                        )
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.top, 16)
                    
                    
                    Text("All-time Best Score")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.white)
                        .opacity(0.5)
                        .multilineTextAlignment(.center)
                        .padding(.top, 16)
                    
                    HStack {
                        Spacer()
                        Image("coin")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                        
                        
                        Text("15,000")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    Spacer()
                    HexagonalButton(
                        text: "New game",
                        color: .yellow,
                        width: 250,
                        height: 50,
                        action: {
                        },
                        isLeadingText: false
                    )
                    
                    HexagonalButton(
                        text: "Continue game",
                        color: .blue,
                        width: 250,
                        height: 50,
                        action: {
                        },
                        isLeadingText: false
                    )
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image("help")
                            .renderingMode(.original)
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
} 
