# DisableConnectionPooling

Disable the connection pooling of Rails.
Connect to the database for each request.

## Installation

Add this line to your application's Gemfile:

    gem 'disable_connection_pooling'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install disable_connection_pooling

## Usage

### Gemfile

```ruby
gem 'disable_connection_pooling'
```

### config/application.rb

```ruby
module MyApp
  class Application.configure do
    ...
    config.active_record.disable_connection_pooling = true
  end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
