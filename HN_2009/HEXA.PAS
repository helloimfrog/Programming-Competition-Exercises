uses crt;

const hexaCode = '0123456789ABCDEF';
	  fInPath = 'D:\PascalAssetFile\hexa.inp';
	  fOutPath = 'D:\PascalAssetFile\hexa.out';

var inpPos: longint;
	HexaSequence: string;
	fIn, fOut: text;

procedure InitData;
	begin
		assign(fIn, fInPath);
		assign(fOut, fOutPath);
		reset(fIn); rewrite(fOut);
		read(fIn, inpPos);
		close(fIn);
	end;

function HexaConverter(inp: longint): string;
	var kq: string;
		du: longint;
	begin
		kq := '';
		du := 0;
		repeat
			du := inp mod 16;
			kq := concat(hexaCode[du+1], kq);
			inp := inp div 16;
		until inp <= 0;
		exit(kq);
	end;
	
procedure CreateHexaSequence(inp: longint);
	var i: longint;
	begin
		HexaSequence := '';
		for i := 1 to inp do 
			HexaSequence := concat(HexaSequence, HexaConverter(i));

	end;
	
procedure GetAndSaveData;
	begin
		write(fOut, HexaSequence[inpPos]);
		close(fOut);
		write('Successfull!');
	end;
	
begin
	InitData;
	CreateHexaSequence(inpPos);
	GetAndSaveData;
	readln
end.