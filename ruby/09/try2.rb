=begin
配列内の要素の個数を表示
先頭に「池田」を追加
末尾に「米田」を追加
先頭「池田」の要素を削除
3番目の要素を「高橋」に変更
配列内の要素の順番を逆順にする
=end
classmates =  ["鈴木", "佐藤", "斎藤", "伊藤", "杉内"]
puts(classmates.size)
classmates.unshift("池田")
print(classmates)
puts()
classmates.push("米田")
print(classmates)
puts()
classmates.delete("池田")
print(classmates)
puts()
classmates[2]="高橋"
print(classmates)
puts()
print(classmates.reverse)