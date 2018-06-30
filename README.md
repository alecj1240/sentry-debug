# Sentry Debug

A [Sentry](https://sentry.io/welcome/) client which will help you solve bugs much faster. We will take all the errors from the Sentry and we only show you only the information that you need - no developer jargon.

## Getting A Sentry Auth Token

You will need to give us a Sentry auth token when you sign up. This is so we can access all the data Sentry gives us. Here's what you'll need to do:
1. Go here: https://sentry.io/settings/account/api/auth-tokens/
2. Sign in
3. Create new token
4. Scopes to be checked off: project:read, team:read, event:admin, member:read, org:read, project:releases, event:read

### The Stack Overflow Advantage

A huge component of this web app is that we take the data right from Stack Overflow. We search to find the best fixes to your bugs, and we give them directly to you. All you need to do is click on a link and you'll be directly linked to the answer you've been looking for.

## Built With

* [Heroku](https://www.heroku.com/) - The hosting provider
* [Rails](https://rubyonrails.org/) - The back-end web framework used
* [Bootstrap](http://getbootstrap.com/) - The front-end framework used

## Authors

* **Alec Jones** - *Initial work* - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Alec Jones (oh wait that's me)
