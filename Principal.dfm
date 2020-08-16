object FormMain: TFormMain
  Left = 0
  Top = 0
  ActiveControl = sgProduto
  Caption = 'Test RTTI'
  ClientHeight = 242
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object sgProduto: TStringGrid
    Left = 8
    Top = 8
    Width = 456
    Height = 201
    ColCount = 2
    DefaultRowHeight = 20
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
    TabOrder = 0
  end
  object Button1: TButton
    Left = 389
    Top = 215
    Width = 75
    Height = 25
    Caption = 'Go'
    TabOrder = 1
    OnClick = Button1Click
  end
end
