# Delivr!

Delivr Delivery API


### Setting up the development environment

- Get the code. Clone this git repository:

  ```bash
  git clone git://github.com/omkz/delivr.git
  cd delivr
  ```

- Install the required gems by running the following command in the project root directory:

  ```bash
  bundle install
  ```

- Create and initialize the database:

  ```bash
  rails db:create
  rails db:migrate
  ```
- Import data restaurants
  ```
  bin/rails import:restaurants
  ```
  
- Import data users
  ```
  bin/rails import:users
  ```

- Start the development server:

  ```bash
  bin/rails s
  ```

### The API documentation
  ```
    http://localhost:3000/apipie/
  ```
or
  ```
    https://delivr.herokuapp.com/apipie
  ```