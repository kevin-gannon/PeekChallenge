## Setup
The `githubToken` varaible will need to be updated the `GraphQLClientProtocol.swift` file.

## Architecture
MVVM. State(fetching, success, error, empty etc..)  is sperated into its own viewmodel & controller. 
This creates an app flow that is  easy to follow and understand. In order to have smooth transitions 
between these states, I used a transition framework called Hero. 

For example,  SearchResultsController will pop to the ServiceController and then will push another SearchResultsController or the ErrorController. Hero helps makes this process seamless for the user, 
as if its the same viewcontroller. The main benefit of this structure is code reusability oppurtunities, 
more immutable state, & less side effects overall.

## If i had more time...
- I would add UnitTests for the viewmodels i've created.
- I need to implement SearchControllerDelegate for the ServiceController to handle
updating the query while fetching
- I would flesh out the empty state more for search. Currently using the ErrorController for empty results
- support iPad layout










