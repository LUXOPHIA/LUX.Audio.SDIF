unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Menus,
  System.Math.Vectors, FMX.Types3D, FMX.Controls3D, FMX.MaterialSources,
  FMX.Objects3D, FMX.TabControl, FMX.Viewport3D, FMX.Layers3D;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    Viewport3D1: TViewport3D;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    Camera1: TCamera;
    Light1: TLight;
    LightMaterialSource1: TLightMaterialSource;
    LightMaterialSource2: TLightMaterialSource;
    Grid3D1: TGrid3D;
    Cylinder1: TCylinder;
    Cylinder2: TCylinder;
    RoundCube1: TRoundCube;
    TextLayer3D1: TTextLayer3D;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
  private
    { private êÈåæ }
  public
    { public êÈåæ }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.FormCreate(Sender: TObject);
begin
     /////
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
     /////
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
     /////
end;

end.
