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
      #make_sub_goals(nil,0)

      Team.all.each do |team|
        g = new_goal(nil,team)
        make_sub_goals(g,1)
      end
    end

    def new_goal(parent, team=nil)
      verb = %w/build grow save develop entertain inform increase write engage test release find/.sample
      noun = %w/users viewers listeners departments platforms tools savings/.sample
      #group = parent.nil? ? Group.all.sample : parent.group
      team = Team.all.sample unless team
      #start_date = Date.today + [*(0..11)].sample.to_i.months
      #end_date = start_date + [0,1,3,3,3,4,5,5,6,6,7,8,9,10,11].sample.to_i.months  #could produce dates WAAAY into the future...
      #goal = Goal.create!(name: "#{verb.humanize} #{[*(1..500)].sample} #{noun} by #{end_date.strftime("%h %Y")}", start_date: start_date , deadline: end_date, owner: User.all.sample, group: group, team: team, parent: parent, sdp: rand > 0.9 ? true : false)
      name =  "#{verb.humanize} #{[*(1..500)].sample} #{noun}"
      puts name
      goal = Goal.create!(name: name, team: team, parent: parent)

      #add some "scores"
      goal.scores << Score.create!(user: User.all.sample, goal: goal, amount: (100*rand).to_i, reason: "This is a fake status update. Reason, reason, reason, blah blah.", status: Status.all.sample)

      #return our goal
      goal
    end

    #recursive function to make 5 child goals at each level
    def make_sub_goals (parent, depth)
      #make between X and Y sub goals
      [*(2..4)].sample.times do
        g = new_goal(parent)

        #max depth...
        # use 2 for just one layer of Objectives and Key Results
        if(depth < 1)
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
      Goal.destroy_all
      User.where("email like ?","%test.com%").destroy_all

      #admin user
      u = User.new(name: 'Suzy Admin', admin: true, email: "email0@test.com")
      u.skip_confirmation!
      u.save(validate: false)

      #some other users
      [*(1..10)].each do |i|
        u = User.new(name: %w{Cindy Ada Jane Barbara Ann Benjamin Walter Alexis Simone Marina Oscar Julia Mark Lazlo Ray Lucretia Tom Peter Sarah Ringo John}.sample + " " + %w{Smith Jones Taylor Gibran Peterson Williams Mott Eames Johnson Davies Robinson Wright Knight Thompson Evans Walker White Roberts Green Hall Wood Jackson Clarke}.sample + " " + i.to_s, email: "email#{i}@test.com")
        u.skip_confirmation!
        u.save(validate:false)
      end
    end

    task :all => [:warn, :users, :teams, :goals]

  end
end
