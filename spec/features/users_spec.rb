require 'rails_helper'

feature 'users' do
  background do
    @user = create(:user)
    @other_user = create(:user)
    visit '/login'
    fill_in('Email', with: @user.email)
    fill_in('Password', with: @user.password)
    click_button('Log in')
  end

  scenario 'login with correct credentials' do
    expect(current_path).to eq me_path
  end

  scenario 'correct user info on login' do
    user_info = all('.user_info h1')
    expect(user_info[1].text).to eq @user.username
    expect(user_info[2].text).to eq @user.email
  end

  scenario 'user can create many tweets' do
    content = Faker::Lorem.paragraph
    file = Rails.root.join('spec', 'files', 'kirby.png')
    10.times do
      fill_in('tweet_content', with: content)
      attach_file('tweet_picture', file)
      click_button('Post')
    end
    expect(all('.my_tweets li').count).to eq 10
  end
end
