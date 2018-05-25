# SchoolBusCheck

Greetings and thanks in advance for taking the time to review my project.

The app uses the good old MVC pattern for the main View Controller setup, and the Google Maps API for the details controller display.

I also implemented a couple of CoreData entities as to avoid having to request the information each time the app launches.

Apologies for the lack of better/more Unit Testing, although I managed to implement Dependency Injection on the Request Manager 
so I could mock a couple of requests and assert the results.

Also apologies for the lack of documentation, I tried to create the methods as self-explanatory as possible to avoid needing to comment
everything.

## Running the Project

As requested, the minimum supported iOS version is 10.0. I tested the project on an iPhone 5s running on iOS 11.3. I also included the Pods folder to avoid having to install them, but, if for some reason the project does not compile, running `pod install` should do the trick.

Built on Xcode 9.3.
