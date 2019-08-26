note
	description: "PLcGrid2 is for passing (as arrays of pointers) 2d coordinate transformation arrays."
	date: "$Date$"
	revision: "$Revision$"

class
	PLC_GRID2

create
	make

feature

	make (a_rows: INTEGER; a_columns: INTEGER)
			-- Create 2d coordinates transformation arrays with
			-- grid dimensions `a_row` for nx and `a_columns` for ny. 	
		do
			create plc_grid2.make
			nx := a_rows
			ny := a_columns
			create xg_impl.make (nx, ny)
			create yg_impl.make (nx, ny)
			create zg_impl.make_empty
			plc_grid2.set_xg (xg.pointer)
			plc_grid2.set_yg (yg.pointer)
			plc_grid2.set_nx (nx)
			plc_grid2.set_ny (ny)
		ensure
			nx_set: nx = a_rows
			ny_set: ny = a_columns
		end

feature -- Access

	xg: PLPLOT_GRID2
			-- x grid.
		do
			Result := xg_impl
		end

	yg: PLPLOT_GRID2
			-- y grid.
		do
			Result := yg_impl
		end

	zg: PLPLOT_GRID2
			-- z grid.	
		do
			Result := zg_impl
		end


	nx: INTEGER
		-- Size of the grid in x.

	ny: INTEGER
		-- Size of the grid in y.


	pointer: POINTER
		do
			Result := plc_grid2.item
		end

feature -- Change Element

	set_xg (a: PLPLOT_GRID2)
		require
			valid_rows: a.rows = nx
			valid_columns: a.columns = ny
		do
			xg_impl := a
			plc_grid2.set_xg (xg_impl.pointer)
		end

	set_yg (a: PLPLOT_GRID2)
		require
			valid_rows: a.rows = nx
			valid_columns: a.columns = ny
		do
			yg_impl := a
			plc_grid2.set_yg (yg_impl.pointer)
		end

	set_zg (a: PLPLOT_GRID2)
		require
			valid_rows: a.rows = nx
			valid_columns: a.columns = ny
		do
			zg_impl := a
			plc_grid2.set_zg (zg_impl.pointer)
		end

feature {NONE} -- Implementation

	plc_grid2: PLC_GRID2_STRUCT_API
		-- C plc struct wrapper.


	xg_impl: PLPLOT_GRID2
		-- x grid.

	yg_impl: PLPLOT_GRID2
		-- y grid.

	zg_impl: PLPLOT_GRID2
		-- z grid.	

end
