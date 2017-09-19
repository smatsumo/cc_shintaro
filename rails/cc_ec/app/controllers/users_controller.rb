class UsersController < ApplicationController
  before_action :authorize, except: [:sign_up, :sign_up_process, :sign_in, :sign_in_process]
  before_action :redirect_to_top_if_signed_in, only: [:sign_up, :sign_in]
  
  def profiles
    #byebug
    @user = User.find(current_user.id)

  end
  
  def edit
    @user = User.find(current_user.id)
  end
  
  def new
  end
  
  def likes
  end
  
  def products
  end
  
  def sign_in
    #モデルのインスタンス化をしている 
    @user = User.new
    render layout: "application_not_login"
  end
  
  def sign_in_process
    # パスワードをmd5に変換
    password_md5 = User.generate_password(user_params[:password]) 
    # メールアドレスとパスワードをもとにデータベースからデータを取得
    user = User.find_by(email: user_params[:email], password: password_md5)
    if user
      # セッション処理
      user_sign_in(user)
      # トップ画面へ遷移する
      redirect_to top_path and return
    else
      flash[:danger] = "サインインに失敗しました。"
      redirect_to sign_in_path and return
    end
  end
  
  def sign_out
    # ユーザーセッションを破棄
    user_sign_out
    # サインインページへ遷移
    redirect_to sign_in_path and return
  end
  
  
  def sign_up
    @user = User.new
    render layout: "application_not_login"
  end
  
  def sign_up_process
    user = User.new(user_params)
    if params[:user][:password]==params[:user][:check_password]
      if user.save
        #データベースへの登録成功
        #user_sign_in(user)   サインインさせる
        redirect_to top_path and return
      else
        #データベースへの登録失敗の為、エラーをだす
        flash[:danger] = "データベースへの登録に失敗しました"
        redirect_to sign_up_path and return
      end
    else
      #失敗しました
      flash[:danger] = "パスワード不一致のため、登録に失敗しました"
      redirect_to sign_up_path and return
    end
      
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
  
  
end


