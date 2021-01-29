function out_stream = awgn_binary(stream,snr)
%AWGN_BINARY: This function adds AWGN to the digital binary stream and
%returns the corresponding binary stream.

%Inputs:
    %stream: A binary stream to add AWGN to it
    %snr: The snr value in dB
%Outputs:
    %stream_out: The binary stream after adding the AWGN
    
 out_stream = round(awgn(stream,snr,'measured'));
 for i=1:length(out_stream)
    if out_stream(i) > 0.5
        out_stream(i) = 1;
    else
        out_stream(i) = 0;
    end
 end
end