class PostsController < ApplicationController
  before_action :authorize
  # 新規投稿ページ
  def new
    @post = Post.new
  end
  
  # 投稿処理
  def create
    # パラメータ受け取り
    #モデルのインスタンス化をしている
    @post = Post.new(post_params)
    #upload_fileはviewから来ている、postはどこから？
    upload_file = params[:post][:upload_file]
    # 投稿画像がない場合
    if upload_file.blank?
      flash[:danger] = "投稿には画像が必須です。"
      redirect_to new_post_path and return
    end
    upload_file_name = upload_file.original_filename
    output_dir = Rails.root.join('public', 'images')
    output_path = output_dir + upload_file_name
    File.open(output_path, 'w+b') do |f|
      f.write(upload_file.read)
    end
    
    # post_imagesテーブルに登録するファイル名をPostインスタンスに格納
    @post.post_images.new(name: upload_file_name)
    # データベースに保存
    if @post.save
      #セーブに成功した時にどう処理すれば良いのか分からない。
      flash[:notice] = "投稿に成功しました。"
      redirect_to new_post_path and return
    else
      flash[:danger] = "投稿に失敗しました。"
      redirect_to new_post_path and return
    end
  end
  
  # 投稿を削除
  def destroy
    @post = Post.find(params[:id])
    #post.destroyの戻り値を簡単に調べる方法が分からない。
    if @post.destroy
      #削除成功メッセージを入れる
      flash[:notice] = "削除に成功しました。"
      redirect_to top_path and return
    else
      flash[:danger] = "削除に失敗しました。"
      redirect_to new_post_path and return
    end
  end
  
  # いいね処理
  def like
    user=current_user
    @post = Post.find(params[:id])
    if PostLike.exists?(post_id: @post.id, user_id: current_user.id)
      # いいねを削除
      PostLike.find_by(post_id: @post.id, user_id: current_user.id).destroy
      redirect_to top_path and return
    else
      # いいねを登録
      PostLike.create(post_id: @post.id, user_id: current_user.id)
      redirect_to top_path and return
    end
  end


  
  # コメント投稿処理
  def comment
    # 投稿IDを受け取り、投稿データを取得
    @post = Post.find(params[:id])
   
    # コメント保存
    @post.post_comments.create(post_comment_params)
  end
  
  
  
  
  
  
  private
  def post_params
    #params.require(:post).permit(:caption)
    params.require(:post).permit(:caption).merge(user_id: current_user.id)
  end
  
  # コメント用パラメータを取得 試しにprivateで定義中
  def post_comment_params
    params.require(:post_comment).permit(:comment).merge(user_id: current_user.id)
  end

end
