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
  
  context "on follow" do
    before do 
      user1.follow(user2)
      visit user_followings_path(user1)
    end
    it "has followings_list" do
      #actual check
      expect(page).to have_content user2.name
      expect(page).to have_link "Unfollow", href: user_unfollow_path(user2)
      #check with each
      user1.followings.each do |following|
        expect(page).to have_content following.name
        expect(page).to have_link "Unfollow", href: user_unfollow_path(following)
      end
    end
  end
  
  context "on followres" do
    before do
      user2.follow(user1)
      visit user_followers_path(user1)
    end
    it "has followres_list" do
      expect(page).to have_content user2.name
    end
    it "has link to follow if not follow yet" do
      expect(page).to have_link "Follow", href: user_follow_path(user2)
    end
    it "hsa link to unfollow if already follow" do
      user1.follow(user2)
      visit current_path
      expect(page).to have_link "Unfollow", href: user_unfollow_path(user2)
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
    it "has followers list" do
      expect(page).to have_content user1.followings.count
      expect(page).to have_link "", href: followers_users_path(usre1)
      expect(page).to have_content user1.followers.count
      expect(page).to have_link "", href: followings_users_path(usre1)
    end
    it "has no link for chats if it is own" do
      expect(page).to have_no_selector "a", "Chats"
    end
    it "has link for chats" do
       visit user_path(user2)
       room = user1.make_room(user2)
       user1.has_room?(user2)
       expect(page).to have_link "Chats", href: user_room_path(user2, room)
    end
    it "has link for beginning chats" do
      visit user_path(user2)
      expect(page).to have_link "Chats", href: user_rooms_path(user2)
    end
    it "has list for songs" do
      user1.songs.each do |song|
        expect(page).to have_content song.name
        expect(page).to have_link "See More", href: song_path(song)
      end
    end
    it "has link to new song if it is the current User" do
      expect(page).to have_link "New Song", href: new_song_path
    end
    it "has NO LINK to new song if it is the diffenret user" do
      visit user_path(user2)
      expect(page).to have_no_link "New Song", href: new_song_path
    end
#    it "has songs list" do
#    end
  end
  context "on edit" do
    before do
      visit edit_user_path(user1)
    end
    it "fails to visit if it is the other user" do
      visit edit_user_path(user2)
      expect(page).to have_content "cannot edit"
      expect(current_path).to eq user_path(user2)
    end
    it "has file_field" do
      expect(page).to have_field "user[avatar]"
    end
    it "has name_field" do
      expect(page).to have_filed "user[name]"
    end
    it "has introduction field" do
      expect(page).to have_field "user[introduction]"
    end
    it "has email field" do
      expect(page).to have_field "user[email]"
    end
    it "succeeds to update" do
      attach_file "user[avatar]", "#{ Rails.root.join("/spec/factories/noiamge.jpg") }"
      fill_in "user[name]", with: "EG"
      flll_in "user[introduction]", with: "intro"
      fill_in "user[email]", with: "eg@com"
      click_button "UPDATE"
      expect(page).to have_content "successfully"
      expect(page).to have_content "EG"
      expect(page).to have_content "intro"
    end
    it "fails to update" do
      fill_in "user[name]", with: ""
      click_button "UPDATE"
      expect(page).to have_content "エラー"
    end
  end
end