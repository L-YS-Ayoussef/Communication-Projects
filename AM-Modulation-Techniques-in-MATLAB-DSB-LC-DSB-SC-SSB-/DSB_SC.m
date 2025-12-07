%%  Generate and plot message signal 1
% Define the time vector
t = 0:1e-6:2e-3; % Time vector from 0 to 2 ms with 1 µs step size

% Generate a right triangle waveform that descends linearly from 1 to -1 over the period
% and then jumps back to 1.
m1_t = -sawtooth(2 * pi * (1/1e-3) * t+pi, 1);

% Plot the signal
figure;
plot(t * 1e3, m1_t); % Convert time to milliseconds for the plot
title('Right Triangle Waveform with Obtuse Hypotenuse (m1_t)');
xlabel('Time (msec)');
ylabel('Amplitude');
grid on;

%%  Generate and plot message signal 2
% Define the time vector
t = 0:1e-6:2e-3; % Time vector from 0 to 2 ms with 1 µs step size

% Define the step levels and the times at which they change
levels = [1 0.5 -0.5 -1 0];
change_times = [0 0.5e-3 1e-3 1.5e-3 2e-3]; % Times at which the amplitude changes

% Generate the staircase waveform
m2_t = zeros(size(t)); % Initialize the signal with zeros
for i = 1:length(change_times)-1
    % Find the indices where the time is within the current step duration
    indices = t >= change_times(i) & t < change_times(i+1);
    % Assign the level to the signal for the current step duration
    m2_t(indices) = levels(i);
end

% Plot the signal
figure;
stairs(t * 1e3, m2_t); % Use stairs function for proper step visualization
title('Staircase Waveform (m2_t)');
xlabel('Time (msec)');
ylabel('Amplitude');
grid on;

%% Part B: DSB-SC using MATLAB

% Carrier frequency and amplitude
fc = 10e3; % 10 KHz
Ac = 1; % 1 Volt amplitude

% Generate carrier signal
carrier = Ac * cos(2 * pi * fc * t);

% Modulate both message signals using DSB-SC
s1_t = m1_t .* carrier;
s2_t = m2_t .* carrier;

% Plot the modulated signal s1(t)
figure('Name', 'DSB-SC Modulation');
plot(t, s1_t);
title('Modulated Signal s1(t)');
xlabel('Time (s)');
ylabel('Amplitude (volt)');
grid on;
saveas(gcf, 's1_t_partB.fig');

% Plot the modulated signal s2(t)
figure('Name', 'DSB-SC Modulation');
plot(t, s2_t);
title('Modulated Signal s2(t)');
xlabel('Time (s)');
ylabel('Amplitude (volt)');
grid on;
saveas(gcf, 's2_t_partB.fig');

%% Demodulation
% Demodulate by multiplying with the carrier signal
demodulated_s1 = s1_t .* carrier;
demodulated_s2 = s2_t .* carrier;

% Plot the demodulated signal s1(t)
figure('Name', 'DSB-SC Demodulation');
plot(t, demodulated_s1);
title('Demodulated Signal s1(t)');
xlabel('Time (s)');
ylabel('Amplitude (volt)');
grid on;
saveas(gcf, 'demod_s1_t_partB.fig');

% Plot the demodulated signal s2(t)
figure('Name', 'DSB-SC Demodulation');
plot(t, demodulated_s2);
title('Demodulated Signal s2(t)');
xlabel('Time (s)');
ylabel('Amplitude (volt)');
grid on;
saveas(gcf, 'demod_s2_t_partB.fig');

%% Filtering (Low Pass Filter)
% Filter the demodulated signals
% Assuming the cutoff frequency is slightly higher than the message signal bandwidth
% For simplicity, using an inbuilt MATLAB function for LPF which might require Signal Processing Toolbox

% LPF for demodulated signal s1(t)
%filtered_s1 = lowpass(demodulated_s1, 1, 1/(t(2)-t(1)));

% LPF for demodulated signal s2(t)
%filtered_s2 = lowpass(demodulated_s2, 1, 1/(t(2)-t(1)));


%% Filtering (Low Pass Filter using Butterworth filter)
% Design a Butterworth low pass filter
% The nth order of the filter (for example, we use 5 here)
n = 5;

% The cutoff frequency normalized from 0 to 1 (1 corresponds to half the sampling rate)
Wn = 0.015; % For example, if your fc (sampling rate) is 20 kHz, this would be 0.1

% Obtain the transfer function coefficients of the Butterworth filter
[b, a] = butter(n, Wn);

% Apply the Butterworth filter to the demodulated signals
% LPF for demodulated signal s1(t)
filtered_s1 = filter(b, a, demodulated_s1);

% LPF for demodulated signal s2(t)
filtered_s2 = filter(b, a, demodulated_s2);

tM = t(1:length(filtered_s1));  % Assuming filtered_s1 is shorter


% Plot the filtered signal s1(t)
figure('Name', 'Filtered Signal');
plot(tM, filtered_s1);
title('Filtered Signal s1(t)');
xlabel('Time (s)');
ylabel('Amplitude (volt)');
grid on;
saveas(gcf, 'filtered_demod_s1_t_partB.fig');

% Plot the filtered signal s2(t)
figure('Name', 'Filtered Signal');
plot(tM, filtered_s2);
title('Filtered Signal s2(t)');
xlabel('Time (s)');
ylabel('Amplitude (volt)');
grid on;
saveas(gcf, 'filtered_demod_s2_t_partB.fig');
