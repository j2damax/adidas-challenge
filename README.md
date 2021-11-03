# adidas challenge

This is a big opportunity to restart my carrer to the next level and thinking of giving my best attempt and I decided to take a real challenege completing this assesment using `The Composable Architecture`. This is the first time i'm using the The Composable Architecture in a project and with my prior experince working with MVVM, MVP architecture patterns was able to understand and implement this architecture in a very short period time with rest of the day to day work during last 3 days. Please let me present my solution.

Here we go;

## Pre requisites
- Xcode 13.0
- Setup API: 
    - Install Docker
    - git clone https://github.com/jayampathyb/interview-test
    - docker-compose up

## Setting up
- Clone the respositary from `https://github.com/j2damax/adidas-challenge.git`
- Open the `adidas-challenge.xcodeproj`
- Let the Xcode to download the dependencies automatically during the first launch
- Run using `iOS 15 Simulator`

## Application Architecture
With SwiftUI + Combine technologies poping up, managing state becoming more important. `The Composable Architecture (TCA)` provides many tools:
- State management 
- Developing and testing isolated features
- Managing dependencies 
- Better composition to develop smaller features in isolation with bigger team enviroments

## Components of TCA
- `State`: Collection of propertise represent the state of the app
- `Actions` All events handling in the app
- `Environment` Wrapping up dependencies of the app or individual feature
- `Reducer` Transform given action to transform the current state to the next state
- `Store` UI Observe for changes and send acions.


## My Experince
I felt love with this architecture how we can isolate each feature build without disturing rest of the modules within in the application and I can highly recommend this architecture any big organization specially with big teams environement. Accrodind the TCA I have structured the modules as below.


## Components of Solution
 .
    ├── Repositary      # Model classes
    ├── Scenes          # The main feature modules
    ├── Core            # Core components that can be used across the application
    └── Utils		    # Helper or utility features to make dev life a bit more easy


        .Scenes
            ├── Products        # Show list of product and search
            ├── ProductDetails  # Show product details and product reviews
            ├── Review          # Add a commen to selected product


                .Products
                    ├── ProductListFeature  # Define 'ProductListState', 'ProductListAction', 'ProductListEnvironment' and 'productListReducer'
                    ├── ProductListView     # View
                    ├── ProductEffects      # Handle API side effects



## Completed Features
- Basic setup of the TCA 
- Launch Screen
- Show loading animation
- Fetch and show list of products
- Show animation while image loading using AsyncImage
- Map 'Product' with 'ProductRow' to compose the details for the view
- Search products by name and description
- Show product details 
- Fetch and show product ratings
- Add Rating
- Few tests
- Fastlane basic setup for CI/CD
- Snapshot testing basic setup, couldn't add more tests due to the time limitation



## NOT Completed (DUE TO TIME CONSTRAINTS, BUT I WOULD BE HAPPY TO TAKE THIS AFTER ASSESMENT SUBMITTED)
- Error handling (Network and other)
- Couldn't handle app crashes
- Couldn't create more meaningful tests


## Screen Recording 
https://drive.google.com/drive/folders/1RHhMTERZdzTWtqWcD61YBYveoq5b86vy?usp=sharing

## Screenshots
![Alt text](/screenshots/launch-screen.png?raw=true "Launch Screen")

![Alt text](/screenshots/products-loading.png?raw=true "Products Loading")

![Alt text](/screenshots/product-list.png?raw=true "Product List")

![Alt text](/screenshots/product-search.png?raw=true "Product Search")

![Alt text](/screenshots/product-details.png?raw=true "Product Details")

![Alt text](/screenshots/product-add-review.png?raw=true "Add Review")

## Code Walkthrough
