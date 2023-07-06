# LDSMobileTakeHome
## Xcode
* Version 15.0 beta 3 (15A5195k)

## Libraries Used
* SwiftUI
* SwiftData
* No 3rd party libraries used

## Notes
I discovered and worked around several bugs in the beta.

1. Enums do not appear to be properly saved in SwiftData. Retreiving data from SwiftData causes the enum to always get the 0 value. To workaround this, [I always fetch from the API when the view is first show](https://github.com/ephraimkunz/LDSMobileTakeHome/blob/2b17f1e58b9e214c0833c2428d7dbc739640e219/LDSMobileTakeHome/ContentView.swift#L28).
2. Enums backed by strings fail to save in SwiftData at runtime. [Work around this by using Int to back enums](https://github.com/ephraimkunz/LDSMobileTakeHome/blob/2b17f1e58b9e214c0833c2428d7dbc739640e219/LDSMobileTakeHome/Individual.swift#L14).
3. SwiftData classes can not be marked as Codable. [Work around this by having separate types for persisting and for deserializing network data](https://github.com/ephraimkunz/LDSMobileTakeHome/blob/2b17f1e58b9e214c0833c2428d7dbc739640e219/LDSMobileTakeHome/NetworkManager.swift#L12). This is probably a better design anyway, as we probably don't want our persistence data model tied to the JSON schema the server works with.
