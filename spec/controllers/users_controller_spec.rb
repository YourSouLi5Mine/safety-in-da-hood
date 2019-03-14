require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before do
  end

  it { should use_before_action(:require_logout) }
  it { should use_before_action(:require_login) }

  it do
    params = {
      user: {
        username: Faker::Internet.username,
        email:    Faker::Internet.email,
        password: Faker::Internet.password
      }
    }
    should permit(:username, :email, :password).
      for(:create, params: params).
      on(:user)
  end
end
