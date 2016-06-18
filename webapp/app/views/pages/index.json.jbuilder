json.array!(@pages) do |page|
  json.extract! page, :id, :name, :owner_id, :active, :name, :links, :description, :contacts, :coordinates
  json.url page_url(page, format: :json)
end
