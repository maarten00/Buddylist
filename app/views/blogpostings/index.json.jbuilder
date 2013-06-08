json.array!(@blogpostings) do |blogposting|
  json.extract! blogposting, :user_id, :content
  json.url blogposting_url(blogposting, format: :json)
end