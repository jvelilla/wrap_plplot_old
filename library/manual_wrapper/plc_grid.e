note
	description: "[
		PLcGrid is for passing (as a pointer to the first element) arbitrarily	
		dimensioned coordinate transformation arrays.  The grid dimensions MUST be
		stored, with a maximum of 3 dimensions assumed for now.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	PLC_GRID

create
	make

feature -- Initialization

	make
		do
			create grid.make
			create xg_impl.make_empty
			create yg_impl.make_empty
			create zg_impl.make_empty
		ensure
			xg_set: xg.is_empty
			yg_set: yg.is_empty
			zg_set: zg.is_empty
		end


feature -- Access	

	xg: ARRAY [REAL_64]
		do
			Result := xg_impl
		end

	yg: ARRAY [REAL_64]
		do
			Result := yg_impl
		end

	zg: ARRAY [REAL_64]
		do
			Result := zg_impl
		end

	pointer: POINTER
		do
			Result := grid.item
		end

feature -- Change Element

	set_xg (a: ARRAY [REAL_64])
		do
			xg_impl := a
			grid.set_xg (a.area.base_address)
			grid.set_nx (a.count)
		end

	set_yg (a: ARRAY [REAL_64])
		do
			yg_impl := a
			grid.set_yg (a.area.base_address)
			grid.set_ny (a.count)
		end

	set_zg (a: ARRAY [REAL_64])
		do
			zg_impl := a
			grid.set_zg (a.area.base_address)
			grid.set_nz (a.count)
		end

feature {NONE} -- Implementation

	grid: PLC_GRID_STRUCT_API

	xg_impl: ARRAY [REAL_64]
	yg_impl: ARRAY [REAL_64]
	zg_impl: ARRAY [REAL_64]

end
