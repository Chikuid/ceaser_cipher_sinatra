require 'sinatra'
require 'sinatra/reloader' if development?

get '/' do

	input = params["input"]
	direction = params["direction"]
	key = params["key"].to_i
	output = caesar_cipher(input,key,direction)

	erb :index, :locals => {:output => output}
end

def shift_is_real(x,y,n) 
#x = char to be shifted
#y = l/L for left shift r/R for right shift
#n = how much shift we want
	if(y=="L"||y=="l")
		if(x>='a' && x<='z')
			temp= x.ord-'a'.ord
			if(temp<n)
				x=(x.ord+(26-n)).chr
			elsif 				
				x=(x.ord-n).chr
			end
		elsif(x>='A' && x<='z')
			temp= x.ord-'A'.ord
			if(temp<n)
				x=(x.ord+(26-n)).chr
			elsif
				x=(x.ord-n).chr
			end
		end
	elsif(y=="R"||y=="r")
		if(x>='a' && x<='z')
			temp= 'z'.ord-x.ord
			if(temp>=n)
				x=(x.ord+n).chr
			elsif
				x=(x.ord-(26-n)).chr
			end
		elsif(x>='A' && x<='Z')
			temp= 'Z'.ord-x.ord
			if(temp>=n)
				x=(x.ord+n).chr
			elsif
				x=(x.ord-(26-n)).chr
			end
		end
	end
	return x
end
def caesar_cipher(input,shift_amount,shift_direction="r")
intput_array=input.scan(/\w/).uniq
#.uniq is used becaue this array is later used to calculate a hash for referring rather than shifting same letters again and again
h=Hash.new 
#Key - character befor shifting, Value - Character after shifting
#Hash is used so we dont calculate value after shifting for same letter multiple times
intput_array.each {|element| 

	h[element]= shift_is_real(element,shift_direction,shift_amount)
}
#value stored in hash now
output = input.scan(/./).collect{|element|
if h.key?(element)
	h[element]
else
	element
end
}.join

output 
end


