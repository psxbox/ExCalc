object FormMain: TFormMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #1050#1072#1083#1100#1082#1091#1083#1103#1090#1086#1088' '#1074#1099#1088#1072#1078#1077#1085#1080#1081
  ClientHeight = 364
  ClientWidth = 481
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -20
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 24
  object LabelResult: TLabel
    Left = 8
    Top = 234
    Width = 98
    Height = 24
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090':'
  end
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 114
    Height = 24
    Caption = #1042#1099#1088#1072#1078#1077#1085#1080#1103':'
  end
  object ButtonCalculate: TButton
    Left = 136
    Top = 175
    Width = 201
    Height = 50
    Caption = #1056#1072#1089#1089#1095#1080#1090#1072#1090#1100
    TabOrder = 0
    OnClick = ButtonCalculateClick
  end
  object RichEditResult: TRichEdit
    Left = 8
    Top = 264
    Width = 465
    Height = 92
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    Zoom = 100
  end
  object MemoExpression: TMemo
    Left = 8
    Top = 40
    Width = 465
    Height = 121
    Lines.Strings = (
      'MemoExpression')
    ScrollBars = ssVertical
    TabOrder = 2
  end
end
