//////////////////////////////////////////////////////////////////////////
// Criação...........: 12-02-2001
// Ultima modificação: 27-06-2007
// Sistema...........: Olimpo Cafe - Automação de Cafeterias
// Analistas.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Desenvolvedores...: Marilene Esquiavoni & Denny Paulista Azevedo Filho
// Copyright.........: Marilene Esquiavoni & Denny Paulista Azevedo Filho
//////////////////////////////////////////////////////////////////////////

unit UnitFechBanc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvComponent, JvTransBtn, StdCtrls, JvLabel, fcLabel,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDCustomParentPanel, LMDBackPanel, Mask, ToolEdit, RXDBCtrl, EMsgDlg,
  Grids, DBGrids;

type
  TFrmFechBanc = class(TForm)
    LMDBackPanel2: TLMDBackPanel;
    fcLabel1: TfcLabel;
    LMDBackPanel1: TLMDBackPanel;
    LMDBackPanel3: TLMDBackPanel;
    JvLabel10: TJvLabel;
    btnGerar: TJvTransparentButton;
    btnDeletar: TJvTransparentButton;
    btnSair: TJvTransparentButton;
    JvLabel1: TJvLabel;
    dbDtIn: TDBDateEdit;
    dbDtFin: TDBDateEdit;
    dbGridCargo: TDBGrid;
    MsgDlg: TEvMsgDlg;
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFechBanc: TFrmFechBanc;

implementation

{$R *.dfm}

procedure TFrmFechBanc.btnSairClick(Sender: TObject);
begin
  Close;
end;

end.
