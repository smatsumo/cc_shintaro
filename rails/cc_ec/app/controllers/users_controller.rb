class UsersController < ApplicationController
  before_action :authorize, except: [:sign_up, :sign_up_process, :sign_in, :sign_in_process]
  before_action :redirect_to_top_if_signed_in, only: [:sign_up, :sign_in]
  
  def profiles
    #byebug
    @user = current_user
  end
  
  #商品出品ページの表示
  def new
    @user = current_user
    @product= Product.new()
    @categories=Category.all
  end
  
  #商品出品処理
  def sell_item
    @user= current_user
    upload_image(item_params[:image1])
    #upload_image(item_params[:image2])
    #upload_image(item_params[:image3])
    upload_file_name1 = item_params[:image1].original_filename
    #upload_file_name2 = item_params[:image2].original_filename
    #upload_file_name3 = item_params[:image3].original_filename
    
    
    #別の変数に代入して変数でアップロードの処理をすれば解決する
    item_params[:image1]=upload_file_name1
    #item_params[:image2]=upload_file_name2
    #item_params[:image3]=upload_file_name3

    
    
    
    
    product= Product.new(item_params.merge({status: 1}))
    if product.save
        #productテーブルへの登録成功
        redirect_to top_path and return
      else
        #product_tableへの登録失敗の為、エラーをだす
        flash[:danger] = "データベースへの登録に失敗しました"
        redirect_to products_new_path and return
    end
    
  end
  
  def edit
    @user = current_user
  end
  
  # プロフィール更新処理
  def update
    #new_passとcheck_new_passが使えるかどうか不明（要検証）
    new_pass=params[:user][:new_password]
    check_new_pass=params[:user][:new_check_password]
    if new_pass.present? && check_new_pass.present? #新しいパスと確認用パスが入力されているか確認
      if new_pass == check_new_pass#新しいパスと確認パスが一致しているか確認
        #create new password
        temp_params = user_params
        temp_params[:password] = new_pass
        upload_profile
      else
        #output error
        flash[:danger] = "新規パスワードと確認用パスワードが不一致の為、更新出来ませんでした。"
        redirect_to top_path and return
      end
    else
        #keep old password and store to database
        #おそらくパスワードに対して何の処理もしなくて良いはず。
        upload_profile
    end
    redirect_to top_path and return
    
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
        user_sign_in(user)   
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
    params.require(:user).permit(:name, :email, :password, :profile)
  end

  def item_params
    params.require(:product).permit(:name,:description,:price,:image1,:image2,:image3)
  end
  
  def upload_profile
    upload_file = params[:user][:image]
    update_image_profile(upload_file,user_params)
  end
  
  #シンボルを渡したい場合はどうすれば良いか？ 現在はitemとuser_paramsの両方に対応している　
  def update_image_profile(file,new_params)
    if upload_image(file)
      #商品の編集時にここの部分をimage1,image2,image3に対応させたい。　現在はプロフィールの編集のみ対応している。
      current_user.update(new_params.merge({image: upload_file.original_filename}))
    else
      current_user.update(new_params)
    end
  end
  
  def update_image_item(file,new_params,imagex)
    # type="image"であるもののnameの配列を受け取る
    # ["image1", "image2", "image3"]
    # names.eachでnameごとに if upload_image(name)
    # アップロード成功時にはmerge用のハッシュに要素を追加する
    # each終了後にupdate(new_params.merge(merge用のハッシュ))
    if upload_image(file)
      #商品の編集時にここの部分をimage1,image2,image3に対応させたい。　現在はプロフィールの編集のみ対応している。
      current_user.update(new_params.merge({image1: upload_file.original_filename,image2: upload_file.original_filename,image3: upload_file.original_filename}))
    else
      current_user.update(new_params)
    end
  end 
  
  #ファイルのアップロードだけの処理 true falseで戻り値を返してその結果によってデータベースへの登録処理を行いたい。
  #もしtrueならデータベース登録処理をする
  def upload_image(file)
    upload_file=file
    if upload_file.present?
      # あった場合はこの中の処理が実行される
      upload_file_name = upload_file.original_filename
      output_dir = Rails.root.join('public', 'images')
      output_path = output_dir + upload_file_name
      File.open(output_path, 'w+b') do |f|
        f.write(upload_file.read)
      end
      return true
    end
    return false
  end

  
end


