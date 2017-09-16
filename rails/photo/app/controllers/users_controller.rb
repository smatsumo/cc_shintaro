class UsersController < ApplicationController
  def top
  end
  def show
  end
  def edit
  end
  def follower_list
  end
  def follow_list
  end
  # ユーザー登録ページ
  def sign_up
    @user = User.new
    render layout: "application_not_login"
  end
   
  # ユーザー登録処理
  def sign_up_process
    user = User.new(user_params) 
    
    if user.save
      redirect_to('/')
    else
      # 登録が失敗したらユーザー登録ページへ
      flash[:danger] = "ユーザー登録に失敗しました。"
      # render 'sign_up' and return
      redirect_to sign_up_path and return
    end
    
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
  # サインインページ
  def sign_in
    @user = User.new
    render layout: "application_not_login"
  end
   
  # サインイン処理
  def sign_in_process
    # ここに処理を実装
  end

end

