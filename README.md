# Omniauth::Citrix

Citrix OAuth2 Strategy for OmniAuth.

## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-citrix'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-citrix

## Usage

`OmniAuth::Strategies::Citrix` is simply a Rack middleware. Read the OmniAuth docs for detailed instructions: <https://github.com/intridea/omniauth>.

Here's a quick example, adding the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :citrix, ENV['CITRIX_CONSUMER_KEY'], ENV['CITRIX_CONSUMER_SECRET']
end
```

Now visit `/auth/citrix` to start authentication against Citrix.

## Contributing

1. Fork it ( https://github.com/fnando/omniauth-citrix/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
