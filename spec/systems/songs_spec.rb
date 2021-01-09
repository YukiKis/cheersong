require "rails_helper"

RSpec.describe "songs-page", type: :system do
  let(:user1){ create(:user1) }
  let(:user2){ create(:user2) }
  let(:song){ create(:song, user: user1) }
  before do
    login_user user1
  end
  context "on index" do
    before do
      visit songs_path
    end
    it "has songs_list" do
      Song.all.each do |song|
        expect(page).to have_content song.name
        expect(page).to have_link "See More", href: song_path(song)
        expect(page).to have_content song.favorites.count
      end
    end
  end
  
  context "on show" do
    let(:comment1){ create(:comment1, user: user1, song: song) }
    let(:comment2){ create(:comment2, user: user2, song: song) }
    before do
      visit song_path(song)
    end
    it "has song name" do
      expect(page).to have_content song.name
    end
    it "has song description" do
      expect(page).to have_content song.description
    end
    it "has song urls" do
      song.addresses.each do |address|
        expect(page).to have_link address.url, href: address_url
      end
    end
    it "has song favorite_link" do
      expect(page).to have_link "★", href: song_favorite_path(song)
    end
    it "hsa delete-song-favorite link" do
      song.favorites.create(user: user1)
      visit song_path(song)
      expect(page).to have_link "★", href: song_favorite_path(song)
      expect{ click_on "★" }.to change{ song.favorites.count }.by(-1)
    end
    it "has comment-list" do
      #check with actual"
      expect(page).to have_content "This is good"
      expect(page).to have_link user1.name, href: user_path(user1)
      expect(page).to have_content "This is bad"
      expect(page).to have_link user2.name, href: user_path(user2)
      #check with each
      song.comments.each do |comment|
        expect(page).to have_content comment.content
        expect(page).to have_link comment.user.name, href: user_path(comment_user)
        expect(page).to have_link "DELETE", href: song_comment_path(comment)
      end
    end
    it "has form for comment" do
      expect(page).to have_field "comment[content]"
      expect(page).to have_button "POST"
    end
    it "successfully post" do
      fill_in "comment[content]", with: "This is so nice"
      click_button "POST"
      expect(page).to have_content "This is so nice"
    end
    it "fails to post" do
      click_button "POST"
      expect(page).to have_content "エラー"
    end
  end
  
  context "on edit" do
    before do
      visit edit_song_path(song)
    end
  end
end