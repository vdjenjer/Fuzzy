uses Fuzzy;
begin
  var f := new Trapmf('Холодно', 1, 2, 3, 4);
  print(f.name, f.fun(3.2));
  var a := new Lingvo('Температура', (10.0, 40.0), new List<TrapMF>);
  a.funcs.Add(f);
end.