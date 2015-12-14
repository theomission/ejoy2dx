
local simple_ui = require "ejoy2dx.simple_ui"

local defalut_cell_width = 110
local defalut_cell_height = 30
local defalut_cell_frame_color = 0xFF669977
local defalut_cell_color = 0xFF666666
local default_font_size = 16
local default_font_y_offset = (defalut_cell_height - default_font_size)/2

local row_mt = {}
row_mt.__index = row_mt

function row_mt:init()
	self.cells = {}
	for k, v in ipairs(self.data) do
		local cell = simple_ui.panel(self.parent.root)
		local x = (k-1) * defalut_cell_width
		local y = self.index * defalut_cell_height
		cell:add_control("frame", x, y,
			defalut_cell_width, defalut_cell_height, defalut_cell_color, 1)
		cell:add_control("label", v, x+defalut_cell_width/2, y+default_font_y_offset,
			0,default_font_size,0xFFFFFFFF, true)
		table.insert(self.cells, cell)
	end
end

----------------------------------------------------------------------------

local grid_mt = {}
grid_mt.__index = grid_mt

function grid_mt:init()
end

function grid_mt:set_title(titles)
	self.titles = {}

	for k, v in ipairs(titles) do
		local cell = simple_ui.panel(self.root)
		table.insert(self.titles, cell)
		local x = (k-1)*defalut_cell_width
		cell:add_control("frame", x, 0, 
			defalut_cell_width, defalut_cell_height, defalut_cell_frame_color,2)
		cell:add_control("label", v,x+defalut_cell_width/2,default_font_y_offset,
			0,default_font_size,0xFF00FF00,true)
		table.insert(self.titles, cell)
	end
end

function grid_mt:add_row(data)
	local row = setmetatable({data=data, parent=self, index=#self.rows+1}, row_mt)
	row:init()
	table.insert(self.rows, row)
end

function grid_mt:show()
	self.root:show()
end

function grid_mt:hide()
	self.root:hide()
end

function grid_mt:position( ... )
	self.root:position(...)
end

function grid_mt:scale( ... )
	self.root:scale(...)
end

return function(layer, titles)
	local root = simple_ui.panel(layer)
	local ret = setmetatable({root=root, rows={}}, grid_mt)
	ret:set_title(titles)
	return ret
end