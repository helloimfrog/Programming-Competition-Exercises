uses crt;

var Name: array[1..1000] of string;
	Height: array[1..1000] of extended;
	UnitHeight: array[1..1000] of string;
	fIn, fOut: text;
	StdNum, k: longint;
	
procedure GetStudentData(inData: string; var nm: string; var hg: extended; var un: string);
	var i, errCode, tmp, coutToDel: longint;
	begin
		errCode := 0; tmp := 0; coutToDel := 0;
		nm := ''; hg := 0; un := '';
		
		//Lấy tên học sinh
		for i := 1 to length(inData) do
		begin
			val(inData[i], tmp, errCode);
			if (errCode <> 0) then nm := concat(nm,inData[i])
				else 
				begin
					delete(inData, 1, i-1);
					break;
				end;
		end;
		
		//Lấy đơn vị tính
		for i := length(inData) downto 1 do
		begin
			val(inData[i], tmp, errCode);
			if (errCode <> 0) then 
			begin
				un := concat(inData[i],un);
				inc(coutToDel);
			end
				else 
				begin
					delete(inData, i+1, coutToDel);
					break;
				end;
		end;
		delete(un,1,1);
		
		//Lấy chiều cao
		val(inData, hg, errCode);
	end;
	
function ConvertToMetre(Value: extended; ConvertUnit: string): extended;
	begin
		if (ConvertUnit = 'm') then Value := Value / 1; 
		if (ConvertUnit = 'dm') then Value := Value / 10;
		if (ConvertUnit = 'cm') then Value := Value / 100;
		if (ConvertUnit = 'mm') then Value := Value / 1000;
		exit(Value);
	end;
	
procedure InitData;
	var tmpData: string;
		i: longint;
	begin
		assign(fIn, 'D:\PascalAssetFile\tall.inp');
		assign(fOut, 'D:\PascalAssetFile\tall.out');
		reset(fIn); rewrite(fOut);
		readln(fIn, StdNum, k);
		for i := 1 to StdNum do
		begin
			readln(fIn, tmpData);
			GetStudentData(tmpData, Name[i], Height[i], UnitHeight[i]);
		end;
	end;
	
procedure ProcessingResult;
	var i, j: longint;
		tmpName: string;
		tmpValue: extended;
	begin
		for i := 1 to StdNum do Height[i] := ConvertToMetre(Height[i], UnitHeight[i]);
		for i := 1 to StdNum - 1 do
			for j := i + 1 to StdNum do
				if (Height[i] < Height[j]) then
				begin
					tmpValue := Height[i];
					Height[i] := Height[j];
					Height[j] := tmpValue;
					
					tmpName := Name[i];
					Name[i] := Name[j];
					Name[j] := tmpName;
				end;
	end;
	
procedure SaveResult;
	var i: longint;
	begin
		for i := 1 to k do writeln(fOut, Name[i]);
		close(fOut);
		write('Successfull!');
	end;
	
begin
	InitData;
	ProcessingResult;
	SaveResult;
	readln
end.