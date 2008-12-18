program calendar (I,O);
label a;
const
days_names='MO TU WD TH FR SA SU';
var
year:longint;
i,x,month,week:integer;
months_sets:array [1..4]of string;
function leap(year:longint):boolean;       {function to know whether the year is leap or not}
              begin
                if year mod 4 = 0 then leap:=true else leap := false;
              end;
function daysOFmonth(month:integer):integer;  {function to know the number of days of a month}
              begin
              if month in [4,6,9,11] then daysOFmonth:= 30
              else
              if month=2 then
                    begin
                    if leap(year)=true then daysOFmonth:=29
                    else daysOFmonth := 28;
                    end
              else daysOFmonth := 31;
              end;

function DAY1(year:longint):integer;        {function to know the day of the 1st of January}
               var NO_OF_DAYS:longint;
               begin
               NO_OF_DAYS:=(((year-1900)div 4)*1461)+(((year-1900)mod 4)*365);
               if year mod 4 = 0 then DAY1:=NO_OF_DAYS mod 7
               else DAY1:= (NO_OF_DAYS mod 7)+ 1 ;
               if DAY1 = 0 then DAY1 := 7;
               end;
function month1st(month:integer):integer;       {function to know the day of the 1st of the month}
               begin
               if month = 1 then month1st:= DAY1(year)
               else
               month1st:=(((month1st(month-1))+ daysOFmonth(month-1)))mod 7;
               if month1st=0 then month1st :=7;
               end;
procedure write3monthsNO(x:integer);
               begin
               writeln(months_sets[x]); writeln;
               for i:=1 to 3 do write(days_names,'   ') ;writeln;writeln;
               for week:=1 to 6 do
                   begin
                      for month:= 1+(3*(x-1)) to 3+(3*(x-1)) do
                          begin
                          if week=1 then
                              begin
                              for i:=1 to month1st(month)-1 do write('   ');
                              for i:=1to (8-month1st(month)) do write(i:2,' ');
                              end
                          else
                              for i:=((9-month1st(month))+7*(week-2)) to (((9-month1st(month))+7*(week-2))+6) do
                              begin
                               if (i<=daysOFmonth(month)) then write(i:2,' ');
                               if (i>daysOFmonth(month)) then  write('   ');
                              end;
                         write('  ');
                   end;
               writeln;

               end;
               end;

begin                      {the real program}
writeln;writeln('*********************************CALENDAR**************************************');writeln;writeln;
writeln(' **best output with screen resolution 1024by768 pixels');
writeln(' **please maximize the output screen before entering the year');
writeln;writeln;writeln;
a:writeln(' **please enter a year between 1901 and 5789489 to show its calendar,');writeln(' or enter 0 to exit.');
writeln;
write(' Show calendar for year:');
read(year);
if year=0000 then halt(0000)
else
   begin
   if (year<=1900)or(year>5789489)then
      begin
      writeln;writeln;
      writeln(' Sorry, The year inserted is out of range');writeln;
      goto a;
      end
   else
      begin               {for an available year}
      for i:=1 to 30 do writeln;
      writeln('**********************         ',year,'          *********************');writeln;writeln;
      months_sets[1]:='January                February               March                    ';
      months_sets[2]:='April                  May                    June                     ';
      months_sets[3]:='July                   August                 September                ';
      months_sets[4]:='October                November               December                 ';
      for x:=1 to 4 do
      begin
      write3monthsNO(x);
      writeln('__________________________________________________________________');writeln;
      end;
      goto a;
      end;
   end;

readln;
readln;
end.
