=begin
3で割り切れる場合は「Fizz」を出力
5で割り切れる場合は「Buzz」を出力
3でも5でも割り切れる場合は「FizzBuzz」を出力
上記以外は数値をそのまま出力
=end

for i in 1..100
    if i%3==0&&i%5==0
        puts("FizzBuzz")
    elsif i%3==0
        puts("Fizz")
    elsif i%5==0
        puts("Buzz")
    else
        puts(i.to_s)
    end
end
