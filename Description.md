# ENUYGUN Task

- App follows MVVM architecture with UI providers in order to provide separation of concerns and testability.
- Basic structure can be summarized as follows:
    - Networking:
        - Network requests are created using Endpoint protocol.
        - Network Manager is responsible for making network requests and returning responses.
        
    - Data Presentation:
        - View Controllers have:
            - View Models:
                - View Model contains all the business logic and use cases for the view controller.
                - Use case contains services and/or managers. It is responsible for fetching data and transferring it to the view model. Use case is injected to view model.
            - UI Elements providers:
                - UI providers are responsible for creating UI elements and updating them.
        - Each view controller is created using a builder.
        - View Models and UI Providers are injected to the view controller.
        
    - Third Party Libraries:
        - RxSwift: Used for reactive programming.
        - SnapKit: Used for programmatic UI constraints.
        - Lotte: Used for animations.
