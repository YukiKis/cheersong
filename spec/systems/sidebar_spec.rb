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
    let(:song){ create(:song, user: user1) }
    before do
      login_user(user1)
    end
    it "has link to users" do
      expect(page).to have_link "USERS", href: users_path
    end
    it "has link to songs" do
      expect(page).to have_link "SONGS", href: songs_path
    end
    it "has link to logout" do
      expect(page).to have_link "LOGOUT", href; destroy_user_session_path
    end
    it "has link to chats" do
      expect(page).to have_link "Chats", href: user_rooms_path(user1)
    end
    it "has form for search" do
      expect(page).to have_field "keyword"
    end
    it "can search song" do
      fill_in "keyword", with: "MyFavorite"
      click_button "SEARCH"
      expect(page).to have_content user1.name
    end
  end
end