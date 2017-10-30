unit FileExtUnit;
(*

    Copyright 2017, Jerome Shidel
    Public Domain

    Kludge Function for macOS to Hide/Show File and Folder extensions.

    Place the fileExtensionShow.scpt and fileExtensionShow.scpt AppleScript
    files in the Application Bundle in the Contents/MacOS directory.

    They should have their execute bit set.

*)

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

function FileExtVisible(Filename:String; Visible:boolean=true):integer;

implementation

uses Process, Forms;

function FileExtVisible(Filename:String; Visible:boolean=true):integer;
const
  AppleScript = '/usr/bin/osascript';
var
   R : AnsiString;
   X : String;
begin
  Filename:=ExcludeTrailingPathDelimiter(FileName);
  Result:=-1;
  if not FileExists(AppleScript) then
    Result:=1
  else begin
    X := IncludeTrailingPathDelimiter(ExtractFileDir(ExtractFileDir(Application.ExeName))) + 'MacOS' + PathDelim;
    case Visible of
      True: begin
        X := X + 'fileExtensionShow.scpt';
        if not FileExists(X) then
          Result := 2
        else if RunCommand(AppleScript, [X, FileName], R) then
          Result:=0
        else Result:=3;
      end;
      False: begin
        X := X + 'fileExtensionHide.scpt';
        if not FileExists(X) then
          Result := 4
        else if RunCommand(AppleScript, [X, FileName], R) then
          Result:=0
        else Result:=5;
      end;
    end;
  end;
end;

end.
