unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TMainForm }

  TMainForm = class(TForm)
    GenerateButton: TButton;
    CardWidthEdit: TEdit;
    CardWidthHeight: TEdit;
    CardList: TComboBox;
    CardImage: TImage;
    Label8: TLabel;
    SuitList: TComboBox;
    DiamondsImage: TImage;
    HeartsImage: TImage;
    FontButton: TButton;
    FontDialog: TFontDialog;
    ClubsImage: TImage;
    Label7: TLabel;
    SpadesImage: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure OnFontButton(Sender: TObject);
    procedure OnGenerate(Sender: TObject);
  private
    m_clubs, m_diamonds, m_hearts, m_spades: TPicture;
  public

  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

const
  CardWidthDefault = 112;
  CardHeightDefault = 176;

{ TMainForm }

procedure TMainForm.OnFontButton(Sender: TObject);
begin
  if FontDialog.Execute then
  begin
    FontButton.Font := FontDialog.Font;
  end;
end;

procedure TMainForm.OnGenerate(Sender: TObject);
const
  suits: array [0..3] of string = ('clubs', 'diamonds', 'hearts', 'spades');
  numbers: array [0..12] of string =
    ( 'A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K');

var
  i, x, y, suit, num: integer;
  filename: string;
  image: TPortableNetworkGraphic;
  suitImage: array [0..3] of TPicture;

begin
  suitImage[0] := m_Clubs;
  suitImage[1] := m_Diamonds;
  suitImage[2] := m_Hearts;
  suitImage[3] := m_Spades;

  x := (CardWidthDefault - 32) div 2 - 16;
  y := (CardHeightDefault - 32) div 2 - 16;

  for i := 0 to 51 do
  begin
    image := TPortableNetworkGraphic.Create;
    image.Width := CardWidthDefault;
    image.Height := CardHeightDefault;

    image.Canvas.Font := FontButton.Font;

    suit := i div 13;
    num := i mod 13;

    image.Canvas.Brush.Color := clWhite;
    image.Canvas.FillRect(0, 0, CardWidthDefault - 1, CardHeightDefault - 1);
    image.Canvas.Draw(x, y, suitImage[suit].Graphic);
    image.Canvas.TextOut(5, 5, numbers[num]);

    filename := 'generated/' + suits[suit] + '/' + numbers[num] + '_' + suits[suit] + '.png';
    image.SaveToFile(filename);

    image.Free;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  CardWidthEdit.Text := IntToStr(CardWidthDefault);
  CardWidthHeight.Text := IntToStr(CardHeightDefault);

  m_clubs := TPicture.Create;
  m_clubs.LoadFromFile('assets/suits/clubs.png');
  m_diamonds := TPicture.Create;
  m_diamonds.LoadFromFile('assets/suits/diamonds.png');
  m_hearts := TPicture.Create;
  m_hearts.LoadFromFile('assets/suits/hearts.png');
  m_spades := TPicture.Create;
  m_spades.LoadFromFile('assets/suits/spades.png');

  ClubsImage.Picture := m_clubs;
  DiamondsImage.Picture := m_diamonds;
  HeartsImage.Picture := m_hearts;
  SpadesImage.Picture := m_spades;
end;

end.

