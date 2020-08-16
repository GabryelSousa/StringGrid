unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, RecordUtils;

type
  WebProduct = record
    produto_id: Integer;
    name: string;
    expiration_date: TDate;
    price: Double;
  end;

  TArrayOfWebProduto = array of WebProduct;

  TFormMain = class(TForm)
    sgProduto: TStringGrid;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain.Button1Click(Sender: TObject);
var
  i: Integer;
  produto: array of WebProduct;
begin
  SetLength(produto, 10);

  for i := 0 to 10 -1  do begin
    produto[i].produto_id := i + 1;
    produto[i].name := 'Product: ' + IntToStr(i);
    produto[i].expiration_date := Now + i + 10;
    produto[i].price := i * 10;
  end;

  RecordUtils.TJsonRecord<WebProduct>.SetColumnName(produto, sgProduto)
end;

end.
