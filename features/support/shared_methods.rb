
# create scored OKRs in a given month for a team with a given name
def create_scored_okrs_by_team_and_quarter(name, month_count)
  team = Team.find_or_create_by!(name: name)

  obj1 = Goal.create!(name: "Primary Objective", team: team,end_date: (Date.today + month_count.months).end_of_financial_quarter)
  team.objectives << obj1

  3.times do |i|
    kr = Goal.create!(name: "KR #{i}", team: team, end_date: obj1.end_date)
    obj1.key_results << kr
  end

  obj1.key_results.each do |kr|
    kr.scores << Score.create!(goal: kr, amount: 50, reason: "reason", learnings: "We learned a lot", status: Status.find_by(name: "Finished"), user: User.first)
  end
end
