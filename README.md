# FORUM BACKEND 
[FrontEnd](https://github.com/MinhMXC/ForumAPI_FrontEnd)

This is my personal project / CVWO Winter Assignment, done during 23-24 winter vacation.
The product is a forum that resembles Reddit.

Welcome to the Backend Repository!

This is a RESTful API done using Ruby On Rails version 7.1.2 and PostgreSQL, 
with token authentication using [devise-token-auth](https://github.com/lynndylanhurley/devise_token_auth).

## How to setup
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
1. The project comes with a Dockerfile
2. Run ```rails credentials:edit --environment production``` to generate the secret base key for
the production build. On Windows, you will need to set up an editor using ```$env:EDITOR="code --wait"```, 
this will use VSCode as the editor.
3. A file ./config/credentials/production.key will be generated. Copy the key into the
Dockerfile at ```ARG RAILS_MASTER_KEY="#insert_key_here"```
4. Build the image and set it up with a separate PostgreSQL image, preferably using Docker Compose.

## Integration with Frontend
Please visit [FrontEnd](https://github.com/MinhMXC/ForumAPI_FrontEnd).