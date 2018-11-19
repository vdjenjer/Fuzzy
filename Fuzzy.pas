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
  end;

implementation


var
  colorsmf := new List<color>;


procedure Lingvar.plot;
begin
  for var i := 0 to funcs.Count - 1 do
  begin
    funcs[i].plot(-1, 1, colorsmf[i mod colorsmf.Count])
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
  (rx, ry) := ((b - a) * 1.1, 1.1);
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

begin
  pen.Width := 2;
  colorsmf.AddRange(seq(clBlue, clRed, clGreen, clGoldenrod, clDarkMagenta, clDarkOrange));
end.