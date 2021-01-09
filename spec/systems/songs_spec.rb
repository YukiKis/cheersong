require "rails_helper"

RSpec.describe "songs-page", type: :system do
  let(:user1){ create(:user1) }
  let(:user2){ create(:user2) }
  let(:song){ create(:song, user: user1) }
  let(:song2){ create(:song2, user: user2) }
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
    it "has link to edit if the user is same as the song's user" do
      expect(page).to have_link "EDIT", href: edit_song_path(song)
    end
    it "has NO LINK to edit if it is the different user" do
      visit song_path(song2)
      expect(page).to have_no_content "EDIT", href: edit_song_path(song2)
    end
  end
  
  context "on edit" do
    before do
      visit edit_song_path(song)
    end
    it "has image_form" do
      expect(page).to have_field "song[image]"
    end
    it "has name_form" do
      expect(page).to have_field "song[name]", with: song.name
    end
    it "has description_form" do
      expect(page).to have_field "song[description]", with: song.description
    end
    it "has tag_list form" do
      expect(page).to have_field "song[tag_list]", with: song.tags
    end
    it "has button to update" do
      expect(page).to have_button "Update"
    end
    it "successfully update" do
      fill_in "song[name]", with: "EXAMPLE"
      fill_in "song[description]", with: "EGEG"
      fill_in "song[tag_list]", with: "EG, eg"
      click_button "Update"
      expect(page).to have_content "successfully update"
      expect(current_path).to eq song_path(song)
      expect(page).to have_content "EXAMPLE"
      expect(page).to have_content "EGEG"
      expect(page).to have_content "EG, eg"
    end
    it "fails to update" do
      fill_in "song[name]", with: ""
      click_button "Update"
      expect(page).to have_content "エラー"
    end
    it "has link to back to show page" do
      expect(page).to have_link "Back", href: song_path(song)
    end
    it "tries to visit edit for other usre's song but to show page" do
      visit edit_song_path(song2)
      expect(page).to have_content "cannot edit"
      expect(current_path).to eq song_path(song2)
    end
  end
end