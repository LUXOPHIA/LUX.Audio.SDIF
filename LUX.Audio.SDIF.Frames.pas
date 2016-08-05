unit LUX.Audio.SDIF.Frames;

interface //#################################################################### ■

uses System.Classes,
     LUX.Audio.SDIF;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TFrame1TYP = class;
     TFrameASTI = class;
     TFrame1ASO = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

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
       ///// アクセス
       function GetClss :String;
       function GetDura :Single;
       function GetTimeMax :Single;
     public
       ///// プロパティ
       property Clss    :String read GetClss   ;
       property Dura    :Single read GetDura   ;
       property TimeMax :Single read GetTimeMax;
       ///// メソッド
       class function Select( const Clss_:String ) :CFrameSDIF; reintroduce; virtual;
       class function ReadCreate( const F_:TFileStream; const H_:TFrameHeaderSDIF; const P_:TFileSDIF ) :TFrameSDIF; override;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses System.SysUtils,
     LUX.Audio.SDIF.Matrixs, LUX.Audio.SDIF.Frames.ASO1;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

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

     Result := Create( P_ );

     for N := 1 to P.ChildsN do P.Head.Paren := TMatrixSDIF( Result );

     P.Free;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TFrame1ASO

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TFrame1ASO.GetClss :String;
begin
     Result := TMatrixChar( FindMatrix( 'clss' ) ).Lines[ 0 ];
end;

function TFrame1ASO.GetDura :Single;
begin
     Result := TMatrixFlo4( FindMatrix( 'dura' ) ).Values[ 0, 0 ];
end;

function TFrame1ASO.GetTimeMax :Single;
begin
     Result := Time + Dura;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

class function TFrame1ASO.Select( const Clss_:String ) :CFrameSDIF;
begin
     if SameText( Clss_, 'Tran' ) then Result := TFrameTran
                                  else
     if SameText( Clss_, 'TmSt' ) then Result := TFrameTmSt
                                  else
     if SameText( Clss_, 'Frmt' ) then Result := TFrameFrmt
                                  else
     if SameText( Clss_, 'BpGa' ) then Result := TFrameBpGa
                                  else
     if SameText( Clss_, 'Rflt' ) then Result := TFrameRflt
                                  else
     if SameText( Clss_, 'Clip' ) then Result := TFrameClip
                                  else
     if SameText( Clss_, 'Gsim' ) then Result := TFrameGsim
                                  else
     if SameText( Clss_, 'Frze' ) then Result := TFrameFrze
                                  else
     if SameText( Clss_, 'Revs' ) then Result := TFrameRevs
                                  else
     if SameText( Clss_, 'Imag' ) then Result := TFrameImag
                                  else
     if SameText( Clss_, 'Brkp' ) then Result := TFrameBrkp
                                  else
     if SameText( Clss_, 'Surf' ) then Result := TFrameSurf
                                  else
     if SameText( Clss_, 'Band' ) then Result := TFrameBand
                                  else
     if SameText( Clss_, 'Noiz' ) then Result := TFrameNoiz
                                  else Result := nil;

     Assert( Assigned( Result ), Clss_ + '：未対応のクラス型です。' );
end;

class function TFrame1ASO.ReadCreate( const F_:TFileStream; const H_:TFrameHeaderSDIF; const P_:TFileSDIF ) :TFrameSDIF;
var
   P :TFrame1ASO;
   N :Integer;
begin
     P := TFrame1ASO.Create;

     for N := 1 to H_.MatrixCount do TMatrixSDIF.ReadCreate( F_, P );

     Result := Select( P.Clss ).Create( P_ );

     for N := 1 to P.ChildsN do P.Head.Paren := TMatrixSDIF( Result );

     P.Free;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■