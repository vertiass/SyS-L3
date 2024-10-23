% Definimos parámetros comunes
fs = 10000;    % Frecuencia de muestreo (10 kHz)
t = 0:1/fs:1-1/fs;  % Vector de tiempo para 1 segundo

% 1. Señal sinusoidal de amplitud unitaria y frecuencia 200 Hz
x1 = sin(2*pi*200*t);

% 2. Señal sinusoidal de amplitud 10 y frecuencia 500 Hz
x2 = 10 * sin(2*pi*500*t);

% 3. Suma de ambas señales
x3 = x1 + x2;

% 4. Agregar ruido blanco a la suma de las señales
x4 = x3 + randn(size(t));

% 5. Leer archivo de audio (asegúrate de que 'acoustic.wav' esté disponible)
[x5, fs_audio] = audioread('acoustic.wav');
x5 = x5(:,1);  % Seleccionar solo un canal si es estéreo

% Procesar cada señal llamando a la función personalizada
procesar_senal(x1, fs, t, 'Señal Sinusoidal 200 Hz');
procesar_senal(x2, fs, t, 'Señal Sinusoidal 500 Hz');
procesar_senal(x3, fs, t, 'Suma de Señales');
procesar_senal(x4, fs, t, 'Suma de Señales con Ruido Blanco');
procesar_senal(x5, fs_audio, (0:length(x5)-1)/fs_audio, 'Señal de Audio (acoustic.wav)');

% --- Función para calcular y graficar señales, FFT y espectrograma ---
function procesar_senal(x, fs, t, nombre)
    % Calcular FFT
    N = length(x);             % Longitud de la señal
    X = fft(x);                % FFT de la señal
    f = (0:N-1) * (fs / N);    % Vector de frecuencias
    X_mag = abs(X) / N;        % Magnitud normalizada

    % --- Graficar Señal Original ---
    figure;
    subplot(3,1,1);
    plot(t, x);
    title(['Señal Original - ', nombre]);
    xlabel('Tiempo (s)');
    ylabel('Amplitud');
    grid on;
    xlim([0, 0.05]);  % Zoom en los primeros 50 ms para mayor claridad

    % --- Graficar Transformada de Fourier ---
    subplot(3,1,2);
    plot(f(1:floor(N/2)), X_mag(1:floor(N/2)));  % Usamos floor para índices enteros
    title(['Transformada de Fourier - ', nombre]);
    xlabel('Frecuencia (Hz)');
    ylabel('Magnitud');
    grid on;

    % --- Graficar Espectrograma ---
    subplot(3,1,3);
    spectrogram(x, 256, 250, 256, fs, 'yaxis');
    title(['Espectrograma - ', nombre]);
    colorbar;
end
