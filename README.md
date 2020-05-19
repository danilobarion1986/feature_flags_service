# Feature Flags Service

[WIP] Little API to control the feature flags on your systems.

## Dependencies

* [rvm](https://rvm.io/) or [rbenv](https://github.com/rbenv/rbenv)
* [Ruby 2.6](https://www.ruby-lang.org/pt/)
* [Bundler](http://bundler.io/)
* [Docker](https://www.docker.com/)
* [docker-compose](https://docs.docker.com/compose/)

## Setting Up

```bash
$ gem install bundler && bundle install
$ docker-compose up
```

## Running Migrations

```bash
$ docker-compose run --rm app bundle exec rake db:migrate
```

## Running Tests

```bash
$ docker-compose run --rm app bundle exec rspec
```

After running the test suite, the coverage report is on the **coverage/index.html** file.

## Dev Tools

To see all available tasks, run `bundle exec rake -T`.

Besides, there is some binary files, that allows you to run an app console or db console.
To run them, execute `bin/_<command>_`

## Code Style

Use [rubocop](http://batsov.com/rubocop/) to verify the code style:

```bash
$ bundle exec rubocop
```

## Code Quality

Use [rubycritic](https://github.com/whitesmith/rubycritic/) to generate a report 
about the overall code quality:

```bash
$ bundle exec rake dev:rubycritic
```

## Code Documentation

Use [yard](https://github.com/lsegal/yard) to generate the code documentation:

```bash
$ bundle exec rake dev:yard
```

## Contributing
1. Clone/Fork the project!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push them: `git push origin my-new-feature`
5. Open a merge request :D
