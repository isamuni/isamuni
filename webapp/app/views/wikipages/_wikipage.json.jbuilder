json.extract! wikipage, :id, :name, :slug, :content, :created_at, :updated_at
json.url wikipage_url(wikipage, format: :json)
