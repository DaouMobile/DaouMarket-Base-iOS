import Foundation

enum DataLayerError: LocalizedError {
	case apiError(reason: APIError)
	case repositoryError(reason: RepositoryError)
}
