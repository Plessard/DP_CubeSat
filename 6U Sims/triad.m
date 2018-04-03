% function [Cba, accuracy] = triad(attitude,sa,sb,ma,mb) 
function [q] = triad(attitude,sa,sb,ma,mb) 

    % sa, ma --> inertial frame sun and magnetic field vectors respectively
    % sb, mb --> body frame sun and magnetic field vectors respectively

    % add white guassian noise to measured values
    % awgn(<vector>,<snr>)
    % <snr>: signal-to-noise ratio in dB
    
%     sb = awgn(sb,25,'measured');

   % add white gaussian noise to magmetometer
    %mb = awgn(mb,20,'measured');
    % add noise to sun sensor
%     noiseSigma_s = 0.06 * sb;
%     noise_s = noiseSigma_s .* randn(3,1);
%     sb = sb + noise_s;
    

    %normalize body frame vectors (measured values)
    sb = sb/norm(sb);
    mb = mb/norm(mb);

    %normalize inertial frame vectors (known values)
    sa = sa/norm(sa);
    ma = ma/norm(ma);

    tb1 = sb;
    tb2 = cross(sb,mb)/norm(cross(sb,mb));
    tb3 = cross(tb1,tb2);
    FB = [tb1 tb2 tb3];

    ta1 = sa;
    ta2 = cross(sa,ma)/norm(cross(sa,ma));
    ta3 = cross(ta1,ta2);
    FA = [ta1 ta2 ta3];

    % Cba*FA = FB
    Cba = FB*(FA');
    q = dcm2quat(Cba);

    % check accuracy
    % what is the measured attitude relative to known attitude
%     Cb2true = Cba*attitude';
%     prv = dcm2prv(Cb2true);
% 
%     accuracy = norm(prv)*180/pi;
end