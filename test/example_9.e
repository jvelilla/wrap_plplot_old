note
	description: "3-d plot demo."
	date: "$Date$"
	revision: "$Revision$"
	eis:"name= example 9", "src=http://plplot.sourceforge.net/examples.php?demo=08&lbind=C", "protocol=uri"
class
	EXAMPLE_9

inherit

	PLPLOT_API

create
	make

feature -- Initialization

	make
			--  Does a series of 3-d plots for a given data set, with different
			-- viewing options in each plot.
		local
			x,y : ARRAY [REAL_64]
			xx, yy: REAL_64
			z: PLPLOT_GRID2
			dx: REAL_64
			dy: REAL_64
			rosen: BOOLEAN
			zmin, zmax: REAL_64
			r: REAL_64
			indexxmin, indexxmax: INTEGER
			indexymin, indexymax: ARRAY [INTEGER]
			zlimited: PLPLOT_GRID2
			square_root: REAL_64
			x0, a, y0, b: REAL_64
			step: REAL_64
			clevel: ARRAY [REAL_64]
			min_max: TUPLE [max:REAL_64; min:REAL_64]
		do
			dx := 2.0 / ( XPTS - 1 )
    		dy := 2.0 / ( YPTS - 1 )

    		zmin := {REAL_64}.min_value
    		zmax := {REAL_64}.max_value

    		indexxmin := 0
        	indexxmax := XPTS

        	create indexymin.make_filled (0, 1, XPTS)
        	create indexymax.make_filled (0, 1, XPTS)
        	create zlimited.make (XPTS, YPTS)
        	create clevel.make_filled (0.0, 1, LEVELS)

				-- parameters of ellipse (in x, y index coordinates) that limits the data.
				-- x0, y0 correspond to the exact floating point centre of the index range.
        	x0 := 0.5 * ( XPTS - 1 )
			a  := 0.9 * x0
			y0 := 0.5 * ( YPTS - 1 )
			b  := 0.7 * y0


				-- Initialize plplot
			initialize

			create x.make_filled (0.0, 1, XPTS)
			create y.make_filled (0.0, 1, YPTS)
			create z.make (XPTS, YPTS)


			across 0 |..| (XPTS - 1) as i  loop
				x [i.item + 1] := -1.0 +  i.item * dx
				if rosen then
					x[i.item + 1] := x[i.item + 1] * 1.5;
				end
			end

			across 0 |..| (YPTS - 1) as j  loop
				y [j.item + 1] := -1.0 +  j.item * dy
				if rosen then
					y[j.item + 1] := y[j.item + 1] + 0.5;
				end
			end


			across 0 |..| (XPTS - 1) as i loop
				xx := x [i.item + 1]
				across 0 |..| (YPTS - 1) as j  loop
					yy := y [j.item + 1]
					if rosen then
						z [i.item, j.item] :=  (( 1.0 - xx)^ 2.0 ) + 100.0 * ( yy - ( xx ^ 2.0 )^ 2.0 )
							-- The log argument might be zero for just the right grid.
						if z [i.item, j.item] > 0.0 then
							z [i.item, j.item] := {DOUBLE_MATH}.log (z [i.item, j.item])
						else
							z [i.item, j.item] := -5.0 -- -MAXFLOAT would mess-up up the scale
						end
					else
						r := {DOUBLE_MATH}.sqrt (xx * xx + yy * yy)
						z [i.item, j.item ] := {DOUBLE_MATH}.exp( -r * r ) * {DOUBLE_MATH}.cosine( 2.0 * {DOUBLE_MATH}.pi * r );
					end
					if ( zmin > z[i.item, j.item ] ) then
                    	zmin := z[i.item, j.item ]
    	              end
                	if ( zmax < z[i.item , j.item ] ) then
                    	zmax := z[i.item , j.item ]
                  	end
				end
			end

			across indexxmin |..| (indexxmax -1) as i loop
				square_root := {DOUBLE_MATH}.sqrt (one - one.min ((( i.item  - x0 ) / a)^ 2.0  ) )

					-- Add 0.5 to find nearest integer and therefore preserve symmetry	
					-- with regard to lower and upper bound of y range.							
				indexymin[i.item + 1] := zero.max (( 0.5 + y0 - b * square_root ).truncated_to_integer)

					-- indexymax calculated with the convention that it is 1
					-- greater than highest valid index.
	            indexymax[i.item + 1] := YPTS.min (( 0.5 + y0 + b * square_root ).truncated_to_integer );

	            across indexymin[i.item + 1] |..|  (indexymax[i.item + 1] - 1) as j loop
	            	zlimited[i.item, j.item] := z[i.item, j.item ]
	            end
			end

			min_max := z.min_max
			zmax := min_max.max
			zmin := min_max.min
			step := ( zmax - zmin ) / ( LEVELS + 1 )

			across 0 |..| (LEVELS -1 ) as i loop
				clevel[i.item + 1] := zmin + step + step * i.item
			end

			pllightsource( 1.0, 1.0, 1.0 )
			across 0 |..| 1 as k loop
				across 0 |..| 4 as ifshade loop
					pladv( 0 )
					plvpor( 0.0, 1.0, 0.0, 0.9 )
					plwind( -1.0, 1.0, -0.9, 1.1 )
					plcol0( 3 )
					plmtex( "t", 1.0, 0.5, 0.5, title[k.item + 1] )
     			    plcol0( 1 )
		            if rosen then
		                plw3d( 1.0, 1.0, 1.0, -1.5, 1.5, -0.5, 1.5, zmin, zmax, alt[k.item + 1], az[k.item + 1] )
        		    else
                		plw3d( 1.0, 1.0, 1.0, -1.0, 1.0, -1.0, 1.0, zmin, zmax, alt[k.item + 1], az[k.item + 1] )
					end
					plbox3( "bnstu", "x axis", 0.0, 0, "bnstu", "y axis", 0.0, 0, "bcdmnstuv", "z axis", 0.0, 0 )
					plcol0( 2 )
					inspect ifshade.item
					when 0 then
							-- diffuse light surface plot
						cmap1_init( 1 )
						plsurf3d( x, y, z, XPTS, YPTS, 0, {ARRAY [REAL_64]}<<>>, 0 )
					when 1 then
							-- magnitude colored plot
						cmap1_init( 0 )
						plsurf3d( x, y, z, XPTS, YPTS, {PLPLOT_CONSTANTS}.MAG_COLOR, {ARRAY [REAL_64]}<<>>, 0 )
					when 2 then
							-- magnitude colored plot with faceted squares.
						cmap1_init( 0 )
						plsurf3d( x, y, z, XPTS, YPTS, {PLPLOT_CONSTANTS}.MAG_COLOR | {PLPLOT_CONSTANTS}.FACETED, {ARRAY [REAL_64]}<<>>, 0 )
					when 3 then
							-- magnitude colored plot with contours.
						cmap1_init( 0 )
						plsurf3d ( x, y, z, XPTS, YPTS, {PLPLOT_CONSTANTS}.MAG_COLOR | {PLPLOT_CONSTANTS}.SURF_CONT | {PLPLOT_CONSTANTS}.BASE_CONT, clevel, LEVELS )
					else
							-- magnitude colored plot with contours and index limits.	
     					cmap1_init( 0 );
						plsurf3dl( x, y, zlimited, XPTS, YPTS, {PLPLOT_CONSTANTS}.MAG_COLOR | {PLPLOT_CONSTANTS}.SURF_CONT | {PLPLOT_CONSTANTS}.BASE_CONT, clevel, LEVELS, indexxmin, indexxmax, indexymin, indexymax );
					end
				end
			end
			z.clean
			zlimited.clean
			finalize
		end


 		-- These values must be odd, for the middle
    	-- of the index range to be an integer, and thus
    	-- to correspond to the exact floating point centre	

    XPTS: INTEGER = 35
		-- Data points in x.

	YPTS: INTEGER = 45
		-- Data points in y.

	alt: ARRAY [REAL_64]
		do
			Result := <<60.0, 40.0>>
		end

	az: ARRAY [REAL_64]
		do
			Result := <<30.0, -30.0>>
		end

	title: ARRAY [STRING]
		do
			Result := <<"#frPLplot Example 8 - Alt=60, Az=30", "#frPLplot Example 8 - Alt=40, Az=-30">>
		end

	one:REAL_64 = 1.0

	zero: INTEGER = 0

	LEVELS: INTEGER = 10

