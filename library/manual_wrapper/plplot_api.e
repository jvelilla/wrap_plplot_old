note

	description: "PLPLOT API based on Eiffel Wrapper Generator code."
	generator: "Eiffel Wrapper Generator"
	eis: "name=PLPLOT API",  "src=http://plplot.sourceforge.net/doxygen/html/namespaceplplot.html", "protocol=uri"


class PLPLOT_API

inherit

	PLPLOT_FUNCTIONS_API
		rename
			plline as plline_api,
			plstring as plstring_api,
			plpoin as plpoin_api,
			plhist as plhist_api,
			plsym as plsym_api,
			plscmap1l as plscmap1l_api,
			plcont as plcont_api,
			plmesh as plmesh_api,
			plot3d as plot3d_api,
			plmeshc as plmeshc_api,
			plfill as plfill_api,
			plfill3 as plfill3_api,
			plshade as plshade_api,
			plpat as plpat_api,
			plline3 as plline3_api,
			plshades as plshades_api,
			plcolorbar as plcolorbar_api,
			plstripc as plstripc_api,
			plstring3 as plstring3_api,
			plpoly3 as plpoly3_api,
			plmap as plmap_api,
			plmapfill as plmapfill_api,
			plmapline as plmapline_api,
			plimage as plimage_api,
			pl_static2d_grid as pl_static2d_grid_api
		end

