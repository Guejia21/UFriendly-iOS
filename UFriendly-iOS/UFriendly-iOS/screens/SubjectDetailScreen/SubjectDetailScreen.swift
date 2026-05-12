import SwiftUI

struct SubjectDetailScreen: View {
    let subject: Subject

    @State private var books: [BookDoc] = []
    @State private var isLoading = true
    @State private var errorMessage: String?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                SubjectFullCard(subject: subject)
                    .padding(.horizontal)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Suggested Reading for \(subject.name)")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.horizontal)

                    if isLoading {
                        VStack(spacing: 12) {
                            ProgressView()
                            Text("Searching books...")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(32)
                    } else if let error = errorMessage {
                        VStack(spacing: 12) {
                            Image(systemName: "wifi.slash")
                                .font(.system(size: 40))
                                .foregroundColor(.gray)
                            Text(error)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(32)
                    } else if books.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "book")
                                .font(.system(size: 40))
                                .foregroundColor(.gray)
                            Text("No books found")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(32)
                    } else {
                        LazyVStack(spacing: 12) {
                            ForEach(books) { book in
                                BookSuggestionCard(book: book)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.vertical)
        }
        .navigationTitle(subject.name)
        .task {
            await loadBooks()
        }
    }

    private func loadBooks() async {
        isLoading = true
        errorMessage = nil
        do {
            books = try await OpenLibraryAPI.shared.searchBooks(query: subject.name)
        } catch {
            errorMessage = "Could not load books. Check your connection."
        }
        isLoading = false
    }
}

struct BookSuggestionCard: View {
    let book: BookDoc

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: book.coverUrl()) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 90)
                        .cornerRadius(6)
                case .failure:
                    Rectangle()
                        .fill(Color(.systemGray5))
                        .frame(width: 60, height: 90)
                        .overlay(Image(systemName: "book").foregroundColor(.gray))
                        .cornerRadius(6)
                case .empty:
                    Rectangle()
                        .fill(Color(.systemGray5))
                        .frame(width: 60, height: 90)
                        .overlay(ProgressView())
                        .cornerRadius(6)
                @unknown default:
                    EmptyView()
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(book.title ?? "Unknown title")
                    .font(.headline)
                    .lineLimit(2)
                if let authors = book.author_name {
                    Text(authors.joined(separator: ", "))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                if let year = book.first_publish_year {
                    Text("First published: \(year)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}
