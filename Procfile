web: bundle exec rails s
worker: bundle exec sidekiq -e production -C config/sidekiq.yml
release: rake db:migrate
