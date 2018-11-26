unit Fuzzy;

interface

uses GraphABC;

type
  MF = class
    name: string;
    constructor (name: string);
    begin
      self.name := name;
    end;
    function fun(x: real): real; virtual; abstract;
    procedure plot(a, b: real; c: color); virtual; abstract;
  end;
  TrapMF = class(MF)
    a, b, c, d: real;
    function fun(x: real): real; override;
    procedure plot(a, b: real; c: color); override;
    constructor (name: string; a, b, c, d: real);
    begin
      inherited create(name);
      self.a := a;
      self.b := b;
      self.c := c;
      self.d := d;
    end;
  end;

type
  Lingvar = auto class
    name: string;
    a, b: real;
    funcs: List<MF>; 
    procedure Plot;
    procedure Grid(nx, ny: integer);
    procedure Add(f: MF);
  end;

type
  FuzzyModel = class
    name: string;
    input, output: List<Lingvar>;
    rules: array [,] of integer;
    constructor (input, output: List<Lingvar>; rules: array [,] of integer);
    begin
      self.input := input;
      self.output := output;
      self.rules := rules;
    end;
    function ToFuzzy(x: List<real>): List<List<real>>; virtual; abstract;
    //function ToDefuzzy(x: List<real>): List<real>; virtual; abstract;
  end;
  Sugeno = class(FuzzyModel)
    constructor (input, output: List<Lingvar>; rules: array [,] of integer);
    begin
      inherited Create(input, output, rules);
    end;
    function ToFuzzy(x: List<real>): List<List<real>>; override;
    //function ToDefuzzy(x: List<real>): List<real>; override;
  end;



implementation


var
  colorsmf := new List<color>;

/// Строим графики всех MF лингвистической переменной
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
  begin
    var xx := round((x + dx * i) * Sx + Hu);
    line(xx, 0, xx, Window.Width);
  end;
  pen.Width := 2;
end;



function Sugeno.ToFuzzy(x: List<real>): List<List<real>>;
begin
  result := new List<List<real>>;
  result.Capacity := x.Count;
  for var i := 0 to x.Count - 1 do
  begin
    result[i] := new List<real>;
    result[i].Capacity := self.input.
  end;
  for var i := 0 to x.Count - 1 do
  begin
    var t := new List<real>;
    for var j := 0 to input[i].funcs.Count - 1 do
      t.Add(input[i].funcs[j].fun(x[i]));
    result.Add(t);
  end;
end;

procedure Lingvar.Add(f: MF);
begin
  self.funcs.Add(f);
end;

begin
  pen.Width := 2;
  colorsmf.AddRange(seq(clBlue, clRed, clGreen, clGoldenrod, clDarkMagenta, clDarkOrange));
end.