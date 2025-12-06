# Communication Projects

## 🌍 Overview

This repository contains a collection of communication systems projects implemented in `Python` and `MATLAB`. The focus is on building, simulating, and analyzing different communication techniques and concepts in a structured, hands-on way.

Each project lives in its own folder with its own `README.md`, code, and assets.

## 🚀 Projects

### 1️⃣ AM Modulation Techniques in MATLAB (DSB-LC, DSB-SC, SSB)
**Folder:** `AM-Modulation-Techniques-in-MATLAB-DSB-LC-DSB-SC-SSB-/`  
This project implements and visualizes three fundamental analog modulation schemes using `MATLAB`:

- Double Sideband Large Carrier (DSB-LC)
- Double Sideband Suppressed Carrier (DSB-SC)
- Single Sideband (SSB)

The goal is to illustrate how each scheme works in the time and frequency domains, and to highlight the trade-offs in power and bandwidth efficiency.

### 2️⃣ Pulse Modulation Techniques: PAM, Flat-Top-PAM, PWM, and PPM [Modulation-and-Demodulation]
**Folder:** `Pulse-Modulation-Techniques-PAM-Flat-Top-PAM-PWM-PPM-Modulation-and-Demodulation-/`  
This project implements and visualizes four fundamental pulse modulation techniques:

- Pulse Amplitude Modulation (PAM)
- Flat-Top Pulse Amplitude Modulation (Flat-Top PAM)
- Pulse Width Modulation (PWM)
- Pulse Position Modulation (PPM)

For each technique, both modulation and demodulation are demonstrated using simple mathematical models and signal plots.

### 3️⃣ Digital Filtering of an Audio Signal
**Folder:** `Digital-Filtering-of-an-Audio-Signal/`  
This project focuses on **digital FIR filtering of an audio signal** using `MATLAB`.  
It consists of two main parts:

- **Part 1:** Development of a filter design tool supporting:
  - Windowed Sinc FIR design
  - Least Squares (LS) FIR design
  - Weighted Least Squares (WLS) FIR design
- **Part 2:** Practical application of the tool to:
  - Analyze an audio file in time and frequency domains
  - Add a sinusoidal interference
  - Design FIR filters to suppress the interference
  - Evaluate the results by plotting spectra and listening to the processed audio

### 4️⃣ Spectrogram Analysis of Epileptic EEG Using STFT and Windowing
**Folder:** `Spectrogram-Analysis-of-Epileptic-EEG-Using-STFT-and-Windowing/`  
This project builds an analytical system for **EEG spectrogram analysis** using the **Short-Time Fourier Transform (STFT)** implemented from scratch with MATLAB’s `fft()` function. The system works on epileptic electroencephalography (EEG) recordings from the CHB-MIT database and focuses on comparing **seizure (ictal)** and **seizure-free (interictal)** states.

The core goals are to:

- Implement a spectrogram generator using STFT and FFT.
- Investigate the impact of **window size**, **window type**, and **overlapping ratio** on the spectrogram representation.
- Understand the trade-off between **time resolution** and **frequency resolution** in practical EEG analysis.

All code is implemented in MATLAB (`.m` and `.mlx` files), and the project operates on multi-channel EEG data sampled at **256 Hz**.


### 5️⃣ JPEG Image Coding & Convolutional Channel Coding in Python
**Folder:** `JPEG-Image-Coding-with-DCT-and-Convolutional-Channel-Coding-in-Python/`  
This project implements a **JPEG-like image compression scheme** and a **convolutional channel coding system** entirely in **Python**, without using built-in JPEG or convolutional-coding libraries.

- **Part 1 – JPEG Encoder/Decoder:**  
  A custom grayscale JPEG-style codec is implemented for 8-bit images:
  - Block-based 2D DCT (coded from scratch),
  - Quantization using multiple 8×8 tables,
  - Zig-zag scanning, run-length encoding,
  - Huffman coding and finite-precision arithmetic coding,
  - Full decoder pipeline and visual comparison for each quantization table.

- **Part 2 – Channel Coding over AWGN:**  
  A **rate 1/3 convolutional encoder** (constraint length K = 3) and **hard-decision Viterbi decoder** are implemented, integrated with BPSK modulation over an **AWGN channel**. The JPEG bitstream from Part 1 is protected with this code to build a complete **source + channel coding communication system**.

All demonstrations and plots (BER vs SNR, reconstructed images) are generated in Python.

