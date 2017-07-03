json.extract! team, :id, :name, :url, :body, :created_at, :updated_at
json.url team_url(team, format: :json)
