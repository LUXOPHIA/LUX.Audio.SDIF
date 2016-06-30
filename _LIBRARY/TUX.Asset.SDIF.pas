unit TUX.Asset.SDIF;

interface //#################################################################### ■

uses System.Classes, System.RegularExpressions,
     LUX, LUX.Graph.Tree;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TPropSDIF = class;
     TNodeSDIF = class;
     TFileSDIF = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropSDIF

     TPropSDIF = class( TTreeNode<TPropSDIF> )
     private
       class var _Reg :TRegEx;
     protected
       _Kind :Integer;
       _Name :String;
       ///// アクセス
       function GetCountX :Integer; virtual; abstract;
       function GetCountY :Integer; virtual; abstract;
       function GetTexts( const Y_,X_:Integer ) :String; virtual; abstract;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); virtual; abstract;
       ///// メソッド
       procedure ReadValues( var F_:TStreamReader; const NY_,NX_:Integer ); virtual; abstract;
     public
       class constructor Create;
       constructor Create; overload; override;
       class function Create( const Kind_:Integer ) :TPropSDIF; overload;
       class function Create( var F_:TStreamReader ) :TPropSDIF; overload;
       destructor Destroy; override;
       ///// プロパティ
       property Kind                         :Integer read   _Kind                 ;
       property Name                         :String  read   _Name                 ;
       property CountX                       :Integer read GetCountX               ;
       property CountY                       :Integer read GetCountY               ;
       property Texts[ const Y_,X_:Integer ] :String  read GetTexts  write SetTexts;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TNodeSDIF

     TNodeSDIF = class( TTreeNode<TPropSDIF> )
     private
     protected
       _Name :String;
       _LayI :Integer;
       _Time :Single;
     public
       constructor Create; overload; override;
       class function Create( const Clss_:String ) :TNodeSDIF; overload;
       destructor Destroy; override;
       ///// プロパティ
       property Name :String  read _Name;
       property LayI :Integer read _LayI;
       property Time :Single  read _Time;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TNodeASTI

     TNodeASTI = class( TNodeSDIF )
     private
     protected
     public
       constructor Create; override;
       destructor Destroy; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TFileSDIF

     TFileSDIF = class( TTreeNode<TNodeSDIF> )
     private
       class var _Reg :TRegEx;
     protected
     public
       class constructor Create;
       constructor Create; override;
       destructor Destroy; override;
       ///// メソッド
       procedure LoadFronFileTex( const FileName_:String );
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses System.SysUtils,
     TUX.Asset.SDIF.Nodes, TUX.Asset.SDIF.Props;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropSDIF

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

class constructor TPropSDIF.Create;
begin
     inherited;

     _Reg := TRegEx.Create( '^\s+(\w{4})\s+(0x\d+)\s+(\d+)\s+(\d+)$' );
end;

constructor TPropSDIF.Create;
begin
     inherited;

end;

class function TPropSDIF.Create( const Kind_:Integer ) :TPropSDIF;
begin
     case Kind_ of
        $0301: Result := TPropChar.Create;
        $0004: Result := TPropFlo4.Create;
        $0008: Result := TPropFlo8.Create;
        $0101: Result := TPropInt1.Create;
        $0102: Result := TPropInt2.Create;
        $0104: Result := TPropInt4.Create;
        $0108: Result := TPropInt8.Create;
        $0201: Result := TPropUIn1.Create;
        $0202: Result := TPropUIn2.Create;
        $0204: Result := TPropUIn4.Create;
        $0208: Result := TPropUIn8.Create;
     else      Result := nil;
     end;

     Result._Kind := Kind_;
end;

class function TPropSDIF.Create( var F_:TStreamReader ) :TPropSDIF;
var
   K, Y, X :Integer;
   M :TMatch;
