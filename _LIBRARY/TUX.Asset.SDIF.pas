unit TUX.Asset.SDIF;

interface //#################################################################### ■

uses System.Classes, System.RegularExpressions,
     System.UITypes,
     LUX, LUX.Graph.Tree;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TPropSDIF   = class;
     TNodeSDIF   = class;
       TNode1TYP = class;
       TNodeASTI = class;
       TNode1ASO = class;
     TFileSDIF   = class;

     CPropSDIF = class of TPropSDIF;
     CNodeSDIF = class of TNodeSDIF;

     TAnsiChar4 = array [ 0..3 ] of AnsiChar;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% THeaderSDIF

     THeaderSDIF = packed record
     private
       _Signature :TAnsiChar4;
       _FrameSize :Cardinal;
       _Version   :Cardinal;
       _Padding   :Cardinal;
       ///// アクセス
       function GetSignature :TAnsiChar4;
       procedure SetSignature( const Signature_:TAnsiChar4 );
       function GetFrameSize :Cardinal;
       procedure SetFrameSize( const FrameSize_:Cardinal );
       function GetVersion :Cardinal;
       procedure SetVersion( const Version_:Cardinal );
       function GetPadding :Cardinal;
       procedure SetPadding( const Padding_:Cardinal );
     public
       property Signature :TAnsiChar4 read GetSignature write SetSignature;
       property FrameSize :Cardinal   read GetFrameSize write SetFrameSize;
       property Version   :Cardinal   read GetVersion   write SetVersion  ;
       property Padding   :Cardinal   read GetPadding   write SetPadding  ;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TFrameHeaderSDIF

     TFrameHeaderSDIF = packed record
     private
       _Signature   :TAnsiChar4;
       _Size        :Integer;
       _Time        :Double;
       _StreamID    :Integer;
       _MatrixCount :Integer;
       ///// アクセス
       function GetSignature :TAnsiChar4;
       procedure SetSignature( const Signature_:TAnsiChar4 );
       function GetSize :Integer;
       procedure SetSize( const Size_:Integer );
       function GetTime :Double;
       procedure SetTime( const Time_:Double );
       function GetStreamID :Integer;
       procedure SetStreamID( const StreamID_:Integer );
       function GetMatrixCount :Integer;
       procedure SetMatrixCount( const MatrixCount_:Integer );
     public
       property Signature   :TAnsiChar4 read GetSignature   write SetSignature  ;
       property Size        :Integer    read GetSize        write SetSize       ;
       property Time        :Double     read GetTime        write SetTime       ;
       property StreamID    :Integer    read GetStreamID    write SetStreamID   ;
       property MatrixCount :Integer    read GetMatrixCount write SetMatrixCount;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMatrixHeaderSDIF

     TMatrixHeaderSDIF = packed record
     private
       _Signature :TAnsiChar4;
       _DataType  :Integer;
       _RowCount  :Integer;
       _ColCount  :Integer;
       ///// アクセス
       function GetSignature :TAnsiChar4;
       procedure SetSignature( const Signature_:TAnsiChar4 );
       function GetDataType :Integer;
       procedure SetDataType( const DataType_:Integer );
       function GetRowCount :Integer;
       procedure SetRowCount( const RowCount_:Integer );
       function GetColCount :Integer;
       procedure SetColCount( const ColCount_:Integer );
     public
       property Signature :TAnsiChar4 read GetSignature write SetSignature;
       property DataType  :Integer    read GetDataType  write SetDataType ;
       property RowCount  :Integer    read GetRowCount  write SetRowCount ;
       property ColCount  :Integer    read GetColCount  write SetColCount ;
     end;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropSDIF

     TPropSDIF = class( TTreeNode<TPropSDIF> )
     private
       class var _Reg :TRegEx;
     protected
       _Kind     :Integer;
       _Name     :String;
       _RowCount :Integer;
       _ColCount :Integer;
       ///// アクセス
       function GetCountY :Integer; virtual;
       procedure SetCountY( const CountY_:Integer ); virtual;
       function GetCountX :Integer; virtual;
       procedure SetCountX( const CountX_:Integer ); virtual;
       function GetTexts( const Y_,X_:Integer ) :String; virtual; abstract;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); virtual; abstract;
       ///// メソッド
       procedure ReadValues( const F_:TFileStream ); overload; virtual; abstract;
       procedure ReadValues( const F_:TStreamReader ); overload; virtual; abstract;
     public
       class constructor Create;
       constructor Create; overload; override;
       class function Select( const Kind_:Integer ) :CPropSDIF; overload;
       class function ReadCreate( const F_:TFileStream; const P_:TNodeSDIF ) :TPropSDIF; overload;
       class function ReadCreate( const F_:TStreamReader ) :TPropSDIF; overload;
       destructor Destroy; override;
       ///// プロパティ
       property Kind                         :Integer read   _Kind   write _Kind    ;
       property Name                         :String  read   _Name   write _Name    ;
       property CountX                       :Integer read GetCountX write SetCountX;
       property CountY                       :Integer read GetCountY write SetCountY;
       property Texts[ const Y_,X_:Integer ] :String  read GetTexts  write SetTexts ;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TNodeSDIF

     TNodeSDIF = class( TTreeNode<TPropSDIF> )
     private
     protected
       _Name  :String;
       _LayI  :Integer;
       _Time  :Single;
       _Color :TAlphaColor;
     public
       constructor Create; override;
       class function Select( const Signature_:TAnsiChar4 ) :CNodeSDIF;
       class function ReadCreate( const F_:TFileStream; const P_:TFileSDIF ) :TNodeSDIF; overload;
       class function ReadCreate( const F_:TFileStream; const H_:TFrameHeaderSDIF; const P_:TFileSDIF ) :TNodeSDIF; overload; virtual; abstract;
       destructor Destroy; override;
       ///// プロパティ
       property Name  :String      read _Name  write _Name ;
       property LayI  :Integer     read _LayI  write _LayI ;
       property Time  :Single      read _Time  write _Time ;
       property Color :TAlphaColor read _Color write _Color;
       ///// メソッド
       function FindProp( const Name_:String ) :TPropSDIF;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TNode1TYP

     TNode1TYP = class( TNodeSDIF )
     private
     protected
       _Text :TArray<AnsiChar>;
     public
       ///// メソッド
       class function ReadCreate( const F_:TFileStream; const H_:TFrameHeaderSDIF; const P_:TFileSDIF ) :TNodeSDIF; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TNodeASTI

     TNodeASTI = class( TNodeSDIF )
     private
     protected
     public
       ///// メソッド
       class function ReadCreate( const F_:TFileStream; const H_:TFrameHeaderSDIF; const P_:TFileSDIF ) :TNodeSDIF; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TNode1ASO

     TNode1ASO = class( TNodeSDIF )
     private
     protected
     public
       ///// メソッド
       class function Select( const Clss_:String ) :CNodeSDIF;
       class function ReadCreate( const F_:TFileStream; const H_:TFrameHeaderSDIF; const P_:TFileSDIF ) :TNodeSDIF; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TFileSDIF

     TFileSDIF = class( TTreeNode<TNodeSDIF> )
     private
       class var _Reg :TRegEx;
     protected
       _Header :THeaderSDIF;
     public
       class constructor Create;
       constructor Create; override;
       destructor Destroy; override;
       ///// メソッド
       procedure LoadFromFileBin( const FileName_:String );
       procedure SaveToFileBin( const FileName_:String );
       procedure LoadFromFileTex( const FileName_:String );
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses System.SysUtils,
     TUX.Asset.SDIF.Nodes, TUX.Asset.SDIF.Props,
     Main;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% THeaderSDIF

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// アクセス

