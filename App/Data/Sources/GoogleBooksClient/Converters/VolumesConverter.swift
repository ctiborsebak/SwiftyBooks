import Domain
import ModelConverter

typealias VolumesConverter = ModelConverter<Volumes, VolumesResponse>

extension VolumesConverter {
  static func live(
    volumeConverter: VolumeConverter
  ) -> Self {
    .init { response in
      let volumes = response.items.compactMap(volumeConverter.convertToDomain(from:))

      return .init(
        volumes: volumes,
        totalItems: response.totalItems
      )
    }
  }
}
