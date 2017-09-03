uses crt;

var Fibo, InpArr: array[1..10000] of longint;
	LgArr, i: longint;
	fIn, fOut: text;
	
procedure InitData;
	var i: longint;
	begin
		assign(fIn, 'D:\PascalAssetFile\fibb.inp');
		assign(fOut, 'D:\PascalAssetFile\fibb.out');
		reset(fIn); rewrite(fOut);
		read(fIn, LgArr);
		for i := 1 to LgArr do read(fIn, InpArr[i]);
	end;
	
procedure CreateFiboSeq(a,b: longint);
	var i: longint;
	begin
		Fibo[1] := a; Fibo[2] := b;
		for i := 3 to LgArr do
			Fibo[i] := Fibo[i-1] + Fibo[i-2];
	end;
	
procedure CheckAndSaveResult;
	var i: longint;
		StResult: string;
	begin
		StResult := '';
		CreateFiboSeq(InpArr[1], InpArr[2]);
		for i := 1 to LgArr do
			if (InpArr[i] = Fibo[i]) then StResult := 'YES'
			else
			begin
				StResult := 'NO';
				break
			end;
		write(fOut, StResult);
		close(fOut);
		write('Run Successfull!');
	end;
	
begin
	InitData;
	CheckAndSaveResult;
	readln
end.
