# Lolcommits Dotcom

[![CI](https://img.shields.io/github/actions/workflow/status/lolcommits/lolcommits-dotcom/ci.yml?branch=main&style=flat&label=CI)](https://github.com/lolcommits/lolcommits-dotcom/actions/workflows/ci.yml)
[![Gem](https://img.shields.io/gem/v/lolcommits-dotcom.svg?style=flat)](http://rubygems.org/gems/lolcommits-dotcom)
[![Depfu](https://img.shields.io/depfu/lolcommits/lolcommits-dotcom.svg?style=flat)](https://depfu.com/github/lolcommits/lolcommits-dotcom)

[lolcommits](https://lolcommits.github.io/) takes a snapshot with your webcam
every time you git commit code, and archives a lolcat style image with it. Git
blame has never been so much fun!

[lolcommits.com](https://lolcommits.com) is web app hosting lolcommits for
multiple repositories! You can signup for free via GitHub. This plugin
integrates your lolcommits gem with the website. The app itself has been
open-sourced and lives on
[GitHub](https://github.com/lolcommits/lolcommits-dot-com), pull-requests are
welcome!

## Requirements

* Ruby >= 3.1
* A webcam
* [ImageMagick](http://www.imagemagick.org)
* [ffmpeg](https://www.ffmpeg.org) (optional) for animated gif capturing

## Installation

After installing the lolcommits gem, install this plugin with:

    $ gem install lolcommits-dotcom

Sign up (for free) [here](https://lolcommits.com) (via GitHub).

From the top menu, click 'New Repo' (give your repository a name). Then click
'[Account Info](https://lolcommits.com/users/account)' to see the keys you'll
need to configure the gem.

Then configure to enable and set these keys:

    $ lolcommits --config -p dotcom
    # set enabled to `true`
    # paste your api key, secret api and repo (external) id

That's it! Your next lolcommit will be sent to
[lolcommits.com](https://lolcommits.com). To disable use:

    $ lolcommits --config -p dotcom
    # and set enabled to `false`

## Development

Check out this repo and run `bin/setup`, this will install all dependencies and
generate docs. Use `bundle exec rake` to run all tests.

You can also run `bin/console` for an interactive prompt that will allow you to
experiment with the gem code.

After capturing every lolcommit is uploaded to the `/git_commits.json`
endpoint with the following multi-part POST body params (JSON encoded):

* `t` - timestamp, seconds since epoch
* `token` - hex digest of `api_secret` from plugin config and timestamp
* `key` - `api_key` from plugin config
* `git_commit` - a hash with these params:
  * `sha` - the commit sha
  * `repo_external_id` - the `repo_id` from plugin config
  * `image` - the lolcommit file (processed jpg, gif or mp4)

## Tests

MiniTest is used for testing. Run the test suite with:

    $ rake test

## Docs

Generate docs for this gem with:

    $ rake rdoc

## Troubles?

If you think something is broken or missing, please raise a new
[issue](https://github.com/lolcommits/lolcommits-dotcom/issues). Take a moment
to check it hasn't been raised in the past (and possibly closed).

## Contributing

Bug [reports](https://github.com/lolcommits/lolcommits-dotcom/issues) and [pull
requests](https://github.com/lolcommits/lolcommits-dotcom/pulls) are welcome on
GitHub.

When submitting pull requests, remember to add tests covering any new behaviour,
and ensure all tests are passing on CI. Read the [contributing
guidelines](https://github.com/lolcommits/lolcommits-dotcom/blob/master/CONTRIBUTING.md)
for more details.

This project is intended to be a safe, welcoming space for collaboration, and
contributors are expected to adhere to the [Contributor
Covenant](http://contributor-covenant.org) code of conduct.  See
[here](https://github.com/lolcommits/lolcommits-dotcom/blob/master/CODE_OF_CONDUCT.md)
for more details.

## License

The gem is available as open source under the terms of
[LGPL-3](https://opensource.org/licenses/LGPL-3.0).

## Links

* [CI](https://github.com/lolcommits/lolcommits-dotcom/actions/workflows/ci.yml)
* [RDoc](https://www.rubydoc.info/gems/lolcommits-dotcom)
* [Issues](http://github.com/lolcommits/lolcommits-dotcom/issues)
* [Report a bug](http://github.com/lolcommits/lolcommits-dotcom/issues/new)
* [Gem](http://rubygems.org/gems/lolcommits-dotcom)
* [GitHub](https://github.com/lolcommits/lolcommits-dotcom)
