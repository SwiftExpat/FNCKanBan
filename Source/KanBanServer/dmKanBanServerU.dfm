object ServerContainer: TServerContainer
  Height = 315
  Width = 647
  PixelsPerInch = 144
  object SparkleHttpSysDispatcher: TSparkleHttpSysDispatcher
    Active = True
    Left = 108
    Top = 24
  end
  object XDataServer: TXDataServer
    BaseUrl = 'http://+:2001/tms/xdata'
    Dispatcher = SparkleHttpSysDispatcher
    Pool = XDataConnectionPool
    EntitySetPermissions = <>
    Left = 324
    Top = 24
  end
  object XDataConnectionPool: TXDataConnectionPool
    Connection = AureliusConnection
    Left = 324
    Top = 108
  end
  object AureliusConnection: TAureliusConnection
    Left = 324
    Top = 192
  end
end
