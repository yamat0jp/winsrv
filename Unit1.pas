unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr,
  Vcl.AppEvnts;

type
  TService1 = class(TService)
    procedure ServiceExecute(Sender: TService);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  private
    { Private êÈåæ }
  public
    f: TextFile;
    function GetServiceController: TServiceController; override;
    { Public êÈåæ }
  end;

var
  Service1: TService1;

implementation

{$R *.dfm}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  Service1.Controller(CtrlCode);
end;

function TService1.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TService1.ServiceExecute(Sender: TService);
begin
  while not Terminated do
  begin
    Sleep(1000);
    Writeln(f, TimeToStr(Time));
    ServiceThread.ProcessRequests(false);
  end;
end;

procedure TService1.ServiceStart(Sender: TService; var Started: Boolean);
begin
  AssignFile(f, 'C:\temp.txt');
  ReWrite(f);
  ServiceThread.ProcessRequests(false);
  Started := true;
end;

procedure TService1.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  CloseFile(f);
  Stopped := true;
end;

end.
