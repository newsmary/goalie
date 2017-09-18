# Goalie

A goal-setting and tracking platform.

## Roadmap (TODOs)
- More tests
- Think about reporting/tracking
- Think about Individual OKRs (not just teams)
- Think about other kinds of OKRs (e.g. discipline)
- Is there a hierarchy of teams? Can a team belong to another team? (e.g RW playback to iPlayer)

# Local development setup
- copy `env.sample` to `.env` and add your hostname
- Install Docker
- first time: Run `docker-compose build` to build it
- When you change the gemfile, you'll need to re-run the above.
- Run `docker-compose up` to start rails
- To run cucumber tests, etc, run `docker-compose run web bash` for an interactive bash shell
- Seed the "statuses" via `rake statuses:seed`
- To shut down gracefully, in another terminal window, run `docker-compose down`

## Mail testing
- To test emails in development, I recommend using (mailcatcher)[https://mailcatcher.me] which caches and displays emails sent by your app. You can run in via a docker container like so: `docker run -it -p 1080:80 -p 25:25 tophfr/mailcatcher`. Using the `-it` switches will keep the virtual terminal open & connected so you can see if mails are routing correctly through the container. The `config/environments/develoment.rb` file should already be set up to relay mails through the host in your local environment.

## Troublshooting:
- If you get a message that a server is already running (because you didn't gracefully shut down) just log into the machine `docker-compose run web bash` and `rm /tmp/pids/server.pids`


#deploy to production
- Use heroku
- Set the "host" env variable
- `heroku run rake db:migrate --app <APPNAME>`
- Seed the "statuses" via `rake statuses:seed`
- You should now be up and running

#TODOs
- allow email allowable domains and return addresses to be configured via env vars

#testing
Use cucumber...
To test WIP tests in dev run `rake cucumber:wip`
