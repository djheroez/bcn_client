# BcnClient

A gem to consume the [BCN Web Service](https://servicios.bcn.gob.ni/Tc_Servicio/ServicioTC.asmx)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bcn_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bcn_client

## Usage

```ruby
require 'bcn_client'

client = BcnClient.create()

client.day_rate(12,11,2018)

client.month_rate(11,2018)

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/djheroez/bcn_client.

## License

The gem is available as open source under the terms of the [Apache License v2.0](https://www.apache.org/licenses/LICENSE-2.0).
