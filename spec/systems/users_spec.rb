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
    before do 
      visit user_path(user1)
    end
    it "has own info on sidebar" do
      expect(page).to have_css ".my-img"
      expect(page).to have_content user1.name
      expect(page).to have_content user1.introduction
      expect(page).to have_link "EDIT", href: edit_user_path(user1)
    end
    it "has user name" do
      expect(page).to have_content user1.name
    end
    it "has user introduction" do
      expect(page).to have_content user1.introduction
    end
    # it "has followers list" do
    #   expect(page).to have_content user1.followings.count
    #   expect(page).to have_link "follower".pluralize(user1.followers.count), href: followers_users_path(usre1)
    #   expect(page).to have_content user1.followers.count
    #   expect(page).to have_link "following".pluralie(user1.followings.count), href: followings_users_path(usre1)
    # end
    # it "has link to check chats" do
    #   expect(page).to have_link "Check Chats", href: chats_users_path(user1)
    # end
    # it "has list for songs" do
    # end
#    it "has songs list" do
#    end
  end
  context "on edit" do
  end
end