class TweetsController < ApplicationController
    require "csv"   # CSVライブラリの読み込み
    def new
        @errors = []
    end
    def create
          # エラー文を格納するための配列
          @errors = []
          # ユーザー名の空チェック
          if params[:name].empty?
            @errors << 'ユーザー名が未入力です。'
          end
          # つぶやき内容の空チェック
          if params[:tweet].empty?
            @errors << 'つぶやき内容が未入力です。'
          end
          # つぶやき内容の文字数チェック
          if params[:tweet].length > 140
            @errors << 'ツイートは140文字以内で入力して下さい。'
          end
          # エラーがあったら新規投稿ページを表示する
          if @errors.present?
            render 'new' and return
          end
        csv = CSV.open('tmp/tweets.csv', 'a')
        time = Time.now 
        csv.puts([params[:name], params[:tweet], time.strftime('%Y/%m/%d %H:%M:%S')]) 
        csv.close
        redirect_to('/')
    end
end
