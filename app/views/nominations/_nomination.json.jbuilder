json.extract! nomination, :id, :user_id, :movie_id, :created_at, :updated_at
json.url nomination_url(nomination, format: :json)
