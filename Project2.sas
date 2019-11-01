*Project 2
Kevin Ye
October 31, 2019;

*1. ;
libname project "C:\Users\kye\Downloads";

*2. ;
data project.film2;
	set project.film;
		if (RT > RTUSER) then CRITIC = "critic";
		else if (RT < RTUSER) then CRITIC = "user";
		else CRITIC = "equal";
		if (IMDB >= 7.0) then RATING = "good";
		else RATING = "bad";
		RTDIFF = (RT - RTUSER);
		NAMELENGTH = length(FILMNAME);
*proc print data = project.film2;
run;	

*3. ;
*The length of the longest Film Name is 70.;
proc means data = project.film2 max;
	var NAMELENGTH;
run;

*4. ;
data project.filmfinal;
	set project.film2;
	format FILMNAME $upcase70.;
	*YEAR = input(scan(FILMNAME, -1, "()"), best4.);
	*YEAR = strip(scan(FILMNAME, -1 , "()" ));
	*format YEAR best6.;
	YEAR1 = (compress(FILMNAME,,'kd'));
	if (YEAR1 >9000) then YEAR = input(substr(YEAR1, 2, 4),4.);
	else YEAR = input(YEAR1,4.);
	drop YEAR1;
	label RATING = "Good or Bad IMDB Rating";
	label CRITIC = "Favorable review from Rotten Tomato Critic or Rotten Tomato User"; 
	label RTDIFF = "The Rating Difference between Rotten Tomato Critic and Rotten Tomato User";
	Drop NAMELENGTH;
proc contents data = project.filmfinal;
proc print data = project.filmfinal;
run;

