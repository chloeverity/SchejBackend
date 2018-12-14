# README FRONT END
​
## About
This is the frontend of our scheduling app, Schej. It is developed in React for its dynamic capabilities, which communicates with Ruby on rails backend API. The aim of the full project is to create an app that will allow employers to create and manage their employees through shifts. It will also allow employees to successfully and quickly swap shifts with their counterparts, without having to go through a third party.
​
Here are our initial user stories:
​
```
As a manager,
So that I can create a schedule,
I can create shifts for my employees on an interactive calendar
​
As a manager and a user,
So that I can see my calendar,
I can sign up and log in
​
As a user,
If I have a clash with a shift,
I'd like to be able to see everyone's shifts, and be able to request a swap with a relevant person
```
​
### Structure
Interaction with the Api falls into two categories. One is interacting with the User model (e.g. creating a new user, and logging in/logging out as a user). This is done via the User model and controller, for which we use Devise to handle authentication.
The second type of interaction is around Shifts (e.g. creating/deleting a shift, and swapping a shift with someone else). This is handled through the Shifts model and controller.
​
## Our Approach
We opted to split our app into front and backend, partially for the learning experience and future applicability, but also to separate concerns and facilitate parallel development. We chose Ruby on Rails because we had already had exposure to it and that would counterbalance the fact that none of us had had prior experience with React. We chose React and JavaScript to ensure a better and more interactive experience for each user.
We have a focus on agile development, TDD, and OOD.
[Here is a link to our Waffle](https://waffle.io/jebax/SchejFrontend)
​
## Installing, running, and testing the app
First, clone the repository, then:
​
```
> bundle install
> bin/rails db:create
> bin/rails db:migrate
​
> rails s
```
​**Test Program**
  * Download/clone this repo
  *
  *
  *

**Cypress** This was used for a consistent TDD approach (Red-Green).

```
Collapse
