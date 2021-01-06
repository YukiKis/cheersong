require "rails_helper" 

RSpec.describe Favorite, type: :model do
  # let(:user){ create(:user1 })
  # let(:song){ create(:song, user: user1) }
  context "on validation" do
    it "belongs_to user" do
      expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
    end
    it "belongs_to song" do
      expect(Favorite.reflect_on_association(:song).macro).to eq :belongs_to
    end
  end
end