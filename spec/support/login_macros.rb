module LoginMacros
  def login_user(user)
    visit new_user_session_path
    fill_in "user[name]", with: user.name
    fill_in "user[password]", with: user.password
    click_button "ログイン"
  end
  
  def logout_user
    click_link "ログアウト"
  end
end