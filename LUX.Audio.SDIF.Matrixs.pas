unit LUX.Audio.SDIF.Matrixs;

interface //#################################################################### ■

uses System.Classes, System.RegularExpressions,
     LUX,
     LUX.Audio.SDIF;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TMatrixSDIF<TVALUE:record> = class;
       TMatrixChar              = class;
       TMatrixFlo4              = class;
       TMatrixFlo8              = class;
       TMatrixInt1              = class;
       TMatrixInt2              = class;
       TMatrixInt4              = class;
       TMatrixInt8              = class;
       TMatrixUIn1              = class;
       TMatrixUIn2              = class;
       TMatrixUIn4              = class;
       TMatrixUIn8              = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMatrixSDIF<TVALUE>

     TMatrixSDIF<TVALUE:record> = class( TMatrixSDIF )
     private
       class var _Reg :TRegEx;
     protected
       _Values :TArray<TVALUE>;
       ///// アクセス
       procedure SetColCount( const ColCount_:Integer ); override;
       procedure SetRowCount( const RowCount_:Integer ); override;
       function GetValues( const Y_,X_:Integer ) :TVALUE; virtual;
       procedure SetValues( const Y_,X_:Integer; const Value_:TVALUE ); virtual;
       ///// メソッド
       procedure ReadValues( const F_:TFileStream ); override;
       procedure ReadValues( const F_:TStreamReader ); override;
     public
       class constructor Create;
       constructor Create; override;
       destructor Destroy; override;
       ///// プロパティ
       property Values[ const Y_,X_:Integer ] :TVALUE read GetValues write SetValues;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMatrixChar

     TMatrixChar = class( TMatrixSDIF<AnsiChar> )
     private
     protected
       ///// アクセス
       function GetTexts( const Y_,X_:Integer ) :String; override;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); override;
       function GetLines( const Y_:Integer ) :String; virtual;
     public
       ///// プロパティ
       property Lines[ const Y_:Integer ] :String read GetLines;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMatrixFlo4

     TMatrixFlo4 = class( TMatrixSDIF<Single> )
     private
     protected
       ///// アクセス
       function GetValues( const Y_,X_:Integer ) :Single; override;
       procedure SetValues( const Y_,X_:Integer; const Value_:Single ); override;
       function GetTexts( const Y_,X_:Integer ) :String; override;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); override;
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMatrixFlo8

     TMatrixFlo8 = class( TMatrixSDIF<Double> )
     private
     protected
       ///// アクセス
       function GetValues( const Y_,X_:Integer ) :Double; override;
       procedure SetValues( const Y_,X_:Integer; const Value_:Double ); override;
       function GetTexts( const Y_,X_:Integer ) :String; override;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); override;
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMatrixInt1

     TMatrixInt1 = class( TMatrixSDIF<Int8> )
     private
     protected
       ///// アクセス
       function GetTexts( const Y_,X_:Integer ) :String; override;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); override;
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMatrixInt2

     TMatrixInt2 = class( TMatrixSDIF<Int16> )
     private
     protected
       ///// アクセス
       function GetValues( const Y_,X_:Integer ) :Int16; override;
       procedure SetValues( const Y_,X_:Integer; const Value_:Int16 ); override;
       function GetTexts( const Y_,X_:Integer ) :String; override;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); override;
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMatrixInt4

     TMatrixInt4 = class( TMatrixSDIF<Int32> )
     private
     protected
       ///// アクセス
       function GetValues( const Y_,X_:Integer ) :Int32; override;
       procedure SetValues( const Y_,X_:Integer; const Value_:Int32 ); override;
       function GetTexts( const Y_,X_:Integer ) :String; override;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); override;
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMatrixInt8

     TMatrixInt8 = class( TMatrixSDIF<Int64> )
     private
     protected
       ///// アクセス
       function GetValues( const Y_,X_:Integer ) :Int64; override;
       procedure SetValues( const Y_,X_:Integer; const Value_:Int64 ); override;
       function GetTexts( const Y_,X_:Integer ) :String; override;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); override;
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMatrixUIn1

     TMatrixUIn1 = class( TMatrixSDIF<UInt8> )
     private
     protected
       ///// アクセス
       function GetTexts( const Y_,X_:Integer ) :String; override;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); override;
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMatrixUIn2

     TMatrixUIn2 = class( TMatrixSDIF<UInt16> )
     private
     protected
       ///// アクセス
       function GetValues( const Y_,X_:Integer ) :UInt16; override;
       procedure SetValues( const Y_,X_:Integer; const Value_:UInt16 ); override;
       function GetTexts( const Y_,X_:Integer ) :String; override;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); override;
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMatrixUIn4

     TMatrixUIn4 = class( TMatrixSDIF<UInt32> )
     private
     protected
       ///// アクセス
       function GetValues( const Y_,X_:Integer ) :UInt32; override;
       procedure SetValues( const Y_,X_:Integer; const Value_:UInt32 ); override;
       function GetTexts( const Y_,X_:Integer ) :String; override;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); override;
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMatrixUIn8

     TMatrixUIn8 = class( TMatrixSDIF<UInt64> )
     private
     protected
       ///// アクセス
       function GetValues( const Y_,X_:Integer ) :UInt64; override;
       procedure SetValues( const Y_,X_:Integer; const Value_:UInt64 ); override;
       function GetTexts( const Y_,X_:Integer ) :String; override;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); override;
     public
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses System.SysUtils, System.Math;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMatrixSDIF<TVALUE>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

