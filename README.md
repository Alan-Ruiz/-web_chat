# README

# Application Name

Web Chat

## Description

This application allows users to send and receive messages in real-time. Users can create an account, log in, and start messaging right away.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- You have installed Ruby version 3.1.2 and Rails version 7.1.3.
- You have a recent version of PostgreSQL installed. This project uses PostgreSQL as the database.

## Dependencies

This project uses the following additional gems:

- Devise: For user authentication.
- ActionCable: For real-time messaging.
- RuboCop: For enforcing Ruby style guide and best practices.
- Sidekiq: For background processing.

## Features

- Real-time messaging: Send and receive messages instantly.
- User authentication: Create an account and log in to access messaging features.
- Weekly message stats: Receive an email every week with your message stats.

## Installation

1. Clone the repository: `git clone https://github.com/yourusername/yourrepository.git`
2. Navigate to the project directory: `cd yourrepository`
3. Install the dependencies: `bundle install`
4. Create the database: `rails db:create`
5. Run the migrations: `rails db:migrate`
6. Create 2 users and 1 charoom: `raild db:seed`
7. Start the server: `rails server`


## Usage

Open your web browser and navigate to `http://localhost:3000` to start using the application.

## Running Tests

This application uses RSpec for testing. To run the tests, follow these steps:

1. Navigate to the project directory in your terminal.
2. Run the test suite with the following command: `bundle exec rspec` or just : `rspec`

This will run all the test files (files ending in `_spec.rb`) in the `spec` directory.

If you want to run a specific test file, you can do so by specifying the file path, like so: `bundle exec rspec spec/models/user_spec.rb`
