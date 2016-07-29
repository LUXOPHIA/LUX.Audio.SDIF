unit TUX.Asset.SDIF.Props;

interface //#################################################################### ■

uses System.Classes, System.RegularExpressions,
     LUX,
     TUX.Asset.SDIF;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TPropSDIF<TVALUE:record> = class;
       TPropChar              = class;
       TPropFlo4              = class;
       TPropFlo8              = class;
       TPropInt1              = class;
       TPropInt2              = class;
       TPropInt4              = class;
       TPropInt8              = class;
       TPropUIn1              = class;
       TPropUIn2              = class;
       TPropUIn4              = class;
       TPropUIn8              = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropSDIF<TVALUE>

     TPropSDIF<TVALUE:record> = class( TPropSDIF )
     private
       class var _Reg :TRegEx;
     protected
       _Values :TArray<TVALUE>;
       ///// アクセス
       procedure SetCountX( const CountX_:Integer ); override;
       procedure SetCountY( const CountY_:Integer ); override;
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

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropChar

     TPropChar = class( TPropSDIF<AnsiChar> )
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

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropFlo4

     TPropFlo4 = class( TPropSDIF<Single> )
     private
     protected
       ///// アクセス
       function GetValues( const Y_,X_:Integer ) :Single; override;
       procedure SetValues( const Y_,X_:Integer; const Value_:Single ); override;
       function GetTexts( const Y_,X_:Integer ) :String; override;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); override;
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropFlo8

     TPropFlo8 = class( TPropSDIF<Double> )
     private
     protected
       ///// アクセス
       function GetValues( const Y_,X_:Integer ) :Double; override;
       procedure SetValues( const Y_,X_:Integer; const Value_:Double ); override;
       function GetTexts( const Y_,X_:Integer ) :String; override;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); override;
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropInt1

     TPropInt1 = class( TPropSDIF<Int8> )
     private
     protected
       ///// アクセス
       function GetTexts( const Y_,X_:Integer ) :String; override;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); override;
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropInt2

     TPropInt2 = class( TPropSDIF<Int16> )
     private
     protected
       ///// アクセス
       function GetValues( const Y_,X_:Integer ) :Int16; override;
       procedure SetValues( const Y_,X_:Integer; const Value_:Int16 ); override;
       function GetTexts( const Y_,X_:Integer ) :String; override;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); override;
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropInt4

     TPropInt4 = class( TPropSDIF<Int32> )
     private
     protected
       ///// アクセス
       function GetValues( const Y_,X_:Integer ) :Int32; override;
       procedure SetValues( const Y_,X_:Integer; const Value_:Int32 ); override;
       function GetTexts( const Y_,X_:Integer ) :String; override;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); override;
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropInt8

     TPropInt8 = class( TPropSDIF<Int64> )
     private
     protected
       ///// アクセス
       function GetValues( const Y_,X_:Integer ) :Int64; override;
       procedure SetValues( const Y_,X_:Integer; const Value_:Int64 ); override;
       function GetTexts( const Y_,X_:Integer ) :String; override;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); override;
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropUIn1

     TPropUIn1 = class( TPropSDIF<UInt8> )
     private
     protected
       ///// アクセス
       function GetTexts( const Y_,X_:Integer ) :String; override;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); override;
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropUIn2

     TPropUIn2 = class( TPropSDIF<UInt16> )
     private
     protected
       ///// アクセス
       function GetValues( const Y_,X_:Integer ) :UInt16; override;
       procedure SetValues( const Y_,X_:Integer; const Value_:UInt16 ); override;
       function GetTexts( const Y_,X_:Integer ) :String; override;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); override;
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropUIn4

     TPropUIn4 = class( TPropSDIF<UInt32> )
     private
     protected
       ///// アクセス
       function GetValues( const Y_,X_:Integer ) :UInt32; override;
       procedure SetValues( const Y_,X_:Integer; const Value_:UInt32 ); override;
       function GetTexts( const Y_,X_:Integer ) :String; override;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); override;
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropUIn8

     TPropUIn8 = class( TPropSDIF<UInt64> )
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

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropSDIF<TVALUE>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

procedure TPropSDIF<TVALUE>.SetCountY( const CountY_:Integer );
begin
     inherited;

     SetLength( _Values, _RowCount * _ColCount );
end;

procedure TPropSDIF<TVALUE>.SetCountX( const CountX_:Integer );
begin
     inherited;

     SetLength( _Values, _RowCount * _ColCount );
end;

function TPropSDIF<TVALUE>.GetValues( const Y_,X_:Integer ) :TVALUE;
begin
     Result := _Values[ Y_ * _ColCount + X_ ];
end;

procedure TPropSDIF<TVALUE>.SetValues( const Y_,X_:Integer; const Value_:TVALUE );
begin
     _Values[ Y_ * _ColCount + X_ ] := Value_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TPropSDIF<TVALUE>.ReadValues( const F_:TFileStream );
var
   N, P :Integer;
begin
     N := _RowCount * _ColCount * SizeOf( TVALUE );

     F_.Read( _Values[ 0 ], N );

     P := 8 * Ceil( N / 8 ) - N;

     F_.Seek( P, soFromCurrent );  // 8 Bytes のアライメント
end;

procedure TPropSDIF<TVALUE>.ReadValues( const F_:TStreamReader );
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

class constructor TPropSDIF<TVALUE>.Create;
begin
     inherited;

     _Reg := TRegEx.Create( '\s+(\S+)' );
end;

