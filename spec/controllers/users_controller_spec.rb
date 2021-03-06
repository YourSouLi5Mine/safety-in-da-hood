require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before(:all) do
    @params = {
      user: {
        username: Faker::Internet.username,
        email:    Faker::Internet.email,
        password: Faker::Internet.password
      }
    }
  end

  it { should use_before_action(:require_logout) }
  it { should use_before_action(:require_login) }

  context 'routes' do
    it { should route(:get, '/signup').to(action: :new) }
    it { should route(:post, '/signup').to(action: :create) }
    it { should route(:get, '/all').to(action: :index) }
    it { should route(:get, '/me/edit').to(action: :edit) }
    it { should route(:patch, '/me/edit').to(action: :update) }
  end

  context 'GET #new' do
    before { get :new }
    it 'correct template rendered and status code' do
      should render_template('new')
      should respond_with(200)
    end
  end

  context 'POST #create' do
    before { post :create, params: @params }
    it 'correct redirect and status code' do
      should redirect_to(root_path)
      should respond_with(302)
    end
  end
end
