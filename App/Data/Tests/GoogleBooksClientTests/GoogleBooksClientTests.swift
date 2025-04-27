import Domain
import Foundation
import ModelConverter
import Networking
import Testing

@testable import GoogleBooksClient

@Suite
struct GoogleBooksClientTests {
  @Test
  func sut_fetches_google_books_volumes() async throws {
    var failed = false
    let dummyRequest = URLRequest(url: URL(string: "https://example.com")!)
    let requestBuilder = StubRequestBuilderClient(urlRequest: dummyRequest, error: nil)
    
    let volumesResponse = VolumesResponse(
      totalItems: 1,
      items: [
        VolumeResponse(
          id: "123",
          volumeInfo: .init(
            title: "Swift Programming",
            authors: ["Author A"],
            publishedDate: "2025",
            description: "Learn Swift",
            imageLinks: .init(thumbnail: "https://example.com/thumb.jpg"),
            maturityRating: "NOT_MATURE"
          ),
          saleInfo: .init(
            saleability: "FOR_SALE",
            listPrice: nil
          )
        )
      ]
    )
    
    let urlSessionClient = StubURLSessionClient(mockObject: volumesResponse)
    
    let client = GoogleBooksClient.live(
      requestBuilder: requestBuilder,
      urlSessionClient: urlSessionClient,
      volumesConverter: .init(
        toDomain: { _ in
          Volumes(
            volumes: [
              Volume(
                id: "123",
                title: "Swift Programming",
                authors: ["Author1"],
                description: "Learn Swift",
                thumbnailImageURLPath: "https://example.com/thumb.jpg",
                isMatureContent: false,
                publishedYear: "2025",
                saleability: .forSale,
                price: nil
              )
            ],
            totalItems: 1
          )
        }
      )
    )
    
    let result = await client.search("Swift", 0)
    
    switch result {
    case let .success(volumes):
      #expect(volumes.totalItems == 1)
      #expect(volumes.volumes.count == 1)
      #expect(volumes.volumes.first?.title == "Swift Programming")
      #expect(volumes.volumes.first?.isMatureContent == false)
    case .failure:
      failed = true
    }
    #expect(!failed)
  }
  
  @Test
  func sut_throws_error_when_request_builder_fails() async throws {
    let requestBuilder = StubRequestBuilderClient(urlRequest: nil, error: .requestFailed)
    
    let urlSessionClient = StubURLSessionClient<VolumesResponse>(mockObject: nil)
    
    let client = GoogleBooksClient.live(
      requestBuilder: requestBuilder,
      urlSessionClient: urlSessionClient,
      volumesConverter: .init(
        toDomain: { _ in
            .init(volumes: [], totalItems: 0)
        }
      )
    )
    
    let result = await client.search("Swift", 0)
    
    #expect(result == .failure(.requestFailed))
  }
  
  @Test
  func sut_throws_error_when_url_session_client_fails() async throws {
    let dummyRequest = URLRequest(url: URL(string: "https://example.com")!)
    let requestBuilder = StubRequestBuilderClient(urlRequest: dummyRequest, error: nil)
    
    let stubError = NetworkError.requestFailed
    let urlSessionClient = StubURLSessionClient<VolumesResponse>(mockObject: nil, mockError: stubError)
    
    let client = GoogleBooksClient.live(
      requestBuilder: requestBuilder,
      urlSessionClient: urlSessionClient,
      volumesConverter: .init(
        toDomain: { _ in
            .init(volumes: [], totalItems: 0)
        }
      )
    )
    
    let result = await client.search("Swift", 0)
    
    #expect(result == .failure(.requestFailed))
  }
}
