Date			an object describing a point in time



Class Methods


	*new(year, month, day, hour, minute, second, dayOfWeek, rawSeconds, bootSeconds)
				Create a new date with the given properties (all numerical values).
				These arguments are also the names of instance variables of the date object.
				
	*getDate		get current date from system and create a date object from it.
				
				(
				var a = Date.getDate;
				a.bootSeconds.postln;
				a.dayOfWeek.postln;
				a
				)
	
	*localtime	get current localized time from system and create a date object from it.
				
	*gmtime		get current Greenwich Mean Time (GMT) from system and create a date object from it.
	
	*seed		get current date and return a value suitable for seeding a random number generator.
				see also randomSeed
	
				(
				var a = Date.seed;
				thisThread.randSeed = a; 
				20.do { [1,0].choose.post }; "".postln;
				thisThread.randSeed = a;
				25.do { [1,0].choose.post }; "".postln;
				)
		
		
Instance Methods

	
	localtime		set the receiver's time to current localtime.
	
	gmtime		set the receiver's time to current Greenwich Mean Time (GMT).
	
	dayStamp	obtain a string with the year, month and day in the format YYMMDD.
	
	hourStamp	obtain a string in the format H:M:S
	
	secStamp	obtain a string with the seconds
	
	stamp		obtain a string in the format YYMMDD_HHMMSS.
	
	asSortableString	obtain a string in an alphabetically sortable standard database format
	
	asctime		obtain a string in the format WeekdayName MonthName Time Year
				
	asString		returns asctime.
	
	
	format(formatstring)	obtain a date string with a given format.  The character % is replaced by the 
						appropriate value, which is derived from the letter that follows.
	
		
	Date.getDate.format("Today is %A. It is around %I o'clock (%p), in %B.");
	Date.getDate.format("%Y-%d-%e-%Hh%m");
	


A list of formats can be found here: http://www.opengroup.org/onlinepubs/009695399/functions/strftime.html



Supported conversion specifications:

%a
Replaced by the locale's abbreviated weekday name. [ tm_wday]

%A
Replaced by the locale's full weekday name. [ tm_wday]

%b
Replaced by the locale's abbreviated month name. [ tm_mon]

%B
Replaced by the locale's full month name. [ tm_mon]

%c
Replaced by the locale's appropriate date and time representation. 

%C
Replaced by the year divided by 100 and truncated to an integer, as a decimal number [00,99]. [ tm_year]

%d
Replaced by the day of the month as a decimal number [01,31]. [ tm_mday]

%D
Equivalent to %m / %d / %y. [ tm_mon, tm_mday, tm_year]

%e
Replaced by the day of the month as a decimal number [1,31]; a single digit is preceded by a space. [ tm_mday]

%F
Equivalent to %Y - %m - %d (the ISO 8601:2000 standard date format). [ tm_year, tm_mon, tm_mday]

%g
Replaced by the last 2 digits of the week-based year (see below) as a decimal number [00,99]. [ tm_year, tm_wday, tm_yday]

%G
Replaced by the week-based year (see below) as a decimal number (for example, 1977). [ tm_year, tm_wday, tm_yday]

%h
Equivalent to %b. [ tm_mon]

%H
Replaced by the hour (24-hour clock) as a decimal number [00,23]. [ tm_hour]

%I
Replaced by the hour (12-hour clock) as a decimal number [01,12]. [ tm_hour]

%j
Replaced by the day of the year as a decimal number [001,366]. [ tm_yday]

%m
Replaced by the month as a decimal number [01,12]. [ tm_mon]

%M
Replaced by the minute as a decimal number [00,59]. [ tm_min]

%n
Replaced by a <newline>.

%p
Replaced by the locale's equivalent of either a.m. or p.m. [ tm_hour]

%r
Replaced by the time in a.m. and p.m. notation; ¬†in the POSIX locale this shall be equivalent to %I :%M :%S%p. [ tm_hour, tm_min, tm_sec]

%R
Replaced by the time in 24-hour notation (%H : %M ). [ tm_hour, tm_min]

%S
Replaced by the second as a decimal number [00,60]. [ tm_sec]

%t
Replaced by a <tab>.

%T
Replaced by the time ( %H : %M : %S ). [ tm_hour, tm_min, tm_sec]

%u
Replaced by the weekday as a decimal number [1,7], with 1 representing Monday. [ tm_wday]

%U
Replaced by the week number of the year as a decimal number [00,53]. The first Sunday of January is the first day of week 1; days in the new year before this are in week 0. [ tm_year, tm_wday, tm_yday]

%V
Replaced by the week number of the year (Monday as the first day of the week) as a decimal number [01,53]. If the week containing 1 January has four or more days in the new year, then it is considered week 1. Otherwise, it is the last week of the previous year, and the next week is week 1. Both January 4th and the first Thursday of January are always in week 1. [ tm_year, tm_wday, tm_yday]

%w
Replaced by the weekday as a decimal number [0,6], with 0 representing Sunday. [ tm_wday]

%W
Replaced by the week number of the year as a decimal number [00,53]. The first Monday of January is the first day of week 1; days in the new year before this are in week 0. [ tm_year, tm_wday, tm_yday]

%x
Replaced by the locale's appropriate date representation.

%X
Replaced by the locale's appropriate time representation.

%y
Replaced by the last two digits of the year as a decimal number [00,99]. [ tm_year]

%Y
Replaced by the year as a decimal number (for example, 1997). [ tm_year]

%z
Replaced by the offset from UTC in the ISO¬†8601:2000 standard format ( +hhmm or -hhmm ), or by no characters if no timezone is determinable. For example, "-0430" means 4 hours 30 minutes behind UTC (west of Greenwich). If tm_isdst is zero, the standard time offset is used. If tm_isdst is greater than zero, the daylight savings time offset is used. If tm_isdst is negative, no characters are returned. [ tm_isdst]

%Z
Replaced by the timezone name or abbreviation, or by no bytes if no timezone information exists. [ tm_isdst]

%%
Replaced by %.

If a conversion specification does not correspond to any of the above, the behavior is undefined.




