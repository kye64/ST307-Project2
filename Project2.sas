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


proc print data = project.film2;
run;	