function THeaderSDIF.GetSignature :TAnsiChar4;
begin
     Result := _Signature;
end;

procedure THeaderSDIF.SetSignature( const Signature_:TAnsiChar4 );
begin
     _Signature := Signature_;
end;

function THeaderSDIF.GetFrameSize :Cardinal;
begin
     Result := RevBytes( _FrameSize );
end;

procedure THeaderSDIF.SetFrameSize( const FrameSize_:Cardinal );
begin
     _FrameSize := RevBytes( FrameSize_ );
end;

function THeaderSDIF.GetVersion :Cardinal;
begin
     Result := RevBytes( _Version );
end;

procedure THeaderSDIF.SetVersion( const Version_:Cardinal );
begin
     _Version := RevBytes( Version_ );
end;

function THeaderSDIF.GetPadding :Cardinal;
begin
     Result := RevBytes( _Padding );
end;

procedure THeaderSDIF.SetPadding( const Padding_:Cardinal );
begin
     _Padding := RevBytes( Padding_ );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TFrameHeaderSDIF

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// アクセス

function TFrameHeaderSDIF.GetSignature :TAnsiChar4;
begin
     Result := _Signature;
end;

procedure TFrameHeaderSDIF.SetSignature( const Signature_:TAnsiChar4 );
begin
     _Signature := Signature_;
