require "rails_helper"

RSpec.describe "songs-page", type: :system do
  let(:user1){ create(:user1) }
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
  end
  
  context "on edit" do
    before do
      visit edit_song_path(song)
    end
  end
end