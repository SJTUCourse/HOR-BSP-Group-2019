object ConfigForm: TConfigForm
  Left = 468
  Top = 229
  BorderStyle = bsDialog
  Caption = 'Streaming AI - Configuration'
  ClientHeight = 340
  ClientWidth = 361
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 21
    Top = 24
    Width = 44
    Height = 17
    AutoSize = False
    Caption = 'Device:'
  end
  object Label5: TLabel
    Left = 21
    Top = 58
    Width = 36
    Height = 17
    AutoSize = False
    Caption = 'Profile:'
  end
  object cmbDevice: TComboBox
    Left = 72
    Top = 20
    Width = 241
    Height = 21
    Style = csDropDownList
    ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
    ItemHeight = 13
    TabOrder = 0
    OnChange = cmbDeviceChange
  end
  object btnOk: TButton
    Left = 143
    Top = 301
    Width = 81
    Height = 26
    Caption = 'OK'
    TabOrder = 1
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 245
    Top = 302
    Width = 81
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object GroupBox1: TGroupBox
    Left = 18
    Top = 94
    Width = 319
    Height = 195
    Caption = 'Buffered AI settings'
    TabOrder = 3
    object Label2: TLabel
      Left = 8
      Top = 23
      Width = 65
      Height = 13
      AutoSize = False
      Caption = 'Channel start:'
    end
    object Label3: TLabel
      Left = 8
      Top = 59
      Width = 73
      Height = 17
      AutoSize = False
      Caption = 'Channel count:'
    end
    object Label4: TLabel
      Left = 9
      Top = 91
      Width = 65
      Height = 17
      AutoSize = False
      Caption = 'Value range:'
    end
    object Label7: TLabel
      Left = 8
      Top = 127
      Width = 65
      Height = 17
      AutoSize = False
      Caption = 'Clock rate:'
    end
    object Label8: TLabel
      Left = 295
      Top = 128
      Width = 13
      Height = 13
      Caption = 'Hz'
    end
    object Label6: TLabel
      Left = 8
      Top = 161
      Width = 81
      Height = 17
      AutoSize = False
      Caption = 'Section Length:'
    end
    object cmbChannelStart: TComboBox
      Left = 88
      Top = 22
      Width = 201
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ItemHeight = 13
      TabOrder = 0
    end
    object cmbChannelCount: TComboBox
      Left = 88
      Top = 55
      Width = 201
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ItemHeight = 13
      TabOrder = 1
    end
    object cmbValueRange: TComboBox
      Left = 88
      Top = 88
      Width = 201
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ItemHeight = 13
      TabOrder = 2
    end
    object txtClockRate: TEdit
      Left = 88
      Top = 121
      Width = 201
      Height = 24
      AutoSize = False
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 3
      Text = '1000'
    end
    object txtSectionLength: TEdit
      Left = 88
      Top = 160
      Width = 201
      Height = 21
      TabOrder = 4
      Text = '1024'
    end
  end
  object txtProfilePath: TEdit
    Left = 72
    Top = 56
    Width = 177
    Height = 21
    TabOrder = 4
  end
  object btnBrowse: TButton
    Left = 264
    Top = 53
    Width = 49
    Height = 25
    Caption = 'Browse'
    TabOrder = 5
    OnClick = btnBrowseClick
  end
end