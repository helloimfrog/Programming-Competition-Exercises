uses crt;

const Encode = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	  Decode = 'ZYXWVUTSRQPONMLKJIHGFEDCBA';
	  
var InpStr, OutStr: string;
	fIn, fOut: text;
	
procedure InitData;
	begin
		assign(fIn, 'D:\PascalAssetFile\enco.inp');
		assign(fOut, 'D:\PascalAssetFile\enco.out');
		reset(fIn); rewrite(fOut);
		read(fIn, InpStr);
		close(fIn);
	end;
	
procedure StartEncoding;
	var i, p: longint;
		tmp: string;
	begin
		OutStr := '';
		for i := 1 to length(InpStr) do
		begin
			tmp := InpStr[i];
			p := pos(tmp, Encode);
			if (p <> 0) then OutStr := concat(OutStr, Decode[p])
				else OutStr := concat(OutStr, InpStr[i])
		end;
	end;
	
procedure SaveResult;
	begin
		write(fOut, OutStr);
		close(fOut);
		write('Successfull!!! String Encoded: ', OutStr);
	end;
	
begin
	InitData;
	StartEncoding;
	SaveResult;
	readln
end.