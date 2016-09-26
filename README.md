# tweetie

Architecture

I used the VIP architecture to create this app. While I'm more familiar with VIPER as an architecture, I think VIP could be a stronger candidate for following the clean code philosphy more closely. It uses unidirectional flow and has clear input and output boundaries to remove coupling and uses the Request/Response models to pass data. Views are only tasked with displaying view ready data and any other view specific activities and only pass user interactiosn through to their output. 
It's ideal for unit testing as it creates small modules that are easily testable. The protocol approach allows dependencies not under test to be swapped out for simple mocks.'

Network Simulation

Anything that would be a networking request, I mocked out the data (from a file or in memory) and created a wait interval to simulate the time for an asyncrhonous network request to complete. 

Storage Choices

I chose to store eveyrthing in NSUserDefaults becasue it was a quick solution to local storage while still being available between launchs of the app. I was hoping to avoid any File I/O or database setup, however the gateways all implement a protocols so can easily be swapped out for another implementation. Normally, for local storage I would choose something like Couchbase or possibly Realm (a noSql db, not coredata).


Asynchronous Work

All requests for work were done on a background thread using GCD and all UI updates were dispatched back to the main thread. I used a library called BrightFutures that makes creating and dispatching to the queues extra simple. I didnt' use any Futures in the application (more because of time and i'm less familiar with them) and instead used completion handler blocks for all asynchrounous calls.

Shortcuts

I chose not to provide user feedback in the UI while asyncrhonous calls were being made. i.e. if fetching tweets could take some time, i might provide an indication to the user that the app was working on it. 
I chose to update the entire table with the new data when retrieved instead of updating only the rows that changed. This was a time saving effort knowing that the data set was small.