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
  end
  
  context "on edit" do
    before do
      visit edit_song_path(song)
    end
  end
end