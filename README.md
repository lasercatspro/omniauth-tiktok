# This is a fork of Tiktok OAuth2 Strategy for OmniAuth.

Supports OAuth 2.0 server-side flow with Tiktok API.
Read the Tiktok docs for more details: https://developers.tiktok.com/doc/login-kit-web

### Tiktok access_token valid only for 24 hours!

## Why a fork
The original gem was creating authentication bug in the authorisation request phase with Tiktok.
We corrected that bug by implementing a custom build_access_token method. We didn't create pull request because this solution is a bit "hacky" due to the fact that tiktok doesnt respect the official oauth implementation by refusing the client_id param.

For more info, please check this [stackoverflow question](https://stackoverflow.com/questions/74747343/tiktok-oauth-parameter-error-login-kit
).

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
