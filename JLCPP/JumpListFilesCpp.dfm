object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 362
  ClientWidth = 612
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 16
    Top = 8
    Width = 577
    Height = 337
    ItemHeight = 13
    TabOrder = 0
  end
  object JumpList1: TJumpList
    AutoRefresh = True
    Enabled = True
    ApplicationID = 'JumpListCppAppID'
    CustomCategories = <
      item
        CategoryName = 'Dropped Files'
        Items = <>
      end>
    ShowRecent = True
    ShowFrequent = True
    TaskList = <
      item
        FriendlyName = 'Sample'
        Arguments = 'SampleParameter'
      end
      item
        FriendlyName = 'Second'
        Arguments = 'SecondParameter'
      end>
    Left = 32
    Top = 301
  end
end
