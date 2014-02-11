# DisableConnectionPooling

Disable the connection pooling of Rails

## Installation

Add this line to your application's Gemfile:

    gem 'disable_connection_pooling'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install disable_connection_pooling

## Usage

```ruby
gem 'disable_connection_pooling'
```

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
