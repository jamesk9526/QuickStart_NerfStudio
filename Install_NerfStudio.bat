@echo off
SETLOCAL

:: Install Git
echo Installing Git...
:: Add your command to install Git here

:: Install Visual Studio 2022
echo Installing Visual Studio 2022...
:: Add your command to install Visual Studio 2022 here

:: Install Conda
echo Installing Conda...
:: Add your command to install Conda here

:: Create and activate Conda environment
echo Creating and activating Conda environment...
call conda create --name nerfstudio -y python=3.8
call conda activate nerfstudio
call python -m pip install --upgrade pip

:: Uninstall previous versions of PyTorch dependencies
echo Uninstalling previous versions of PyTorch dependencies...
call pip uninstall torch torchvision functorch tinycudann -y

:: Install PyTorch 2.0.1 with CUDA 11.8
echo Installing PyTorch 2.0.1 with CUDA 11.8...
call pip install torch==2.0.1+cu118 torchvision==0.15.2+cu118 --extra-index-url https://download.pytorch.org/whl/cu118

:: Install cuda-toolkit
echo Installing cuda-toolkit...
call conda install -c "nvidia/label/cuda-11.8.0" cuda-toolkit

:: Install tiny-cuda-nn
echo Installing tiny-cuda-nn...
call pip install ninja
call pip install git+https://github.com/NVlabs/tiny-cuda-nn/#subdirectory=bindings/torch

:: Installing nerfstudio
echo Installing nerfstudio...
call pip install nerfstudio

:: Optional: Install nerfstudio from source
:: echo Installing nerfstudio from source...
:: call git clone https://github.com/nerfstudio-project/nerfstudio.git
:: call cd nerfstudio
:: call pip install --upgrade pip setuptools
:: call pip install -e .

echo Installation complete.
ENDLOCAL