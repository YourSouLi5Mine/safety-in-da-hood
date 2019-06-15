require 'rails_helper'

feature 'users' do
  context 'normal login' do
    background do
      @user = create(:user)
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

    context 'image uploads' do
      background do
        content = Faker::Lorem.paragraph
        file = Rails.root.join('spec', 'files', 'kirby.png')
        3.times do
          fill_in('tweet_content', with: content)
          attach_file('tweet_picture', file)
          click_button('Post')
        end
      end

      scenario 'user can create many tweets' do
        expect(all('.my_tweets li').count).to eq 3
      end
    end

    scenario 'user can not upload bigger than 3 mb pictures' do
      file = Rails.root.join('spec', 'files', 'rick_and_morty.jpg')
      attach_file('tweet_picture', file)
      click_button('Post')
      expect(all('.my_tweets li').count).to eq 0
    end

    scenario 'user can logout' do
      find_link(href: '/logout').click
      expect(current_path).to eq root_path
    end

    scenario 'require logout to access root' do
      visit '/'
      expect(current_path).to eq me_path
    end
  end

  context 'remember me on login' do
    background do
      @user = create(:user)
      visit '/login'
      fill_in('Email', with: @user.email)
      fill_in('Password', with: @user.password)
      check('Remember me')
      click_button('Log in')
    end

    scenario 'cookie exists' do
      browser = Capybara.current_session.driver.browser
      cookie = browser.manage.all_cookies[1]
      expect(cookie[:name]).to eq "remember_token"
      expect(cookie[:value]).to_not be_nil
    end
  end

  context 'incorrect login' do
    background do
      visit '/login'
      fill_in('Email', with: 'incorrect_email')
      fill_in('Password', with: 'incorrect_password')
      click_button('Log in')
    end

    scenario 'render login form again' do
      expect(current_path).to eq login_path
    end
  end

  context 'check if logged_in?' do
    scenario 'login required' do
      visit '/me'
      expect(current_path).to eq login_path
    end
  end
end
