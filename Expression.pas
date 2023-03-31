unit Expression;

interface

uses
  System.SysUtils, System.StrUtils, Generics.Collections;

type
  TCharList = class(TList<char>);
  TExpression = class

  private
    brackets: TCharList;
    actList: TCharList;
    FResult: double;

    function Calc(exp: string): string;
    function GetActs(exp: string): string;
  public
    constructor Create();
    function Calculate(exp: string): string;
    destructor Destroy; override;

    property Result: double read FResult;
  end;

implementation

{ TExpression }

function TExpression.GetActs(exp: string): string;
var
  res: string;
  I: Integer;
begin
  res := '';
  for I := 0 to exp.Length - 1 do
    if actList.Contains(exp[I]) then
      res := res + exp[I];

  Result := res;
end;

function TExpression.Calc(exp: string): string;
var
  nums: TArray<string>;
  actInd: Integer;
  I: Integer;
  ch: char;
  acts: string;
  temp: double;
  n1: double;
  n2: double;
begin
  nums := exp.Split(actList.ToArray);

  if Length(nums) = 1 then
  begin
    Result := exp;
    exit;
  end;

  acts := GetActs(exp);

  while acts.IndexOfAny(['*', '/']) > -1 do
  begin
    I := acts.IndexOfAny(['*', '/']);
    n1 := nums[I].Replace('M','-').ToDouble;
    n2 := nums[I + 1].Replace('M', '-').ToDouble;
    if acts.Chars[I] = '*' then
      temp := n1 * n2
    else
      temp := n1 / n2;

    Delete(nums, I, 2);
    Insert(temp.ToString, nums, I);
    acts := acts.Remove(I, 1);
  end;

  while acts.IndexOfAny(['+', '-']) > -1 do
  begin
    I := acts.IndexOfAny(['+', '-']);
    n1 := nums[I].Replace('M','-').ToDouble;
    n2 := nums[I + 1].Replace('M', '-').ToDouble;
    if acts.Chars[I] = '+' then
      temp := n1 + n2
    else
      temp := n1 - n2;

    Delete(nums, I, 2);
    Insert(temp.ToString, nums, I);
    acts := acts.Remove(I, 1);
  end;

  Result := nums[0].Replace('-', 'M');

end;

function TExpression.Calculate(exp: string): string;
var
  I: Integer;
  openBracket: char;
  bracketOpened: Boolean;
  index1, index2, ind: Integer;
  ch: char;
  _calc: string;
  value: double;

begin

  exp := exp
    .Replace(' ', '')
    .Trim([' ', #0])
    .Replace(',', FormatSettings.DecimalSeparator)
    .Replace('.', FormatSettings.DecimalSeparator)
    .Replace(#13, '')
    .Replace(#10, '');


  if string.IsNullOrWhiteSpace(exp) then
  begin
    raise Exception.Create('Пустое выражение');
    exit;
  end;

  I := 0;
  while exp.IndexOfAny(brackets.ToArray) <> -1 do
  begin
    ch := exp.Chars[I];
    ind := brackets.IndexOf(ch);
    if ind <> -1 then
    begin
      if ind mod 2 = 0 then
      begin
        bracketOpened := True;
        index1 := I;
        openBracket := brackets[ind];
      end
      else if bracketOpened and (brackets[ind - 1] = openBracket) then
      begin
        index2 := I;

        _calc := Calc(exp.Substring(index1 + 1, index2 - index1 - 1));

        exp := exp.Remove(index1, index2 - index1 + 1).Insert(index1, _calc);
        bracketOpened := false;
        I := 0;
        Continue;
      end
      else
      begin
        raise Exception.Create('Есть незакрытая скобка');
        exit;
      end;
    end;

    Inc(I);
    if I >= exp.Length then
      Break;
  end;

  Result := Calc(exp).Replace('M', '-');

  FResult := Result.ToDouble;

  if not TryStrToFloat(Result, value) then
  begin
    raise Exception.Create('Неверное выражение');
  end
end;

constructor TExpression.Create();
begin
  inherited Create;

  brackets := TCharList.Create();
  brackets.AddRange('{}()[]'.ToCharArray);

  actList := TCharList.Create;
  actList.AddRange('+-*/'.ToCharArray);
end;

destructor TExpression.Destroy;
begin
  brackets.Clear;
  brackets.Destroy;

  actList.Clear;
  actList.Destroy;
  inherited;
end;

end.
