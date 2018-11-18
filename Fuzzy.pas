unit Fuzzy;

interface
type TrapMF = auto class
  name: string;
  a, b, c, d: real;
  function fun(x: real): real;
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
  
type Lingvar = auto class
  name: string;
  opr: (real, real);
  funcs: List<TrapMF>; 
end;
    
implementation

begin

end.