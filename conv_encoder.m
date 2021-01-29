function out = conv_encoder(stream,gs)
%CONV_ENCODER: this function perform the econding for a stream of binary
%bits using the convolitional encoding method with specified K and r

%INPUTS:
    %stream: The binary stream of bits to be encoded.
    %gs    : The generative polynomials
        %The dimension of gs must be (r x K), r is the number of parity
        %bits to be added, K is the block size at each evaluation
%OUTPUTS:
    %out: The encoded stream
    
  %----------Get r and K---------------
[r,K] = size(gs);


%concatenate K-1 zeros at the begining of the stream (start from state 00)
stream = [zeros(1,K-1) stream]; 
len = length(stream);
out = [];

 %----------- The algorithm steps ------------
for n=K:len
 for i=1:r
   g = gs(i,:); 
   temp = g.*stream(n-K+1:n);
   out = [out poly_xor(temp)];
 end
end

end
