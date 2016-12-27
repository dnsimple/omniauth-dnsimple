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

### Testing

If you want to test DNSimple authentication with RSpec, here's how you can do it:

```ruby
require "omniauth/dnsimple/rspec"

RSpec.feature "Login" do
  scenario "with success" do
    #
    # This method is provided by omniauth-dnsimple.
    # It mocks OmniAuth and it provides a successful signup
    #
    data = omniauth_successful_signup 

    puts data.class
      # => OmniAuth::AuthHash

    puts data.dig('credentials', 'token')
      # => "421bb40ff4656c7077ecf9a6ac441f30b62b9749f6bce190013df201e61125f8"
    puts data.dig('info', 'email')
      # => "user@cebe93c9-cf6a-4158-b8b9-dd398f4fc797.test"
    puts data.dig('info', 'plan_identifier')
      # => "dnsimple-professional"
    puts data.dig('info', 'type')
      # => "account"

    puts data.dig('provider')
      # => "dnsimple"
    puts data.dig('uid') # DNSimple Account ID
      # => 2882493

    visit "/auth/dnsimple"

    # ...
  end

  scenario "without success" do
    #
    # This method is provided by omniauth-dnsimple.
    # It mocks OmniAuth and it provides a failing signup
    #
    omniauth_failing_signup

    visit "/auth/dnsimple"

    # ...
  end
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