end;

function TFrameHeaderSDIF.GetSize :Integer;
begin
     Result := RevBytes( _Size );
end;

procedure TFrameHeaderSDIF.SetSize( const Size_:Integer );
begin
     _Size := RevBytes( Size_ );
end;

function TFrameHeaderSDIF.GetTime :Double;
begin
     Result := RevBytes( _Time );
end;

procedure TFrameHeaderSDIF.SetTime( const Time_:Double );
begin
     _Time := RevBytes( Time_ );
end;

function TFrameHeaderSDIF.GetStreamID :Integer;
begin
     Result := RevBytes( _StreamID );
end;

procedure TFrameHeaderSDIF.SetStreamID( const StreamID_:Integer );
begin
     _StreamID := RevBytes( StreamID_ );
end;

function TFrameHeaderSDIF.GetMatrixCount :Integer;
begin
     Result := RevBytes( _MatrixCount );
end;

procedure TFrameHeaderSDIF.SetMatrixCount( const MatrixCount_:Integer );
begin
     _MatrixCount := RevBytes( MatrixCount_ );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMatrixHeaderSDIF

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// アクセス

function TMatrixHeaderSDIF.GetSignature :TAnsiChar4;
begin
     Result := _Signature;
end;

procedure TMatrixHeaderSDIF.SetSignature( const Signature_:TAnsiChar4 );
begin
     _Signature := Signature_;
end;

function TMatrixHeaderSDIF.GetDataType :Integer;
begin
     Result := RevBytes( _DataType );
end;

procedure TMatrixHeaderSDIF.SetDataType( const DataType_:Integer );
begin
     _DataType := RevBytes( DataType_ );
end;

function TMatrixHeaderSDIF.GetRowCount :Integer;
begin
     Result := RevBytes( _RowCount );
end;

procedure TMatrixHeaderSDIF.SetRowCount( const RowCount_:Integer );
begin
     _RowCount := RevBytes( RowCount_ );
end;

function TMatrixHeaderSDIF.GetColCount :Integer;
begin
     Result := RevBytes( _ColCount );
end;

procedure TMatrixHeaderSDIF.SetColCount( const ColCount_:Integer );
begin
     _ColCount := RevBytes( ColCount_ );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TPropSDIF

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

function TPropSDIF.GetCountY :Integer;
begin
     Result := _RowCount;
end;

procedure TPropSDIF.SetCountY( const CountY_:Integer );
begin
     _RowCount := CountY_;
end;

function TPropSDIF.GetCountX :Integer;
begin
     Result := _ColCount;
end;

procedure TPropSDIF.SetCountX( const CountX_:Integer );
begin
     _ColCount := CountX_;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

class constructor TPropSDIF.Create;
begin
     inherited;

     _Reg := TRegEx.Create( '^\s+(\w{4})\s+(0x\d+)\s+(\d+)\s+(\d+)$' );
end;

constructor TPropSDIF.Create;
begin
     inherited;

     _Kind     := 0;
     _Name     := '';
     _RowCount := 0;
     _ColCount := 0;
end;

class function TPropSDIF.Select( const Kind_:Integer ) :CPropSDIF;
begin
     case Kind_ of
        $0301: Result := TPropChar;
        $0004: Result := TPropFlo4;
        $0008: Result := TPropFlo8;
        $0101: Result := TPropInt1;
        $0102: Result := TPropInt2;
        $0104: Result := TPropInt4;
        $0108: Result := TPropInt8;
        $0201: Result := TPropUIn1;
        $0202: Result := TPropUIn2;
        $0204: Result := TPropUIn4;
        $0208: Result := TPropUIn8;
     else      Result := nil      ;
     end;

     Assert( Assigned( Result ), '$' + Kind_.ToHexString + '：未対応のデータ型です。' );
end;

class function TPropSDIF.ReadCreate( const F_:TFileStream; const P_:TNodeSDIF ) :TPropSDIF;
var
   H :TMatrixHeaderSDIF;
