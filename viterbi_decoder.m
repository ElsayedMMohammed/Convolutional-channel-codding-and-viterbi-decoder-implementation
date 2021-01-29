function output_bits = viterbi_decoder(rcvd,gs)
%VITERBI_DECODER: this function perform the deconding for a stream of binary
%bits using the viterbi decoding method with specified generative
%polynomials.

%INPUTS:
    %rcvd: The received encoded stream of bits to be decoded.
    %gs  : The generative polynomials
        %The dimension of gs must be (r x K), r is the number of parity
        %bits to be added, K is the block size at each evaluation
%OUTPUTS:
    %output_bits: The decoded stream

%----------Get r and K and the basic constants---------------
[r,K] = size(gs);
len = length(rcvd);
n_registers=K-1; 
n_states = 2^n_registers;

%--------- Generate the viterbi table for path metric-----------
 table = cell(n_states,1+len/r);
 table(:,:) = num2cell(inf); 
 table{1,1} = 0; % first initialization (Path metric)
 
%---------- Filling the viterbi table---------------------------
 for col = 1:len/r
     %Update the word to be compared..
     word = rcvd(col*r-r+1:col*r);
     for index=1:n_states
          state = flip(de2bi(index-1,n_registers));
           for i=0:1
           new_state = [i state];
           temp = conv_encoder(flip(new_state),gs); 
 %-----------ALERT:::WHy flipping in the previous line?------------------%
%As our (conv_encoder) is getting the previous bits, not the 
%following ones. [ Starting from state 00]. 
%To illustrate: if the next state 100 and we entered it to the encoder, it
%will deal with it as 00100 and k=3, r=3, hence the first word is 001 and
%the application of the generative polynomial will be reversed in this case
%------------------------------------------------------------------------%
           state_out = temp(end-r+1:end);
               % Calculate the hamming distance
           col2go = col+1; row2go=bi2de(flip(new_state(1:end-1)))+1;
           acc_ham_distance = sum(state_out ~= word) + table{index,col};
           table{row2go,col2go}= min(table{row2go,col2go},acc_ham_distance);
          end
     end
 end
 
%--------------Get the bits correspond to the optimum path generated-----
output_bits = viterbi_backward_bits(table,n_registers);
end
