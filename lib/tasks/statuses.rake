namespace :statuses do
  desc "Tasks for pre-loading default status data."
  # Colors taken from here http://www.bbc.co.uk/gel/guidelines/how-to-design-infographics
  task seed: :environment do
    Status.create!([{
      name: "Not started",
      ordinal: 0,
      hex_color: '#566'
    },
    {
      name: "On track",
      ordinal: 1,
      hex_color: '#5a8c3e'
    },
    {
      name: "Off track",
      ordinal: 2,
      hex_color: '#facf12'
    },
    {
      name: "Help!",
      ordinal: 3,
      hex_color: '#9d1c1f'
    },
    {
      name: "Complete",
      ordinal: 4,
      hex_color: '#4a777c'
    },
    {
      name: "Cancelled",
      ordinal: 5,
      hex_color: '#000'
    }])

    p "Created default statuses"

  end

end
