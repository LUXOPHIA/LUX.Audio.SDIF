unit TUX.Asset.SDIF;

interface //#################################################################### ■

uses System.Classes, System.RegularExpressions,
     System.UITypes,
     LUX, LUX.Graph.Tree;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TMatrixSDIF  = class;
     TFrameSDIF   = class;
       TFrame1TYP = class;
       TFrameASTI = class;
       TFrame1ASO = class;
     TFileSDIF    = class;

     CMatrixSDIF = class of TMatrixSDIF;
     CFrameSDIF  = class of TFrameSDIF;

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

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMatrixSDIF

     TMatrixSDIF = class( TTreeNode<TMatrixSDIF> )
     private
       class var _Reg :TRegEx;
     protected
       _Signature :String;
       _DataType  :Integer;
       _RowCount  :Integer;
       _ColCount  :Integer;
       ///// アクセス
       function GetRowCount :Integer; virtual;
       procedure SetRowCount( const RowCount_:Integer ); virtual;
       function GetColCount :Integer; virtual;
       procedure SetColCount( const ColCount_:Integer ); virtual;
       function GetTexts( const Y_,X_:Integer ) :String; virtual; abstract;
       procedure SetTexts( const Y_,X_:Integer; const Text_:String ); virtual; abstract;
       ///// メソッド
       procedure ReadValues( const F_:TFileStream ); overload; virtual; abstract;
       procedure ReadValues( const F_:TStreamReader ); overload; virtual; abstract;
     public
       class constructor Create;
       constructor Create; overload; override;
       class function Select( const DataType_:Integer ) :CMatrixSDIF; overload;
       class function ReadCreate( const F_:TFileStream; const P_:TFrameSDIF ) :TMatrixSDIF; overload;
       class function ReadCreate( const F_:TStreamReader ) :TMatrixSDIF; overload;
       destructor Destroy; override;
       ///// プロパティ
       property Signature                    :String  read   _Signature write   _Signature;
       property DataType                     :Integer read   _DataType  write   _DataType ;
       property ColCount                     :Integer read GetColCount  write SetColCount ;
       property RowCount                     :Integer read GetRowCount  write SetRowCount ;
       property Texts[ const Y_,X_:Integer ] :String  read GetTexts     write SetTexts    ;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TFrameSDIF

     TFrameSDIF = class( TTreeNode<TMatrixSDIF> )
     private
     protected
       _Signature :String;
       _StreamID  :Integer;
       _Time      :Single;
       _Color     :TAlphaColor;
     public
       constructor Create; override;
       class function Select( const Signature_:TAnsiChar4 ) :CFrameSDIF;
       class function ReadCreate( const F_:TFileStream; const P_:TFileSDIF ) :TFrameSDIF; overload;
       class function ReadCreate( const F_:TFileStream; const H_:TFrameHeaderSDIF; const P_:TFileSDIF ) :TFrameSDIF; overload; virtual; abstract;
       destructor Destroy; override;
       ///// プロパティ
       property Signature  :String      read _Signature write _Signature;
       property StreamID   :Integer     read _StreamID  write _StreamID ;
       property Time       :Single      read _Time      write _Time     ;
       property Color      :TAlphaColor read _Color     write _Color    ;
       ///// メソッド
       function FindMatrix( const Signature_:String ) :TMatrixSDIF;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TFrame1TYP

     TFrame1TYP = class( TFrameSDIF )
     private
     protected
       _Text :TArray<AnsiChar>;
     public
       ///// メソッド
       class function ReadCreate( const F_:TFileStream; const H_:TFrameHeaderSDIF; const P_:TFileSDIF ) :TFrameSDIF; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TFrameASTI

     TFrameASTI = class( TFrameSDIF )
     private
     protected
     public
       ///// メソッド
       class function ReadCreate( const F_:TFileStream; const H_:TFrameHeaderSDIF; const P_:TFileSDIF ) :TFrameSDIF; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TFrame1ASO

     TFrame1ASO = class( TFrameSDIF )
     private
     protected
     public
       ///// メソッド
       class function Select( const Clss_:String ) :CFrameSDIF;
       class function ReadCreate( const F_:TFileStream; const H_:TFrameHeaderSDIF; const P_:TFileSDIF ) :TFrameSDIF; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TFileSDIF

     TFileSDIF = class( TTreeNode<TFrameSDIF> )
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
     TUX.Asset.SDIF.Frames, TUX.Asset.SDIF.Matrixs,
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

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMatrixSDIF

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

