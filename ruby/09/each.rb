list = [1,2,3,4,5]
sum = 0
list.each do |elem|
  sum += elem       # sum = sum + elem と同じ処理です
  print(elem)
  puts("を足します")
end
puts("合計は")
puts(sum)
puts("です")