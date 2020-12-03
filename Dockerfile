FROM ruby:2.7

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /app

COPY . /app
RUN bundle install
RUN inspec plugin install /app/lib/inspec-tfkit.rb --chef-license=accept
CMD ["bundle exec rake test"]