procedure TMatrixSDIF<TVALUE>.SetRowCount( const RowCount_:Integer );
begin
     inherited;

     SetLength( _Values, _RowCount * _ColCount );
end;

procedure TMatrixSDIF<TVALUE>.SetColCount( const ColCount_:Integer );
begin
     inherited;

     SetLength( _Values, _RowCount * _ColCount );
end;

function TMatrixSDIF<TVALUE>.GetValues( const Y_,X_:Integer ) :TVALUE;
begin
     Result := _Values[ Y_ * _ColCount + X_ ];
end;

procedure TMatrixSDIF<TVALUE>.SetValues( const Y_,X_:Integer; const Value_:TVALUE );
begin
     _Values[ Y_ * _ColCount + X_ ] := Value_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TMatrixSDIF<TVALUE>.ReadValues( const F_:TFileStream );
var
   N, P :Integer;
begin
     N := _RowCount * _ColCount * SizeOf( TVALUE );

     F_.Read( _Values[ 0 ], N );

     P := 8 * Ceil( N / 8 ) - N;

     F_.Seek( P, soFromCurrent );  // 8 Bytes のアライメント
end;

procedure TMatrixSDIF<TVALUE>.ReadValues( const F_:TStreamReader );
var
   Y, X :Integer;
   Ms :TMatchCollection;
begin
     for Y := 0 to _RowCount-1 do
     begin
          Ms := _Reg.Matches( F_.ReadLine );

          for X := 0 to _ColCount-1 do Texts[ Y, X ] := Ms[ X ].Groups[ 1 ].Value;
     end;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

class constructor TMatrixSDIF<TVALUE>.Create;
begin
     inherited;

     _Reg := TRegEx.Create( '\s+(\S+)' );
end;

constructor TMatrixSDIF<TVALUE>.Create;
begin
     inherited;

end;

destructor TMatrixSDIF<TVALUE>.Destroy;
begin

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMatrixChar

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TMatrixChar.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := Char( Values[ Y_, X_ ] );
end;

procedure TMatrixChar.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     Values[ Y_, X_ ] := AnsiChar( Text_[ 2 ] );
end;

function TMatrixChar.GetLines( const Y_:Integer ) :String;
var
   X :Integer;
begin
     Result := '';

     for X := 0 to ColCount-1 do Result := Result + Char( Values[ Y_, X ] );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMatrixFlo4

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TMatrixFlo4.GetValues( const Y_,X_:Integer ) :Single;
begin
     Result := RevBytes( inherited GetValues( Y_, X_ ) );
end;

procedure TMatrixFlo4.SetValues( const Y_,X_:Integer; const Value_:Single );
begin
     inherited SetValues( Y_, X_, RevBytes( Value_ ) );
end;

function TMatrixFlo4.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := Values[ Y_, X_ ].ToString;
end;

procedure TMatrixFlo4.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     if Text_ = 'nan' then Values[ Y_, X_ ] := Single.NaN
                      else Values[ Y_, X_ ] := Text_.ToSingle;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMatrixFlo8

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TMatrixFlo8.GetValues( const Y_,X_:Integer ) :Double;
begin
     Result := RevBytes( inherited GetValues( Y_, X_ ) );
end;

