unit Rproject;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure boardclick(sender: Tobject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  board_label: array of TLabel;
  is_start : boolean = false;
  board : array of integer;
  board_width : integer = 8;
  board_height : integer = 8;
  turn : integer = 1;
  pass : boolean = false;

procedure printboard(var board_label : array of Tlabel; board_width : integer; board_height : integer);

implementation

{$R *.dfm}

uses Rproject2;

procedure TForm1.boardclick(sender: Tobject);
begin
  if board[(sender as Tlabel).Tag] = 10 then
  begin
  click_action(board, board_width, board_height, (sender as Tlabel).Tag, turn);
  turn := turn + 1;
  mark_board(board, board_width, board_height, turn);
  if is_can_click(board, board_width, board_height) = false then
    begin
    turn := turn + 1;
    mark_board(board, board_width, board_height, turn);
    end;
  //showmessage('click ('+inttostr((sender as Tlabel).tag)+')');
  printboard(board_label, board_width, board_height);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i: Integer;
  j: Integer;
  k: integer;
begin
  if is_start = false then
  begin
    setlength(board, (board_width+2)*(board_height+2));
    setlength(board_label, (board_width+2)*(board_height+2));

    clear_board(board, board_width, board_height);
    set_board_wall(board, board_width, board_height);
    reversie_start(board, board_width, board_height);
    mark_board(board, board_width, board_height, turn);

    for i := 0 to board_height +1 do
      for j := 0 to board_width +1 do
      begin
        k := i*(board_width+2) + j;
        board_label[k] := Tlabel.Create(self);
        board_label[k].Parent := self;
        board_label[k].Tag := k;
        board_label[k].Width := 30;
        board_label[k].Height := 30;
        board_label[k].Top := 30 + i*30;
        board_label[k].Left := 30 + j*30;
        board_label[k].AutoSize := false;
        board_label[k].font.size := 20;
        if board[k] <> -100 then
          board_label[k].Transparent := false
        else
         board_label[k].Transparent := true;
        if ((k div (board_width+2)) mod 2 = 1) then
        begin
        if (k mod 2 = 1) then
          board_label[k].Color := clwhite
        else
          board_label[k].Color := clyellow;
        end
        else
        begin
        if (k mod 2 = 1) then
          board_label[k].Color := clyellow
        else
          board_label[k].Color := clwhite;
        end;
        board_label[k].OnClick := boardclick;
      end;
  end;

  if is_start = true then
  begin
    turn := 1;
    pass := false;

    clear_board(board, board_width, board_height);
    set_board_wall(board, board_width, board_height);
    reversie_start(board, board_width, board_height);
    mark_board(board, board_width, board_height, turn);
  end;

  printboard(board_label, board_width, board_height);

  is_start := true;
end;



procedure printboard(var board_label : array of Tlabel; board_width : integer; board_height : integer);
var
  i: Integer;
begin
  for i := 0 to (board_width+2)*(board_height+2)-1 do
  begin
        if board[i] = 1 then
          board_label[i].Caption := '¡Û'
        else if board[i] = 2 then
          board_label[i].Caption := '¡Ü'
        else if board[i] = 10 then
          board_label[i].caption := '#'
        else if board[i] = 0 then
          board_label[i].Caption := '';
  end;
end;

end.
