import SwiftUI
import Combine
import Amplify

var subscription: GraphQLSubscriptionOperation<RecordDS>?
var dataSink: AnyCancellable?

func createRecord(_ rec: RecordDS) -> AnyCancellable {
    let sink = Amplify.API.mutate(request: .create(rec))
        .resultPublisher
        .sink { completion in
        if case let .failure(error) = completion {
            print("Failed to create graphql \(error)")
        }
    }
    receiveValue: { result in
        switch result {
        case .success(let rec):
            print("Successfully created the record: \(rec)")
        case .failure(let graphQLError):
            print("Could not decode result: \(graphQLError)")
        }
    }
    return sink
}

func updateRecord(_ rec: RecordDS) -> AnyCancellable {
    let sink = Amplify.API.mutate(request: .update(rec))
        .resultPublisher
        .sink {
            if case let .failure(error) = $0 {
                print("Got failed event with error \(error)")
            }
        }
        receiveValue: { result in
            switch result {
            case .success(let rec):
                print("Successfully created record: \(rec)")
            case .failure(let error):
                print("Got failed result with \(error.errorDescription)")
            }
        }
    return sink
}

func deleteRecord(_ rec: RecordDS) -> AnyCancellable {
    let sink = Amplify.API.mutate(request: .delete(rec))
        .resultPublisher
        .sink {
            if case let .failure(error) = $0 {
                print("Got failed event with error \(error)")
            }
        }
        receiveValue: { result in
            switch result {
            case .success(let rec):
                print("Successfully created record: \(rec)")
            case .failure(let error):
                print("Got failed result with \(error.errorDescription)")
            }
        }
    return sink
}

func listRecords(dailyKey: String) -> Future<[RecordDS], Error> {
  return Future {
    promise in
    let rec = RecordDS.keys
    let predicate = rec.dailyKey == dailyKey
    Amplify.API.query(request: .list(RecordDS.self, where: predicate)) { event in
        switch event {
        case .success(let result):
            switch result {
            case .success(let rec):
                print("Successfully retrieved list of records \(rec)")
                promise(.success(rec))
            case .failure(let error):
                print("Got failed result with \(error.errorDescription)")
            }
        case .failure(let error):
            print("Got failed event with error \(error)")
        }
    }
  }
}
