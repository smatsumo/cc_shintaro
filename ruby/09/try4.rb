=begin
try4.rb」というファイルを新規作成し、1~10までの数値の配列を用意して、そのすべての合計値をeachを使って計算してみましょう。
=end
res=0
nums=[1,2,3,4,5,6,7,8,9,10]

nums.each do |n|
    res=res+n
end

puts(res)