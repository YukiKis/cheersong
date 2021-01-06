require "rails_helper"

RSpec.describe Song, type: :model do
  let(:user1){ create(:user1)}
  let(:song){ build(:song, user, usre1) }
  context "on validation" do
    it "has many favorites" do
      expect(Song.reflect_on_association(:faorites).macro).to eq :has_many
    end
    it "belongs_to user" do
      expect(Song.reflect_on_association(:user).macro).to eq :belongs_to
    end
    it "has many addresses" do
      expect(Song.reflect_on_association(:addresses).macro).to eq :has_many
    end
    it "is valid" do
      expect(song).to be_valid
    end
    it "is invalid without name" do
      song.name = ""
      expect(song).to be_invalid
    end
    it "is invalid without description" do
      song.description = ""
      expect(song).to be_invalid
    end
  end
end