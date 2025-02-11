local pngEncoder = require("encoder/pngencoder")


function colorFunction( w , h )
	pixelData = {}
	for col = 1 , h , 1 do
		local temp = {}
		for row = 1 , w , 1 do 
			local r = math.floor(255/2) 
			local g = math.floor(255/2)
			local b = math.floor(255/2)
			local a = 255
			local color = { r , g , b,a}
			table.insert(temp , color)
			end
		table.insert(pixelData , temp)
		end
	return pixelData
end

function createImage(data , w , h )
	local img = pngEncoder(w,h , "rgba")
	for i , v in ipairs(data) do
		for j , x in ipairs(v) do
			img:write(x)
			end
		end
	return img
end

function main()
	local width , height = 64 , 64
	data = colorFunction( width , height)
	data = createImage(data , width , height)
	assert(data.done)
	local binary = table.concat(data.output)
	local file = assert(io.open("results/" .. "001.png" , "wb"))
	file:write(binary)
	file:close()
	return
end

main()