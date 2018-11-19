unit Fuzzy;

interface

uses GraphABC;

type
  TrapMF = auto class
    name: string;
    a, b, c, d: real;
    function fun(x: real): real;
    procedure plot(a, b: real; c: color);
  end;

type
  Lingvar = auto class
    name: string;
    a, b: real;
    funcs: List<TrapMF>; 
    procedure plot;
    procedure grid(nx, ny: integer);
  end;

implementation


var
  colorsmf := new List<color>;


procedure Lingvar.plot;
begin
  Window.Caption := 'Linguistic variable: ' + name;
  grid(10, 4);
  for var i := 0 to funcs.Count - 1 do
  begin
    funcs[i].plot(a, b, colorsmf[i mod colorsmf.Count])
  end;
end;



function TrapMF.fun(x: real): real;
begin
  begin
    if x <= a then
      result := 0
    else if x <= b then 
      result := (x - a) / (b - a)
    else if x <= c then
      result := 1
    else if x <= d then
      result := (d - x) / (d - c)
    else
      result := 0;
  end;
end;

///Строит одну MF на отрезке [a, b]

procedure TrapMF.plot(a, b: real; c: color);
var
  Hu, Hv, rx, ry, Sx, Sy: real;
begin
  (rx, ry) := ((b - a) * 1.02, 1.01);
  (Sx, Sy) := (Window.Width / rx, Window.Height / ry);
  (Hu, Hv) := (-a * Sx, Window.Height - 2);
  var dx := 0.01;
  var p := new List<Point>;
  var x := a;
  while x < b do
  begin
    var y := -fun(x);
    p.Add(pnt(round(x * Sx + Hu), round(-fun(x) * Sy + Hv)));
    x += dx;
  end;
  pen.Color := c;
  Polyline(p.ToArray);
end;

///Строит масштабную сетку
procedure Lingvar.grid(nx, ny: integer);
var
  Hu, Hv, rx, ry, Sx, Sy: real;
begin
  (rx, ry) := ((b - a) * 1.02, 1.01);
  (Sx, Sy) := (Window.Width / rx, Window.Height / ry);
  (Hu, Hv) := (-a * Sx, Window.Height - 2);
  // Оси
  pen.Color := clDarkGray;
  DrawRectangle(0, 0, Window.Width, Window.Height);
  line(0, round(Hv), Window.Width, round(Hv));
  line(round(Hu), 0, round(Hu), Window.Height);
  // Горизонтали
  pen.Width := 1;
  pen.Color := clLightGray;
  for var i := 0 to ny - 1 do
    line(0, round(Hv / ny * i), Window.Width, round(Hv / ny * i));
  // Вертикали
  var dx := (b - a) / nx;
  var x := a;
  for var i := 1 to nx do
    line(round((x + dx * i) * Sx + Hu), 0, round((x + dx * i) * Sx + Hu), Window.Width);
  pen.Width := 2;
end;

begin
  pen.Width := 2;
  colorsmf.AddRange(seq(clBlue, clRed, clGreen, clGoldenrod, clDarkMagenta, clDarkOrange));
end.