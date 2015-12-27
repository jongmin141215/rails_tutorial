require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:jongmin)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { name: '',
                                    email: 'invalid@email',
                                    password: 'foo',
                                    password_confirmation: 'bar' }
    assert_template 'users/edit'
  end

  test "successful edit with friendly fowrarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    new_name = 'Jorgen Hahn'
    new_email = 'jorg@hahn.com'
    patch user_path(@user), user: { name: new_name,
                                    email: new_email,
                                    password: '',
                                    password: '' }
    assert_not flash.nil?
    assert_redirected_to @user
    @user.reload
    assert_equal new_name, @user.name
    assert_equal new_email, @user.email
  end

  test "successful edit" do
    log_in_as(@user)
    new_name = 'Jorgen Hahn'
    new_email = 'jorg@hahn.com'
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { name: new_name,
                                    email: new_email,
                                    password: '',
                                    password: '' }
    assert_not flash.nil?
    assert_redirected_to @user
    @user.reload
    assert_equal new_name, @user.name
    assert_equal new_email, @user.email
  end
end