begin
     F_.Read( H, SizeOf( H ) );

     with Form1.Memo1.Lines do
     begin
          Add( '│▽ Matrix Header'                          );
          Add( '│・Signature = '  + H.Signature             );
          Add( '│・DataType  = $' + H.DataType .ToHexString );
          Add( '│・RowCount  = '  + H.RowCount .ToString    );
          Add( '│・ColCount  = '  + H.ColCount .ToString    );
     end;

     Result := TPropSDIF.Select( H.DataType ).Create( P_ );

     with Result do
     begin
          _Kind :=         H.DataType   ;
          _Name := String( H.Signature );

          CountY := H.RowCount;
          CountX := H.ColCount;

          ReadValues( F_ );
     end;
end;

class function TPropSDIF.ReadCreate( const F_:TStreamReader ) :TPropSDIF;
var
   K :Integer;
   M :TMatch;
begin
     M := _Reg.Match( F_.ReadLine );

     Assert( M.Success );

     K := M.Groups[ 2 ].Value.ToInteger;

     Result := TPropSDIF.Select( K ).Create;

     with Result do
     begin
          _Name := M.Groups[ 1 ].Value;
          _Kind := K;
     end;

     with Result do
     begin
          CountY := M.Groups[ 3 ].Value.ToInteger;
          CountX := M.Groups[ 4 ].Value.ToInteger;

          ReadValues( F_ );
     end;
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

     _Name := '';
     _LayI := 0;
     _Time := 0;
end;

class function TNodeSDIF.Select( const Signature_:TAnsiChar4 ) :CNodeSDIF;
begin
     if Signature_ = '1TYP' then Result := TNode1TYP
                            else
     if Signature_ = 'ASTI' then Result := TNodeASTI
                            else
     if Signature_ = '1ASO' then Result := TNode1ASO
                            else Result := nil;

     Assert( Assigned( Result ), Signature_ + '：未対応のフレーム型です。' );
end;

class function TNodeSDIF.ReadCreate( const F_:TFileStream; const P_:TFileSDIF ) :TNodeSDIF;
var
   H :TFrameHeaderSDIF;
begin
     F_.Read( H, SizeOf( H ) );

     with Form1.Memo1.Lines do
     begin
          Add( '▼ Frame Header'                           );
          Add( '・Signature   = ' + H.Signature            );
          Add( '・Size        = ' + H.Size       .ToString );
          Add( '・Time        = ' + H.Time       .ToString );
          Add( '・StreamID    = ' + H.StreamID   .ToString );
          Add( '・MatrixCount = ' + H.MatrixCount.ToString );
     end;

     Result := Select( H.Signature ).ReadCreate( F_, H, P_ );

     with Result do
     begin
          _Name := String( H.Signature );
          _LayI :=         H.StreamID   ;
          _Time :=         H.Time       ;
     end;
end;

destructor TNodeSDIF.Destroy;
begin

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TNodeSDIF.FindProp( const Name_:String ) :TPropSDIF;
var
   I :Integer;
begin
     for I := 0 to ChildsN-1 do
     begin
          Result := Childs[ I ];

          if Result.Name = Name_ then Exit;
     end;

     Result := nil;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TNode1TYP

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

class function TNode1TYP.ReadCreate( const F_:TFileStream; const H_:TFrameHeaderSDIF; const P_:TFileSDIF ) :TNodeSDIF;
begin
     Result := Create( P_ );

     with TNode1TYP( Result ) do
     begin
          SetLength( _Text, H_.Size - 16 );

          F_.Read( _Text[0], H_.Size - 16 );

          with Form1.Memo1.Lines do
          begin
               Add( '▽'                          );
               Add( String( CharsToStr( _Text ) ) );
               Add( '△'                          );
               Add( ''                            );
          end;
     end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TNodeASTI

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

class function TNodeASTI.ReadCreate( const F_:TFileStream; const H_:TFrameHeaderSDIF; const P_:TFileSDIF ) :TNodeSDIF;
var
   P :TNodeSDIF;
   N :Integer;
begin
     P := TNodeSDIF.Create;

     for N := 1 to H_.MatrixCount do TPropSDIF.ReadCreate( F_, P );

     Form1.Memo1.Lines.Add( '' );

     Result := Create( P_ );

     for N := 1 to P.ChildsN do P.Head.Paren := TPropSDIF( Result );

     P.Free;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TNode1ASO

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

