function Iout = BT709_gamma(Iin)
    Mask = Iin < 0.018;
    Iout = max(0,Iin * 4.5) .* Mask + (1.099*max(Iin,0).^0.45 - 0.099) .* (~Mask);
end