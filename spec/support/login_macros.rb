module LoginMacros
  def login_as(user)
    visit root_path
    click_button 'Login'
    fill_in 'email', with:user.email
    fill_in 'passsword', with:user.password
    click_button 'Login'
  end
end