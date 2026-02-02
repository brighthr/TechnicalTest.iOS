# Bright iOS Technical Test

## The project: A Trivia Question App 

Ready to take on a fun challenge?  
In this project, you'll create a simple trivia game app called 'Trivia Quest.' The app will test users' knowledge with a variety of questions. 
You'll need to use your skills in Swift/SwiftUI to build an exciting and interactive trivia experience that will keep users hooked!

We're interested in seeing the architecture you will implement for the codebase, the design patterns and the user experience. 

## The API

You will need to use the following endpoint from [Open Trivia DB](https://opentdb.com/api_config.php) API to complete the take home
test:

    GET https://opentdb.com/api.php?amount=15

All endpoints return a JSON response 

## The Tasks

### Task 1: Display Trivia Questions List

Create a screen that retrieves trivia questions from the Open Trivia Database API and displays them in a list format.

- Fetch 15 trivia questions from the API (https://opentdb.com/api.php?amount=15).
- Display each question in a list view, showing the level of difficulty, category, and the question itself.

### Task 2: Detailed Question Screen

Implement a screen that displays full details of a selected question when tapped.

- Upon tapping on a question from the list, navigate to a detailed screen.
- Show the type, difficulty, category, question, correct answer, and incorrect answers.
- Implement a self-explanatory UI indicator (ex. a badge) to distinguish between boolean and multiple-choice questions.

### Task 3: Search functionality 

Incorporate a search bar to allow users to search for specific questions based on keywords.

- Implement a search bar to allow users to type in specific keywords for the search functionality.
- Display search results questions that contains the search keyword typed in the search bar.
Ex: the keyword was "how". Questions that contains the keyword "how" should be displayed in the results. 

### Additional requirements 

Upon returning to the main screen, indicate with a badge those questions for which the user has viewed details, to prevent unnecessary revisiting. 

## BONUS 

Provide the option to filter questions by difficulty level and/or category as a bonus feature

## Requirements

- Submission must have a good unit test coverage.
- UI should be written/convert into SwiftUI.
- Error handling should be considered.
- You can use third party packages but be prepared to justify your
  choices.
- Write the code using MVVM or [composable architecture](https://pointfreeco.github.io/swift-composable-architecture/main/tutorials/meetcomposablearchitecture/). 

## Submission

Please provide us a Github link to your submission. 
Please commit regularly as you carry out the task and keep the commit history in tact. 
We would love to see if you can devlop the feature using TDD.

## Alternative

If you have a good example project that demonstrates your coding skills, 
you can choose to use that project for submission instead of working on the one above.