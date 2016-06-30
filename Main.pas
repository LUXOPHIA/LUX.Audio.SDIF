unit Main;

interface //#################################################################### ■

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Math.Vectors,
  FMX.Menus, FMX.Types3D, FMX.Controls3D, FMX.MaterialSources, FMX.Objects3D,
  FMX.TabControl, FMX.Viewport3D, FMX.Layers3D, FMX.Layouts, FMX.TreeView,
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
        LightMaterialSource2: TLightMaterialSource;
        Viewport3D1: TViewport3D;
          Camera1: TCamera;
          Light1: TLight;
          Grid3D1: TGrid3D;
          Cylinder1: TCylinder;
          Cylinder2: TCylinder;
          RoundCube1: TRoundCube;
          TextLayer3D1: TTextLayer3D;
      TabItem2: TTabItem;
        TreeView1: TTreeView;
    TabControl2: TTabControl;
      TabItem3: TTabItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
  private
    { private 宣言 }
  public
    { public 宣言 }
    _FileSDIF :TFileSDIF;
    ///// メソッド
    procedure ShowNodes;
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

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

procedure TForm1.FormCreate(Sender: TObject);  //アプリが開始する時
begin
     _FileSDIF := TFileSDIF.Create;  // TFileSDIF クラスを生成し、インスタンスを取得。

     _FileSDIF.LoadFronFileTex( '..\..\_DATA\ManyTreatments6.trt.txt' ); //ファイルをロード

     ShowNodes;
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

end. //######################################################################### ■
