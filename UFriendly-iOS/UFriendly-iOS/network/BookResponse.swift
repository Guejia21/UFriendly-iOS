import Foundation

struct BookResponse: Codable {
    let docs: [BookDoc]
}

struct BookDoc: Codable, Identifiable {
    var id: String { key ?? UUID().uuidString }
    let title: String?
    let author_name: [String]?
    let first_publish_year: Int?
    let cover_i: Int?
    let key: String?

    func coverUrl(size: String = "M") -> URL? {
        guard let coverId = cover_i else { return nil }
        return URL(string: "https://covers.openlibrary.org/b/id/\(coverId)-\(size).jpg")
    }
}
