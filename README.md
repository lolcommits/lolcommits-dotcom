# Lolcommits Dotcom

[![Gem Version](https://img.shields.io/gem/v/lolcommits-dotcom.svg?style=flat)](http://rubygems.org/gems/lolcommits-dotcom)
[![Travis Build Status](https://travis-ci.org/lolcommits/lolcommits-dotcom.svg?branch=master)](https://travis-ci.org/lolcommits/lolcommits-dotcom)
[![Test Coverage](https://codeclimate.com/github/lolcommits/lolcommits-dotcom/badges/coverage.svg)](https://codeclimate.com/github/lolcommits/lolcommits-dotcom/coverage)
[![Code Climate](https://codeclimate.com/github/lolcommits/lolcommits-dotcom/badges/gpa.svg)](https://codeclimate.com/github/lolcommits/lolcommits-dotcom)
[![Gem Dependency Status](https://gemnasium.com/badges/github.com/lolcommits/lolcommits-dotcom.svg)](https://gemnasium.com/github.com/lolcommits/lolcommits-dotcom)

[lolcommits](https://lolcommits.github.io/) takes a snapshot with your webcam
every time you git commit code, and archives a lolcat style image with it. Git
blame has never been so much fun!

This plugin uploads each lolcommit to a remote server after capturing. You
configure the plugin by setting a remote endpoint to handle the HTTP post
request. The following params will be sent:

* `file` - captured lolcommit image file
* `message` - the commit message
* `repo` - repository name e.g. mroth/lolcommits
* `sha` - commit SHA
* `author_name` - the commit author name
* `author_email` - the commit author email address
* `key` - optional key (string) from plugin config

You can also set an optional HTTP Basic Auth header (username and/or password).

## Requirements

* Ruby >= 2.0.0
* A webcam
* [ImageMagick](http://www.imagemagick.org)
* [ffmpeg](https://www.ffmpeg.org) (optional) for animated gif capturing

## Installation

After installing the lolcommits gem, install this plugin with:

    $ gem install lolcommits-dotcom

Then configure to enable and set the remote endpoint:

    $ lolcommits --config -p dotcom
    # set enabled to `true`
    # set the remote endpoint (must begin with http(s)://)
    # optionally set a key (sent in params) and/or HTTP Basic Auth credentials

That's it! Provided the endpoint responds correctly, your next lolcommit will be
uploaded to it. To disable use:

    $ lolcommits --config -p dotcom
    # and set enabled to `false`

## Development

Check out this repo and run `bin/setup`, this will install all dependencies and
generate docs. Use `bundle exec rake` to run all tests and generate a coverage
report.

You can also run `bin/console` for an interactive prompt that will allow you to
experiment with the gem code.

## Tests

MiniTest is used for testing. Run the test suite with:

    $ rake test

## Docs

Generate docs for this gem with:

    $ rake rdoc

## Troubles?

If you think something is broken or missing, please raise a new
[issue](https://github.com/lolcommits/lolcommits-dotcom/issues). Take
a moment to check it hasn't been raised in the past (and possibly closed).

## Contributing

Bug [reports](https://github.com/lolcommits/lolcommits-dotcom/issues) and [pull
requests](https://github.com/lolcommits/lolcommits-dotcom/pulls) are welcome on
GitHub.

When submitting pull requests, remember to add tests covering any new behaviour,
and ensure all tests are passing on [Travis
CI](https://travis-ci.org/lolcommits/lolcommits-dotcom). Read the
[contributing
guidelines](https://github.com/lolcommits/lolcommits-dotcom/blob/master/CONTRIBUTING.md)
for more details.

This project is intended to be a safe, welcoming space for collaboration, and
contributors are expected to adhere to the [Contributor
Covenant](http://contributor-covenant.org) code of conduct. See
[here](https://github.com/lolcommits/lolcommits-dotcom/blob/master/CODE_OF_CONDUCT.md)
for more details.

## License

The gem is available as open source under the terms of
[LGPL-3](https://opensource.org/licenses/LGPL-3.0).

## Links

* [Travis CI](https://travis-ci.org/lolcommits/lolcommits-dotcom)
* [Code Climate](https://codeclimate.com/github/lolcommits/lolcommits-dotcom)
* [Test Coverage](https://codeclimate.com/github/lolcommits/lolcommits-dotcom/coverage)
* [RDoc](http://rdoc.info/projects/lolcommits/lolcommits-dotcom)
* [Issues](http://github.com/lolcommits/lolcommits-dotcom/issues)
* [Report a bug](http://github.com/lolcommits/lolcommits-dotcom/issues/new)
* [Gem](http://rubygems.org/gems/lolcommits-dotcom)
* [GitHub](https://github.com/lolcommits/lolcommits-dotcom)
