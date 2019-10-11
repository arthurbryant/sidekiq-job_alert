# Sidekiq::JobAlert

Sidekiq-job_alert is a gem to send alert to slack to warn you when there are too many waiting jobs or dead jobs

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sidekiq-job_alert'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sidekiq-job_alert

## Usage
- config
  - copy `sidekiq_job_alert.yml` to your local and edit it to fit your needs
  - example:

```yaml
:webhook_url: "https://hooks.slack.com/services/xxxx"
:username: "Sidekiq_Job_Alert"
:channel: "sidekiq-job"
:link_names: 'false'
:sidekiq_url: "http://localhost:3000/sidekiq/"
:alert_dead_jobs:
  :message: "%<job_counter>d dead jobs.\n"
:alert_total_waiting_jobs:
  :message: "Totally %<job_counter>d waiting jobs.\n"
  :all:
    :limit: 50
:alert_each_waiting_job:
  :message: "%<job_counter>d waiting jobs in %<queue_name>s.\n"
  :create_place:
    :limit: 10
  :update_place:
    :limit: 10
```

- run
  - command line tool
    - `sidekiq_job_alert alert --config ./sidekiq_job_alert.yml`
  - rails application
    - ` Sidekiq::JobAlert::Notifier.new('config/sidekiq_job_alert.yml').call `
- notification

![image](https://user-images.githubusercontent.com/853200/65889183-c2612480-e3db-11e9-9c9c-cdae69ef2863.png)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/sidekiq-job_alert. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Sidekiq::JobAlert project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/sidekiq-job_alert/blob/master/CODE_OF_CONDUCT.md).
