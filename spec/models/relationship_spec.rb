require "rails_helper"

RSpec.describe Relationship, type: :model do
  let(:user1){ create(:user1) }
  let(:user2){ create(:usre2) }
#  let(:relationship)
  context "on validation" do
    before do
    end
    it "belong_to follower" do
      expect(Relationship.reflect_on_association(:followed).macro).to eq :belongs_to
    end
    it "belongs_to following" do
      expect(Relationship.reflect_on_association(:following).macro).to eq :belongs_to
    end
    it "is valid" do
      expect(relationship).to be_valid
    end
    it "is invalid wihtout followed_id" do
      relationship.followed_id = ""
      expect(relationship).to be_invalid
    end
    it "is invalid without following_id" do
      relationship.following_id = ""
      expect(relationship).to be_invalid
    end
  end
end