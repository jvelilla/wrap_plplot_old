note
	description: "Contour plot demo."
	date: "$Date$"
	revision: "$Revision$"
	eis: "name=example 10", "src=http://plplot.sourceforge.net/examples.php?demo=09&lbind=C", "protocol=uri"
class
	EXAMPLE_10

inherit

	PLPLOT_API

create
	make

feature -- Initialization

	make
			-- Does several contour plots using different coordinate mappings.
		local
			xx, yy, argx, argy, distort: REAL_64
			mark, space: INTEGER
			z, w: PLPLOT_GRID2
			xg1, yg1: ARRAY [REAL_64]
			cgrid1: PLC_GRID
			cgrid2: PLC_GRID2
			l_dispatcher: PLTRANSFORM_CALLBACK_DISPATCHER
		do

				-- TODO fix issues, this example does not works as expected.

			mark := 1500
			space := 1500

				-- Initialize Plplot

			initialize

				--	Set up function arrays
			create z.make ( XPTS, YPTS )
			create w.make ( XPTS, YPTS )

			across 0 |..| (XPTS - 1) as i loop
				xx :=  ( i.item - ( XPTS / 2.0 ) ) / ( XPTS / 2.0 )
				across 0 |..| (YPTS - 1) as j loop
					yy := ( j.item - ( YPTS / 2.0 ) ) / ( YPTS / 2.0 ) - 1.0
					z[i.item ,j.item ] := xx * xx - yy * yy
					w[i.item ,j.item] := 2 * xx * yy
				end
			end

				-- Set up grids
			create cgrid2.make (XPTS, YPTS)

			create xg1.make_filled (0.0, 1, XPTS)
			create yg1.make_filled (0.0, 1, YPTS)

			across 0 |..| (XPTS - 1) as i loop
				across 0 |..| (YPTS - 1) as j  loop
					mypltr (i.item , j.item, $xx, $yy, default_pointer )
					argx := xx * {DOUBLE_MATH}.pi / 2
					argy := yy * {DOUBLE_MATH}.pi / 2
					distort := 0.4

					xg1[i.item +1 ] := xx + distort * {DOUBLE_MATH}.cosine( argx );
					yg1[j.item + 1] := yy - distort * {DOUBLE_MATH}.cosine( argy );

					cgrid2.xg[i.item, j.item] := xx + distort * {DOUBLE_MATH}.cosine( argx ) * {DOUBLE_MATH}.cosine( argy );
					cgrid2.yg[i.item, j.item] := yy - distort * {DOUBLE_MATH}.cosine( argx ) * {DOUBLE_MATH}.cosine( argy );

				end
			end
			create cgrid1.make
			cgrid1.set_xg(xg1)
			cgrid1.set_yg(yg1)

				-- Plot using identity transform
			create l_dispatcher.make (agent on_callback)
			pl_setcontlabelformat( 4, 3 )
			pl_setcontlabelparam( 0.006, 0.3, 0.1, 1 )
			plenv( -1.0, 1.0, -1.0, 1.0, 0, 0 )
			plcol0( 2 )
			plcont( z, XPTS, YPTS, 1, XPTS, 1, YPTS, clevel, 11, l_dispatcher.c_dispatcher, default_pointer )
			plstyl( 1, $mark, $space )
			plcol0( 3 )
			plcont( w, XPTS, YPTS, 1, XPTS, 1, YPTS, clevel, 11, l_dispatcher.c_dispatcher, default_pointer )
			plstyl( 0, $mark, $space );
			plcol0( 1 );
			pllab( "X Coordinate", "Y Coordinate", "Streamlines of flow" )
			pl_setcontlabelparam( 0.006, 0.3, 0.1, 0 )

				-- Plot using 1d coordinate transform

		    plenv( -1.0, 1.0, -1.0, 1.0, 0, 0 )
		    plcol0( 2 )
		    plcont( z, XPTS, YPTS, 1, XPTS, 1, YPTS, clevel, 11, pltr1_address, cgrid1.pointer )
		    plstyl( 1, $mark, $space )
		    plcol0( 3 )
		    plcont( w, XPTS, YPTS, 1, XPTS, 1, YPTS, clevel, 11, pltr1_address, cgrid1.pointer )
		    plstyl( 0, $mark, $space )
		    plcol0( 1 )
		    pllab( "X Coordinate", "Y Coordinate", "Streamlines of flow" )

		 		-- Plot using 2d coordinate transform

