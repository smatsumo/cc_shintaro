require "application_system_test_case"

class UserTest < ApplicationSystemTestCase
    setup do 
        @user = User.create!(name: 'test', email: 'test@test.com', password: 'password', created_at: '2017-01-01 00:00:00', updated_at: '2017-01-01 00:00:00') 
    end
    
    test "Sing_in_Test!!" do
        # サインアップページをリクエスト 
        visit sign_in_path
        
        #メアド入力 
        fill_in 'user_email', with: 'test@test.com'
        
        #メアド入力できたか確認 
        assert has_field?('user_email', with:'test@test.com')
        
        #パスワード入力 
        fill_in 'user_password', with: 'password' 
        #パスワード入力できたか確認 
        assert has_field?('user_password', with:'password')
        
        # click_button 'button' 
        click_button()
        #　バリデーションに通れば、サインイン後のトップにいる状態なので　ユーザー名取得
        expect(page).to have_content 'test'
    end
end