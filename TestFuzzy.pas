uses GraphABC, Fuzzy;
begin
 { var f := new TrapMF('Холодно', 1, 2, 3, 4);
  print(f.name, f.fun(3.2));
  var a := new Lingvar('Температура', 10, 40, new List<MF>);
  a.Add(f);}
  {X: -1  -0.6 0 0.4   1
   Y:  1  0.36 0 0.16  1}
  
  var x := new Lingvar('X', -1, 1, new List<MF>);
  x.add(new TrapMF('bn', -1, -1, -0.9, -0.8));
  x.add(new TrapMF('n', -0.9, -0.6, -0.6, -0.4));
  x.add(new TrapMF('z', -0.3, -0.1, 0.1, 0.3));
  x.add(new TrapMF('p', 0.2, 0.4, 0.4, 0.6));
  x.add(new TrapMF('bp', 0.8, 0.9, 1, 1));
  //var y: real -> real := x.funcs[1].fun; 
  //draw(x.funcs[1].fun, -1, 1, 0, 1);
  //x.plot;
  //x.funcs[1].plot(-1, 1, clDarkOrange)
  var y := new Lingvar('Y', 0, 1, new List<MF>);
  y.funcs.Add(new TrapMF('1', 0.8, 0.9, 1, 1));
  y.funcs.Add(new TrapMF('0.36', 0.3, 0.36, 0.36, 0.4));
  y.funcs.Add(new TrapMF('0.16', 0.1, 0.16, 0.16, 0.2));
  y.funcs.Add(new TrapMF('0', 0.0, 0.0, 0.05, 0.1));
  x.plot;
  var s := new Sugeno(new List<Lingvar>, new List<Lingvar>, new integer[5, 2]);
  s.input.Add(x);
  s.output.Add(y);
  s.ToFuzzy(lst(0.22)).Println;
end.