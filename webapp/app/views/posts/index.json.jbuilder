json.array!(@posts) do |post|
  json.extract! post, :id, :author_name, :author_uid, :link, :content
  json.url post_url(post, format: :json)
end
