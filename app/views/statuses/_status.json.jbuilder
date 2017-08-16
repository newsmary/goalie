json.extract! status, :id, :name, :ordinal, :hex_color, :created_at, :updated_at
json.url status_url(status, format: :json)
