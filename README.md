# Omniauth::Dnsimple

[DNSimple](https://dnsimple.com) strategy for [OmniAuth](https://github.com/omniauth/omniauth).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-dnsimple'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-dnsimple

## Usage

You need to create a DNSimple application. The application has a _client id_ and _client secret_.

Use DNSimple strategy with `OmniAuth::Builder` in your [Rack](https://rack.github.io) middleware stack.

```ruby
use OmniAuth::Builder do
  provider :dnsimple, ENV['DNSIMPLE_CLIENT_ID'], ENV['DNSIMPLE_CLIENT_SECRET']
end
```

### Sandbox

If we pass `sandbox: true`, the strategy will use the [DNSimple sandbox](https://developer.dnsimple.com/sandbox/) environment.

```ruby
use OmniAuth::Builder do
  provider :dnsimple, ENV['DNSIMPLE_CLIENT_ID'], ENV['DNSIMPLE_CLIENT_SECRET'],
           sandbox: ENV['DNSIMPLE_SANDBOX']
end
```

## Development

Clone the repository and install the dependencies:

```
git clone https://github.com/dnsimple/omniauth-dnsimple.git
cd omniauth-dnsimple
bundle
```

Run the tests with:

```
bundle exec rake
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dnsimple/omniauth-dnsimple.
