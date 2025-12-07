%%  Generate and plot message signal 1
% Define the time vector
t = 0:1e-6:2e-3; % Time vector from 0 to 2 ms with 1 µs step size

% Generate a right triangle waveform that descends linearly from 1 to -1 over the period
% and then jumps back to 1.
m1_t = -sawtooth(2 * pi * (1/1e-3) * t+pi, 1);

% Plot the signal
figure('Name', 'My Triangle Waveform Figure');
plot(t * 1e3, m1_t); % Convert time to milliseconds for the plot
title('Right Triangle Waveform (m1_t)');
xlabel('Time (msec)');
ylabel('Amplitude (volt)');
grid on;
%saveas(gcf, 'triangle_waveform.fig');

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
figure('Name', 'Info. Signal2 m2(t) Figure');
stairs(t * 1e3, m2_t); % Use stairs function for proper step visualization
title('Staircase Waveform (m2_t)');
xlabel('Time (msec)');
ylabel('Amplitude');
grid on;
saveas(gcf, 'msg_signal2.fig');

%% DSB-LC Modulation 
% Define the carrier amplitude and frequency
Ac = 2; % Carrier amplitude of 2 Volts
fc = 10e3; % Carrier frequency of 10 KHz

% Define modulation indices
Ka_values = [0.5, 1, 2];

for Ka = Ka_values
    % Generate the modulated signals for m1(t) and m2(t)
    s1_t = Ac * (1 + Ka * m1_t) .* cos(2 * pi * fc * t);
    s2_t = Ac * (1 + Ka * m2_t) .* cos(2 * pi * fc * t);
    
    % Modulation index is simply the value of Ka
    modulation_index = Ka;
    
    % Plot the modulated signals
    figure('Name', 'DSB-LC Modulation');
    subplot(2,1,1);
    plot(t, s1_t);
    title(['Modulated Signal s(t) for m1(t) with K_a = ', num2str(Ka)]);
    xlabel('Time (msec)');
    ylabel('Amplitude (volt)');
    grid on;
    
    subplot(2,1,2);
    plot(t, s2_t);
    title(['Modulated Signal s(t) for m2(t) with K_a = ', num2str(Ka)]);
    xlabel('Time (msec)');
    ylabel('Amplitude (volt)');
    grid on;
    filename = ['st_Ka_', num2str(Ka), '.fig'];
    saveas(gcf, filename);
end



