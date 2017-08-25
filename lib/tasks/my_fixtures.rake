namespace :db do
  desc "Load my custom fixtures to popluate the database. Not quite Factory Girl..."
  namespace :my_fixtures do

    task teams: [:environment, :warn] do
      #have to delete goals before deleting teams...
      Goal.destroy_all
      #Group.destroy_all
      Team.destroy_all

      Team.create!(name: "The Cure")
      Team.create!(name: "Bauhaus")
      Team.create!(name: "Nitzer Ebb")
      Team.create!(name: "Underworld")

    end

    task goals: [:environment, :teams] do
      #require 'Date'
      make_sub_goals(nil,0)

    end

    def new_goal(parent)
      verb = %w/build grow save develop entertain inform increase write engage test release find/.sample
      noun = %w/users viewers listeners departments platforms tools savings/.sample
      #group = parent.nil? ? Group.all.sample : parent.group
      team = Team.all.sample
      #start_date = Date.today + [*(0..11)].sample.to_i.months
      #end_date = start_date + [0,1,3,3,3,4,5,5,6,6,7,8,9,10,11].sample.to_i.months  #could produce dates WAAAY into the future...
      #goal = Goal.create!(name: "#{verb.humanize} #{[*(1..500)].sample} #{noun} by #{end_date.strftime("%h %Y")}", start_date: start_date , deadline: end_date, owner: User.all.sample, group: group, team: team, parent: parent, sdp: rand > 0.9 ? true : false)
      goal = Goal.create!(name: "#{verb.humanize} #{[*(1..500)].sample} #{noun}}", team: team, parent: parent)

      #add some "scores"
      goal.scores << Score.create!(user: User.all.sample, goal: goal, reason: "This is a fake status update. Reason, reason, reason, blah blah.", status: Status.all.sample)

      #return our goal
      goal
    end

    #recursive function to make 5 child goals at each level
    def make_sub_goals (parent, depth)
      #make up to 4 sub goals
      [*(2..6)].sample.times do
        g = new_goal(parent)

        #max depth...
        if(depth < 2)
          puts " #{depth} id: #{g.id} name: #{g.name} parent: #{parent.name if parent.present?}"
          make_sub_goals(g,depth+1)
        end
      end
    end

    task warn: [:environment] do
      #puts "WARNING: This may erase/overwrite existing data. Press enter to continue."
      #STDIN.gets
    end

    task users: [:environment, :warn] do
      #remove only the test accounts we've created.
      #this leaves any accounts we've created by logging in manually
      User.where("email like ?","%test.com%").destroy_all

      #admin user
      User.create!(name: 'Suzy Admin', admin: true, email: "email0@test.com")

      #some other users
      [*(1..10)].each do |i|
        User.create!(name: %w{Cindy Ada Jane Barbara Ann Benjamin Walter Alexis Simone Marina Oscar Julia Mark Lazlo Ray Lucretia Tom Peter Sarah Ringo John}.sample + " " + %w{Smith Jones Taylor Gibran Peterson Williams Mott Eames Johnson Davies Robinson Wright Knight Thompson Evans Walker White Roberts Green Hall Wood Jackson Clarke}.sample + " " + i.to_s, email: "email#{i}@test.com")
      end
    end

    task :all => [:warn, :users, :groups_and_teams, :goals]

  end
end
