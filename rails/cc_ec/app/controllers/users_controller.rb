class UsersController < ApplicationController
  before_action :authorize, except: [:sign_up, :sign_up_process, :sign_in, :sign_in_process]
  before_action :redirect_to_top_if_signed_in, only: [:sign_up, :sign_in]
  
  
  #サインイン後のトップページ及びユーザーページの表示
  def profiles
    @user = current_user
  end
  
  #商品出品ページの表示
  def new
    @user = current_user
    @product= Product.new()
    @categories=Category.all
  end
  
  #現在販売中の商品ページの表示
  #事前に自分が出品したプロダクトを除いて検索をしたい場合はどうすれば良いか？
  def item_list
    @user=current_user
    
    @categories=Category.all
    #byebug
    # キーワード検索処理
    if params[:word].present?
      @products=Product.where("name like ?", "%#{params[:word]}%").order("id desc").page(params[:page])
      #last_result=@products
      #byebug
    elsif params[:highest].present? && params[:lowest].present?
      #byebug
      @products=Product.where(price: params[:lowest]..params[:highest]).page(params[:page])
      #.not(user_id: current_user.id)
      
    elsif params[:category_id].present?
    #byebug
      @products=Product.where(category_id: params[:category_id]).page(params[:page])
    elsif params[:sort].present? && params[:sort] !=0
      #byebug
      @products=sort_item(params[:sort]).page(params[:page])
      #byebug
    else
      # 一覧表示処理
      @products=Product.where.not(user_id: current_user.id).page(params[:page])
      #byebug
    end
    
    
  end
  
  #商品出品処理
  def sell_item
    @user= current_user
    #item_paramsはname,desciption,category_idとimage1,2,3などの実際の画像を保有している
    #temp_paramsはimage1,image2,image3から名前を得て、実際のデータベース登録に必要.
    
    temp_params=upload_image_item(item_params)
    
    @product= Product.new(temp_params.merge({status: 1,user_id: @user.id}))
    #@product= Product.new(item_params)
    #@product= Product.new()
    #
    #product.save!にするとRails側のデータベース関連エラーがサイトに出力されるようになる。
    if @product.save
        #productテーブルへの登録成功
        redirect_to top_path and return
      else
        #product_tableへの登録失敗の為、エラーをだす
        #
        flash[:danger] = "必須情報の未記入があった為、登録に失敗しました"
        redirect_to products_new_path and return
    end
    
  end
  
  #プロフィール編集のページ
  def edit
    @user = current_user
  end
  
  #出品した商品の詳細を表示する　/users/products/(:id)
  def user_item_detail
    @user =current_user
    #byebug
    @product=Product.find_by(id: params[:id])
    #@categories=Category.all
    #byebug
  end
  
  #出品した個別アイテムの編集ページの表示 /users/products/{id}/edit
  def user_item_edit
    @user = current_user
    @product=Product.find_by(id: params[:id])
    @categories=Category.all
  end
  
  #出品した商品の編集処理
  def item_edit
    @product = Product.find_by(id: params[:id])
    new_params = upload_image_item(item_params)
    @product.update(new_params)
    redirect_to top_path and return
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
        #user_params[:password]はメソッドで変数では無い為、user_params[:password]=new_passではエラーが発生する
        password_md5 = User.generate_password(new_pass) 
        temp_params[:password] = password_md5
        update_profile(temp_params)
      else
        #output error
        flash[:danger] = "新規パスワードと確認用パスワードが不一致の為、更新出来ませんでした。"
        redirect_to profile_edit_path and return
      end
    else
        #keep old password and store to database
        #おそらくパスワードに対して何の処理もしなくて良いはず。
        update_profile(user_params)
    end
    redirect_to top_path and return
  end
  
  #お気に入り商品の処理
  def likes
    #byebug
    @product = Product.find(params[:id])
    if UserLike.exists?(product_id: @product.id, user_id: current_user.id)
      # いいねを削除
      UserLike.find_by(product_id: @product.id, user_id: current_user.id).destroy
      #redict_toで同じ場所に戻るにはどうすれば良いか？
      redirect_back(fallback_location: root_path)
    else
      # いいねを登録
      UserLike.create(product_id: @product.id, user_id: current_user.id)
      #redirect_to top_path and return
      redirect_back(fallback_location: root_path)
    end
  end
  
  
  #ユーザーが登録している商品一覧ページ /products
  def products
    @user=current_user
    @products = Product.where(user_id: current_user.id).page(params[:page])
    #byebug
  end
  
  #サインインページ
  def sign_in
    #モデルのインスタンス化をしている 
    @user = User.new
    render layout: "application_not_login"
  end
  
  #サインインの機能
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
  #サインアウト
  def sign_out
    # ユーザーセッションを破棄
    user_sign_out
    # サインインページへ遷移
    redirect_to sign_in_path and return
  end
  
  #ユーザー登録ページ
  def sign_up
    @user = User.new
    render layout: "application_not_login"
  end
  
  #ユーザー登録処理
  def sign_up_process
    user = User.new(user_params)
    #
    if params[:user][:password]==params[:user][:check_password]
      if user.save
        #データベースへの登録成功
        user_sign_in(user)   
        redirect_to top_path and return
      else
        #データベースへの登録失敗の為、エラーをだす
        flash[:danger] = "必要科目の欄で未記入があった為、登録に失敗しました"
        redirect_to sign_up_path and return
      end
    else
      #失敗しました
      flash[:danger] = "パスワード不一致のため、登録に失敗しました"
      redirect_to sign_up_path and return
    end
  end

  #お気に入り商品一覧ページ
  def likes_list
    @user=current_user
    #like_id=UserLike.where(user_id: current_user.id)
    #byebug
    @products=Product.where(id: UserLike.where(user_id: current_user.id).pluck(:product_id)).page(params[:page])
  end










  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :profile)
  end

  def item_params
    params.require(:product).permit(:name,:description,:price,:category_id,:image1,:image2,:image3)
  end
  

  #ユーザープロファイルのアップデート
  def update_profile(new_user_params)
    upload_file = params[:user][:image]
    update_image_profile(upload_file,new_user_params)
  end
  
  #ユーザーのイメージのアップデート処理
  #シンボルを渡したい場合はどうすれば良いか？ 現在はitemとuser_paramsの両方に対応している　
  #プロファイルの中のイメージ画像をアップデートする
  def update_image_profile(file,new_params)
    if upload_image(file)
      current_user.update(new_params.merge({image: file.original_filename}))
    else
      current_user.update(new_params)
    end
  end


  #出品した商品のイメージをアップロードする
  def upload_image_item(image_files)
    new_params=image_files
    #imageは実際の画像なのでファイルネームを取り出したい。
    #image_files.each do |image|
      # type="image"であるもののnameの配列を受け取る
      # ["image1", "image2", "image3"]
      # names.eachでnameごとに if upload_image(name)
      # アップロード成功時にはmerge用のハッシュに要素を追加する
      # each終了後にupdate(new_params.merge(merge用のハッシュ))
      #if upload_image(image)
        #アップロードに成功
        #この処理を:image1,:image2,:image3で繰り返し行いたい
        #new_params.merge({image1: image.original_filename})
      #else
        #アップロードに失敗
      #end
    #end
    
    if upload_image(image_files[:image1])
      new_params[:image1]=image_files[:image1].original_filename
    end
    
    if upload_image(image_files[:image2])
      new_params[:image2]=image_files[:image2].original_filename
    end
    
    if upload_image(image_files[:image3])
      new_params[:image3]=image_files[:image3].original_filename
    end
    
    return new_params
  
  end 
  

  def upload_image(file)
    upload_file=file
    if upload_file.present?
      #画像があった場合はこの中の処理が実行される
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
  
  
  def sort_item(sort_num)
    
    if sort_num == "1"
      #byebug
      return Product.all.order("price desc").page(params[:page])
    elsif sort_num == "2"
      return Product.all.order("price asc").page(params[:page])
    elsif sort_num == "3"
      return Product.all.order("created_at desc").page(params[:page])
    else
      return Product.all.order("created_at asc").page(params[:page])
    end
  end

  
end