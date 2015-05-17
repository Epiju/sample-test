The "reserve" methods in users_controller has too any conditions. It can be simplified by adding submethods.

We also maybe can merge the user events and company events calls in order to delete some codes in those two controllers.

Finally the token is created at the user creation and there is not time limit. For security it will be good to have a time limit after retrieving the token.

I think Ruby on Rails is overkill if this API is just a standalone API. We prefer NodeJS or Grape to be faster and lighter.
But if the project will transform into a website with a frontend part it is a good choice.

