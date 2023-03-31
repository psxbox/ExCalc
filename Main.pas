unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Expression;

type
  TFormMain = class(TForm)
    ButtonCalculate: TButton;
    RichEditResult: TRichEdit;
    LabelResult: TLabel;
    MemoExpression: TMemo;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ButtonCalculateClick(Sender: TObject);
  private
    { Private declarations }
    Expression: TExpression;
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain.ButtonCalculateClick(Sender: TObject);
var
  res: string;
  value: Double;
begin
  try
    Expression.Calculate(MemoExpression.Text);
    value := Expression.Result;
    res := FormatFloat(',0.######', value);

    RichEditResult.DefAttributes.Color := clDefault;
  except
    on E: Exception do
    begin
      RichEditResult.DefAttributes.Color := clRed;
      res := e.Message;
    end;
  end;
  RichEditResult.Lines.Text := res;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  Expression := TExpression.Create;
  MemoExpression.Clear;
end;

end.
