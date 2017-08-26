uses crt;
type ArrType = array[-100..100, -100..100] of longint;
var Arr: ArrType;
	imax, jmax, WayMax: longint;
	fIn, fOut: text;
	
procedure initData;
	var i, j: longint;
	begin
		fillchar(Arr, sizeof(Arr), 0);
		assign(fIn, 'D:\PascalAssetFile\qm.in');
		assign(fOut, 'D:\PascalAssetFile\qm.ou');
		reset(fIn); rewrite(fOut);
		read(fIn, jmax, imax);
		for j := 1 to jmax do
			for i := 1 to imax do read(fIn, Arr[i,j]);
		close(fIn);
	end;
	
function getMax(a, b, c, d: longint): longint;
	begin
		getMax := a;
		if (b > getMax) then getMax := b;
		if (c > getMax) then getMax := c;
		if (d > getMax) then getMax := d;
	end;
	
procedure Calculate;
	var i, j: longint;
	begin
		for j := 1 to jmax do
			for i := 1 to imax do
			begin
				Arr[i,j] := getMax(Arr[i-2, j-1], 
								Arr[i-1, j-2], 
								Arr[i+1, j-2], 
								Arr[i+2, j-1]) + Arr[i,j];
			end;
		WayMax := Arr[1, jmax];
		for i := 1 to imax do
			if (Arr[i, jmax] > WayMax) then WayMax := Arr[i, jmax];
	end;
	
procedure saveData;
	begin
		write(fOut, WayMax);
		close(fOut);
		write('Save successful! Output data have just saved in "D:\PascalAssetFile\qm.ou"');
	end;

begin
	initData;
	Calculate;
	saveData;
	readln
end.