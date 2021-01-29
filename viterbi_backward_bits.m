function output_bits = viterbi_backward_bits(table,n_registers)
%VITERBI_BACKWARD_BITS: Performs the backward bits identification in
%viterbi decoding algorithm.

%INPUTS:
       % table: The constructed table of viterbo decoder containing the
       %        pathes metrice
       % n_registers: The number of registers used in the digital
       %              implemtation of viterbi decoder
%OUTPUTS:
       % output_bits: The decoded output stream
       

table = cell2mat(table);
[rows,cols]= size(table);

output_bits = [];
prev_state_indecies = linspace(1,rows,rows); z              
for i = cols:-1:2
    %Get the minimum value index within the possible stream indeices
[~,index] = min(table(prev_state_indecies,i));  
    % Map the minimum index to the exact index in the whole table
index = prev_state_indecies(index);
     % Figure out the state which path metric is the chosen minimum one.
current_state = flip(de2bi(index-1,n_registers));
     % Concatenate the discovered bit, according to the current state.
output_bits = cat(2,current_state(1),output_bits);
     % Decide the possible previous states
prev_states = bi2de([0 current_state(n_registers);
                     1 current_state(n_registers)]);
     % Convert the possible states numbers to MATLAB indecies
prev_state_indecies = prev_states + 1;
end
end

