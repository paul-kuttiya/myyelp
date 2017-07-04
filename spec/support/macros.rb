def set_user(user=nil)
  session[:user_id] = user || Fabricate(:user)
end