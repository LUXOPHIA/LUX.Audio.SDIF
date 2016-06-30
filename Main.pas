unit Main;

interface //#################################################################### ��

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Menus,
  System.Math.Vectors, FMX.Types3D, FMX.Controls3D, FMX.MaterialSources,
  FMX.Objects3D, FMX.TabControl, FMX.Viewport3D, FMX.Layers3D,
  TUX.Asset.SDIF, FMX.Layouts, FMX.TreeView;

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
    { private �錾 }
  public
    { public �錾 }
    _FileSDIF :TFileSDIF;
    ///// ���\�b�h
    procedure ShowNodes;
  end;

var
  Form1: TForm1;

implementation //############################################################### ��

{$R *.fmx}

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

procedure TForm1.ShowNodes;  //�m�[�h�\����\�����郁�\�b�h
var
   I, J, Y, X :Integer;
   TN, TP, TV :TTreeViewItem;
   PN :TNodeSDIF;
   PP :TPropSDIF;
begin
     TreeView1.Clear;  // TreeView1 �̕\�����N���A

     for I := 0 to _FileSDIF.ChildsN-1 do
     begin
          PN := _FileSDIF.Childs[ I ];  // I �Ԗڂ̃m�[�h�N���X���擾

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

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

procedure TForm1.FormCreate(Sender: TObject);  //�A�v�����J�n���鎞
begin
     _FileSDIF := TFileSDIF.Create;  // TFileSDIF �N���X�𐶐����A�C���X�^���X���擾�B

     _FileSDIF.LoadFronFileTex( '..\..\_DATA\ManyTreatments6.trt.txt' ); //�t�@�C�������[�h

     ShowNodes;
end;

procedure TForm1.FormDestroy(Sender: TObject);  //�A�v�����I�����鎞
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

end. //######################################################################### ��
