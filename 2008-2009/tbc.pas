uses crt;

type DynArr = array of extended;

var InpSequence, FlagValue: DynArr;
	fIn, fOut: text;
	ArrLg: longint;

procedure InitData;
	begin
		assign(fIn, 'D:\PascalAssetFile\tbc.inp');
		assign(fOut, 'D:\PascalAssetFile\tbc.out');
		reset(fIn); rewrite(fOut);
		readln(fIn);
		repeat
			inc(ArrLg);
			SetLength(InpSequence, ArrLg);
			read(fIn, InpSequence[ArrLg-1]);
		until eof(fIn);
		SetLength(FlagValue, ArrLg);
		close(fIn);
	end;
	
function TBC(a, b, c: extended): extended;
	begin
		TBC := (a+b+c) / 3;
	end;
	
function isFlagged(a: longint): boolean;
	begin
		if (FlagValue[a] = InpSequence[a]) then exit(true)
			else exit(false);
	end;
	
procedure CalculateTBCAndSave;
	var i, j, k, p, couttbc: longint;
	begin
		couttbc := 0;
		for p := 0 to ArrLg-1 do
			for i := 0 to ArrLg - 3 do
				for j := i + 1 to ArrLg - 2 do
					for k := j + 1 to ArrLg - 1 do
						if not isFlagged(p) 
						and (InpSequence[p] = TBC(InpSequence[i], InpSequence[j], InpSequence[k])) then 
						begin
							FlagValue[p] := InpSequence[p];
							inc(couttbc);
						end;
		write(fOut, couttbc);
		close(fOut);
	end;
	
begin
	InitData;
	CalculateTBCAndSave;
	readln;
end.