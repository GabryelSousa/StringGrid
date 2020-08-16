unit RecordUtils;

interface

uses
  System.Rtti, Vcl.Grids, System.SysUtils;

type
TJsonRecord<T: Record> = class
  public
    class procedure SetColumnName(O: array of T; var grid: TStringGrid);
    class procedure SetCells(O: T; var grid: TStringGrid);
    class function GetAsRecord(AContext: TRttiContext): TRttiRecordType;
  end;

function GetColumn(nome_coluna: string; var grid: TStringGrid): Integer;

implementation

class procedure TJsonRecord<T>.SetColumnName(O: array of T; var grid: TStringGrid);
var
  AContext: TRttiContext;
  field_record: TRttiField;
  ARecord: TRttiRecordType;
  nome_field_json: string;
  AValue: TValue;
  i: Integer;
begin
  AContext := TRttiContext.Create;

  ARecord := GetAsRecord(AContext);
  grid.ColCount := 0;

  for field_record in ARecord.GetFields do begin
    grid.Cells[grid.ColCount -1, 0] := field_record.Name;

    grid.ColCount := grid.ColCount + 1;
  end;

  grid.ColCount := grid.ColCount -1;

  for i := Low(O) to High(O) do begin
    TJsonRecord<T>.SetCells(O[i], grid);
    grid.RowCount := grid.RowCount +1;
  end;

  grid.RowCount := grid.RowCount -1;
end;

class function TJsonRecord<T>.GetAsRecord(AContext: TRttiContext): TRttiRecordType;
begin
  Result := AContext.GetType(TypeInfo(T)).AsRecord;
end;

class procedure TJsonRecord<T>.SetCells(O: T; var grid: TStringGrid);
var
  AField: TRttiField;
  AFldName: String;
  AValue: TValue;
  ArrFields: TArray<TRttiField>;
  AContext: TRttiContext;

  i: Integer;
  line: Integer;
begin
  ArrFields := GetAsRecord(AContext).GetFields;

  line := grid.RowCount -1;

  for AField in ArrFields do begin
    AFldName := AField.Name;
    AValue := AField.GetValue(@O);

    case AField.FieldType.TypeKind of
      tkInteger, tkInt64:
        grid.Cells[GetColumn(AFldName,grid), line] := IntToStr(AValue.AsInt64);

      tkEnumeration:
      if AField.FieldType.ToString.Equals('Boolean') then
        if AValue.AsBoolean then
          grid.Cells[GetColumn(AFldName,grid), line] := 'S'
        else
          grid.Cells[GetColumn(AFldName,grid), line] := 'N'
      else
        grid.Cells[GetColumn(AFldName,grid), line] := IntToStr(AValue.AsInteger);

      tkFloat:
      begin
        if AField.FieldType.ToString.Equals('TDateTime') then
          grid.Cells[GetColumn(AFldName,grid), line] := FormatDateTime('dd/mm/yyyy HH:nn:ss',AValue.AsExtended)
        else if AField.FieldType.ToString.Equals('TDate') then
          grid.Cells[GetColumn(AFldName,grid), line] := FormatDateTime('dd/mm/yyyy', AValue.AsExtended)
        else if AField.FieldType.ToString.Equals('TTime') then
          grid.Cells[GetColumn(AFldName,grid), line] := FormatDateTime('HH:nn:ss', AValue.AsExtended)
        else
          grid.Cells[GetColumn(AFldName,grid), line] := FloatToStr(AValue.AsExtended);
      end;
      tkDynArray:
        Continue;

      tkRecord:
        continue;
    else
      grid.Cells[GetColumn(AFldName,grid), line] := AValue.AsString;
    end;
  end;
end;

function GetColumn(nome_coluna: string; var grid: TStringGrid): Integer;
var
  x: Integer;
begin
  Result := 0;

  for x := 0 to grid.ColCount -1 do begin
    if grid.Cells[x, 0] <> nome_coluna then
      Continue;

    Result := x;
  end;
end;

end.
