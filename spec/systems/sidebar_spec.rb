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
  end
end