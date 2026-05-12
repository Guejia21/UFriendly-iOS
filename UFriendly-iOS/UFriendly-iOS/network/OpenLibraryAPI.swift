import Foundation

actor OpenLibraryAPI {
    static let shared = OpenLibraryAPI()
    private let baseURL = "https://openlibrary.org/"
    private let session = URLSession.shared

    func searchBooks(query: String, limit: Int = 10) async throws -> [BookDoc] {
        let encoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        let urlString = "\(baseURL)search.json?q=\(encoded)&limit=\(limit)&fields=title,author_name,cover_i,first_publish_year,key"
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }

        let (data, _) = try await session.data(from: url)
        let response = try JSONDecoder().decode(BookResponse.self, from: data)
        return response.docs
    }
}
