import SwiftUI
import Combine
import Amplify

func createTask() -> AnyCancellable {
    let todo = Task(id: "my second todo", title: "todo title")
    let sink = Amplify.API.mutate(request: .create(todo))
        .resultPublisher
        .sink { completion in
        if case let .failure(error) = completion {
            print("Failed to create graphql \(error)")
        }
    }
    receiveValue: { result in
        switch result {
        case .success(let todo):
            print("Successfully created the todo: \(todo)")
        case .failure(let graphQLError):
            print("Could not decode result: \(graphQLError)")
        }
    }
    return sink
}
