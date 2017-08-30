uses crt;

type DynamicArr2 = array of array of longint; //Mảng 2 chiều động
	 DynamicArr1 = array of longint;
     NormalArr = array[1..10000] of longint;
	 
const fInPath = 'D:\PascalAssetFile\clb.in';
      fOutPath = 'D:\PascalAssetFile\clb.ou';
	  
var InpArr: DynamicArr2;
	GetMaxArr: NormalArr;
	ChoosedMem: DynamicArr1;
	fIn, fOut: text;
	NumOfClub, InpArrLgI, InpArrLgJ: longint;
	
procedure initData;
	var i, j, k, a, b: longint;
	begin
		assign(fIn, fInPath);
		assign(fOut, fOutPath);
		reset(fIn); rewrite(fOut);
		read(fIn, NumOfClub);
		InpArrLgJ := NumOfClub;
		for i := 1 to (NumOfClub * 2) do read(fIn, GetMaxArr[i]);
		InpArrLgI := GetMaxArr[1];
		for i := 1 to (NumOfClub * 2) do
			if GetMaxArr[i] > InpArrLgI then 
			begin
				InpArrLgI := GetMaxArr[i];
				k := i;
			end;
		InpArrLgI := InpArrLgI - GetMaxArr[k-1] + 1;
		close(fIn);
		SetLength(InpArr, InpArrLgI, InpArrLgJ);
		
		reset(fIn);
		read(fIn, NumOfClub);
		for j := 0 to InpArrLgJ - 1 do
		begin
			read(fIn, a, b);
			for i := 0 to InpArrLgI - 1 do
				for k := a to b do
				begin
					InpArr[i,j] := k;
					inc(a);
					break;
				end;
		end;
		close(fIn);
	end;
	
function isAppearOnArray(val, line: longint): boolean;
	var i: longint;
	begin
		isAppearOnArray := false;
		for i := 0 to length(InpArr) - 1 do
		begin
			if (val = InpArr[i,line-1]) then
			begin
				isAppearOnArray := true;
				break;
			end;
		end;
	end;
	
procedure ChooseMember; 
	var i, j, Choosed: longint;
	begin
		Choosed := 0;
		for j := 0 to InpArrLgJ - 1 do
			for i := 0 to InpArrLgI - 1 do
			begin
				if (InpArr[i,j] <> 0) and isAppearOnArray(InpArr[i,j], j+2) then
				begin
					inc(Choosed);
					SetLength(ChoosedMem, Choosed);
					ChoosedMem[Choosed - 1] := InpArr[i,j];
				end;
			end;
		for i := 0 to length(ChoosedMem) - 1 do write(ChoosedMem[i]:3);
		for j := 0 to InpArrLgJ - 1 do
		begin
			if (ChoosedMem[Choosed - 1] < InpArr[0,j]) then
			begin
				writeln(InpArr[0,j]);
				inc(Choosed,2);
			end;
		end;
		writeln(Choosed);
	end;

begin
	initData;
	ChooseMember;
	readln
end.