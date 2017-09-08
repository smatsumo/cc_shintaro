str=""
for i in 1..100
    if i%10==0
        str=str+i.to_s
        puts(str)
        str=""
    else
        str=str+i.to_s+" "
    end
end
