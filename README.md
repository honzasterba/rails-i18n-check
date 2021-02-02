# rails-i18n-check

[![Build Status](https://travis-ci.com/honzasterba/rails-i18n-check.svg?branch=main)](https://travis-ci.com/honzasterba/rails-i18n-check)

A simple checker for missing translations in rails i18n config files

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails-i18n-check'
```

And then execute:

    $ bundle

## Usage

Define a rake task in `lib/tasks`:

```ruby
require 'rails-i18n-check'
namespace :i18n do
  task :check => :environment do
    RailsI18nCheck::Checker.new(%w[en cs], Rails.root).run
  end
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/honzasterba/rails-i18n-check. This project is intended to be a
safe, welcoming space for collaboration, and contributors are
expected to adhere to the [Contributor Covenant](http://contributor-covenant.org)
code of conduct.


## License

The gem is available as open source under the terms of
the [MIT License](http://opensource.org/licenses/MIT).
