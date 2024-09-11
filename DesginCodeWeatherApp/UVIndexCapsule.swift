import SwiftUI

struct UVIndexView: View {
    // UV Index range colors from 0 to 11+
    let uvRangeColors: [Color] = [
        Color(red: 0.0, green: 0.5, blue: 0.0), // Green for 0-2 (Low)
        Color.yellow,                           // Yellow for 3-5 (Moderate)
        Color.orange,                           // Orange for 6-7 (High)
        Color.red,                              // Red for 8-10 (Very High)
        Color.purple,                           // Purple for 11+ (Extreme)
        Color(red: 0.5, green: 0.0, blue: 0.0)  // Dark Red for 11+ (Extreme)
    ]
    
    // UV Index to display
    let uvIndex: Int
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .leading) {
                    // Linear gradient background capsule displaying all UV index colors
                    LinearGradient(
                        gradient: Gradient(colors: uvRangeColors),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(height: 10)
                    .clipShape(Capsule())
                    
                    // Circle indicating the current UV index
                    Circle()
                        .fill(Color.white)
                        .shadow(radius: 3)
                        .frame(width: 10, height: 10)
                        .offset(x: offsetForUVIndex(geometry: geometry))
                }
                
                Text("UV Index: \(uvIndex)")
                    .font(.headline)
                    .padding(.top, 10)
            }
        }
        .padding()
    }
    
    // Helper function to calculate the offset of the circle
    private func offsetForUVIndex(geometry: GeometryProxy) -> CGFloat {
        let totalWidth = geometry.size.width
        let cappedUVIndex = min(max(uvIndex, 0), 11)
        
        // Normalized index range
        let normalizedIndex = CGFloat(cappedUVIndex) / 11.0
        let offset = totalWidth * normalizedIndex - 10 // 10 is half the circle size
        return offset
    }
}

#Preview(body: {
    UVIndexView(uvIndex: 3)
})
