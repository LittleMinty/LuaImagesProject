local pngEncoder = require("encoder/pngencoder")

--file path for storing
local filename = "003"
local imgFilePath = "results/".. filename..".png"

--Image data function
function colorFunction( w , h )
	pixelData = {}
	local halfW,halfH = w/2 , h/2
	local FDFC = math.sqrt((w-halfW)^2+(h-halfH)^2)
	local r_2 = 32
	local r_3 = 86
	for y = 1 , h , 1 do
		for x = 1 , w , 1 do
			--Change this to change the image content
			local distC = math.sqrt(((x-halfW)^2 + (y-halfH)^2))
			
			local r = (distC / FDFC) * 255 
			local g = (distC/FDFC)*255
			local b = (1-(distC/FDFC))*255
			local a = 255
			if distC < r_2 then
				g = (1-(distC/FDFC))*255
				b = 255-g
			elseif distC > r_3 then
				b = distC/FDFC*255
				g = 255-b
			end
			local color = { r , g , b, a }
			table.insert(pixelData , color)
			end
		end
	return pixelData
end

--Makes the image object and returns it
--Never changes unless the encoding mode needs to change
function createImage(data , w , h )
	local img = pngEncoder(w,h , "rgba")
	for i , v in ipairs(data) do
    img:write(v)
		end
	return img
end


function main()
	--Setting width and height of image
	local width , height = 600 , 600
	
	--Inputting image data into a table 
	data = colorFunction( width , height)
	
	--Making an image object based on image data
	--Storing it in variable data because I'm not using it for anything else
	data = createImage(data , width , height)
	
	--Image check
	assert(data.done)
	
	--Storing image
	local binary = table.concat(data.output)
	local file = assert(io.open(imgFilePath , "wb"))
	file:write(binary)
	file:close()
	
	--Using pngout.exe to compress the PNG
	--I have PNGOUT.exe in my system PATH
	if os.execute("pngout "..imgFilePath.." ".."results/"..filename.."-v.png") then
		print("pngout executed")
	else 
		print("PNGOUT isn't recognized")
	end
	return
end

main()