uses crt;
var n, m: longint;
	S: extended;
	fIn, fOut: text;
	
procedure initData;
	begin
		assign(fIn, 'D:\lt.in');
		assign(fOut, 'D:\lt.ou');
		reset(fIn); rewrite(fOut);
		read(fIn, n, m);
		close(fIn);
	end;
	
function LuyThua(a, b: longint): extended;
	begin
		LuyThua := exp(ln(a)*b);
	end;
	
procedure Calculate;
	var tmpSt: string;
	begin
		S := LuyThua(2, n) + LuyThua(3, m);
		str(S:0:0, tmpSt);
		if (tmpSt[1] = ' ') then write(fOut, tmpSt[2])
			else write(fOut, tmpSt[1]);
		close(fOut);
		write('Successful!');
	end;
	
begin
	initData;
	Calculate;
	readln
end.