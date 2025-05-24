import SwiftUI

struct InputView: View {
    let placeholder: String
    var isSecuredField: Bool = false
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(placeholder)
                .font(.caption)
                .foregroundColor(.gray)

            if isSecuredField {
                SecureField("", text: $text)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            } else {
                TextField("", text: $text)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
        )
    }
}

#Preview {
    ZStack {
        Color(.systemGroupedBackground).ignoresSafeArea()
        InputView(placeholder: "Email or Phone Number", text: .constant(""))
            .padding()
    }
}
