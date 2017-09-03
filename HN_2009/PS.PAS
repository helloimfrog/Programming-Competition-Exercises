type DynArr = array of longint;
	 NorArr = array[0..1000] of longint;
	 RealArr = array of real;
	 
const fInPath = 'D:\PascalAssetFile\ps.inp';
	  fOutPath = 'D:\PascalAssetFile\ps.out';
	  
var InpTu, InpMau: NorArr;
	tgTu, tgMau: DynArr;
	psVal: RealArr;
	fIn, fOut: text;
	m, n, k: longint;
	
procedure initData;
	var i, j, CurrentPos, SavePoint: longint;
	begin		
		assign(fIn, fInPath);
		assign(fOut, fOutPath);
		reset(fIn); rewrite(fOut);
		read(fIn, m, n, k);
		
		for i := 0 to m - 1 do read(fIn, InpTu[i]);
		for i := 0 to n - 1 do read(fIn, InpMau[i]);
		
		close(fIn);
		
		SetLength(tgTu, m*n);
		SetLength(tgMau, m*n);
		
		SavePoint := 0;
		CurrentPos := 0;
		repeat
			tgMau[SavePoint] := InpMau[CurrentPos];
			inc(SavePoint); inc(CurrentPos);
			if (CurrentPos = n) then CurrentPos := 0;
		until (SavePoint = m*n);
		
		SavePoint := 0;
		repeat
			for j := 0 to m - 1 do
				for i := 0 to n - 1 do
				begin
					tgTu[SavePoint] := InpTu[j];
					inc(SavePoint);
				end;
		until (SavePoint = m*n);
		
	end;
	
function UCLN(a, b: longint): longint;
	var tmp: longint;
	begin
		while (b > 0) do
		begin
			a := a mod b;
			tmp := a; a := b; b := tmp;
		end;
		exit(a);
	end;
	
procedure RutGon;
	var i, tmpUcln: longint;
	begin
		tmpUcln := 0;
		for i := 0 to length(tgTu) - 1 do
		begin
			tmpUcln := UCLN(tgTu[i],tgMau[i]);
			tgTu[i] := tgTu[i] div tmpUcln;
			tgMau[i] := tgMau[i] div tmpUcln;
		end;
	end;
	
procedure SortPSTangDan;
	var i, j, tmpTu, tmpMau: longint;
		tmpPsVal: real;
	begin
		tmpPsVal := 0; tmpMau := 0; tmpTu := 0;
		for i := 0 to length(tgTu) - 1 do
			for j := 0 to length(tgTu) - 1 do
				if (psVal[j] > psVal[i]) then
				begin
					tmpPsVal := psVal[i];
					psVal[i] := psVal[j];
					psVal[j] := tmpPsVal;
					
					tmpTu := tgTu[i];
					tgTu[i] := tgTu[j];
					tgTu[j] := tmpTu;
					
					tmpMau := tgMau[i];
					tgMau[i] := tgMau[j];
					tgMau[j] := tmpMau;
				end;
	end;
	
procedure SortPSGiamDan;
	var i, j, tmpTu, tmpMau: longint;
		tmpPsVal: real;
	begin
		tmpPsVal := 0; tmpMau := 0; tmpTu := 0;
		for i := 0 to length(tgTu) - 1 do
			for j := 0 to length(tgTu) - 1 do
				if (psVal[j] < psVal[i]) then
				begin
					tmpPsVal := psVal[i];
					psVal[i] := psVal[j];
					psVal[j] := tmpPsVal;
					
					tmpTu := tgTu[i];
					tgTu[i] := tgTu[j];
					tgTu[j] := tmpTu;
					
					tmpMau := tgMau[i];
					tgMau[i] := tgMau[j];
					tgMau[j] := tmpMau;
				end;
	end;
	
procedure ChoosePS;
	var i, j, RemoveCode: longint;
	begin
		SetLength(psVal, length(tgTu));
		for i := 0 to length(tgTu) - 1 do 
			psVal[i] := tgTu[i] / tgMau[i];
			
		SortPSTangDan;
		RemoveCode := 0;
		for i := 0 to length(psVal) - 1 do
			if (psVal[i] = psVal[i+1]) then 
			begin
				psVal[i+1] := 0;
				tgTu[i+1] := 0;
				tgMau[i+1] := 0;
				inc(RemoveCode);
			end;
		if (RemoveCode <> 0) then
		begin
			SortPSGiamDan;
			SetLength(psVal, length(psVal) - RemoveCode);
			SetLength(tgTu, length(tgTu) - RemoveCode);
			SetLength(tgMau, length(tgMau) - RemoveCode);
			SortPSTangDan;
		end;
	
		write(fOut, tgTu[k-1], ' ', tgMau[k-1]);
		close(fOut);
		
	end;
	
begin
	initData;
	RutGon;
	ChoosePS;
	writeln('Successfull!!!');
	readln
end.