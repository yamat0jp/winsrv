program Project1;

uses
  Vcl.SvcMgr,
  Unit1 in 'Unit1.pas' {Service1: TService};

{$R *.RES}

begin
  // Windows 2003 Server では、CoRegisterClassObject の前に StartServiceCtrlDispatcher を
  // 呼び出す必要があります。前者は Application.Initialize で間接的に
  // 呼び出されることがあります。TServiceApplication.DelayInitialize では、
  // (StartServiceCtrlDispatcher が呼び出された後で) TService.Main から
  // Application.Initialize を呼び出すことができます。
  //
  // Application オブジェクトの遅延初期化は、初期化より前に発生する
  // イベント (たとえば TService.OnCreate など) に影響を及ぼす
  // 可能性があります。これを推奨するのは、ServiceApplication が、
  // Windows 2003 Server で使用するためのもので、かつ OLE に
  // クラス オブジェクトを登録する場合だけです。
  //
  // Application.DelayInitialize := True;
  //
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(TService1, Service1);
  Application.Run;
end.
