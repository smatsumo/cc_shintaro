arrays = Array.new  # 一行ずつ格納するための配列を準備
str=""
# ファイル読み込み
for i in 1..100 do
    if i%10==0
        str=sprintf(str+" "+i.to_s)
        arrays.push(str)
        str=""
    else
        str=sprintf(str+" "+i.to_s)
    end
end
 
# ファイル書き込み
file_w = File.open("try1.txt", "w")
arrays.each do |arr|
  file_w.puts(arr)
end