begin
     M := _Reg.Match( F_.ReadLine );

     Assert( M.Success );

     K := M.Groups[ 2 ].Value.ToInteger;

     Result := TPropSDIF.Create( K );

     Result._Name := M.Groups[ 1 ].Value;

     Y := M.Groups[ 3 ].Value.ToInteger;
     X := M.Groups[ 4 ].Value.ToInteger;

     Result.ReadValues( F_, Y, X );
end;

destructor TPropSDIF.Destroy;
begin

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TNodeSDIF

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TNodeSDIF.Create;
begin
     inherited;

end;

class function TNodeSDIF.Create( const Clss_:String ) :TNodeSDIF;
begin
     if Clss_ = 'Tran' then Result := TNodeTran.Create
                       else
     if Clss_ = 'TmSt' then Result := TNodeTmSt.Create
                       else
     if Clss_ = 'Frmt' then Result := TNodeFrmt.Create
                       else
     if Clss_ = 'BpGa' then Result := TNodeBpGa.Create
                       else
     if Clss_ = 'Rflt' then Result := TNodeRflt.Create
                       else
     if Clss_ = 'Clip' then Result := TNodeClip.Create
                       else
     if Clss_ = 'Gsim' then Result := TNodeGsim.Create
                       else
     if Clss_ = 'Frze' then Result := TNodeFrze.Create
                       else
     if Clss_ = 'Revs' then Result := TNodeRevs.Create
                       else
     if Clss_ = 'Imag' then Result := TNodeImag.Create
                       else
     if Clss_ = 'Brkp' then Result := TNodeBrkp.Create
                       else
     if Clss_ = 'Surf' then Result := TNodeSurf.Create
                       else
     if Clss_ = 'Band' then Result := TNodeBand.Create
                       else
     if Clss_ = 'Noiz' then Result := TNodeNoiz.Create
                       else Result := nil;
end;

destructor TNodeSDIF.Destroy;
begin

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TNodeASTI

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TNodeASTI.Create;
begin
     inherited;

end;

destructor TNodeASTI.Destroy;
begin

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TFileSDIF

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

class constructor TFileSDIF.Create;
begin
     inherited;

     _Reg := TRegEx.Create( '^(\w{4})\s+(\d+)\s+(\d+)\s+(\d+(\.\d+)?)$' );
end;

constructor TFileSDIF.Create;
begin
     inherited;

end;

destructor TFileSDIF.Destroy;
begin

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TFileSDIF.LoadFronFileTex( const FileName_:String );
var
   F :TStreamReader;
   M :TMatch;
   N :record
        Name :String;
        ProN :Integer;
        LayI :Integer;
        Time :Single;
      end;
   PN :TNodeSDIF;
   PP :TPropSDIF;
   S :String;
   I :Integer;
begin
     DeleteChilds;

     F := TStreamReader.Create( FileName_, TEncoding.Default );

     while not F.EndOfStream do
     begin
          M := _Reg.Match( F.ReadLine );

          if M.Success then
          begin
               N.Name := M.Groups[ 1 ].Value          ;
               N.ProN := M.Groups[ 2 ].Value.ToInteger;
               N.LayI := M.Groups[ 3 ].Value.ToInteger;
               N.Time := M.Groups[ 4 ].Value.ToSingle ;

               if N.Name = 'ASTI' then
               begin
                    PN := TNodeASTI.Create;

                    for I := 1 to N.ProN
                    do TPropSDIF.Create( F ).Paren := TPropSDIF( PN );
               end
               else
               if N.Name = '1ASO' then
               begin
                    PP := TPropSDIF.Create( F );

                    Assert( PP is TPropChar, PP.ClassName );

                    S := TPropChar( PP ).Lines[ 0 ];

                    PN := TNodeSDIF.Create( S );

                    PP.Paren := TPropSDIF( PN );

                    for I := 2 to N.ProN
                    do TPropSDIF.Create( F ).Paren := TPropSDIF( PN );
               end
               else PN := nil;

               with PN do
               begin
                    Paren := TPropSDIF( Self );

                    _Name := N.Name;
                    _LayI := N.LayI;
                    _Time := N.Time;
               end;
          end;
     end;

     F.Free;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■