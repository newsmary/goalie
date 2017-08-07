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
- To shut down gracefully, in another terminal window, run `docker-compose down`
- To send emails, make sure you start the host's postfix server `sudo postfix start`

## Troublshooting:
- If you get a message that a server is already running (because you didn't gracefully shut down) just log into the machine `docker-compose run web bash` and `rm /tmp/pids/server.pids`


#deploy to production
- Use heroku
- Set the "host" env variable
- `heroku run rake db:migrate --app <APPNAME>`

#testing
Use cucumber...
To test WIP tests in dev run `rake cucumber:wip`
