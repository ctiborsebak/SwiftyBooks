import Foundation
import Testing

@testable import ModelConverter

private struct UserDTO: Equatable {
  public let userId: String
  public let username: String
}

private struct User: Equatable {
  public let id: String
  public let name: String
}

@Suite
struct ModelConverterTests {
  @Test
  func sut_should_convert_to_domain() {
    let userDTO = UserDTO(userId: "123", username: "john_doe")

    let converter = ModelConverter<User, UserDTO>(
      toDomain: { dto in
        User(id: dto.userId, name: dto.username)
      }
    )

    let user = converter.convertToDomain(from: userDTO)

    #expect(user?.id == "123")
    #expect(user?.name == "john_doe")
  }

  @Test
  func sut_should_convert_to_external() {
    let user = User(id: "123", name: "john_doe")

    let converter = ModelConverter<User, UserDTO>(
      toExternal: { user in
        UserDTO(userId: user.id, username: user.name)
      }
    )

    let userDTO = converter.convertToExternal(from: user)

    #expect(userDTO?.userId == "123")
    #expect(userDTO?.username == "john_doe")
  }

  @Test
  func sut_should_convert_to_domain_with_custom_logic() {
    let userDTO = UserDTO(userId: "456", username: "jane_doe")

    let converter = ModelConverter<User, UserDTO>(
      toDomain: { dto in
        User(id: dto.userId, name: "Mr. \(dto.username)")
      }
    )

    let user = converter.convertToDomain(from: userDTO)

    #expect(user?.id == "456")
    #expect(user?.name == "Mr. jane_doe")
  }

  @Test
  func sut_should_convert_to_external_with_custom_logic() {
    let user = User(id: "456", name: "Mr. jane_doe")

    let converter = ModelConverter<User, UserDTO>(
      toExternal: { user in
        let strippedName = user.name.replacingOccurrences(of: "Mr. ", with: "")
        return UserDTO(userId: user.id, username: strippedName)
      }
    )

    let userDTO = converter.convertToExternal(from: user)

    #expect(userDTO?.userId == "456")
    #expect(userDTO?.username == "jane_doe")
  }
}
