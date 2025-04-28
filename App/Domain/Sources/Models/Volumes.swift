public struct Volumes: Equatable, Sendable {
  public let volumes: [Volume]
  public let totalItems: Int

  public init(volumes: [Volume], totalItems: Int) {
    self.volumes = volumes
    self.totalItems = totalItems
  }
}
