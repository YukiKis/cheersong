require "rails_helper"

RSpec.describe "User-page", type: :system do
  let(:user1){ create(:user1) }
  let(:user2){ create(:user2) }
  let(:user3){ create(:user3) }
  let(:user4){ create(:user4) }
  let(:user5){ create(:user5) }

  before do
    login_user user1
  end
  context "on index" do
    before do
      visit users_path
    end
    it "has own info on sidebar" do
      expect(page).to have_css ".my-img"
      expect(page).to have_content user1.name
      expect(page).to have_content user1.introduction
      expect(page).to have_link "EDIT", href: edit_user_path(user1)
    end
    it "has list for users" do
      #check by each
      User.all.each do |user|
        expect(page).to have_content user.name
        expect(page).to have_content user.songs.count
        expect(page).to have_link "SEE MORE", href: user_path(user)
      end
    end
      
  end
  context "on show" do
  end
  context "on edit" do
  end
end