module UserHelpers

  def setup_user
    User.create(email: 'test@test.com',
                password: 'test',
                password_confirmation: 'test')
  end

end
