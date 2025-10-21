# Feedforward Neural Networks — Shape Classification in MATLAB

A MATLAB-based project developed using the **Deep Learning Toolbox**, focused on designing and training **Feedforward Neural Networks** for geometric shape classification.  
The goal was to create, evaluate and optimize networks capable of identifying different shapes from binary image datasets.


## Overview

This project explores how network **topology**, **activation functions**, **training algorithms** and **data partitioning** influence the performance of feedforward neural networks in a **pattern recognition** context.

The system classifies six geometric shapes:
- Circle  
- Kite  
- Parallelogram  
- Square  
- Trapezoid  
- Triangle  

The project was divided into several stages of experimentation, testing various configurations and analyzing their effects on accuracy and generalization.

## Technologies Used

- **MATLAB** – Implementation language and development environment  
- **Deep Learning Toolbox** – Neural network creation, training and performance analysis  
- **Excel (Experiences.xlsx)** – Used for storing, comparing and visualizing experimental results  

## Datasets Structure

The project used multiple image folders, each containing **binary images of six geometric shapes**:  
circle, kite, parallelogram, square, trapezoid and triangle.

The datasets were organized as follows:

- **Start** – 5 images per shape (small, initial dataset used for preliminary training).  
- **Train** – 50 images per shape (main dataset for model training).  
- **Test** – 10 images per shape (used for evaluation and generalization tests).  
- **Draw** – 5 hand-drawn images per shape, created by the team as required for manual testing.

Each image was converted into a **25×25 binary matrix**, representing pixel values used as inputs for the neural network.

## Project Stages

The project was structured into several stages, each designed to progressively enhance the Feedforward Neural Network’s ability to classify geometric shapes.

### a) Initial Training – Start Dataset
i. Converted images from the **Start** folder (5 per shape) into **25×25 binary matrices** using MATLAB image processing.  
ii. Trained a simple **feedforward neural network** with 1 hidden layer (10 neurons) to recognize all shapes.  
iii. Tested alternative topologies (more neurons/layers) and compared accuracy across configurations.

### b) Extended Training – Train Dataset
i. Used the **Train** folder (50 images per shape) to build and evaluate different network configurations.  
ii. Compared results by varying:
   - Topology (layers and neurons)  
   - Activation and training functions  
   - Data division ratios (train/validation/test)  
   Recorded global and test accuracies, as well as confusion matrices.  

iii. Saved the **three best-performing models** for later analysis.

### c) Combined Evaluation – Start, Train, and Test Datasets
i. Tested the best models on all datasets to assess generalization.  
ii. Retrained the top networks with **Test** data and compared performance improvements.  
iii. Trained using **all images combined** to evaluate overall accuracy.  
iv. Saved the **three best final networks** for future use.

### d) Manual Drawings Classification
i. Created a **Draw** dataset (5 new hand-drawn images per shape).  
ii. Converted drawings into binary matrices and classified them using the best trained networks.  
iii. Observed generalization behavior and analyzed misclassifications.

### e) MATLAB Graphical Interface
i. Developed a **MATLAB GUI** that allows:  
   - Configuration of network topology and parameters  
   - Selection of training/activation functions  
   - Training, saving, and loading networks  
   - Classifying datasets or hand-drawn shapes  
   - Displaying confusion matrices and results

## Experiments

All network configurations and results are detailed in **[ExperiencesCr.xlsx](ExperiencesCr.xlsx)**.  
This file includes all tests, accuracy values and parameter comparisons performed during experimentation.

### Default Configuration

- **Hidden layers:** 1  
- **Neurons per layer:** 10  
- **Activation functions:** `tansig`, `purelin`  
- **Training function:** `trainlm`  
- **Data division:** `dividerand = {0.7, 0.15, 0.15}`  
- **Epochs:** 20  

### Example Console Output
```bash
Starting training with 5 repetitions:
Topology: 10 neurons
Epochs: 20
Training Function: trainlm
Activation Function: tansig
Data Split: 0.70 / 0.15 / 0.15
Dataset: Start

Average Accuracy (5 runs):
Global: 81.33% (±6.91)
Test: 40.00% (±14.14)
```
---

*This work was completed as part of the “Knowledge and Reasoning” course during the 2024/2025 academic year.*
