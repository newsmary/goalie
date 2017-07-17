# Goalie

A goal-setting and tracking platform.

## Roadmap (TODOs)
- More tests
- Think about reporting/tracking
- Think about Individual OKRs (not just teams)
- Think about other kinds of OKRs (e.g. discipline)
- Is there a hierarchy of teams? Can a team belong to another team? (e.g RW playback to iPlayer)

# Local development
- Install Docker
- Run `docker-compose build` to build it
- Run `docker-compose up` to start rails
- To run cucumber tests, etc, run `docker-compose run web bash` for an interactive bash shell
- To shut down gracefully, in another terminal window, run `docker-compose down` if you just kill it, you'll have to log-in and remove the tmp/pids/puma.pid
- If you make changes to the Gemfile, run `docker-compose run web bundle`


This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
