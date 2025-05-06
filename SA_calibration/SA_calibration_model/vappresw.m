function [ tulos ] = vappresw( T )
%saturation vapor pressure of water (Pa) at temperature T (K)
%Preining 1981

tulos = exp(77.34491296-7235.424651./T-8.2.*log(T)+0.0057113.*T);

end

