{
	Ý Tưởng:
	Đầu tiên lấy giá trị lớn nhất Max của dữ liệu đầu vào. Có 2 dạng ghép hình sau!
	+ Dạng 1: Max có 3 giá trị giống nhau: Cộng các giá trị còn lại với nhau. 
			  Nếu bằng Max -> Ghép thành công. Ko thì Fail!
	+ Dạng 2: Số các giá trị Max nhỏ hơn 3: Lấy Max trừ lần lượt với từng số của
			  dữ liệu đầu vào (Không bao gồm Max và các giá trị bằng Max).
			  Nếu như kết quả của phép trừ ấy bằng một trong những số của dữ
			  liệu đầu vào thì tăng 1 đơn vị cho một biến k.tra.
			  Nếu giá trị cuối cùng của biến kiểm tra đó bằng hiệu của Số lượng phần
			  tử đầu vào trừ đi Số phần tử Max thì ghép thành công. Không thì fail!
	#Thanks to Uchiha D Dragneel!
}

uses crt;
type TypeArr = array[1..100] of longint;
var AllValue: TypeArr;
	fIn, fOut: text;
	
//Đọc dữ liệu
procedure initData;
	var i: longint;
	begin
		assign(fIn, 'D:\PascalAssetFile\gh.in');
		assign(fOut, 'D:\PascalAssetFile\gh.ou');
		reset(fIn); rewrite(fOut);
		for i := 1 to 6 do read(fIn, AllValue[i]);
		close(fIn);
	end;
	
//Get lấy phần tử Max của mảng
function getMaxValue(a: TypeArr): longint;
	var tmpMax, i: longint;
	begin
		tmpMax := a[1];
		for i := 1 to length(a) do
			if tmpMax < a[i] then tmpMax := a[i];
		getMaxValue := tmpMax;
	end;
	
	
//Ktra xem số có trong mảng không
function isAppearOnArray(num: longint; a: TypeArr): boolean;
	var i: longint;
	begin
		isAppearOnArray := false;
		for i := 1 to length(a) do
			if (a[i] = num) then
			begin
				isAppearOnArray := true;
				break;
			end;
	end;
	
//Ghép hình dạng 1
procedure GhepHinhType1;
	var i, S, MaxVal: longint;
	begin
		MaxVal := getMaxValue(AllValue);
		S := 0;
		for i := 1 to 6 do
			if (AllValue[i] <> MaxVal)
				then S := S + AllValue[i];
		if (S = MaxVal) then write(fOut, MaxVal)
			else write(fOut, 0);
		close(fOut);
	end;

//Ghép hình dạng 2	
procedure GhepHinhType2(RequestCode: longint);
	var i, S, finishCode, MaxVal, finishCodeOK: longint;
	begin
		finishCodeOK := 6 - RequestCode;
		MaxVal := getMaxValue(AllValue);
		finishCode := 0; S := 0;
		for i := 1 to 6 do
			if (AllValue[i] <> MaxVal) then
			begin
				S := MaxVal - AllValue[i];
				if isAppearOnArray(S, AllValue) then inc(finishCode);
			end;
		if (finishCode = finishCodeOK) then write(fOut, MaxVal)
			else write(fOut, 0);
		close(fOut);
	end;
	
//Xử lý chọn dạng ghép hình
procedure GhepHinh;
	var i, MaxValCout: longint;
	begin
		MaxValCout := 0;
		for i := 1 to 6 do
			if (getMaxValue(AllValue) = AllValue[i])
				then inc(MaxValCout);
		if (MaxValCout = 3) then GhepHinhType1
			else GhepHinhType2(MaxValCout);
		write('Run Complete! Please check the result file!');
	end;
	
begin
	initData;
	GhepHinh;
	readln
end.