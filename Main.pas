unit Main;

interface //#################################################################### ��

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
    { private �錾 }
    _MouseS :TShiftState;
    _MouseP :TPointF;
  public
    { public �錾 }
    _FileSDIF :TFileSDIF;
    ///// ���\�b�h
    procedure ShowNodes;
    procedure MakeBlock( const MinX_,MinY_,MaxX_,MaxY_:Single; const Text_:String; const Color_:TAlphaColor );
    procedure ClearBlocks;
  end;

var
  Form1: TForm1;

implementation //############################################################### ��

{$R *.fmx}

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

procedure TForm1.ShowNodes;  //�m�[�h�\����\�����郁�\�b�h
var
   I, J, Y, X , K :Integer;
   MinX, MaxX, MinY, MaxY :Single;
   TN, TP, TV :TTreeViewItem;
   PN :TNodeSDIF;
   PP :TPropSDIF;
   ClssP :TPropChar;
   DuraP :TPropFlo4;
   C :TAlphaColor;
begin
     TreeView1.Clear;  // TreeView1 �̕\�����N���A

     for I := 0 to _FileSDIF.ChildsN-1 do
     begin
          PN := _FileSDIF.Childs[ I ];  // I �Ԗڂ̃m�[�h�N���X���擾

          if PN.Name = '1ASO' then
          begin
               for K := 0 to PN.ChildsN-1 do
               begin
                    PP := PN.Childs[ K ];

                    if PP.Name = 'clss' then
                    begin
                         ClssP := TPropChar( PP );
                    end;

                    if PP.Name = 'dura' then
                    begin
                         DuraP := TPropFlo4( PP );
                    end;
               end;

               MinX := PN.Time * 10;
               MaxX := ( PN.Time + DuraP.Values[0,0] ) * 10;

               MinY := PN.LayI;
               MaxY := PN.LayI + 1;

               MakeBlock( MinX, MinY,
                          MaxX, MaxY,
                          ClssP.Lines[ 0 ],
                          PN.Color );
          end;

          TN := TTreeViewItem.Create( TreeView1 );  //�m�[�h�N���X�p�̍��ڃN���X�𐶐�
          with TN do
          begin
               Parent         := TreeView1;  //�e��ݒ�
               StyledSettings := [];  //�X�^�C����������
               Font.Family    := 'Lucida Console';  //�t�H���g����ݒ�
               Text           := PN.Name
                               + '�@ProN:' + PN.ChildsN.ToString
                               + '�@LayI:' + PN.LayI   .ToString
                               + '�@Time:' + PN.Time   .ToString;  //�\�����e��ݒ�
               Expand;  //�q���ڂ�W�J
          end;

          for J := 0 to PN.ChildsN-1 do
          begin
               PP := PN.Childs[ J ];  // J �Ԗڂ̃v���p�e�B�N���X���擾

               TP := TTreeViewItem.Create( TN );  //�v���p�e�B�N���X�p�̍��ڃN���X�𐶐�
               with TP do
               begin
                    Parent         := TN;  //�e��ݒ�
                    StyledSettings := [];  //�X�^�C����������
                    Font.Family    := 'Lucida Console';  //�t�H���g����ݒ�
                    Text           := PP.Name
                                    + '�@Kind:0x' + IntToHex( PP.Kind, 4 )
                                    + '�@VerN:' + PP.CountY.ToString + 'x'
                                                + PP.CountX.ToString;  //�\�����e��ݒ�
                    //Expand;  //�q���ڂ�W�J
               end;

               for Y := 0 to PP.CountY-1 do
               begin
                    TV := TTreeViewItem.Create( TP );  //�o�����[�N���X�p�̍��ڃN���X�𐶐�
                    with TV do
                    begin
                         Parent         := TP;  //�e��ݒ�
                         StyledSettings := [];  //�X�^�C����������
                         Font.Family    := 'Lucida Console';  //�t�H���g����ݒ�
                         Text           := PP.Texts[ Y, 0 ];  //�\�����e��ݒ�
                    end;

                    for X := 1 to PP.CountX-1
                    do TV.Text := TV.Text + ', ' + PP.Texts[ Y, X ];  //�\�����e��ǉ�
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
          Width       := 3;
          Height      := 1;
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
 procedure TForm1.FormCreate(Sender: TObject);  //�A�v�����J�n���鎞
begin
     _MouseS := [];

     _FileSDIF := TFileSDIF.Create;  // TFileSDIF �N���X�𐶐����A�C���X�^���X���擾�B

     _FileSDIF.LoadFronFileTex( '..\..\_DATA\ManyTreatments6.trt.txt' ); //�t�@�C�������[�h

     ShowNodes;
end;

procedure TForm1.FormDestroy(Sender: TObject); //�A�v�����I�����鎞
begin
     _FileSDIF.Free;  // �C���X�^���X��p���B
end;


////////////////////////////////////////////////////////////////////////////////

procedure TForm1.MenuItem2Click(Sender: TObject);  //�u�J��...�v���j���[���I�����ꂽ��
begin
     if OpenDialog1.Execute then  //�t�@�C���I���_�C�A���O���J���AOK �������ꂽ��B
     begin
          _FileSDIF.LoadFronFileTex( OpenDialog1.Filename );  //�w�肳�ꂽ�t�@�C�����J���B

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

end. //######################################################################### ��
