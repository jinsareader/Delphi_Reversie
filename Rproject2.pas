unit Rproject2;

interface
  var
    temp : array[0..7] of integer;
  procedure clear_board(var board : array of integer; board_width : integer; board_height : integer);
  procedure set_board_wall(var board : array of integer; board_width : integer; board_height : integer);
  procedure reversie_start(var board : array of integer; board_width : integer; board_height : integer);
  procedure mark_board(var board: array of integer; board_width : integer; board_height : integer; turn : integer);
  procedure click_action(var board: array of integer; board_width : integer; board_height : integer; label_tag : integer; turn : integer);
  function is_can_click(board: array of integer; board_width : integer; board_height : integer) : boolean;
implementation

  procedure clear_board(var board : array of integer; board_width : integer; board_height : integer);
var
  i: Integer;
  temp: integer;
  begin
    temp := (board_width+2)*(board_height+2)-1;
    for i := 0 to temp do
    begin
      board[i] := 0;
    end;
  end;

  procedure set_board_wall(var board : array of integer; board_width : integer; board_height : integer);
var
  i: Integer;
  begin
    for i := 0 to board_width + 1 do
    begin
      board[i] := -100;
      board[i+(board_width+2)*(board_height+1)] := -100;
    end;
    for i := 0 to board_height + 1 do
    begin
      board[i*(board_width+2)] := -100;
      board[i*(board_width+2)+(board_width+1)] := -100;
    end;
  end;
  procedure reversie_start(var board : array of integer; board_width : integer; board_height : integer);
  begin
    board[44] := 1;
    board[55] := 1;
    board[45] := 2;
    board[54] := 2;
  end;
  procedure mark_board(var board: array of integer; board_width : integer; board_height : integer; turn : integer);
var
  i: Integer;
  j: Integer;
  k: integer;
  begin
    temp[0] := -1 - (board_width + 2);
    temp[1] := 0 - (board_width + 2);
    temp[2] := 1 - (board_width + 2);
    temp[3] := -1;
    temp[4] := 1;
    temp[5] := -1 + (board_width + 2);
    temp[6] := 0 + (board_width + 2);
    temp[7] := 1 + (board_width + 2);
    k := 1;

    for i := 0 to (board_width+2)*(board_height+2)-1 do
    begin
      if (board[i] = 1) and (turn mod 2 = 1) then
        for j := 0 to 7 do
          if board[i+temp[j]] = 2 then
          begin
            while board[i+temp[j]*k] = 2 do
              k := k + 1;
            if board[i+temp[j]*k] = 0 then
              board[i+temp[j]*k] := 10;
            k := 1;
          end;

      if (board[i] = 2) and (turn mod 2 = 0) then
        for j := 0 to 7 do
          if board[i+temp[j]] = 1 then
          begin
            while board[i+temp[j]*k] = 1 do
              k := k + 1;
            if board[i+temp[j]*k] = 0 then
              board[i+temp[j]*k] := 10;
            k := 1;
          end;
    end;
  end;
  procedure click_action(var board: array of integer; board_width : integer; board_height : integer; label_tag : integer; turn : integer);
var
  i: Integer;
  j: integer;
  k: Integer;
  begin
    temp[0] := -1 - (board_width + 2);
    temp[1] := 0 - (board_width + 2);
    temp[2] := 1 - (board_width + 2);
    temp[3] := -1;
    temp[4] := 1;
    temp[5] := -1 + (board_width + 2);
    temp[6] := 0 + (board_width + 2);
    temp[7] := 1 + (board_width + 2);
    j := 1;

    if turn mod 2 = 1 then
    begin
      board[label_tag] := 1;
      for i := 0 to 7 do
        if board[label_tag+temp[i]] = 2 then
        begin
          while board[label_tag+temp[i]*j] = 2 do
            j := j + 1;
          if board[label_tag+temp[i]*j] = 1 then
            for k := 1 to j do
              board[label_tag+temp[i]*k] := 1;
          j := 1;
        end;

    end

    else
    begin
      board[label_tag] := 2;
      for i := 0 to 7 do
        if board[label_tag+temp[i]] = 1 then
        begin
          while board[label_tag+temp[i]*j] = 1 do
            j := j + 1;
          if board[label_tag+temp[i]*j] = 2 then
            for k := 1 to j do
              board[label_tag+temp[i]*k] := 2;
          j := 1;
        end;

    end;

    for i := 0 to (board_width+2)*(board_height+2)-1 do
      if board[i] = 10 then
        board[i] := 0;

  end;
  function is_can_click(board: array of integer; board_width : integer; board_height : integer) : boolean;
var
  i: integer;
  begin
    for i := 0 to (board_width+2) * (board_height+2) - 1 do
      if board[i] = 10 then
      begin
        result := true;
        exit;
      end;
    result := false;
  end;

end.
