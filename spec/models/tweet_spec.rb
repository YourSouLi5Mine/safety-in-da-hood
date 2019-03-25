require 'rails_helper'

RSpec.describe Tweet, type: :model do
  before(:all) do
    @tweet = build(:tweet)
    @tweet.user_id = create(:user).id
  end

  context 'tweet creation' do
    it 'raise error with empty attributes' do
      expect { Tweet.create! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'is valid with valid attributes' do
      expect(@tweet.save!).to be_truthy
    end
  end

  context 'model validation' do
    it { should belong_to(:user) }

    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:content) }

    it { should validate_length_of(:content).is_at_most(280) }
  end
end
