hash_count={}
file = File.open("try2.txt","r")
file.each do |line|
    line.each_char do |char|
        if(hash_count[char]!=nil)
            hash_count[char]=hash_count[char]+1
        else
            hash_count[char]=1
        end
    end
end

p hash_count.to_a