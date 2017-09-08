file = File.open("read_file.txt", "r")
=begin
一気にファイルを読み込むので処理速度が遅い
f=file.read
puts(f)
file.close



file = File.open("read_file.txt", "r")
file.each_line do |line|
    printf("%4d : ", file.lineno)
    puts(line)
end
file.close

# ファイル書き込み
file_w = File.open("write_file.txt", "w")
file_w.puts("test")
file.close
=end


arrays = Array.new  # 一行ずつ格納するための配列を準備
 
# ファイル読み込み
file = File.open("read_file.txt", "r")
file.each_line do |line|
  str = sprintf("%4d : " + line, file.lineno) # 行番号をつけた文字列を作成
  arrays.push(str)  # 行番号のついた文字列を配列に格納
end
file.close
 
# ファイル書き込み
file_w = File.open("write_file.txt", "w")
arrays.each do |arr|
  file_w.puts(arr)
end
