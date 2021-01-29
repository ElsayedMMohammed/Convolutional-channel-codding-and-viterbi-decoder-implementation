function out = poly_xor(vec)
%POLY_XOR: this function performs XOR operation between the content of
%1D-Vector


len = length(vec);
out = vec(1);

for i=2:len
   out = xor(out,vec(i)); 
end

end