--		    plenv( -1.0, 1.0, -1.0, 1.0, 0, 0 )
--		    plcol0( 2 );
--		    plcont( z, XPTS, YPTS, 1, XPTS, 1, YPTS, clevel, 11,  pltr2_address, cgrid2.pointer )
--		    plstyl( 1, $mark, $space )
--		    plcol0( 3 )
--		    plcont( w, XPTS, YPTS, 1, XPTS, 1, YPTS, clevel, 11, pltr2_address, cgrid2.pointer )
--		    plstyl( 0, $mark, $space )
--		    plcol0( 1 )
--		    pllab( "X Coordinate", "Y Coordinate", "Streamlines of flow" )

		    pl_setcontlabelparam( 0.006, 0.3, 0.1, 0 )
		    polar
			pl_setcontlabelparam( 0.006, 0.3, 0.1, 0 )
			potential

				--// Clean up

			z.clean
			w.clean
			cgrid2.xg.clean
			cgrid2.yg.clean
			finalize
		end


feature -- Access

	XPTS: INTEGER = 35
		-- Data points in x.

	YPTS: INTEGER = 46
		-- Data points in y.

	XSPA: REAL_64
		do
			Result := 2.0 / ( XPTS - 1 )
		end

	YSPA: REAL_64
		do
			Result := 2.0 / ( YPTS - 1 )
		end

feature -- Polar plot data

	PERIMETERPTS: INTEGER = 100
	RPTS: INTEGER         = 40
	THETAPTS: INTEGER     = 40

feature --Potential plot data

	PPERIMETERPTS: INTEGER =  100
	PRPTS: INTEGER 		   =  40
	PTHETAPTS: INTEGER     =  64
	PNLEVEL: INTEGER       =  20


	clevel: ARRAY [REAL_64]
		do
			Result := {ARRAY [REAL_64]}<< -1.0, -0.8, -0.6, -0.4, -0.2, 0, 0.2, 0.4, 0.6, 0.8, 1.0 >>
		end


