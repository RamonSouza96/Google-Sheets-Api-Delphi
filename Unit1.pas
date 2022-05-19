unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, REST.Types,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,System.JSON,
  FMX.Objects, FMX.Edit, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, REST.Response.Adapter, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TForm1 = class(TForm)
    MemResult1: TMemo;
    Codigo: TMemo;
    MemResult2: TMemo;
    Layout1: TLayout;
    Button1: TButton;
    MemResponse: TMemo;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    Parse: TButton;
    Musica: TMemo;
    Cantor: TMemo;
    Text1: TText;
    Edit1: TEdit;
    SpeedButton1: TSpeedButton;
    procedure Button1Click(Sender: TObject);
    procedure ParseClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
begin
RESTClient1.BaseURL:='https://sheets.googleapis.com/v4/spreadsheets/1_IAPJpnRv7D2jWahfsv2lzKUoB994aP0kC1ZylonHGI/values/A1:C27685?majorDimension=ROWS&key=AIzaSyDrRcKA79ajuHu3HoM6KHlLS5F6cO5_Dcc';
RESTRequest1.Execute;
MemResponse.Lines.Add(RESTResponse1.Content);

end;

procedure TForm1.ParseClick(Sender: TObject);
Var
JSonValue :TJSONValue;
resultados : TJSONObject;
ArrayItem: TJSONArray;
 j : integer;
begin

  JSonValue := resultados.ParseJSONValue(TEncoding.UTF8.GetBytes(MemResponse.Text), 0);
  MemResult1.Lines.Add(JSonValue.GetValue<String>('range'));
  MemResult2.Lines.Add(JSonValue.GetValue<String>('majorDimension'));

  ArrayItem := JSonValue.GetValue<TJSONArray>('values');

  Text1.Text:='TOTAL DE ITENS: '+ ArrayItem.Size.ToString;

  for j := 0 to ArrayItem.Size - 1 do
  begin
    Codigo.Lines.Add('Codigo: '+ArrayItem.Get(j).A[0].Value);
    Cantor.Lines.Add('Cantor: '+ArrayItem.Get(j).A[1].Value);
    Musica.Lines.Add(' Musica: '+ArrayItem.Get(j).A[2].Value)
  end;




end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
MemResult1.Text:=EmptyStr;
MemResult2.Text:=EmptyStr;
MemResponse.Text:=EmptyStr;
Codigo.Text:=EmptyStr;
Musica.Text:=EmptyStr;
Cantor.Text:=EmptyStr;
end;

end.