constructor TPropSDIF<TVALUE>.Create;
begin
     inherited;

end;

destructor TPropSDIF<TVALUE>.Destroy;
begin

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropChar

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TPropChar.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := Values[ Y_, X_ ];
end;

procedure TPropChar.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     Values[ Y_, X_ ] := AnsiChar( Text_[ 2 ] );
end;

function TPropChar.GetLines( const Y_:Integer ) :String;
var
   X :Integer;
begin
     Result := '';

     for X := 0 to CountX-1 do Result := Result + Char( Values[ Y_, X ] );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropFlo4

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TPropFlo4.GetValues( const Y_,X_:Integer ) :Single;
begin
     Result := RevBytes( inherited GetValues( Y_, X_ ) );
end;

procedure TPropFlo4.SetValues( const Y_,X_:Integer; const Value_:Single );
begin
     inherited SetValues( Y_, X_, RevBytes( Value_ ) );
end;

function TPropFlo4.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := Values[ Y_, X_ ].ToString;
end;

procedure TPropFlo4.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     if Text_ = 'nan' then Values[ Y_, X_ ] := Single.NaN
                      else Values[ Y_, X_ ] := Text_.ToSingle;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropFlo8

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TPropFlo8.GetValues( const Y_,X_:Integer ) :Double;
begin
     Result := RevBytes( inherited GetValues( Y_, X_ ) );
end;

procedure TPropFlo8.SetValues( const Y_,X_:Integer; const Value_:Double );
begin
     inherited SetValues( Y_, X_, RevBytes( Value_ ) );
end;

function TPropFlo8.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := Values[ Y_, X_ ].ToString;
end;

procedure TPropFlo8.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     if Text_ = 'nan' then Values[ Y_, X_ ] := Double.NaN
                      else Values[ Y_, X_ ] := Text_.ToDouble;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropInt1

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TPropInt1.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := Values[ Y_, X_ ].ToString;
end;

procedure TPropInt1.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     Values[ Y_, X_ ] := Text_.ToInteger;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropInt2

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TPropInt2.GetValues( const Y_,X_:Integer ) :Int16;
begin
     Result := RevBytes( inherited GetValues( Y_, X_ ) );
end;

procedure TPropInt2.SetValues( const Y_,X_:Integer; const Value_:Int16 );
begin
     inherited SetValues( Y_, X_, RevBytes( Value_ ) );
end;

function TPropInt2.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := Values[ Y_, X_ ].ToString;
end;

procedure TPropInt2.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     Values[ Y_, X_ ] := Text_.ToInteger;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropInt4

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TPropInt4.GetValues( const Y_,X_:Integer ) :Int32;
begin
     Result := RevBytes( inherited GetValues( Y_, X_ ) );
end;

procedure TPropInt4.SetValues( const Y_,X_:Integer; const Value_:Int32 );
begin
     inherited SetValues( Y_, X_, RevBytes( Value_ ) );
end;

function TPropInt4.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := Values[ Y_, X_ ].ToString;
end;

procedure TPropInt4.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     Values[ Y_, X_ ] := Text_.ToInteger;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropInt8

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TPropInt8.GetValues( const Y_,X_:Integer ) :Int64;
begin
     Result := RevBytes( inherited GetValues( Y_, X_ ) );
end;

procedure TPropInt8.SetValues( const Y_,X_:Integer; const Value_:Int64 );
begin
     inherited SetValues( Y_, X_, RevBytes( Value_ ) );
end;

function TPropInt8.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := Values[ Y_, X_ ].ToString;
end;

procedure TPropInt8.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     Values[ Y_, X_ ] := Text_.ToInt64;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropUIn1

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TPropUIn1.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := Values[ Y_, X_ ].ToString;
end;

procedure TPropUIn1.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     Values[ Y_, X_ ] := Text_.ToInteger;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropUIn2

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TPropUIn2.GetValues( const Y_,X_:Integer ) :UInt16;
begin
     Result := RevBytes( inherited GetValues( Y_, X_ ) );
end;

procedure TPropUIn2.SetValues( const Y_,X_:Integer; const Value_:UInt16 );
begin
     inherited SetValues( Y_, X_, RevBytes( Value_ ) );
end;

function TPropUIn2.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := Values[ Y_, X_ ].ToString;
end;

procedure TPropUIn2.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     Values[ Y_, X_ ] := Text_.ToInteger;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropUIn4

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TPropUIn4.GetValues( const Y_,X_:Integer ) :UInt32;
begin
     Result := RevBytes( inherited GetValues( Y_, X_ ) );
end;

procedure TPropUIn4.SetValues( const Y_,X_:Integer; const Value_:UInt32 );
begin
     inherited SetValues( Y_, X_, RevBytes( Value_ ) );
end;

function TPropUIn4.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := Values[ Y_, X_ ].ToString;
end;

procedure TPropUIn4.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     Values[ Y_, X_ ] := Text_.ToInteger;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropUIn8

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TPropUIn8.GetValues( const Y_,X_:Integer ) :UInt64;
begin
     Result := RevBytes( inherited GetValues( Y_, X_ ) );
end;

procedure TPropUIn8.SetValues( const Y_,X_:Integer; const Value_:UInt64 );
begin
     inherited SetValues( Y_, X_, RevBytes( Value_ ) );
end;

function TPropUIn8.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := Values[ Y_, X_ ].ToString;
end;

procedure TPropUIn8.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     Values[ Y_, X_ ] := Text_.ToInt64;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■
