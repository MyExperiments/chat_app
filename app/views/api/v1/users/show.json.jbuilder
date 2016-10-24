if @user
  json.user do
    json.id @user.id
    json.email @user.email
    json.online @user.online
  end
else
  json.user {}
end
