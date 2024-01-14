# FORUM BACKEND 
[FrontEnd](https://github.com/MinhMXC/ForumAPI_FrontEnd)

This is my personal project / CVWO Winter Assignment, done during 23-24 winter vacation.
The product is a forum that resembles Reddit.

Welcome to the Backend Repository!

This is a RESTful API done using Ruby On Rails version 7.1.2 and PostgreSQL, 
with token authentication using [devise-token-auth](https://github.com/lynndylanhurley/devise_token_auth).

## How to setup

### Things to note

The **default user** is ```username: minhmxc``` and ```password: 123456```

The access-token is changed with every requests that requires authentication.

### IDE / Code Editor
1. Clone the repository.
2. Install Ruby, Rails and PostgreSQL, if you haven't.
3. CD into the project folder.
4. Run ```bundle install``` to install all dependencies.
5. Open ./config/database.yml file and under development, 
check that username and password is correct for your installation of PostgreSQL.
6. Run ```rails db:setup``` to setup the database and seed it.
7. Run ```rails s``` to start the server in development environment.

### Docker
This project comes with a Dockerfile that can be easily build into an image and run, using
the default secret base key included.

## Integration with Frontend
Please visit [FrontEnd](https://github.com/MinhMXC/ForumAPI_FrontEnd).