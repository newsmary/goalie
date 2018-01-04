Given(/^I have a team called "([^"]*)" with some scored OKRs from the last quarter$/) do |name|
  team = Team.create!(name: name)
  obj1 = Goal.create!(name: "Primary Objective", team: team,end_date: (Date.today - 3.months).end_of_financial_quarter)
  kr1 = Goal.create!(name: "KR 1", team: team, end_date: obj1.end_date)
  kr2 = Goal.create!(name: "KR 2", team: team, end_date: obj1.end_date)
  kr3 = Goal.create!(name: "KR 3", team: team, end_date: obj1.end_date)

  obj1.key_results << [kr1, kr2, kr3]
  team.objectives << obj1

  kr1.scores << Score.create!(goal: kr1, amount: 50, reason: "reason", learnings: "We learned a lot", status: Status.find_by(name: "Complete"), user: User.first)
  kr2.scores << Score.create!(goal: kr2, amount: 50, reason: "reason", learnings: "We learned a lot", status: Status.find_by(name: "Complete"), user: User.first)
  kr3.scores << Score.create!(goal: kr3, amount: 50, reason: "reason", learnings: "We learned a lot", status: Status.find_by(name: "Complete"), user: User.first)

end