feature -- Access

	initialize
		do
			plinit
		end

	finalize
		do
			plend
		end

	plline (x: ARRAY [REAL_64]; y: ARRAY [REAL_64])
		require
			arrays_same_length: x.count = y.count
		do
			plline_api (x.count, x.area.base_address, y.area.base_address)
		end

	plline3 (x: ARRAY [REAL_64]; y: ARRAY [REAL_64]; z: ARRAY [REAL_64])
		require
			arrays_same_length: x.count = y.count and x.count = z.count
		do
			c_plline3 (x.count, x.area.base_address, y.area.base_address, z.area.base_address)
		end

	plpoin (x: ARRAY [REAL_64]; y: ARRAY [REAL_64]; code: INTEGER)
		require
			arrays_same_length: x.count = y.count
		do
			c_plpoin (x.count, x.area.base_address, y.area.base_address, code)
		end

	 has_pl_have_nanosleep: BOOLEAN
		external
			"C inline use <plplot.h>"
		alias
			"[
				#ifdef PL_HAVE_NANOSLEEP
					return (EIF_BOOLEAN) 1
				#else
					return (EIF_BOOLEAN) 0
				#endif
			]"
		end

	plscmap0 (r: ARRAY [INTEGER]; g: ARRAY [INTEGER]; b: ARRAY [INTEGER]; ncol0: INTEGER)
		local
		do
			c_plscmap0 (r.area.base_address, g.area.base_address, b.area.base_address, ncol0)
		end


	pllegend (
				p_legend_width: POINTER; p_legend_height: POINTER; opt: INTEGER;
				position: INTEGER; x: REAL_64; y: REAL_64; plot_width: REAL_64;
				bg_color: INTEGER; bb_color: INTEGER; bb_style: INTEGER; nrow: INTEGER;
				ncolumn: INTEGER; nlegend: INTEGER; opt_array: ARRAY [INTEGER]; text_offset: REAL_64;
				text_scale: REAL_64; text_spacing: REAL_64; text_justification: REAL_64;
				text_colors: ARRAY [INTEGER]; text: ARRAY [STRING]; box_colors: POINTER; box_patterns: POINTER;
				box_scales: POINTER; box_line_widths: POINTER; line_colors: ARRAY [INTEGER]; line_styles: ARRAY [INTEGER];
				line_widths: ARRAY [REAL_64]; symbol_colors: ARRAY [INTEGER]; symbol_scales: ARRAY [REAL_64]; symbol_numbers: ARRAY [INTEGER]; symbols: ARRAY [STRING])
		local
			l_text: MANAGED_POINTER
			l_symbols:  MANAGED_POINTER
			i: INTEGER
		do
			create l_text.make (text.count * 8)
			i := 0
			across text as ic  loop
				l_text.put_pointer (ic.item.area.base_address, i)
				i := i + 8
			end

			create l_symbols.make (symbols.count * 8)
			i := 0
			across text as ic  loop
				l_symbols.put_pointer (ic.item.area.base_address, i)
				i := i + 8
			end


			c_pllegend (
						p_legend_width, p_legend_height, opt, position,
						x, y, plot_width, bg_color, bb_color, bb_style,
						nrow, ncolumn, nlegend, opt_array.area.base_address, text_offset,
						text_scale, text_spacing, text_justification, text_colors.area.base_address,
						l_text.item, box_colors, box_patterns,
						box_scales, box_line_widths, line_colors.area.base_address, line_styles.area.base_address,
						line_widths.area.base_address, symbol_colors.area.base_address, symbol_scales.area.base_address, symbol_numbers.area.base_address,
						l_symbols.item)
		end

	plstring (x: ARRAY [REAL_64]; y: ARRAY [REAL_64]; string: STRING)
		require
			arrays_same_length: x.count = y.count
		do
			plstring_api (x.count, x.area.base_address, y.area.base_address, string)
		end


	plhist (data: ARRAY [REAL_64]; datmin: REAL_64; datmax: REAL_64; nbin: INTEGER; opt: INTEGER)
		do
			plhist_api (data.count, data.area.base_address, datmin, datmax, nbin, opt)
		end

	plsym ( x: ARRAY [REAL_64]; y: ARRAY [REAL_64]; code: INTEGER)
		require
			arrays_same_length: x.count = y.count
		do
			plsym_api (x.count, x.area.base_address, y.area.base_address, code)
		end

	plscmap1l (itype: INTEGER; npts: INTEGER; intensity: ARRAY [REAL_64]; coord1: ARRAY [REAL_64]; coord2: ARRAY [REAL_64]; coord3: ARRAY [REAL_64]; alt_hue_path: ARRAY [BOOLEAN])
		do
			if alt_hue_path.is_empty  then
				plscmap1l_api (itype, npts, intensity.area.base_address, coord1.area.base_address, coord2.area.base_address, coord3.area.base_address, default_pointer)
			else
				plscmap1l_api (itype, npts, intensity.area.base_address, coord1.area.base_address, coord2.area.base_address, coord3.area.base_address, alt_hue_path.area.base_address)
			end
		end

	plsurf3d (x: ARRAY [REAL_64]; y: ARRAY [REAL_64]; z: PLPLOT_GRID2; nx: INTEGER; ny: INTEGER; opt: INTEGER; clevel: ARRAY [REAL_64]; nlevel: INTEGER)
		do
			if clevel.is_empty then
				c_plsurf3d (x.area.base_address, y.area.base_address, z.pointer, nx, ny, opt, default_pointer, nlevel)
			else
				c_plsurf3d (x.area.base_address, y.area.base_address, z.pointer, nx, ny, opt, clevel.area.base_address, nlevel)
			end

		end

	plsurf3dl (x: ARRAY [REAL_64]; y: ARRAY [REAL_64]; z: PLPLOT_GRID2; nx: INTEGER; ny: INTEGER; opt: INTEGER; clevel: ARRAY [REAL_64]; nlevel: INTEGER; indexxmin: INTEGER; indexxmax: INTEGER; indexymin: ARRAY [INTEGER]; indexymax: ARRAY [INTEGER])
		do
			if clevel.is_empty then
				c_plsurf3dl (x.area.base_address, y.area.base_address, z.pointer, nx, ny, opt, default_pointer, nlevel,indexxmin, indexxmax, indexymin.area.base_address, indexymax.area.base_address)
			else
				c_plsurf3dl (x.area.base_address, y.area.base_address, z.pointer, nx, ny, opt, clevel.area.base_address, nlevel,indexxmin, indexxmax, indexymin.area.base_address, indexymax.area.base_address)
			end
		end


	plcont (f: PLPLOT_GRID2; nx: INTEGER; ny: INTEGER; kx: INTEGER; lx: INTEGER; ky: INTEGER; ly: INTEGER; clevel: ARRAY [REAL_64]; nlevel: INTEGER; pltr: POINTER; pltr_data: POINTER)
		do
			c_plcont (f.pointer, nx, ny, kx, lx, ky, ly, clevel.area.base_address, nlevel, pltr, pltr_data)
		end


	plmesh (x: ARRAY [REAL_64]; y: ARRAY [REAL_64]; z: PLPLOT_GRID2; nx: INTEGER; ny: INTEGER; opt: INTEGER)
		do
			plmesh_api (x.area.base_address, y.area.base_address, z.pointer, nx, ny, opt)
		end

	plot3d (x: ARRAY [REAL_64]; y: ARRAY [REAL_64]; z: PLPLOT_GRID2; nx: INTEGER; ny: INTEGER; opt: INTEGER; side: INTEGER)
		do
			plot3d_api (x.area.base_address, y.area.base_address, z.pointer, nx, ny, opt, side)
		end

	plmeshc (x: ARRAY [REAL_64]; y: ARRAY [REAL_64]; z: PLPLOT_GRID2; nx: INTEGER; ny: INTEGER; opt: INTEGER; clevel: ARRAY [REAL_64]; nlevel: INTEGER)
		do
			plmeshc_api (x.area.base_address, y.area.base_address, z.pointer, nx, ny, opt, clevel.area.base_address, nlevel)
		end

	plfill (x: ARRAY [REAL_64]; y: ARRAY [REAL_64])
		require
			arrays_same_length: x.count = y.count
		do
			plfill_api (x.count, x.area.base_address, y.area.base_address)
		end

	plfill3 (x: ARRAY [REAL_64]; y: ARRAY [REAL_64]; z: ARRAY [REAL_64])
		require
			arrays_same_length: x.count = y.count and x.count = z.count
		do
			c_plfill3 (x.count, x.area.base_address, y.area.base_address, z.area.base_address)
		end

