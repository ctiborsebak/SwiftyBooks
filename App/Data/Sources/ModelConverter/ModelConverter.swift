import Foundation

public struct ModelConverter<DomainModel: Equatable & Sendable, ExternalModel: Equatable & Sendable>: Sendable {
  private let toDomain: (@Sendable (ExternalModel) -> DomainModel)?
  private let toExternal: (@Sendable (DomainModel) -> ExternalModel)?

  public init(
    toDomain: (@Sendable (ExternalModel) -> DomainModel)? = nil,
    toExternal: (@Sendable (DomainModel) -> ExternalModel)? = nil
  ) {
    self.toDomain = toDomain
    self.toExternal = toExternal
  }

  public func convertToDomain(from externalModel: ExternalModel) -> DomainModel? {
    toDomain?(externalModel)
  }

  public func convertToExternal(from domainModel: DomainModel) -> ExternalModel? {
    toExternal?(domainModel)
  }
}
