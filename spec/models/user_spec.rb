require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) { @user = build(:user) }

  context 'sign up' do
    it 'raise error with empty attributes' do
      expect { User.create! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'is valid with valid attributes' do
      expect(@user.save!).to be_truthy
    end
  end

  context 'model validation' do
    it { should have_many(:tweets) }
    it { should have_many(:active_follows) }
    it { should have_many(:passive_follows) }
    it { should have_many(:following) }
    it { should have_many(:followers) }

    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:email) }

    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:email) }

    it { should allow_value(@user.email).for(:email) }
    it { should_not allow_value("bad_email").for(:email) }

    it { should have_secure_password }
    it { should validate_confirmation_of(:password) }
    it { should_not allow_value(nil).for(:password) }
  end
end
