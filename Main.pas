unit Main;

interface //#################################################################### ■

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Math.Vectors,
  FMX.Menus, FMX.Types3D, FMX.Controls3D, FMX.MaterialSources, FMX.Objects3D,
  FMX.TabControl, FMX.Viewport3D, FMX.Layers3D, FMX.Layouts, FMX.TreeView,
  LUX, LUX.D1, LUX.D2, LUX.D3,
  TUX.Asset.SDIF, TUX.Asset.SDIF.Nodes, TUX.Asset.SDIF.Props;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
      MenuItem1: TMenuItem;
      MenuItem2: TMenuItem;
    OpenDialog1: TOpenDialog;
    TabControl1: TTabControl;
      TabItem1: TTabItem;
        LightMaterialSource1: TLightMaterialSource;
        Viewport3D1: TViewport3D;
          Camera1: TCamera;
          Light1: TLight;
          Grid3D1: TGrid3D;
          Cylinder1: TCylinder;
          Cylinder2: TCylinder;
          Dummy1: TDummy;
      TabItem2: TTabItem;
        TreeView1: TTreeView;
    TabControl2: TTabControl;
      TabItem3: TTabItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure Viewport3D1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure Viewport3D1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure Viewport3D1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure Viewport3D1MouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
  private
    { private 宣言 }
    _MouseS :TShiftState;
    _MouseP :TPointF;
  public
    { public 宣言 }
    _FileSDIF :TFileSDIF;
    ///// メソッド
    procedure ShowNodes;
    procedure MakeBlock( const MinX_,MinY_,MaxX_,MaxY_:Single; const Text_:String; const Color_:TAlphaColor );
    procedure ClearBlocks;
  end;

var
  Form1: TForm1;

implementation //############################################################### ■

{$R *.fmx}

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

procedure TForm1.ShowNodes;  //ノード構造を表示するメソッド
var
   I, J, Y, X :Integer;
   TN, TP, TV :TTreeViewItem;
   PN :TNodeSDIF;
   PP :TPropSDIF;
begin
     TreeView1.Clear;  // TreeView1 の表示をクリア

     for I := 0 to _FileSDIF.ChildsN-1 do
     begin
          PN := _FileSDIF.Childs[ I ];  // I 番目のノードクラスを取得

          TN := TTreeViewItem.Create( TreeView1 );  //ノードクラス用の項目クラスを生成
          with TN do
          begin
               Parent         := TreeView1;  //親を設定
               StyledSettings := [];  //スタイルを初期化
               Font.Family    := 'Lucida Console';  //フォント名を設定
               Text           := PN.Name
                               + '　ProN:' + PN.ChildsN.ToString
                               + '　LayI:' + PN.LayI   .ToString
                               + '　Time:' + PN.Time   .ToString;  //表示内容を設定
               Expand;  //子項目を展開
          end;

          for J := 0 to PN.ChildsN-1 do
          begin
               PP := PN.Childs[ J ];  // J 番目のプロパティクラスを取得

               TP := TTreeViewItem.Create( TN );  //プロパティクラス用の項目クラスを生成
               with TP do
               begin
                    Parent         := TN;  //親を設定
                    StyledSettings := [];  //スタイルを初期化
                    Font.Family    := 'Lucida Console';  //フォント名を設定
                    Text           := PP.Name
                                    + '　Kind:0x' + IntToHex( PP.Kind, 4 )
                                    + '　VerN:' + PP.CountY.ToString + 'x'
                                                + PP.CountX.ToString;  //表示内容を設定
                    //Expand;  //子項目を展開
               end;

               for Y := 0 to PP.CountY-1 do
               begin
                    TV := TTreeViewItem.Create( TP );  //バリュークラス用の項目クラスを生成
                    with TV do
                    begin
                         Parent         := TP;  //親を設定
                         StyledSettings := [];  //スタイルを初期化
                         Font.Family    := 'Lucida Console';  //フォント名を設定
                         Text           := PP.Texts[ Y, 0 ];  //表示内容を設定
                    end;

                    for X := 1 to PP.CountX-1
                    do TV.Text := TV.Text + ', ' + PP.Texts[ Y, X ];  //表示内容を追加
               end;
          end;
     end;
end;

//------------------------------------------------------------------------------

procedure TForm1.MakeBlock( const MinX_,MinY_,MaxX_,MaxY_:Single; const Text_:String; const Color_:TAlphaColor );
var
   PB :TPlane;
   PT :TTextLayer3D;
begin
     PB := TPlane.Create( Dummy1 );

     with PB do
     begin
          Parent         := Dummy1;
          HitTest        := False;
          Width          := MaxX_ - MinX_;
          Height         := MaxY_ - MinY_;
          Depth          := 1;
          Position.X     := +( MaxX_ + MinX_ ) / 2;
          Position.Y     := -( MaxY_ + MinY_ ) / 2;
          Position.Z     := +0.01;
          MaterialSource := TLightMaterialSource.Create( PB );

          with TLightMaterialSource( MaterialSource ) do
          begin
               Ambient  := TAlphaColors.Null;
               Diffuse  := Color_;
               Specular := TAlphaColors.Null;
          end;
     end;

     PT := TTextLayer3D.Create( PB );

     with PT do
     begin
          Parent      := PB;
          HitTest     := True;
          Width       := 0.9 * ( MaxX_ - MinX_ );
          Height      := 0.9 * ( MaxY_ - MinY_ );
          Position.Z  := -0.02;
          Text        := Text_;
          Font.Family := 'Lucida Console';
          Font.Size   := 30;
          ZWrite      := False;
     end;
end;

procedure TForm1.ClearBlocks;
begin
     Dummy1.DeleteChildren;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

procedure TForm1.FormCreate(Sender: TObject);  //アプリが開始する時
begin
     _MouseS := [];

     _FileSDIF := TFileSDIF.Create;  // TFileSDIF クラスを生成し、インスタンスを取得。

     _FileSDIF.LoadFronFileTex( '..\..\_DATA\ManyTreatments6.trt.txt' ); //ファイルをロード

     ShowNodes;

     MakeBlock( 0, 0, 3, 2, 'CLIP', TAlphaColors.Red  );
     MakeBlock( 2, 2, 5, 3, 'CLIP', TAlphaColors.Lime );
end;

procedure TForm1.FormDestroy(Sender: TObject);  //アプリが終了する時
begin
     _FileSDIF.Free;  // インスタンスを廃棄。
end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.MenuItem2Click(Sender: TObject);  //「開く...」メニューが選択された時
begin
     if OpenDialog1.Execute then  //ファイル選択ダイアログを開き、OK が押されたら。
     begin
          _FileSDIF.LoadFronFileTex( OpenDialog1.Filename );  //指定されたファイルを開く。

          ShowNodes;
     end;
end;

//------------------------------------------------------------------------------

procedure TForm1.Viewport3D1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
     _MouseS := Shift;
     _MouseP := TPointF.Create( X, Y );
end;

procedure TForm1.Viewport3D1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
var
   P :TPointF;
begin
     if ssLeft in _MouseS then
     begin
          P := TPointF.Create( X, Y );

          with Camera1.Position do X := X - ( P.X - _MouseP.X ) * 20 / Viewport3D1.Height;

          _MouseP := P;
     end;
end;

procedure TForm1.Viewport3D1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
     Viewport3D1MouseMove( Sender, Shift, X, Y );

     _MouseS := [];
end;

//------------------------------------------------------------------------------

procedure TForm1.Viewport3D1MouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
begin
     with Camera1.Position do X := X - WheelDelta / 120;
end;

end. //######################################################################### ■
