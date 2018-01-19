# Lolcommits Dotcom

[![Gem Version](https://img.shields.io/gem/v/lolcommits-dotcom.svg?style=flat)](http://rubygems.org/gems/lolcommits-dotcom)
[![Travis Build Status](https://travis-ci.org/lolcommits/lolcommits-dotcom.svg?branch=master)](https://travis-ci.org/lolcommits/lolcommits-dotcom)
[![Maintainability](https://img.shields.io/codeclimate/maintainability/lolcommits/lolcommits-dotcom.svg)](https://codeclimate.com/github/lolcommits/lolcommits-dotcom/maintainability)
[![Test Coverage](https://img.shields.io/codeclimate/c/lolcommits/lolcommits-dotcom.svg)](https://codeclimate.com/github/lolcommits/lolcommits-dotcom/test_coverage)
[![Gem Dependency Status](https://gemnasium.com/badges/github.com/lolcommits/lolcommits-dotcom.svg)](https://gemnasium.com/github.com/lolcommits/lolcommits-dotcom)

[lolcommits](https://lolcommits.github.io/) takes a snapshot with your webcam
every time you git commit code, and archives a lolcat style image with it. Git
blame has never been so much fun!

[lolcommits-dot-com](http://lolcommits-dot-com.herokuapp.com) is web app hosting
lolcommits for multiple repositories! You can signup for free via GitHub. This
plugin integrates your lolcommits gem with the website. The app itself has been
open-sourced and lives on
[GitHub](https://github.com/lolcommits/lolcommits-dot-com), pull-requests are
welcome!

## Requirements

* Ruby >= 2.0.0
* A webcam
* [ImageMagick](http://www.imagemagick.org)
* [ffmpeg](https://www.ffmpeg.org) (optional) for animated gif capturing

## Installation

After installing the lolcommits gem, install this plugin with:

    $ gem install lolcommits-dotcom

Sign up (for free) [here](http://lolcommits-dot-com.herokuapp.com) (via GitHub).
From the top menu, click 'New Repo' (give your repository a name). Then click
'[Account Info](http://lolcommits-dot-com.herokuapp.com/users/account)' to see
the keys you'll need to configure the gem.

Then configure to enable and set these keys:

    $ lolcommits --config -p dotcom
    # set enabled to `true`
    # paste your api key, secret api and repo (external) id

That's it! Your next lolcommit will be sent to
[lolcommits-dot-com](http://lolcommits-dot-com.herokuapp.com). To disable use:

    $ lolcommits --config -p dotcom
    # and set enabled to `false`

## Development

Check out this repo and run `bin/setup`, this will install all dependencies and
generate docs. Use `bundle exec rake` to run all tests and generate a coverage
report.

You can also run `bin/console` for an interactive prompt that will allow you to
experiment with the gem code.

After capturing every lolcommit is uploaded to the `/git_commits.json` endpoint
with the following multi-part POST body params (JSON encoded):

* `t` - timestamp, seconds since epoch
* `token` - hex digest of `api_secret` from plugin config and timestamp
* `key` - `api_key` from plugin config
* `git_commit` - a hash with these params:
  * `sha` - the commit sha
  * `repo_external_id` - the `repo_id` from plugin config
  * `image` - the lolcommit image file (processed)
  * `raw` - the original captured camera image

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
* [Code Climate](https://codeclimate.com/github/lolcommits/lolcommits-dotcom/maintainability)
* [Test Coverage](https://codeclimate.com/github/lolcommits/lolcommits-dotcom/test_coverage)
* [RDoc](http://rdoc.info/projects/lolcommits/lolcommits-dotcom)
* [Issues](http://github.com/lolcommits/lolcommits-dotcom/issues)
* [Report a bug](http://github.com/lolcommits/lolcommits-dotcom/issues/new)
* [Gem](http://rubygems.org/gems/lolcommits-dotcom)
* [GitHub](https://github.com/lolcommits/lolcommits-dotcom)