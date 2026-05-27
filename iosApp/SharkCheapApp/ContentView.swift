import SwiftUI
import SharedLogic

struct ContentView: View {
    @State private var showContent = false
    @State private var apiResponse = "Loading..."

    var body: some View {
        VStack {
            Button("Click me!") {
                withAnimation {
                    showContent = !showContent
                }
            }

            if showContent {
                ScrollView {
                    VStack(spacing: 16) {
                        Image(systemName: "swift")
                            .font(.system(size: 200))
                            .foregroundColor(.accentColor)
                        Text(apiResponse)
                            .font(.system(size: 14))
                    }
                }
                .transition(.move(edge: .top).combined(with: .opacity))
                .task {
                    await fetchStores()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
    }

    @MainActor
    private func fetchStores() async {
        do {
            apiResponse = try await CheapSharkBridge().fetchStoresRaw()
        } catch {
            apiResponse = "Request failed: \(error.localizedDescription)"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
