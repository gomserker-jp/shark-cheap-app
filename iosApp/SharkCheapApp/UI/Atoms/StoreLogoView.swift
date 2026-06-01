import Kingfisher
import SwiftUI

struct StoreLogoView: View {
  let url: String

  var body: some View {
    Group {
      if let imageURL = URL(string: url) {
        KFImage(imageURL)
          .placeholder {
            ProgressView()
          }
          .resizable()
          .scaledToFit()
      } else {
        Image(systemName: "photo")
          .resizable()
          .scaledToFit()
          .foregroundStyle(.secondary)
      }
    }
    .frame(width: 96, height: 48)
    .clipShape(RoundedRectangle(cornerRadius: 8))
  }
}

#Preview {
  StoreLogoView(url: "https://www.cheapshark.com/images/stores/logos/0.png")
}
