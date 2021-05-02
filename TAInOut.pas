unit TAInOut;

interface

uses
  TAHBrowser, TAHParam;

                   { * Read the source export file MODLA contributions * }
procedure          ReadMODLASourceFile(
                     FileName: String );
                   { * Read the sequence pointer File * }
procedure          ReadSEQPointerFile(
                     FileName: String );
                   { * Read the sequence description File * }
procedure          ReadSequenceFile(
                     FileName: String );

implementation

uses
  SysUtils, StrUtils, AccessXML, Classes, List,
  {$WARNINGS OFF}
  Dialogs;
  {$WARNINGS ON}

{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ReadMODLASourceFile
  * Read the MODLA source file *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
procedure          ReadMODLASourceFile(
  FileName:        String );
var
  IOR:             Integer;
  AllocRec:        Integer;
  Lgt:             Integer;
  Posit:           Integer;
  MyTID:           Integer;
  Trans:           String;
  Line:            String;
  Indc:            tContrib;
begin
  // Open input file in text format, splitted or unsplitted
  TotMODLA := 0;
  AllocRec := 0;
    AssignFile( Infile, FileName );
    Reset( InFile );

    // Loop on all lines of input file and prepare splitting
    while not EOF( InFile ) do
    begin

      // Read the next line of text
      {$I-}
      Readln( InFile, Line );
      IOR := IOResult;
      {$I+}
      if ( IOR = 0 ) then
      begin

        // Allocate dynamic memory
        if TotMODLA >= AllocRec then
        begin
          Inc( AllocRec, 20 );
          SetLength( MODLA, AllocRec );
        end;

        // Expected format is made of 11 fields:
        // UID¦LID¦Seq¦Typ¦Sub¦Lnk¦Mand¦Opt¦Ref¦Rel¦Lib
        Lgt := Length( Line );
        with MODLA[ TotMODLA ] do
        begin
          Posit := Pos( CurSep, Line );
          UID := StrToInt( Copy( Line, 1, Posit - 1 ) );
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          LID := StrToInt( Copy( Line, 1, Posit - 1 ) );
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          Seq := StrToInt( Copy( Line, 1, Posit - 1 ) );
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          Trans := Copy( Line, 1, Posit - 1 );
          Typ := co_Undefined;
          for Indc := Succ( Low( tContrib ) ) to High( tContrib ) do
          begin
            if cContrib[ Indc ] = Trans then
            begin
              Typ := Indc;
              Break;
            end;
          end;
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          Sub := cEmpty;
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          if ( Posit = 1 ) then
            Lnk := 0
          else
            Lnk := StrToInt( Copy( Line, 1, Posit - 1 ) );
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          if ( Posit = 1 ) then
            Mand := 0
          else
            Mand := StrToInt( Copy( Line, 1, Posit - 1 ) );
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          if ( Posit = 1 ) then
            Opt := 0
          else
            Opt := StrToInt( Copy( Line, 1, Posit - 1 ) );
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          if ( Posit = 1 ) then
            Ref := 0
          else
            Ref := StrToInt( Copy( Line, 1, Posit - 1 ) );
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          if ( Posit = 1 ) then
            Rel := 0
          else
            Rel := StrToInt( Copy( Line, 1, Posit - 1 ) );
          Lib := Copy( Line, Posit + 1, Lgt );
        end; // with

        Inc( TotMODLA );
      end;
    end; // while

    // Close the reading of source file
    CloseFile( InFile );
    SetLength( MODLA, TotMODLA );
end; // _____________________________________________________ReadMODLASourceFile

procedure          ReadSEQPointerFile(
  FileName:        String );
{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ReadSEQPointerFile
  * Read the sequence pointer file *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var
  IOR:             Integer;
  AllocRec:        Integer;
  Lgt:             Integer;
  Posit:           Integer;
  Line:            String;
begin
  // Open input file in text format, splitted or unsplitted
  TotSEQ := 0;
  AllocRec := 0;
    AssignFile( Infile, FileName );
    Reset( InFile );

    // Loop on all lines of input file and prepare splitting
    while not EOF( InFile ) do
    begin

      // Read the next line of text
      {$I-}
      Readln( InFile, Line );
      IOR := IOResult;
      {$I+}
      if ( IOR = 0 ) then
      begin

        // Allocate dynamic memory
        if ( TotSEQ >= AllocRec ) then
        begin
          Inc( AllocRec, 20 );
          SetLength( SEQ, AllocRec );
        end;

        // Expected format is made of 3 fields:
        // TID¦SID¦Ord
        Lgt := Length( Line );
        with SEQ[ TotSEQ ] do
        begin
          // if TotSEQ = 2149 then
          //  TotSEQ := 2149;
          Posit := Pos( CurSep, Line );
          TID := StrToInt( Copy( Line, 1, Posit - 1 ) );
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          SID := StrToInt( Copy( Line, 1, Posit - 1 ) );
          Ord := StrToInt( Copy( Line, Posit + 1, Lgt ) );
        end; // with

        Inc( TotSEQ );
      end;
    end; // while

    // Close the reading of source file
    CloseFile( InFile );
    SetLength( SEQ, TotSEQ );
end; // ______________________________________________________ReadSEQPointerFile

{<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ReadSequenceFile
  * Read sequence description source file *
  Description:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
procedure          ReadSequenceFile(
  FileName:        String );
var
  IOR:             Integer;
  AllocRec:        Integer;
  Lgt:             Integer;
  Posit:           Integer;
  Line:            String;
begin
  // Open input file in text format, splitted or unsplitted
  TotSequence := 0;
  AllocRec := 0;
    AssignFile( Infile, FileName );
    Reset( InFile );

    // Loop on all lines of input file and prepare splitting
    while not EOF( InFile ) do
    begin

      // Read the next line of text
      {$I-}
      Readln( InFile, Line );
      IOR := IOResult;
      {$I+}
      if ( IOR = 0 ) then
      begin

        // Allocate dynamic memory
        if TotSequence >= AllocRec then
        begin
          Inc( AllocRec, 20 );
          SetLength( Sequence, AllocRec );
        end;

        // Expected format is made of 3 fields:
        // SID¦Title¦Descr
        Lgt := Length( Line );
        with Sequence[ TotSequence ] do
        begin
          // if TotSequence = 2149 then
          //  TotSequence := 2149;
          Posit := Pos( CurSep, Line );
          SID := StrToInt( Copy( Line, 1, Posit - 1 ) );
          Line := Copy( Line, Posit + 1, Lgt );
          Posit := Pos( CurSep, Line );
          Title := Copy( Line, 1, Posit - 1 );
          Descr := Copy( Line, Posit + 1, Lgt );
        end; // with

        Inc( TotSequence );
      end;
    end; // while

    // Close the reading of source file
    CloseFile( InFile );
    SetLength( Sequence, TotSequence );
end; // ________________________________________________________ReadSequenceFile

end.
