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
       _Values :TArray2<TVALUE>;
       ///// アクセス
       function GetCountX :Integer; override;
       function GetCountY :Integer; override;
       function GetValues( const Y_,X_:Integer ) :TVALUE; virtual;
       procedure SetValues( const Y_,X_:Integer; const Value_:TVALUE ); virtual;
       ///// メソッド
       procedure ReadValues( var F_:TStreamReader; const NY_,NX_:Integer ); override;
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
       function GetTexts( const Y_,X_:Integer ) :String; override;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); override;
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropFlo8

     TPropFlo8 = class( TPropSDIF<Double> )
     private
     protected
       function GetTexts( const Y_,X_:Integer ) :String; override;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); override;
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropInt1

     TPropInt1 = class( TPropSDIF<Int8> )
     private
     protected
       function GetTexts( const Y_,X_:Integer ) :String; override;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); override;
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropInt2

     TPropInt2 = class( TPropSDIF<Int16> )
     private
     protected
       function GetTexts( const Y_,X_:Integer ) :String; override;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); override;
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropInt4

     TPropInt4 = class( TPropSDIF<Int32> )
     private
     protected
       function GetTexts( const Y_,X_:Integer ) :String; override;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); override;
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropInt8

     TPropInt8 = class( TPropSDIF<Int64> )
     private
     protected
       function GetTexts( const Y_,X_:Integer ) :String; override;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); override;
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropUIn1

     TPropUIn1 = class( TPropSDIF<UInt8> )
     private
     protected
       function GetTexts( const Y_,X_:Integer ) :String; override;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); override;
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropUIn2

     TPropUIn2 = class( TPropSDIF<UInt16> )
     private
     protected
       function GetTexts( const Y_,X_:Integer ) :String; override;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); override;
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropUIn4

     TPropUIn4 = class( TPropSDIF<UInt32> )
     private
     protected
       function GetTexts( const Y_,X_:Integer ) :String; override;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); override;
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropUIn8

     TPropUIn8 = class( TPropSDIF<UInt64> )
     private
     protected
       function GetTexts( const Y_,X_:Integer ) :String; override;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); override;
     public
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses System.SysUtils;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropSDIF<TVALUE>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TPropSDIF<TVALUE>.GetCountX :Integer;
begin
     Result := Length( _Values[ 0 ] );
end;

function TPropSDIF<TVALUE>.GetCountY :Integer;
begin
     Result := Length( _Values );
end;

function TPropSDIF<TVALUE>.GetValues( const Y_,X_:Integer ) :TVALUE;
begin
     Result := _Values[ Y_, X_ ];
end;

procedure TPropSDIF<TVALUE>.SetValues( const Y_,X_:Integer; const Value_:TVALUE );
begin
     _Values[ Y_, X_ ] := Value_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TPropSDIF<TVALUE>.ReadValues( var F_:TStreamReader; const NY_,NX_:Integer );
var
   Y, X :Integer;
   Ms :TMatchCollection;
begin
     SetLength( _Values, NY_, NX_ );

     for Y := 0 to NY_-1 do
     begin
          Ms := _Reg.Matches( F_.ReadLine );

          for X := 0 to NX_-1 do Texts[ Y, X ] := Ms[ X ].Groups[ 1 ].Value;
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

/////////////////////////////////////////////////////////////////////// メソッド

function TPropChar.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := '''' + _Values[ Y_, X_ ] + '''';
end;

procedure TPropChar.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     _Values[ Y_, X_ ] := AnsiChar( Text_[ 2 ] );
end;

function TPropChar.GetLines( const Y_:Integer ) :String;
var
   X :Integer;
begin
     Result := '';

     for X := 0 to CountX-1 do Result := Result + String( _Values[ Y_, X ] );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropFlo4

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// メソッド

function TPropFlo4.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := _Values[ Y_, X_ ].ToString;
end;

procedure TPropFlo4.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     if Text_ = 'nan' then _Values[ Y_, X_ ] := Single.NaN
                      else _Values[ Y_, X_ ] := Text_.ToSingle;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropFlo8

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// メソッド

function TPropFlo8.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := _Values[ Y_, X_ ].ToString;
end;

procedure TPropFlo8.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     if Text_ = 'nan' then _Values[ Y_, X_ ] := Double.NaN
                      else _Values[ Y_, X_ ] := Text_.ToDouble;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropInt1

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// メソッド

function TPropInt1.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := _Values[ Y_, X_ ].ToString;
end;

procedure TPropInt1.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     _Values[ Y_, X_ ] := Text_.ToInteger;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropInt2

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// メソッド

function TPropInt2.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := _Values[ Y_, X_ ].ToString;
end;

procedure TPropInt2.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     _Values[ Y_, X_ ] := Text_.ToInteger;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropInt4

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// メソッド

function TPropInt4.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := _Values[ Y_, X_ ].ToString;
end;

procedure TPropInt4.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     _Values[ Y_, X_ ] := Text_.ToInteger;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropInt8

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// メソッド

function TPropInt8.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := _Values[ Y_, X_ ].ToString;
end;

procedure TPropInt8.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     _Values[ Y_, X_ ] := Text_.ToInt64;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropUIn1

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// メソッド

function TPropUIn1.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := _Values[ Y_, X_ ].ToString;
end;

procedure TPropUIn1.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     _Values[ Y_, X_ ] := Text_.ToInteger;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropUIn2

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// メソッド

function TPropUIn2.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := _Values[ Y_, X_ ].ToString;
end;

procedure TPropUIn2.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     _Values[ Y_, X_ ] := Text_.ToInteger;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropUIn4

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// メソッド

function TPropUIn4.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := _Values[ Y_, X_ ].ToString;
end;

procedure TPropUIn4.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     _Values[ Y_, X_ ] := Text_.ToInteger;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropUIn8

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// メソッド

function TPropUIn8.GetTexts( const Y_,X_:Integer ) :String;
begin
     Result := _Values[ Y_, X_ ].ToString;
end;

procedure TPropUIn8.SetTexts( const Y_,X_:Integer; const Text_:String );
begin
     _Values[ Y_, X_ ] := Text_.ToInt64;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■
