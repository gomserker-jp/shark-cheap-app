import SwiftUI

struct IndicatorView: View {
  var body: some View {
    ProgressView()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

#Preview {
  IndicatorView()
}