feature -- Transformation function

	tr: ARRAY [REAL_64]
		do
			Result := << XSPA, 0.0, -1.0, 0.0, YSPA, -1.0 >>
		end

	mypltr (x: REAL_64; y: REAL_64; tx: POINTER; ty: POINTER; a_data: POINTER)
		local
			l_tx: REAL_64
			l_ty: REAL_64
		do
			l_tx := tr[1] * x + tr[2] * y + tr[3]
			l_ty := tr[4] * x + tr[5] * y + tr[6]
			tx.memory_copy ($l_tx, {PLATFORM}.real_64_bytes)
			ty.memory_copy ($l_tY, {PLATFORM}.real_64_bytes)
		end


	polar
			-- polar contour plot example.
		local
			cgrid2: PLC_GRID2
			z: PLPLOT_GRID2
			px: ARRAY [REAL_64]
			py: ARRAY [REAL_64]
			t, r, theta: REAL_64
    		lev: ARRAY [REAL_64]
		do
			create lev.make_filled (0.0, 1, 10)
			create px.make_filled (0.0, 1, PERIMETERPTS)
			create py.make_filled (0.0, 1, PERIMETERPTS)

			plenv( -1.0, 1.0, -1.0, 1.0, 0, -2 )
    		plcol0( 1 )

				-- Perimeter
			across 0 |..| (PERIMETERPTS - 1) as i loop
				t := (2.0 * {DOUBLE_MATH}.pi / (PERIMETERPTS - 1)) * i.item
				px [i.item + 1] := {DOUBLE_MATH}.cosine (t)
				py [i.item + 1] := {DOUBLE_MATH}.sine (t)
			end
			plline (px, py)
				-- create data to be contoured.

			create cgrid2.make (RPTS, THETAPTS)
			create z.make (RPTS, THETAPTS)

			across 0 |..| (RPTS - 1)  as i  loop
				r := i.item / ( RPTS - 1.0 )
				across 0 |..| (THETAPTS - 1) as j loop
					theta := ( 2. * {DOUBLE_MATH}.pi / ( THETAPTS - 1 ) ) *  j.item
					cgrid2.xg[i.item, j.item] := r * {DOUBLE_MATH}.cosine( theta )
					cgrid2.yg[i.item, j.item] := r * {DOUBLE_MATH}.sine( theta )
					z[i.item, j.item]         := r
				end
			end

			across  0 |..| 9 as i loop
				lev[i.item + 1] := 0.05 + 0.10 *  i.item;
			end

			plcont( z, RPTS, THETAPTS, 1, RPTS, 1, THETAPTS, lev, 10, pltr2_address, cgrid2.pointer );
		    plcol0( 1 )
		    pllab( "", "", "Polar Contour Plot" );
		    z.clean
		    cgrid2.xg.clean
		    cgrid2.yg.clean
		end

	f2mnmx (a_f: PLPLOT_GRID2; nx, ny: INTEGER): TUPLE [min: REAL_64; max: REAL_64]
			-- TODO check if nx and ny are needed.
			-- Returns min & max of input 2d array.
		local
			l_min, l_max: REAL_64
		do
			l_max := a_f[0,0]
			l_min := l_max
			across 0 |..| (nx - 1) as i loop
				across 0 |..| (ny - 1) as j  loop
					 l_max := l_max.max (a_f [i.item, j.item])
					 l_min := l_min.min (a_f [i.item, j.item])
				end
			end
			Result := [l_min, l_max]
		end


	potential
			-- shielded potential contour plot example.
		local
			rmax, xmin, xmax, x0, ymin, ymax, y0, zmin, zmax: REAL_64
			peps, xpmin, xpmax, ypmin, ypmax: REAL_64
			eps, q1, d1, q1i, d1i, q2, d2, q2i, d2i: REAL_64
			div1, div1i, div2, div2i: REAL_64
			z: PLPLOT_GRID2
			nlevelneg, nlevelpos: INTEGER
			dz, clevel2: REAL_64
			clevelneg, clevelpos: ARRAY [REAL_64]
			ncollin, ncolbox, ncollab: INTEGER
			px, py: ARRAY [REAL_64]
			t, r, theta: REAL_64
			cgrid2: PLC_GRID2
			min_max: TUPLE [min: REAL_64; max: REAL_64]
		do
				--	create data to be contoured.
			create cgrid2.make (PRPTS, PTHETAPTS)
			create z.make (PRPTS, PTHETAPTS)

			across 0 |..| (PRPTS - 1) as i loop
				r :=  0.5 + i.item
				across 0 |..| (PTHETAPTS - 1) as j loop
					theta := (2.0 * {DOUBLE_MATH}.pi / ( PTHETAPTS - 1 ) ) * ( 0.5 +  j.item )
				    cgrid2.xg[i.item, j.item] := r * {DOUBLE_MATH}.cosine( theta )
					cgrid2.yg[i.item, j.item] := r * {DOUBLE_MATH}.sine( theta )
				end
			end

			rmax := r
			min_max := f2mnmx( cgrid2.xg, PRPTS, PTHETAPTS)
			xmin := min_max.min
			xmax := min_max.max
			min_max := f2mnmx( cgrid2.yg, PRPTS, PTHETAPTS)
			ymin := min_max.min
			ymax := min_max.max


		    x0 := ( xmin + xmax ) / 2.0
		    y0 := ( ymin + ymax ) / 2.0

				-- Expanded limits
		    peps  := 0.05;
		    xpmin := xmin - xmin.abs * peps
		    xpmax := xmax + xmax.abs * peps
		    ypmin := ymin - ymin.abs * peps
		    ypmax := ymax + ymax.abs * peps

				-- Potential inside a conducting cylinder (or sphere) by method of images.
				--	Charge 1 is placed at (d1, d1), with image charge at (d2, d2).
				-- Charge 2 is placed at (d1, -d1), with image charge at (d2, -d2).
				-- Also put in smoothing term at small distances.

			eps := 2.0

			q1 := 1.0
			d1 := rmax / 4.0

			q1i := -q1 * rmax / d1
			d1i := rmax.power( 2.0 ) / d1

			q2 := -1.0
			d2 := rmax / 4.0

			q2i := -q2 * rmax / d2
			d2i := rmax.power (2.0 ) / d2

			across 0 |..| (PRPTS - 1) as i loop
				across 0 |..| (PTHETAPTS - 1)  as j loop
					div1 := {DOUBLE_MATH}.sqrt((cgrid2.xg [i.item, j.item] - d1).power (2.0)) +  ( cgrid2.yg[i.item, j.item] - d1).power(2.0) +  eps.power (2.0)
					div1i := {DOUBLE_MATH}.sqrt((cgrid2.xg [i.item, j.item] - d1i).power (2.0)) +  ( cgrid2.yg[i.item, j.item] - d1i).power(2.0) +  eps.power (2.0)
					div2 := {DOUBLE_MATH}.sqrt((cgrid2.xg [i.item, j.item] - d2).power (2.0)) +  ( cgrid2.yg[i.item, j.item] + d2).power(2.0) +  eps.power (2.0)
					div2i := {DOUBLE_MATH}.sqrt((cgrid2.xg [i.item, j.item] - d2i).power (2.0)) +  ( cgrid2.yg[i.item, j.item] + d2i).power(2.0) +  eps.power (2.0)
					z [i.item, j.item] := q1 / div1 + q1i / div1i + q2 / div2 + q2i / div2i
				end
			end

			min_max := f2mnmx (z, PRPTS, PTHETAPTS)
			zmin := min_max.min
			zmax := min_max.max

			-- Positive and negative contour levels.
			dz := ( zmax - zmin ) / PNLEVEL
			nlevelneg := 0
			nlevelpos := 0

			create clevelneg.make_filled (0.0, 1, PNLEVEL )
			create clevelpos.make_filled (0.0, 1, PNLEVEL )

			across 0 |..| (PNLEVEL - 1) as i loop
				clevel2 := zmin + ( i.item + 0.5 ) * dz
				if clevel2 <= 0 then
					clevelneg[nlevelneg + 1] := clevel2
					nlevelneg := nlevelneg + 1
				else
					clevelpos[nlevelpos + 1] := clevel2
					nlevelpos := nlevelpos + 1
				end
			end

				-- Colours!
			ncollin := 11
			ncolbox := 1
			ncollab := 2

				-- Finally start plotting this page!
			pladv( 0 )
			plcol0( ncolbox )

			plvpas( 0.1, 0.9, 0.1, 0.9, 1.0 )
			plwind( xpmin, xpmax, ypmin, ypmax )
			plbox( "", 0.0, 0, "", 0.0, 0 );

			plcol0( ncollin )

			if nlevelneg > 0 then
					-- Negative contours
				pllsty( 2 )
		        plcont( z, PRPTS, PTHETAPTS, 1, PRPTS, 1, PTHETAPTS, clevelneg, nlevelneg, pltr2_address, cgrid2.pointer)
			end

		    if  nlevelpos > 0 then
		        	-- Positive contours
		        pllsty( 1 )
		        plcont( z, PRPTS, PTHETAPTS, 1, PRPTS, 1, PTHETAPTS, clevelpos, nlevelpos, pltr2_address, cgrid2.pointer )
		    end

				-- Draw outer boundary

			create px.make_filled (0, 1, PPERIMETERPTS)
			create py.make_filled (0, 1, PPERIMETERPTS)

			across 0 |..| (PPERIMETERPTS - 1)  as i loop
				t := ( 2.0 * {DOUBLE_MATH}.pi / ( PPERIMETERPTS - 1 ) ) *  i.item
				px [i.item + 1] := x0 + rmax * {DOUBLE_MATH}.cosine (t)
				py [i.item + 1] := y0 + rmax * {DOUBLE_MATH}.sine( t )
			end


		    plcol0( ncolbox )
		    plline( px, py )

		    plcol0( ncollab );
		    pllab( "", "", "Shielded potential of charges in a conducting sphere" )

		    z.clean
		    cgrid2.xg.clean
		    cgrid2.yg.clean
		end


	on_callback (x: REAL_64; y: REAL_64; tx: POINTER; ty: POINTER; a_data: POINTER)
		local
			l_tx: REAL_64
			l_ty: REAL_64
		do
			l_tx := tr[1] * x + tr[2] * y + tr[3]
			l_ty := tr[4] * x + tr[5] * y + tr[6]
			tx.memory_copy ($l_tx, {PLATFORM}.real_64_bytes)
			ty.memory_copy ($l_tY, {PLATFORM}.real_64_bytes)
		end

end
