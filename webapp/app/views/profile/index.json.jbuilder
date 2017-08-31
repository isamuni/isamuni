json.users @users do |user|
    json.extract! user, :name, :slug, :occupation, :projects, :description, :links
    json.skills user.skills, :id, :name
    json.url link_to(user)
end

json.skills @skills