function TMatrixSDIF.GetRowCount :Integer;
begin
     Result := _RowCount;
end;

procedure TMatrixSDIF.SetRowCount( const RowCount_:Integer );
begin
     _RowCount := RowCount_;
end;

function TMatrixSDIF.GetColCount :Integer;
begin
     Result := _ColCount;
end;

procedure TMatrixSDIF.SetColCount( const ColCount_:Integer );
begin
     _ColCount := ColCount_;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

class constructor TMatrixSDIF.Create;
begin
     inherited;

     _Reg := TRegEx.Create( '^\s+(\w{4})\s+(0x\d+)\s+(\d+)\s+(\d+)$' );
end;

constructor TMatrixSDIF.Create;
begin
     inherited;

     _Signature := '';
     _DataType  := 0;
     _RowCount  := 0;
     _ColCount  := 0;
end;

class function TMatrixSDIF.Select( const DataType_:Integer ) :CMatrixSDIF;
begin
     case DataType_ of
        $0301: Result := TMatrixChar;
        $0004: Result := TMatrixFlo4;
        $0008: Result := TMatrixFlo8;
        $0101: Result := TMatrixInt1;
        $0102: Result := TMatrixInt2;
        $0104: Result := TMatrixInt4;
        $0108: Result := TMatrixInt8;
        $0201: Result := TMatrixUIn1;
        $0202: Result := TMatrixUIn2;
        $0204: Result := TMatrixUIn4;
        $0208: Result := TMatrixUIn8;
     else      Result := nil        ;
     end;

     Assert( Assigned( Result ), '$' + DataType_.ToHexString + '：未対応のデータ型です。' );
end;

class function TMatrixSDIF.ReadCreate( const F_:TFileStream; const P_:TFrameSDIF ) :TMatrixSDIF;
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

     Result := TMatrixSDIF.Select( H.DataType ).Create( P_ );

     with Result do
     begin
          _Signature := String( H.Signature );
          _DataType  :=         H.DataType   ;

          RowCount   := H.RowCount;
          ColCount   := H.ColCount;

          ReadValues( F_ );
     end;
end;

class function TMatrixSDIF.ReadCreate( const F_:TStreamReader ) :TMatrixSDIF;
var
   T :Integer;
   M :TMatch;
begin
     M := _Reg.Match( F_.ReadLine );

     Assert( M.Success );

     T := M.Groups[ 2 ].Value.ToInteger;

     Result := TMatrixSDIF.Select( T ).Create;

     with Result do
     begin
          _Signature := M.Groups[ 1 ].Value;
          _DataType  := T;
     end;

     with Result do
     begin
          RowCount := M.Groups[ 3 ].Value.ToInteger;
          ColCount := M.Groups[ 4 ].Value.ToInteger;

          ReadValues( F_ );
     end;
end;

destructor TMatrixSDIF.Destroy;
begin

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TFrameSDIF

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TFrameSDIF.Create;
begin
     inherited;

     _Signature := '';
     _StreamID  := 0;
     _Time      := 0;
end;

class function TFrameSDIF.Select( const Signature_:TAnsiChar4 ) :CFrameSDIF;
begin
     if Signature_ = '1TYP' then Result := TFrame1TYP
                            else
     if Signature_ = 'ASTI' then Result := TFrameASTI
                            else
     if Signature_ = '1ASO' then Result := TFrame1ASO
                            else Result := nil;

     Assert( Assigned( Result ), Signature_ + '：未対応のフレーム型です。' );
end;

class function TFrameSDIF.ReadCreate( const F_:TFileStream; const P_:TFileSDIF ) :TFrameSDIF;
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
          _Signature := String( H.Signature );
          _StreamID  :=         H.StreamID   ;
          _Time      :=         H.Time       ;
     end;
end;

destructor TFrameSDIF.Destroy;
begin

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TFrameSDIF.FindMatrix( const Signature_:String ) :TMatrixSDIF;
var
   I :Integer;
begin
     for I := 0 to ChildsN-1 do
     begin
          Result := Childs[ I ];

          if Result.Signature = Signature_ then Exit;
     end;

     Result := nil;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TFrame1TYP

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

class function TFrame1TYP.ReadCreate( const F_:TFileStream; const H_:TFrameHeaderSDIF; const P_:TFileSDIF ) :TFrameSDIF;
begin
     Result := Create( P_ );

     with TFrame1TYP( Result ) do
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

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TFrameASTI

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

