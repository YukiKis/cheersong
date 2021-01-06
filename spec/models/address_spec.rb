require "rails_helper"

RSpec.describe Address, type: :model do
  let(:user1){ create(:user1) }
  let(:song){ create(:song, user: user1) }
  let(:address){ build(:address, song: song) }
  context "on validation" do
    it "belongs_to song" do
      expect(Address.reflect_on_association(:song).macro).to eq :belongs_to
    end
    it "is valid" do
      expect(address).to be_valid
    end
    it "is invalid without url" do
      song.url = ""
      expect(song).to be_invalid
    end
  end
end