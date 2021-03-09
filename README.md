# Bright iOS Technical Test

## The Starter Project

The candidate is given an existing codebase that uses the JSON placeholder API
to display a list of posts. The list includes the title of each post and an
excerpt from each post's body. Tapping a post opens a post details screen that
displays the title and complete body of the post.

The architecture of the starting application is deliberately poor to give the
candidate an opportunity to demonstrate how they would tackle improving legacy
code.

## The API

The candidate will need to use the following endpoints from the [JSON
placeholder](https://jsonplaceholder.typicode.com) API to complete the take home
test:

    GET https://jsonplaceholder.typicode.com/posts/

    GET https://jsonplaceholder.typicode.com/posts/{POST_ID}/

    GET https://jsonplaceholder.typicode.com/posts/{POST_ID}/comments/

## Home Tasks

1.  Add a button to the post details screen that navigates to a new screen
    showing a list of all comments on the post. Each item in the list should
    show the author and body of the comment.
2.  Add a button to the post details screen that saves a post to be read
    offline. The state of the button should reflect whether the post is saved to
    read offline.

    There should be a separate post list screen that displays only posts that
    are saved for offline reading. It should look and behave identically to the
    original post list screen.

    The original post list and the offline post list screens should be embedded
    in a tabbed view. The tab item for the offline post list screen should be
    badged with the number of offline posts that have been saved. The badge
    value should update in the background (i.e., without having to open the
    offline post list screen).

    Only details about the post have to be available to read offline.  Post
    comments do not have to be available offline (but it's a bonus if they are).

## Provided Resources

Included in the starter repository:

-   Some icons extracted from SFSymbols that can be used for the home tasks.
-   API response bodies so the candidate can complete the test if they're having
    connection issues.
-   List of API endpoints they'll need to use for the task.

## Pairing Tasks

1.  On the post detail screen, show the name of the author of the post next to
    the title of the post. Post authors should be visible when offline.
2.  Add support for swipe-to-save in the all posts list screen and
    swipe-to-delete in the offline posts list screen. Add an indicator to items
    in the all posts list that appears on items that are saved for offline
    reading.

## Requirements

-   The project must build for iOS 11+.
-   Must be written in Swift 5 or newer.
-   The project should build and run without warnings in Xcode 12.4.
-   Must scale to screen sizes from iPhone SE to whatever the biggest phone is
    nowadays.
-   All screens should be accessible using VoiceOver.
-   Error handling should be considered.
-   Candidate can use whatever packages they like but should be prepared to
    justify their choices.
-   They don't have to write tests if they feel they don't have time but they
    should write their code as though they were going to have time to write
    tests.
-   Should submit a compressed git repository.