class function TFrameASTI.ReadCreate( const F_:TFileStream; const H_:TFrameHeaderSDIF; const P_:TFileSDIF ) :TFrameSDIF;
var
   P :TFrameSDIF;
   N :Integer;
begin
     P := TFrameSDIF.Create;

     for N := 1 to H_.MatrixCount do TMatrixSDIF.ReadCreate( F_, P );

     Form1.Memo1.Lines.Add( '' );

     Result := Create( P_ );

     for N := 1 to P.ChildsN do P.Head.Paren := TMatrixSDIF( Result );

     P.Free;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TFrame1ASO

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

class function TFrame1ASO.Select( const Clss_:String ) :CFrameSDIF;
//･･････････････････････････････････････････････････････････････
     function Compare( const Signature_:String ) :Boolean;
     begin
          Result := ( AnsiCompareText( Clss_, Signature_ ) = 0 );
     end;
//･･････････････････････････････････････････････････････････････
begin
     if Compare( 'Tran' ) then Result := TFrameTran
                          else
     if Compare( 'TmSt' ) then Result := TFrameTmSt
                          else
     if Compare( 'Frmt' ) then Result := TFrameFrmt
                          else
     if Compare( 'BpGa' ) then Result := TFrameBpGa
                          else
     if Compare( 'Rflt' ) then Result := TFrameRflt
                          else
     if Compare( 'Clip' ) then Result := TFrameClip
                          else
     if Compare( 'Gsim' ) then Result := TFrameGsim
                          else
     if Compare( 'Frze' ) then Result := TFrameFrze
                          else
     if Compare( 'Revs' ) then Result := TFrameRevs
                          else
     if Compare( 'Imag' ) then Result := TFrameImag
                          else
     if Compare( 'Brkp' ) then Result := TFrameBrkp
                          else
     if Compare( 'Surf' ) then Result := TFrameSurf
                          else
     if Compare( 'Band' ) then Result := TFrameBand
                          else
     if Compare( 'Noiz' ) then Result := TFrameNoiz
                          else Result := nil;

     Assert( Assigned( Result ), Clss_ + '：未対応のクラス型です。' );
end;

class function TFrame1ASO.ReadCreate( const F_:TFileStream; const H_:TFrameHeaderSDIF; const P_:TFileSDIF ) :TFrameSDIF;
var
   P :TFrameSDIF;
   N :Integer;
begin
     P := TFrameSDIF.Create;

     for N := 1 to H_.MatrixCount do TMatrixSDIF.ReadCreate( F_, P );

     Form1.Memo1.Lines.Add( '' );

     Result := TFrame1ASO.Select( TMatrixChar( P.FindMatrix( 'clss' ) ).Lines[ 0 ] ).Create( P_ );

     for N := 1 to P.ChildsN do P.Head.Paren := TMatrixSDIF( Result );

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

     while F.Position < F.Size do TFrameSDIF.ReadCreate( F, Self );

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
        Signature :String;
        MatrixsN  :Integer;
        StreamID  :Integer;
        Time      :Single;
      end;
   PF :TFrameSDIF;
   PM :TMatrixSDIF;
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
               N.Signature := M.Groups[ 1 ].Value          ;
               N.MatrixsN  := M.Groups[ 2 ].Value.ToInteger;
               N.StreamID  := M.Groups[ 3 ].Value.ToInteger;
               N.Time      := M.Groups[ 4 ].Value.ToSingle ;

               if N.Signature = 'ASTI' then
               begin
                    PF := TFrameASTI.Create( Self );

                    for I := 1 to N.MatrixsN
                    do TMatrixSDIF.ReadCreate( F ).Paren := TMatrixSDIF( PF );
               end
               else
               if N.Signature = '1ASO' then
               begin
                    PM := TMatrixSDIF.ReadCreate( F );

                    Assert( PM is TMatrixChar, PM.ClassName );

                    S := TMatrixChar( PM ).Lines[ 0 ];

                    PF := TFrame1ASO.Select( S ).Create( Self );

                    PM.Paren := TMatrixSDIF( PF );

                    for I := 2 to N.MatrixsN
                    do TMatrixSDIF.ReadCreate( F ).Paren := TMatrixSDIF( PF );
               end
               else PF := nil;

               with PF do
               begin
                    _Signature := N.Signature;
                    _StreamID  := N.StreamID;
                    _Time      := N.Time;
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
