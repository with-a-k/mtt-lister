require 'test_helper'

class UserRegistrationTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.app = MTTLister::Application
    DatabaseCleaner.clean
    reset_session!
  end

  test "successful registration" do
    visit root_path
    click_on "Register as a New User"
    assert_equal register_path, current_path
    fill_in 'Username', with: "Yggdra Artwaltz"
    fill_in 'Password', with: "SwordCrusader"
    fill_in 'Re-enter Password', with: "SwordCrusader"
    click_on "Register"
    assert page.has_content?("Yggdra Artwaltz")
  end

  test "password mismatch" do
    visit root_path
    click_on "Register as a New User"
    fill_in 'Username', with: "Garlot"
    fill_in 'Password', with: "DragonDemon"
    fill_in 'Re-enter Password', with: "DemonDragon"
    click_on "Register"
    assert_equal register_path, current_path
    assert page.has_content?("Your passwords need to match!")
  end
end