--	pl_static2d_grid (ziliffe: ARRAY [REAL_64]; z_static: PLPLOT_GRID2; nx: INTEGER; ny: INTEGER)
--		do
--			c_pl_static2d_grid (ziliffe.area.base_address, z_static.pointer, nx, ny)
--		end

--	pl_min_max2d_grid (ziliffe: ARRAY [REAL_64]; nx: INTEGER; ny: INTEGER; fmax: POINTER; fmin: POINTER)
--		do
--			c_pl_min_max2d_grid (ziliffe.area.base_address, nx, ny, fmax, fmin)
--		end

	plshade (a: PLPLOT_GRID2; nx: INTEGER; ny: INTEGER;
				defined: POINTER; xmin: REAL_64; xmax: REAL_64;
				ymin: REAL_64; ymax: REAL_64; shade_min: REAL_64;
				shade_max: REAL_64; sh_cmap: INTEGER; sh_color: REAL_64;
				sh_width: REAL_64; min_color: INTEGER; min_width: REAL_64;
				max_color: INTEGER; max_width: REAL_64; fill: POINTER;
				rectangular: INTEGER; pltr: POINTER; pltr_data: POINTER)
		do
			c_plshade (a.pointer, nx, ny, defined, xmin, xmax, ymin, ymax, shade_min, shade_max, sh_cmap, sh_color, sh_width, min_color, min_width, max_color, max_width, fill, rectangular, pltr, pltr_data)
		end


	pl_static2d_grid (ziliffe: ARRAY [REAL_64]; zstatic: PLPLOT_GRID2; nx, ny: INTEGER ): PLPLOT_GRID2
		do
			c_pl_static2d_grid (ziliffe.area.base_address, zstatic.base_address, nx, ny);
			create Result.make_by_pointer (ziliffe.area.base_address, nx, ny)
		end

	plpat (nlin: INTEGER; inc: ARRAY [INTEGER]; del: ARRAY [INTEGER])
		do
			c_plpat (nlin, inc.area.base_address, del.area.base_address)
		end

	plshades (a: PLPLOT_GRID2; nx: INTEGER; ny: INTEGER; defined: POINTER; xmin: REAL_64;
				xmax: REAL_64; ymin: REAL_64; ymax: REAL_64; clevel: ARRAY [REAL_64];
				nlevel: INTEGER; fill_width: REAL_64; cont_color: INTEGER; cont_width: REAL_64;
				fill: POINTER; rectangular: INTEGER; pltr: POINTER; pltr_data: detachable PLC_GRID2)
		do
			if attached pltr_data then
				c_plshades (a.pointer, nx, ny, defined, xmin, xmax, ymin, ymax, clevel.area.base_address, nlevel, fill_width, cont_color, cont_width, fill, rectangular, pltr, pltr_data.pointer)
			else
				c_plshades (a.pointer, nx, ny, defined, xmin, xmax, ymin, ymax, clevel.area.base_address, nlevel, fill_width, cont_color, cont_width, fill, rectangular, pltr, default_pointer)
			end

		end

	plcolorbar (p_colorbar_width: POINTER; p_colorbar_height: POINTER; opt: INTEGER; position: INTEGER;
				x: REAL_64; y: REAL_64; x_length: REAL_64; y_length: REAL_64; bg_color: INTEGER;
				bb_color: INTEGER; bb_style: INTEGER; low_cap_color: REAL_64; high_cap_color: REAL_64;
				cont_color: INTEGER; cont_width: REAL_64; n_labels: INTEGER; label_opts: POINTER;
				labels: ARRAY [STRING]; n_axes: INTEGER; axis_opts: ARRAY [STRING]; ticks: ARRAY [REAL_64]
				sub_ticks: ARRAY [INTEGER]; n_values: ARRAY [INTEGER]; values: POINTER)
		local
			mpl: MANAGED_POINTER
			mpx: MANAGED_POINTER
		do

			create mpl.make (labels.count * {PLATFORM}.pointer_bytes)
			across labels as ic  loop
				mpl.put_pointer ((create {C_STRING}.make (ic.item)).item, (ic.cursor_index - 1)*{PLATFORM}.pointer_bytes)
			end

			create mpx.make (axis_opts.count * {PLATFORM}.pointer_bytes)
			across axis_opts as ic  loop
				mpx.put_pointer ((create {C_STRING}.make (ic.item)).item, (ic.cursor_index - 1)*{PLATFORM}.pointer_bytes)
			end
			c_plcolorbar (p_colorbar_width, p_colorbar_height, opt, position,
							x, y, x_length, y_length, bg_color, bb_color, bb_style,
							low_cap_color, high_cap_color, cont_color, cont_width, n_labels, label_opts,
							mpl.item, n_axes,
							mpx.item, ticks.area.base_address, sub_ticks.area.base_address, n_values.area.base_address, values)
		end


	plsError (errorcode: POINTER; a_string: detachable STRING)
		local
			c_string: C_STRING
		do
			if attached a_string then
				create c_string.make (a_string)
				c_pls_error (errorcode, c_string.item)
				a_string.append (c_string.string)
			else
				c_pls_error (errorcode, default_pointer)
			end
		end

	plstripc (id: POINTER; xspec: STRING; yspec: STRING; xmin: REAL_64;
						xmax: REAL_64; xjump: REAL_64; ymin: REAL_64; ymax: REAL_64;
						xlpos: REAL_64; ylpos: REAL_64; y_ascl: INTEGER; acc: INTEGER;
						colbox: INTEGER; collab: INTEGER; colline: ARRAY [INTEGER];
						styline: ARRAY [INTEGER]; legline: ARRAY [STRING];
						labx: STRING; laby: STRING; labtop: STRING)
		local
			l_xspec: C_STRING
			l_yspec: C_STRING
			l_labx: C_STRING
			l_laby: C_STRING
			l_labtop: C_STRING
			l_legline: MANAGED_POINTER

		do
			create l_xspec.make (xspec)
			create l_yspec.make (yspec)
			create l_labx.make (labx)
			create l_laby.make (laby)
			create l_labtop.make (labtop)


			create l_legline.make (legline.count * {PLATFORM}.pointer_bytes)
			across legline as ic  loop
				l_legline.put_pointer ((create {C_STRING}.make (ic.item)).item, (ic.cursor_index - 1)*{PLATFORM}.pointer_bytes)
			end

			c_plstripc (id,l_xspec.item, l_yspec.item, xmin,
						xmax, xjump, ymin, ymax,
						xlpos, ylpos, y_ascl, acc,
						colbox, collab, colline.area.base_address,
						styline.area.base_address, l_legline.item,
						l_labx.item, l_laby.item, l_labtop.item)
		end

	plstring3 (x: ARRAY [REAL_64]; y: ARRAY [REAL_64]; z: ARRAY [REAL_64]; string: STRING)
		require
			arrays_same_length: x.count = y.count and x.count = z.count
		do
			plstring3_api (x.count, x.area.base_address, y.area.base_address, z.area.base_address,  string)
		end

	plpoly3 (x: ARRAY [REAL_64]; y: ARRAY [REAL_64]; z: ARRAY[REAL_64]; draw: ARRAY [INTEGER]; ifcc: INTEGER)
		require
			arrays_same_length: x.count = y.count and x.count = z.count
			draw_same_length_xyx_arrays_minus_one:  x.count - 1 = draw.count
		do
			plpoly3_api (x.count, x.area.base_address, y.area.base_address, z.area.base_address, draw.area.base_address, ifcc)
		end

	plmap (mapform: POINTER; name: STRING; minx: REAL_64; maxx: REAL_64; miny: REAL_64; maxy: REAL_64)
		do
			c_plmap (mapform, name.area.base_address, minx, maxx, miny, maxy)
		end

	plmapfill (mapform: POINTER; name: STRING; minx: REAL_64; maxx: REAL_64; miny: REAL_64; maxy: REAL_64; plotentries: ARRAY [INTEGER]; nplotentries: INTEGER)
		do
			plmapfill_api (mapform, name, minx, maxx, miny, maxy, plotentries.area.base_address, nplotentries)
		end

	plmapline (mapform: POINTER; name: STRING; minx: REAL_64; maxx: REAL_64; miny: REAL_64; maxy: REAL_64; plotentries: ARRAY [INTEGER]; nplotentries: INTEGER)
		do
			c_plmapline (mapform,  (create {C_STRING}.make (name)).item, minx, maxx, miny, maxy, plotentries.area.base_address, nplotentries)
		end


	plimage (idata: PLPLOT_GRID2; nx: INTEGER; ny: INTEGER; xmin: REAL_64; xmax: REAL_64; ymin: REAL_64; ymax: REAL_64; zmin: REAL_64; zmax: REAL_64; dxmin: REAL_64; dxmax: REAL_64; dymin: REAL_64; dymax: REAL_64)
		do
			c_plimage (idata.pointer, nx, ny, xmin, xmax, ymin, ymax, zmin, zmax, dxmin, dxmax, dymin, dymax)
		end

