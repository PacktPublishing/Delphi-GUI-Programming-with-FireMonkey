unit AppState;

interface

uses Classes, SysUtils, System.Messaging;

type
  TAppState = (Home, Orders, OrderDetail);

  TAppStateChanged = class(TMessageBase);


implementation

end.
