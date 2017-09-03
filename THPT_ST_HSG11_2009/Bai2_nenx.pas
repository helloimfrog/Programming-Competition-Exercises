uses crt;
var Str: string;

function compressSt(s: string): string;
    var i, j, cout, lg: longint;
        StCout: string;
    begin
        lg := length(s);
        for i := 1 to lg do 
        begin
            cout := 1; StCout := '';
            for j := i + 1 to lg do
                if (s[i] = s[j]) then cout := cout + 1 else break;
            if (cout <> 1) then 
			str(cout, StCout);
            begin
                delete(s, i + 1, cout - 1);
                insert(StCout, s, i);
            end;
            lg := length(s);
        end;
        compressSt := s;
    end;
    
begin
    clrscr;
	writeln(compressSt('aaabbcccccccccba'));
	readln
end.