feature -- Color Map

	cmap1_init (gray: INTEGER)
			-- Initializes color map 1 in HLS space.
			-- Basic grayscale variation from half-dark (which makes more interesting
			-- looking plot compared to dark) to light.
			-- An interesting variation on this:
			-- s[1] = 1.0
		local
			i,h,l,s : ARRAY [REAL_64]
		do
			create i.make_filled (0.0, 1, 2)
			create h.make_filled (0.0, 1, 2)
			create l.make_filled (0.0, 1, 2)
			create s.make_filled (0.0, 1, 2)

 			i[1] := 0.0
 				-- left boundary
    		i[2] := 1.0
    			-- right boundary

		    if  gray = 1  then
 				h[1] := 0.0
 					-- hue - low: red (arbitrary if s=0)
				h[2] := 0.0
					-- hue  high: red (arbitrary if s=0)

				l[1] := 0.5
					-- lightness -- low: half-dark
				l[2] := 1.0
					-- lightness -- high: light

		        s[1] := 0.0
		        	-- minimum saturation
				s[2] := 0.0
					-- minimum saturation
			else
				h[1] := 240
					-- blue -> green -> yellow ->
				h[2] := 0
					-- -> red
				l[1] := 0.6
				l[2] := 0.6

		        s[1] := 0.8
				s[2] := 0.8
			end
			plscmap1n( 256 )
			plscmap1l( 0, 2, i, h, l, s, {ARRAY [BOOLEAN]}<<>> )
		end

end
