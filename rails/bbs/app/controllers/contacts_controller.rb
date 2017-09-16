class ContactsController < ApplicationController
  def ask
    @errors = []
  end
  def create
     #エラー文を格納するための配列
      @errors = []
      # 名前の空チェック
      if params[:name].empty?
        @errors << '名前が未入力です。'
      end
      # メールアドレスの空チェック
      if params[:email].empty?
        @errors << 'メールアドレスが未入力です。'
      end
      #　問い合わせ内容の空チェック
      if params[:ask].empty?
        @errors << '問い合わせ内容が未入力です。'
      end
      
      # つぶやき内容の文字数チェック
      if params[:ask].length > 500
        @errors << '問い合わせ内容は500文字以内で入力して下さい。'
      end
      # エラーがあったら新規投稿ページを表示する
      if @errors.present?
        render 'ask' and return
      end
     
      #CSVファイルに書き込み
      #csv = CSV.open('tmp/contacts.csv', 'a')
      #time = Time.now
      #csv.puts([params[:name], params[:email],params[:ask],time.strftime('%Y/%m/%d %H:%M:%S') ])
      #csv.close
      @contact = Contact.new(name: params[:name], email: params[:email], contact: params[:ask])
      if @contact.save
        redirect_to('/')
      else
        render 'ask' and return
      end
      
    end
end
