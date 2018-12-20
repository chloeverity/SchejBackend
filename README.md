# Schej Backend [![Build Status](https://travis-ci.org/chloeverity/SchejBackend.svg?branch=master)](https://travis-ci.org/chloeverity/SchejBackend)

## About
This is the backend of our scheduling app, Schej. It is a Ruby on Rails API, which communicates with [the front end](https://github.com/jebax/SchejFrontend), which is React. The aim of the full project is to create an app that will allow employers to create and manage their employees through shifts. It will also allow employees to successfully and quickly swap shifts with their counterparts, without having to go through a third party.

Here are our initial user stories:

```
As an employee,
So that I can see my calendar,
I can sign up and log in

As an employee,
So that I can manage my time,
I can input my shifts on an interactive calendar

As an employee,
If I have a clash with a shift,
I'd like to be able to see everyone's shifts in my organisation, and be able to see contact details in case I want to request a swap
```

Our final product also added in the following functionality

* Users can only see and request swaps with employees with the same job title as them
* Users can click a single button to request a shift swap with another employee's shift
* Users can send an emergency notification to other employees if they have an emergency and can no longer cover a shift
* Users can view their notifications to see requests (shift swaps and emergencies) from other users
* Users can approve or decline a shift swap via their notifications with a single click
* Users can approve an emergency request and thereby take on another user's shift in a single click

### Structure
Interaction with the Api falls into the following categories, as outlined by our different controllers: 
* User controller: signing up and authentication
* Shifts controller: Adding a shift, amending a shift, and swapping it with another user
* Requests controller: Handles requests to swap shifts
* Emergency requests controller: Handles emergency requests when a user is no longer able to cover their shifts

## Our Approach
We opted to split our app into front and backend, partially for the learning experience and future applicability, but also to separate concerns and facilitate parallel development. We chose Ruby on Rails because we had already had exposure to it and that would counterbalance the fact that none of us had had prior experience with React. We chose React and JavaScript to ensure a better and more interactive experience for each user.
We have a focus on agile development, TDD, and OOD.
[Here is a link to our Waffle](https://waffle.io/jebax/SchejFrontend)

## Installing, running, and testing the app
First, clone the repository, then:

```
> bundle install
> bin/rails db:create
> bin/rails db:migrate

> rails s -p 3001
```
You can now make requests to our Api. The chosen port is important, as the front-end runs on port 3000.

to test:
```
> rspec
```

Production link:
[Here](http://schej-backend.herokuapp.com/) is a link to the deployed API on Heroku.