feature -- C function address: Transformation routines

	pltr0_address: POINTER
				-- Address of C function `pltr0'.
				-- Identity transformation.
			external
				"C inline use <plplot.h>"
			alias
				"return (void*) pltr0"
			end

	pltr1_address: POINTER
				-- Address of C function `pltr1'.
				-- Does linear interpolation from singly dimensioned coord arrays.
			external
				"C inline use <plplot.h>"
			alias
				"return (void*) pltr1"
			end

	pltr2_address: POINTER
				-- Address of C function `pltr2'.
				-- Does linear interpolation from doubly dimensioned coord arrays
				-- (column dominant, as per normal C 2d arrays).
			external
				"C inline use <plplot.h>"
			alias
				"return (void*) pltr2"
			end

	pltr2p_address: POINTER
				-- Address of C function `pltr2p'.
				-- Just like pltr2() but uses pointer arithmetic to get coordinates from
				-- 2d grid tables.
			external
				"C inline use <plplot.h>"
			alias
				"return (void*) pltr2p"
			end

	pltr2f_address: POINTER
				-- Address of C function `pltr2f'.
				-- Does linear interpolation from doubly dimensioned coord arrays
				-- (row dominant, i.e. Fortran ordering).
			external
				"C inline use <plplot.h>"
			alias
				"return (void*) pltr2f"
			end

	plfill_address: POINTER
				-- Address of C function `plfill'.
				-- Pattern fills the polygon bounded by the input points.
			external
				"C inline use <plplot.h>"
			alias
				"return (void*) plfill"
			end


feature -- {NONE}

end
