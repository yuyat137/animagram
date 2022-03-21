module LoginMacros
  def login_as(user)
    visit login_path
    fill_in 'email', with: user.email
    fill_in 'password', with: 'Password-222'
    click_button 'ログイン'
  end
end
