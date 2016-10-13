if @user
  json.user do
    json.id @user.id
    json.email @user.email
  end
else
  json.user {}
end
