classmates = {
  "ガリ勉" => "鈴木",
  "委員長" => "佐藤",
  "セレブ" => "斎藤",
  "メガネ" => "伊藤",
  "女神"  => "杉内"
}
classmates["委員長"] = "加藤"  # キーが「委員長」の要素を更新
puts(classmates)

classmates = {
  "ガリ勉" => "鈴木",
  "委員長" => "佐藤",
  "セレブ" => "斎藤",
  "メガネ" => "伊藤",
  "女神"  => "杉内"
}
classmates["スポーツマン"] = "加藤"  # キーが「スポーツマン」の要素を追加
puts(classmates)


classmates = {
  suzuki: "鈴木",
  satou: "佐藤",
  saitou: "斎藤",
  itou: "伊藤",
  sugiuchi: "杉内"
}
puts(classmates[:suzuki])
