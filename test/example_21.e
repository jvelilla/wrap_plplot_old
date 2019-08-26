note
	description: "plimage demo"
	date: "$Date$"
	revision: "$Revision$"
	eis:"name=example21", "src=http://plplot.sourceforge.net/examples.php?demo=20&lbind=C", "protocol=uri"

class
	EXAMPLE_21

inherit

	PLPLOT_API

create
	make

feature {NONE} --Initialization

	make
		local
			x, y: ARRAY [REAL_64]
			z, r: PLPLOT_GRID2
			xi, yi, xe, ye: REAL_64
			width, height, num_col: INTEGER
			img_f: PLPLOT_GRID2
			img_min: REAL_64
    		img_max: REAL_64
    		stretch: STRETCH_DATA
    		cgrid2: PLC_GRID2
    		xx, yy: REAL_64
		do
				--	// Bugs in plimage():
				--    // -at high magnifications, the left and right edge are ragged, try
				--    //    ./x20c -dev xwin -wplt 0.3,0.3,0.6,0.6 -ori 0.5
				--    // AWI comment as of 2016-02-04.  This bug appears to no longer exist.

				--    //
				--    // Bugs in x20c.c:
				--    // -if the window is resized after a selection is made on "Chloe", when
				--    //  making a new selection the old one will re-appear.

				--    //  AWI comment as of 2016-02-04.  I confirm that both the old
				--    // and new selection areas are outlined, but only the new one
				--    // is actually used for the selection so this is relatively harmless
				--    // for this application.  Nevertheless, it should be looked into as a
				--    // likely rendering issue with plbuf.

				 -- Initialize plplot

			 initialize

			 create z.make (XDIM, YDIM)

		   		--  view image border pixels
		    if dbg then
		        plenv( 1.,XDIM, 1., YDIM, 1, 1 ); -- no plot box

		        	--  build a one pixel square border, for diagnostics

		        across 0 |..| (XDIM - 1) as i loop
		        	z[i.item, YDIM - 1] := 1. -- right
		        end

		        across 0 |..| (XDIM - 1) as i loop
		        	z[i.item, 0] := 1. -- left
		        end

		        across 0 |..| (YDIM - 1) as i loop
		        	z[0, i.item] := 1. -- top
		        end

		        across 0 |..| (YDIM - 1) as i loop
		        	z[XDIM - 1, i.item] := 1. -- botton
		        end

		        pllab( "...around a blue square.", " ", "A red border should appear..." )

		        plimage( z, XDIM, YDIM,
		            1.,  XDIM, 1.,  YDIM, 0., 0.,
		            1.,  XDIM, 1.,  YDIM )
		    end

				--	sombrero-like demo
		    if  not nosombrero then
		    	create r.make ( XDIM, YDIM )
		        plcol0( 2 ) --draw a yellow plot box, useful for diagnostics! :(
		        plenv( 0., 2. * {DOUBLE_MATH}.pi, 0, 3. * {DOUBLE_MATH}.pi, 1, -1 )

				create x.make_filled (0.0, 1, XDIM)
		        across 0 |..| (XDIM-1) as i  loop
		        	x[i.item + 1] := i.item  * 2. * {DOUBLE_MATH}.pi / ( XDIM - 1 )
		        end

		        create y.make_filled (0.0, 1, YDIM)
		        across 0 |..| (YDIM-1) as i  loop
		        	y[i.item + 1] := i.item * 3. * {DOUBLE_MATH}.pi / ( YDIM - 1 )
		        end

				across 0 |..| (XDIM - 1) as i loop
					across 0 |..| (YDIM - 1) as j loop
						r[i.item, j.item] := {DOUBLE_MATH}.sqrt( x[i.item + 1] * x[i.item + 1] + y[j.item + 1] * y[j.item + 1] ) + 0.001 --1e-3
						z[i.item, j.item] := {DOUBLE_MATH}.sine( r[i.item, j.item] ) / ( r[i.item, j.item] )
					end
				end

		        pllab( "No, an amplitude clipped %"sombrero%"", "", "Saturn?" )
		        plptex( 2., 2., 3., 4., 0., "Transparent image" );
		        plimage( z, XDIM, YDIM, 0., 2. * {DOUBLE_MATH}.pi, 0., 3. * {DOUBLE_MATH}.pi, 0.05, 1.,
		            0., 2. * {DOUBLE_MATH}.pi, 0., 3. * {DOUBLE_MATH}.pi )
		        r.clean

		        	-- save the plot
		        if attached f_name as l_name then
		            save_plot( l_name )
				end
			end
		    z.clean

		  		-- read Chloe image
		  	create img_f.make_empty
		  	if read_img ("Chloe.pgm", img_f, $width, $height, $num_col) then

		  	end
--	        if ( ( img_f = read_img( "Chloe.pgm", n ) ) == null )
--	        {
--	            if ( ( img_f = read_img( "../Chloe.pgm", n ) ) == null )
--	            {
--	                System.out.println( "File error - aborting" );
--	                pls.end();
--	                System.exit( 1 );
--	            }
--	        }
--	        num_col = n[0];
--	        width   = img_f.length;
--	        height  = img_f[0].length;

--	        // set gray colormap
--	        gray_cmap( num_col );

--	        // display Chloe
--	        pls.env( 1., width, 1., height, 1, -1 );


			finalize
		end


feature -- Access

	XDIM: INTEGER = 260
	YDIM: INTEGER = 220

	dbg: BOOLEAN
	nosombrero: BOOLEAN
	nointeractive: BOOLEAN
	f_name: detachable STRING


feature -- Transformation function

	mypltr(  x: REAL_64; y: REAL_64; tx: POINTER; ty: POINTER; pltr_data: POINTER )
		local
			x0, y0, dy: REAL_64
			s: STRETCH_DATA
			l_tx: REAL_64
			l_ty: REAL_64
		do
			create s.make_by_pointer (pltr_data)
			x0 := ( s.xmin + s.xmax ) * 0.5
			y0 := ( s.ymin + s.ymax ) * 0.5
			dy := ( s.ymax - s.ymin ) * 0.5
			l_tx := x0 + ( x0 - x ) * ( 1.0 - s.stretch * {DOUBLE_MATH}.cosine( ( y - y0 ) / dy * {DOUBLE_MATH}.pi * 0.5 ) )
			l_ty := y
			tx.memory_copy ($l_tx, {PLATFORM}.real_64_bytes)
			ty.memory_copy ($l_tY, {PLATFORM}.real_64_bytes)
		end

feature -- Save plot

	save_plot (fname: STRING)
		local
			cur_strm, new_strm: INTEGER
		do
		    plgstrm( $cur_strm )    -- get current stream
		    plmkstrm( $new_strm )   -- create a new one

		    plsdev( "psc" )	         -- new device type. Use a known existing driver
		    plsfnam( fname )		 -- file name

		    plcpstrm( cur_strm, 0 )  -- copy old stream parameters to new stream
		    plreplot              	 -- do the save
		    plend1                	 -- close new device

		    plsstrm( cur_strm );     -- and return to previous one
		end


feature -- Read Image

	read_img (fname: STRING; img_f: PLPLOT_GRID2; width, height, num_col: POINTER) : BOOLEAN
		local
			l_width, l_height, l_num_col: INTEGER
			fp: RAW_FILE
		do
				-- grayscale binary ppm reading.
			create fp.make_open_read (fname)

				-- Check version P5 is the only one supported.
		end

--// read image from file in binary ppm format
--int read_img( PLCHAR_VECTOR fname, PLFLT ***img_f, int *width, int *height, int *num_col )
--{
--    FILE          *fp;
--    unsigned char *img;
--    char          ver[80];
--    int           i, j, w, h;
--    PLFLT         **imf;

--    // naive grayscale binary ppm reading. If you know how to, improve it
--    if ( ( fp = fopen( fname, "rb" ) ) == NULL )
--        return 1;

--    if ( fscanf( fp, "%s\n", ver ) != 1 ) // version
--    {
--        fclose( fp );
--        return 1;
--    }
--    // printf("version: %s\n", ver);

--    if ( strcmp( ver, "P5" ) ) // I only understand this!
--    {
--        fclose( fp );
--        return 1;
--    }

--    while ( ( i = fgetc( fp ) ) == '#' )
--    {
--        if ( fgets( ver, 80, fp ) == NULL ) // comments
--        {
--            fclose( fp );
--            return 1;
--        }
--        // printf("%s", ver);
--    }
--    ungetc( i, fp );

--    if ( fscanf( fp, "%d%d%d\n", &w, &h, num_col ) != 3 ) // width, height num colors
--    {
--        fclose( fp );
--        return 1;
--    }
--    // printf("width=%d height=%d num_col=%d\n", w, h, *num_col);

--    img = (unsigned char *) malloc( (size_t) ( w * h ) * sizeof ( char ) );
--    plAlloc2dGrid( &imf, w, h );

--    if ( (int) fread( img, sizeof ( char ), (size_t) ( w * h ), fp ) != w * h )
--    {
--        fclose( fp );
--        free( img );
--        plFree2dGrid( imf, w, h );
--        return 1;
--    }
--    fclose( fp );

--    for ( i = 0; i < w; i++ )
--        for ( j = 0; j < h; j++ )
--            imf[i][j] = img[( h - 1 - j ) * w + i];
--    // flip image up-down

--    free( img );

--    *width  = w;
--    *height = h;
--    *img_f  = imf;
--    return 0;
--}

end
