
# Tweetie

## Setup

Tweetie will run on all devices 5 and up. It was built for ios 9 using swift 2.2 in Xcode 7.

### Credentials 
username: tweetieuser

password: tweetie123


## Architecture
### VIP Architecture

I used the VIP architecture to create this app. While I'm more familiar with VIPER as an architecture, I think VIP could be a stronger candidate as it seems to follow the clean code philosphies more closely and thought this was a good sized project to test it out. It uses unidirectional flow and has clear input and output boundaries to remove coupling and uses  Request/Response models to pass data to and from the business logic. Views are only tasked with displaying view ready data and any other view specific activities and only pass user interactiosn through to their output.

It's ideal setup for unit testing as it creates small modules that are more easily testable. The protocol approach allows dependencies not under test to be swapped out for simple mocks.


## Network Simulation

Anything that would be a networking request, I mocked out the data (from a file or in memory) and created a wait interval to simulate the time for an asyncrhonous network request to complete. 

## Storage Choices

I chose to store local data in NSUserDefaults becasue it was a quick solution to local storage while still being available between launchs of the app. I was hoping to avoid any File I/O or database setup and infrastructure, however the gateways all implement a protocols so can easily be swapped out for another implementation. Normally, for local storage I would choose something like Couchbase or possibly Realm (a noSql db, not coredata).

## Asynchronous Work

All requests for work were done on a background thread using GCD and all UI updates were dispatched back to the main thread. I used a library called BrightFutures that makes creating and dispatching to the queues extra simple. I didnt' use any Futures in the application (more because of time and i'm less familiar with them) and instead used completion handler blocks for all asynchrounous calls.

## Authentication
Authentication is mocked out and the user must match the given credentials. Anything else and they will be presented with an Invalid Credentials error. 

User data is also stored in NSUserDefaults as a serialized User object. This I would normally store in the database as well, along with any other pertinent logged in user data. A token could be stored in teh keychain as well if authorization provided one. In addition to the user object I have a key that indicates if the user is logged in. This key is used to detect if the application launches to the Recents Tweets (main) page or if they should be asked to Sign In by presenting the sign in page. The check for auth could also be the presence of the User object or a valid token. Another option would be that all requests to the web service return an unauthorized error if the token or credentials have expired, triggering the user to sign in again. 

On Sign out, all local user data is cleared from storage. Signing in again will refetch the recent tweets remotely and store again in local storage.

## Fetching Remote Data
I used a lastFetchTime value on each request to the "network" for remote requests. I did this assuming we would only want to request the most recent tweets since the last fetch. Each successful fetch will update this lastFetchTime. 

I did not limit the amount of tweets to fetch, however, in a real world scenario we would likely want to page the requests and only request X at a time as we scroll back in the history.

## Shortcuts

I chose not to provide user feedback in the UI while asyncrhonous calls were being made. i.e. if fetching tweets could take some time, i might provide an indication to the user that the app was working on it. 
I chose to update the entire table with the new data when retrieved instead of updating only the rows that changed. This was a time saving effort knowing that the data set was small.

## Would like to do

I would have preferred if I designed the asynchronous calls using Result instead of the Optional error route I went. Using Result with appropriate errors results in much easier to understand code and easier processing of the results from the asyncrhonous call (i.e. switch on success or each type of failure that could occur). 

## Tests
Tests can be created for each of the boundary methods, easily identifiable in each file by their input and output protocols.

Most of the tests for the Presenter and View involve spies that simply ensure the methods boundary were called. Beyond that there isn't much to test as they simply pass data to and from. 

The more important tests will take place on the business rules/use cases. These include loadTweets(), saveTweet(), saveTweets()