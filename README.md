## DISCLAIMER READ UPDATE BEFORE USING THIS FORK


# This is a fork of Tiktok OAuth2 Strategy for OmniAuth.

Supports OAuth 2.0 server-side flow with Tiktok API.
Read the Tiktok docs for more details: https://developers.tiktok.com/doc/login-kit-web

### Tiktok access_token valid only for 24 hours!

## Why a fork
The original gem was creating authentication bug in the authorisation request phase with Tiktok.
We corrected that bug by implementing a custom build_access_token method. We didn't create pull request because this solution is a bit "hacky" due to the fact that tiktok doesnt respect the official oauth implementation by refusing the client_id param.

For more info, please check this [stackoverflow question](https://stackoverflow.com/questions/74747343/tiktok-oauth-parameter-error-login-kit
).

#### UPDATE of 08/09/2023
We'v migrated the old API using a fork by [acorn-influence](https://github.com/acorn-influence/omniauth-tiktok). Since Tiktok change their API, they put more restricted way of reading params during the OAuth callback phase. 
We modify our way to get rid of "client_id" by monkey patch OAuth2::Authenticator's method ``apply(params)``. This monkey patch had a special auth_scheme for tiktok that doesnt send ``client_id``. 
We'v tested out by authenticate through other omniauth-strategies and it seems to work, but as we all know **monkey patch can be dangereous and cause bugs**.

## Installing

Add to your `Gemfile`:

```ruby
gem 'omniauth-tiktok', git: 'https://github.com/lasercatspro/omniauth-tiktok.git'
```

Then `bundle install`.

## Usage

`OmniAuth::Strategies::Tiktok` is simply a Rack middleware. Read the OmniAuth docs for detailed instructions: https://github.com/omniauth/omniauth.

Here's a quick example, adding the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :tiktok, ENV['TIKTOK_CLIENT_KEY'], ENV['TIKTOK_CLIENT_SECRET'],
  scope: "user.info.basic,video.list,video.upload,video.publish"
end
```

### Custom Callback URL/Path

You can set a custom `callback_url` or `callback_path` option to override the default value.

## Auth Hash

Here's an example Auth Hash available in `request.env['omniauth.auth']`:

```
{
"provider"=>"tiktok",
 "uid"=>"_123456634",
 "info"=>{"username"=>"USERNAME"},
 "credentials"=>
  {
    "token"=>
    "act.token1234343",
   "refresh_token"=>
    "rft.refresh_token12324343",
   "expires_at"=>12345678,
   "expires"=>true,
   "refresh_token_expires_at"=>1234566
  },
 "extra"=>{"raw_info"=>{"username"=>"USERNAME"}
}
```

## Development

```
gem bump --file=lib/omniauth-tiktok/version.rb --push --tag --release --pretend
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the OmniAuth::Tiktok project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Lianowar/omniauth-tiktok/blob/master/CODE_OF_CONDUCT.md).
