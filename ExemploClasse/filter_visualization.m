function [response, freq_x] = filter_visualization(b,a,fs)
% Função que ilustra a resposta em magnitude, fequência e atraso de grupo
% do filtro
% b - Coeficientes b do filtro
% a - Coeficientes a do filtro
% fs - frequência de amostragem


figure()
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

n = 4024;
[response, freq_x] = freqz(b,a,n,fs);

ax1 = subplot(3,1,1);
plot(freq_x,20*log10(abs(response)),'b')
title("Mag [dB]")
ax2 = subplot(3,1,2);
plot(freq_x,unwrap(angle(response)),'b')
title("Phase")
ax3 = subplot(3,1,3);
[group_delay, freq_response_group_delay] = grpdelay(b,a,512,fs);
plot(freq_response_group_delay,group_delay,'b')
linkaxes([ax1,ax2,ax3],'x')
title("Atraso de grupo")
end

