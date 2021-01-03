require "rails_helper"

RSpec.describe 'Sidebar', type: :system do
  before do
    visit root_path 
  end
  context 'when not logged in' do
    it "has link to top" do
      expect(page).to have_link "HOME", href: root_path
    end
    it "has link to about" do
      expect(page).to have_link "ABOUT", href: about_path
    end
    it "has link to login" do
      expect(page).to have_link "LOGIN", href: new_user_session_path
    end
    it "has link to register" do
      expect(page).to have_link "REGISTER", href: new_user_registration_path
    end
  end
  context 'when logged in as user' do
    let(:user1){ create(:user1) }
    before do
      login_user(user1)
    end
    it "has link to logout" do
      expect(page).to have_link "LOGOUT", destroy_user_session_path
    end
  end
end