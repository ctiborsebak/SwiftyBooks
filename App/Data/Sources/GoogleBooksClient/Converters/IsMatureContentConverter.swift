import ModelConverter

typealias IsMatureContentConverter = ModelConverter<Bool?, String?>

extension IsMatureContentConverter {
  static func live() -> Self {
    .init { response in
      switch response {
      case "NOT_MATURE":
        return false
      default:
        return true
      }
    }
  }
}