procedure TMatrixFlo8.SetValues( const Y_,X_:Integer; const Value_:Double );
begin
     inherited SetValues( Y_, X_, RevBytes( Value_ ) );
end;

function TMatrixFlo8.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := Values[ Y_, X_ ].ToString;
end;

procedure TMatrixFlo8.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     if Text_ = 'nan' then Values[ Y_, X_ ] := Double.NaN
                      else Values[ Y_, X_ ] := Text_.ToDouble;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMatrixInt1

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TMatrixInt1.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := Values[ Y_, X_ ].ToString;
end;

procedure TMatrixInt1.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     Values[ Y_, X_ ] := Text_.ToInteger;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMatrixInt2

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TMatrixInt2.GetValues( const Y_,X_:Integer ) :Int16;
begin
     Result := RevBytes( inherited GetValues( Y_, X_ ) );
end;

procedure TMatrixInt2.SetValues( const Y_,X_:Integer; const Value_:Int16 );
begin
     inherited SetValues( Y_, X_, RevBytes( Value_ ) );
end;

function TMatrixInt2.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := Values[ Y_, X_ ].ToString;
end;

procedure TMatrixInt2.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     Values[ Y_, X_ ] := Text_.ToInteger;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMatrixInt4

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TMatrixInt4.GetValues( const Y_,X_:Integer ) :Int32;
begin
     Result := RevBytes( inherited GetValues( Y_, X_ ) );
end;

procedure TMatrixInt4.SetValues( const Y_,X_:Integer; const Value_:Int32 );
begin
     inherited SetValues( Y_, X_, RevBytes( Value_ ) );
end;

function TMatrixInt4.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := Values[ Y_, X_ ].ToString;
end;

procedure TMatrixInt4.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     Values[ Y_, X_ ] := Text_.ToInteger;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMatrixInt8

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TMatrixInt8.GetValues( const Y_,X_:Integer ) :Int64;
begin
     Result := RevBytes( inherited GetValues( Y_, X_ ) );
end;

procedure TMatrixInt8.SetValues( const Y_,X_:Integer; const Value_:Int64 );
begin
     inherited SetValues( Y_, X_, RevBytes( Value_ ) );
end;

function TMatrixInt8.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := Values[ Y_, X_ ].ToString;
end;

procedure TMatrixInt8.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     Values[ Y_, X_ ] := Text_.ToInt64;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMatrixUIn1

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TMatrixUIn1.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := Values[ Y_, X_ ].ToString;
end;

procedure TMatrixUIn1.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     Values[ Y_, X_ ] := Text_.ToInteger;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMatrixUIn2

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TMatrixUIn2.GetValues( const Y_,X_:Integer ) :UInt16;
begin
     Result := RevBytes( inherited GetValues( Y_, X_ ) );
end;

procedure TMatrixUIn2.SetValues( const Y_,X_:Integer; const Value_:UInt16 );
begin
     inherited SetValues( Y_, X_, RevBytes( Value_ ) );
end;

function TMatrixUIn2.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := Values[ Y_, X_ ].ToString;
end;

procedure TMatrixUIn2.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     Values[ Y_, X_ ] := Text_.ToInteger;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMatrixUIn4

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TMatrixUIn4.GetValues( const Y_,X_:Integer ) :UInt32;
begin
     Result := RevBytes( inherited GetValues( Y_, X_ ) );
end;

procedure TMatrixUIn4.SetValues( const Y_,X_:Integer; const Value_:UInt32 );
begin
     inherited SetValues( Y_, X_, RevBytes( Value_ ) );
end;

function TMatrixUIn4.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := Values[ Y_, X_ ].ToString;
end;

procedure TMatrixUIn4.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     Values[ Y_, X_ ] := Text_.ToInteger;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMatrixUIn8

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TMatrixUIn8.GetValues( const Y_,X_:Integer ) :UInt64;
begin
     Result := RevBytes( inherited GetValues( Y_, X_ ) );
end;

procedure TMatrixUIn8.SetValues( const Y_,X_:Integer; const Value_:UInt64 );
begin
     inherited SetValues( Y_, X_, RevBytes( Value_ ) );
end;

function TMatrixUIn8.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := Values[ Y_, X_ ].ToString;
end;

procedure TMatrixUIn8.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     Values[ Y_, X_ ] := Text_.ToInt64;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■
