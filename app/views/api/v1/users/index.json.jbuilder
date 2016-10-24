json.users @users do |user|
  json.id user.id
  json.email user.email
  json.is_online user.online
end