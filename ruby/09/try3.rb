=begin
配列オブジェクトのeachメソッドを利用して、各要素の苗字に「さん」をつけて出力するプログラムを作成しましょう。
=end
classmates = ["鈴木", "佐藤", "斎藤", "伊藤", "杉内"]

classmates.each do |name|
    puts(name+"さん")
end