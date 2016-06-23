# Crawler

Welcome to the crawler gem! 

Please note that this is just a test gem. We are still trying out different things. That is what we call: **fun** :)

The crawler will initially be used to crawl information relative to a specific **Facebook group**. This information consists into:
- the published posts (e.g. content, person posting, any relevant used tags, etc.)
- the members of the group
- any events attached to the group


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'crawler'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install crawler

## Usage

Stay Tuned!

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Project Structure

```
crawler/
    ├── bin
    │   ├── console
    │   └── setup
    ├── lib
    │   ├── crawler
    │   └── crawler.rb
    ├── spec
    │   ├── crawler_spec.rb
    │   └── spec_helper.rb
    ├── CODE_OF_CONDUCT.md
    ├── Gemfile
    ├── LICENSE.txt
    ├── README.md
    ├── Rakefile
    └── crawler.gemspec
```

* Code goes in `lib`
* Spec tests go in `spec` (any test data should go in `spec/fixtures`)
* Require all your Ruby files in `lib/crawler.rb`
* Add your gem dependencies in the `Gemfile`
* NEVER CHANGE `LICENSE.txt`

## Contributing

Bug reports and pull requests are welcome on GitHub as part of the **isamuni** project: https://github.com/sic2/isamuni/. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
