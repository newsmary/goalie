namespace :my_fixtures do
desc "Load my custom fixtures to popluate the database. Not quite Factory Girl..."
  task teams: [:environment, :warn] do
    #have to delete goals before deleting teams...
    Goal.destroy_all
    #Group.destroy_all
    Team.destroy_all
    names = "The Cure, Bauhaus, Depeche Mode, B12, Ministry, Pearl Jam, Underworld, Autechre, Tom Jones, New Order, Plaid, Fishbone, Primus, Nirvana, Joy Division, Macklemore, Roxy Music, Queen, Styxx, Journey, Survivor, Toto, The Police, Spin Doctors, Oingo Boingo, Midnight Oil"

    names.split(", ").each do |name|
      #usually create at the root
      if rand < 0.7
        Team.create!(name: name)
      else
        #but sometimes... if there are existing teams, nest them!
        if (Team.count > 0)
          Team.create!(name: name, parent: Team.all.sample)
        end
      end


    end
  end

  task goals: [:environment, :teams] do
    #require 'Date'
    #make_sub_goals(nil,0)

    Team.all.each do |team|
      [*(8..12)].sample.times do
        g = new_goal(nil,team)
        make_sub_goals(g,1)
      end
    end
  end

  def new_goal(parent, team=nil)
    #Get agreement to <verb> <number> <object> and <verb> <object.pluralize>
    verbs = %w/build grow save develop entertain inform increase write engage test release find workshop /
    nouns = %w/users viewers listeners departments platforms tools savings/
    #group = parent.nil? ? Group.all.sample : parent.group
    team = parent.team if parent
    Team.all.sample unless team
    #start_date = Date.today + [*(0..11)].sample.to_i.months
    #end_date = start_date + [0,1,3,3,3,4,5,5,6,6,7,8,9,10,11].sample.to_i.months  #could produce dates WAAAY into the future...
    #goal = Goal.create!(name: "#{verb.humanize} #{[*(1..500)].sample} #{noun} by #{end_date.strftime("%h %Y")}", start_date: start_date , deadline: end_date, owner: User.all.sample, group: group, team: team, parent: parent, sdp: rand > 0.9 ? true : false)
    name =  "#{verbs.sample.humanize} #{[*(1..500)].sample} #{nouns.sample} by #{verbs.sample.sub(/e$/,'')}ing #{[*(1..500)].sample} new #{nouns.sample.pluralize} and #{verbs.sample.sub(/e$/,'')}ing #{[*(1..500)].sample} new #{nouns.sample.pluralize}."

    #fix syntax highlighting weirdness (below)
    #"


    end_date = (Date.today + (6.months - (rand * 12).to_i.months)).end_of_financial_quarter
    puts name + " " + end_date.to_s


    goal = Goal.create!(name: name, team: team, parent: parent, end_date: end_date)

    #add several scores
    [1,2,3,5,7].sample.times do
      add_score(goal)
    end

    #return our goal
    goal
  end

  def add_score(goal)
    status = Status.all.sample

    if status.require_learnings?
      learnings = "Gravity is highly effictive. When in doubt, dance it out. Solve the problems you have, not the problems you imagine."
    end

    #add a score if it has been started.
    if(status.ordinal != 0)
      score = Score.create!(user: User.all.sample, goal: goal, amount: (100*rand).to_i, reason: "This is a fake status update. \nReason, reason, reason, blah blah.", learnings: learnings, status: status)
      score.update_attributes({updated_at: (100*rand).to_i.days.ago, created_at: (100*rand).to_i.days.ago})
      goal.scores << score
    end
  end

  #recursive function to make 5 child goals at each level
  def make_sub_goals (parent, depth)
    #make between X and Y sub goals
    [*(2..5)].sample.times do
      g = new_goal(parent)

      #max depth...
      # use 2 for just one layer of Objectives and Key Results
      if(depth < 1)
        puts " #{depth} id: #{g.id} name: #{g.name} parent: #{parent.name if parent.present?}"
        make_sub_goals(g,depth+1)
      end
    end
  end

  task add_scores: [:environment] do
      3.times do
        Goal.all.each do |goal|
          add_score(goal)
        end
      end
  end

  task clean: [:environment] do
    #remove only the test accounts we've created.
    #this leaves any accounts we've created by logging in manually
    Goal.destroy_all
    User.where("email like ?","%test.com%").destroy_all
  end

  task warn: [:environment] do
    #puts "WARNING: This may erase/overwrite existing data. Press enter to continue."
    #STDIN.gets
  end

  task statuses: [:environment] do
    #defined in statuses.rake
    Rake::Task['statuses:seed'].invoke
  end

  task users: [:environment, :clean, :warn] do
    #admin user
    u = User.new(name: 'Suzy Admin', admin: true, email: "email0@test.com")
    u.skip_confirmation!
    u.save(validate: false)

    #some other users
    [*(1..50)].each do |i|
      u = User.new(name: %w{Cindy Ada Jane Barbara Ann Benjamin Walter Alexis Simone Marina Oscar Julia Mark Lazlo Ray Lucretia Tom Peter Sarah Ringo John}.sample + " " + %w{Smith Jones Taylor Gibran Peterson Williams Mott Eames Johnson Davies Robinson Wright Knight Thompson Evans Walker White Roberts Green Hall Wood Jackson Clarke}.sample + " " + i.to_s, email: "email#{i}@test.com")
      u.skip_confirmation!
      u.save(validate:false)
    end
  end

  task :all => [:clean, :statuses, :warn, :users, :teams, :goals]

end