class function TNode1ASO.Select( const Clss_:String ) :CNodeSDIF;
//･･････････････････････････････････････････････････････････････
     function Compare( const Signature_:String ) :Boolean;
     begin
          Result := ( AnsiCompareText( Clss_, Signature_ ) = 0 );
     end;
//･･････････････････････････････････････････････････････････････
begin
     if Compare( 'Tran' ) then Result := TNodeTran
                          else
     if Compare( 'TmSt' ) then Result := TNodeTmSt
                          else
     if Compare( 'Frmt' ) then Result := TNodeFrmt
                          else
     if Compare( 'BpGa' ) then Result := TNodeBpGa
                          else
     if Compare( 'Rflt' ) then Result := TNodeRflt
                          else
     if Compare( 'Clip' ) then Result := TNodeClip
                          else
     if Compare( 'Gsim' ) then Result := TNodeGsim
                          else
     if Compare( 'Frze' ) then Result := TNodeFrze
                          else
     if Compare( 'Revs' ) then Result := TNodeRevs
                          else
     if Compare( 'Imag' ) then Result := TNodeImag
                          else
     if Compare( 'Brkp' ) then Result := TNodeBrkp
                          else
     if Compare( 'Surf' ) then Result := TNodeSurf
                          else
     if Compare( 'Band' ) then Result := TNodeBand
                          else
     if Compare( 'Noiz' ) then Result := TNodeNoiz
                          else Result := nil;

     Assert( Assigned( Result ), Clss_ + '：未対応のクラス型です。' );
end;

class function TNode1ASO.ReadCreate( const F_:TFileStream; const H_:TFrameHeaderSDIF; const P_:TFileSDIF ) :TNodeSDIF;
var
   P :TNodeSDIF;
   N :Integer;
begin
     P := TNodeSDIF.Create;

     for N := 1 to H_.MatrixCount do TPropSDIF.ReadCreate( F_, P );

     Form1.Memo1.Lines.Add( '' );

     Result := TNode1ASO.Select( TPropChar( P.FindProp( 'clss' ) ).Lines[ 0 ] ).Create( P_ );

     for N := 1 to P.ChildsN do P.Head.Paren := TPropSDIF( Result );

     P.Free;
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

     with _Header do
     begin
          Signature := 'SDIF';
          FrameSize := 8;
          Version   := 3;
          Padding   := 1;
     end;
end;

destructor TFileSDIF.Destroy;
begin

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TFileSDIF.LoadFromFileBin( const FileName_:String );
var
   F :TFileStream;
begin
     DeleteChilds;

     F := TFileStream.Create( FileName_, fmOpenRead );

     F.Read( _Header, SizeOf( _Header ) );

     with Form1.Memo1.Lines do
     begin
          Add( '▼ File Header'                              );
          Add( '・Signature = ' + _Header.Signature          );
          Add( '・FrameSize = ' + _Header.FrameSize.ToString );
          Add( '・Version   = ' + _Header.Version  .ToString );
          Add( '・Padding   = ' + _Header.Padding  .ToString );
          Add( ''                                            );
     end;

     while F.Position < F.Size do TNodeSDIF.ReadCreate( F, Self );

     F.Free;
end;

procedure TFileSDIF.SaveToFileBin( const FileName_:String );
var
   F :TFileStream;
begin
     F := TFileStream.Create( FileName_, fmCreate );



     F.Free;
end;

procedure TFileSDIF.LoadFromFileTex( const FileName_:String );
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
                    PN := TNodeASTI.Create( Self );

                    for I := 1 to N.ProN
                    do TPropSDIF.ReadCreate( F ).Paren := TPropSDIF( PN );
               end
               else
               if N.Name = '1ASO' then
               begin
                    PP := TPropSDIF.ReadCreate( F );

                    Assert( PP is TPropChar, PP.ClassName );

                    S := TPropChar( PP ).Lines[ 0 ];

                    PN := TNode1ASO.Select( S ).Create( Self );

                    PP.Paren := TPropSDIF( PN );

                    for I := 2 to N.ProN
                    do TPropSDIF.ReadCreate( F ).Paren := TPropSDIF( PN );
               end
               else PN := nil;

               with PN do
               begin
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
