*Project 2
Kevin Ye
October 31, 2019;

*1. ;
libname project "C:\Users\kye\Downloads";

*2. The data step creates a copy of project.film as project.film2 with modifications.
A new critic variable is created where critic = critic when RT > RTUSER, critic = users when RT < RTUSER and critic = equals when RT = RTUSER.
A new rating variable is created where rating = good when imdb => 7 and where rating = bad when imdb is less than 7.
A new rtdiff variable is created that is the difference between rt and rtuser.
A new namelength variable is created that counts the character length of the movie titles in filmname.;
data project.film2;
	set project.film;
		if (RT > RTUSER) then CRITIC = "critic";
		else if (RT < RTUSER) then CRITIC = "user";
		else CRITIC = "equal";
		if (IMDB >= 7.0) then RATING = "good";
		else RATING = "bad";
		RTDIFF = (RT - RTUSER);
		NAMELENGTH = length(FILMNAME);
run;	

*3. The means procedure prints out the statistical values of the NAMELENGTH variable of project.film2.
The option max requests the type of statistcal value to print.;
*The length of the longest Film Name is 70.;
proc means data = project.film2 max;
	var NAMELENGTH;
run;

*4. The format statement formats the movie titles in filename to display in all uppercase letters and sets the character length up to 70.
A year1 variable is created that keeps all the numberical characters of filmname and drops all the character letters.
The if then else statement creates a year variable that is the numerical copy of year1 and it copies the last four digits of year1 if the digit length is greater than 4.
the format statement formats the display of the year variable to show roman numerals.;
data project.filmfinal;
	set project.film2;
	format FILMNAME $upcase70.;
	YEAR1 = (compress(FILMNAME,,'kd'));
	if (YEAR1 >9000) then YEAR = input(substr(YEAR1, 2, 4),4.);
	else YEAR = input(YEAR1,4.);
	drop YEAR1;
	format YEAR ROMAN8.;
	label RATING = "Good or Bad IMDB Rating";
	label CRITIC = "Favorable review from Rotten Tomato Critic or Rotten Tomato User"; 
	label RTDIFF = "The Rating Difference between Rotten Tomato Critic and Rotten Tomato User";
	Drop NAMELENGTH;
run;

*5. The print procedure prints out observations of the data project.filmfinal where the movie premiered in 2015, its imdb rating is good and it was valued higher by professional critics.;
proc print data = project.filmfinal;
	where YEAR = 2015 and RATING = "good" and CRITIC = "critic";
run;

*6. The frequency procedure creates a two way contigency table between the rating and year variable;
*The sample proportion of “good” movies in the year 2014 is 0.0753.;
proc freq data = project.filmfinal;
	table RATING *YEAR;
run;

*.7 The freq. procedure creates a proprtion test of the rating variable with the binomial option. 
The where statement tells SAS to select all observations where year = 2015.
The option level sets the proportion test to be about the good movies while the p option sets the null proportion equals to 0.7.
The alpha option sets the alpha level to 0.01.;
*We reject the null hypothesis that the proportion of good movies in 2015 is different from 0.7. 
We have evidence to suggest the population proportion of good movies in 2015 is not equal to 0.7.
We are 99% confident that the true proportion of good movies in 2015 lies between 0.3258 and 0.5588.;
proc freq data = project.filmfinal;
	where YEAR = 2015;
	table RATING /binomial (level = "good" p = .7 )alpha = 0.01;
run;

*8. The t-test procedure conducts a one sample t-test of the variable imdb.
The side option dictates a one sided upper test, the h0 option sets the null mean equal to 6.5 and the alpha option sets the alpha level to 0.01.;
*The normality of the distribution of imdb is valid as examined by the histogram.
The p-value is 0.0017 and it is lest than alpha = 0.01. We reject the  the null hypothesis.
We have evidence to suggest the true mean imdb rating is greater than 6.5.;
proc ttest data = project.filmfinal sides = U h0 = 6.5 alpha = 0.01;
	var IMDB;
run;


