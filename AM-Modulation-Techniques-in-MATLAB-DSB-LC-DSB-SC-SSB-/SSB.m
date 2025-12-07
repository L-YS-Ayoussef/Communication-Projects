%% Generating the Message Signal 
% Define the bandwidth B
B = 1e3; % Bandwidth of 1 KHz

% Define the time vector over which to generate the signal
t = -5e-3:1e-6:5e-3; % Time from -5 ms to +5 ms with 1 µs step

% Generate the message signal m2(t)
m2_t = sinc(B * t); % sinc function is defined as sin(pi*t)/(pi*t)

% Plot the message signal
figure('Name', 'Sinc Message Signal');
plot(t, m2_t);
title('Message Signal m2(t)');
xlabel('Time (msec)');
ylabel('Amplitude (volt)');
grid on;
saveas(gcf, 'sinc_partC.fig');

%% Generate the SSB modulated signal and plot
% Define the carrier amplitude and frequency
Ac = 2; % Amplitude of the carrier is 2 Volts
fc = 5e3; % Carrier frequency of 5 KHz

% Generate the carrier signal
carrier_signal = Ac * cos(2 * pi * fc * t);

% Generate the Hilbert transform of the message signal
hilbert_transform = imag(hilbert(m2_t));

% Generate the USB modulated signal
usb_signal = carrier_signal .* m2_t - hilbert_transform .* sin(2 * pi * fc * t);

% Generate the LSB modulated signal
lsb_signal = carrier_signal .* m2_t + hilbert_transform .* sin(2 * pi * fc * t);

% Plot the USB and LSB signals
figure('Name', 'Modulated Signal');
subplot(2,1,1);
plot(t, usb_signal);
title('Upper Sideband (USB) Output');
xlabel('Time (msec)');
ylabel('Amplitude (volt)');
grid on;

subplot(2,1,2);
plot(t, lsb_signal);
title('Lower Sideband (LSB) Output');
xlabel('Time (msec)');
ylabel('Amplitude (volt)');
grid on;
saveas(gcf, 'modSignal_partC.fig');

%% Plot the spectrum of the modulated signals
% Calculate and plot the spectrum of the USB signal
figure('Name', 'Modulated Signal Spectrum');
[frequency, magnitude] = freq_spectrum(usb_signal, t);
subplot(2,1,1);
plot(frequency, magnitude);
title('Spectrum of USB Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

% Calculate and plot the spectrum of the LSB signal
[frequency, magnitude] = freq_spectrum(lsb_signal, t);
subplot(2,1,2);
plot(frequency, magnitude);
title('Spectrum of LSB Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;
saveas(gcf, 'spect_modSignal_partC.fig');


%% Demodulate the signal
% Demodulation of the USB signal
demodulated_usb = usb_signal .* (2 * carrier_signal);

% Demodulation of the LSB signal
demodulated_lsb = lsb_signal .* (2 * carrier_signal);

% Plot the demodulated message signal
figure('Name', 'Demodulated Signal');
subplot(2,1,1);
plot(t, demodulated_usb);
title('Demodulated Message from USB Signal before filtering');
xlabel('Time (msec)');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
plot(t, demodulated_lsb);
title('Demodulated Message from LSB Signal before filtering');
xlabel('Time (msec)');
ylabel('Amplitude');
grid on;
saveas(gcf, 'demodSignal_partC_before_filter.fig');
%% Filter
% The nth order of the filter (for example, we use 5 here)
n = 5;
% The cutoff frequency normalized from 0 to 1 (1 corresponds to half the sampling rate)
Wn = 0.01; % For example, if your fc (sampling rate) is 20 kHz, this would be 0.1
% Obtain the transfer function coefficients of the Butterworth filter
[b, a] = butter(n, Wn);
% Apply the Butterworth filter to the demodulated signals
% LPF for demodulated signal s1(t)
message_retrieved_usb = filter(b, a, demodulated_usb);
% LPF for demodulated signal s2(t)
message_retrieved_lsb = filter(b, a, demodulated_lsb);
tM = t(1:length(message_retrieved_usb));  % Assuming filtered_s1 is shorter

% Plot the demodulated message signal
figure('Name', 'Demodulated Signal');
subplot(2,1,1);
plot(tM, message_retrieved_usb);
title('Demodulated Message from USB Signal');
xlabel('Time (msec)');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
plot(tM, message_retrieved_lsb);
title('Demodulated Message from LSB Signal');
xlabel('Time (msec)');
ylabel('Amplitude');
grid on;
saveas(gcf, 'demodSignal_partC.fig');

%% Investigate frequency offset in carrier synchronization
% Frequency offsets for local carrier at the receiver due to non-perfect synchronization
f1 = fc + 0.1 * B; % Offset by +10% of B
f2 = fc - 0.2 * B; % Offset by -20% of B

% Generate local carriers with frequency offsets
local_carrier_f1 = Ac * cos(2 * pi * f1 * t); % Local carrier for f1
local_carrier_f2 = Ac * cos(2 * pi * f2 * t); % Local carrier for f2

% Demodulation process using local carriers with frequency offsets
demodulated_with_f1 = usb_signal .* (2 * local_carrier_f1); % Demodulate with f1
demodulated_with_f2 = usb_signal .* (2 * local_carrier_f2); % Demodulate with f2


n = 5;
Wn = 0.01; 
[b, a] = butter(n, Wn);
message_with_f1 = filter(b, a, demodulated_with_f1);
message_with_f2 = filter(b, a, demodulated_with_f2);
tM = t(1:length(message_with_f2));  % Assuming filtered_s1 is shorter

% Plotting the results showing the effect of frequency offset on the demodulated message
figure('Name', 'Frequency Offset');
subplot(2,1,1);
plot(tM, message_with_f1);
title('Demodulated Message with f1 Offset');
xlabel('Time (msec)');
ylabel('Amplitude');
grid on; % Plot for f1 offset

subplot(2,1,2);
plot(tM, message_with_f2);
title('Demodulated Message with f2 Offset');
xlabel('Time (msec)');
ylabel('Amplitude');
grid on; % Plot for f2 offset
saveas(gcf, 'frequency_offset_partC.fig');



%% Function at the end
% Function to calculate the frequency spectrum of a signal
function [f, M] = freq_spectrum(signal, t)
    N = length(signal);
    Y = fftshift(fft(signal));
    f = (-N/2:N/2-1)/(t(2)-t(1))/N;
    M = abs(Y);
end









