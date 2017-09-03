uses crt;

var InpArr: array[-1000..1000, -1000..1000] of longint;
	m, n: longint;
	fIn, fOut: text;
	
procedure InitData;
	var i, j: longint;
	begin
		assign(fIn, 'D:\PascalAssetFile\hc.inp');
		assign(fOut, 'D:\PascalAssetFile\hc.out');
		reset(fIn); rewrite(fOut);
		read(fIn, m, n);
		fillchar(InpArr, sizeof(InpArr), 0);
		for j := 1 to m do
			for i := 1 to n do
				read(fIn, InpArr[i,j]);
		close(fIn);
		for j := 1 to m do InpArr[n+1,j] := 30001;
		for i := 1 to n do InpArr[i,m+1] := 30001;
	end;
	
function getMin(a,b,c: longint): longint;
	begin
		getMin := a;
		if (b < getMin) then getMin := b;
		if (c < getMin) then getMin := c;
	end;
	
procedure Calculate;
	var i,j: longint;
	begin
		for j := 1 to m do
			for i := 1 to n do
				InpArr[i,j] := InpArr[i,j] + getMin(InpArr[i+1, j],
													InpArr[i, j+1],
													InpArr[i, j-1]);
	end;
	
procedure SaveResult;
	var i, tmpResult: longint;
	begin
		tmpResult := InpArr[1,m];
		for i := 1 to n do
			if (InpArr[i,m] > tmpResult) then tmpResult := InpArr[i,m];
		write(fOut, tmpResult);
		close(fOut);
		write('Successfull!');
	end;
	
begin
	InitData;
	Calculate;
	SaveResult;
	readln;
end.