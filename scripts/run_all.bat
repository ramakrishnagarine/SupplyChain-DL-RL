@echo off
setlocal

REM === Go to the folder this .bat is in (your scripts folder) ===
pushd "%~dp0"

REM === Activate the virtual environment (one level up) ===
call "..\venv\Scripts\activate"

REM === Output folder ===
set "OUTDIR=%cd%\outputs"
if not exist "%OUTDIR%" mkdir "%OUTDIR%"

REM === Jupyter kernel and timeout ===
set "KERNEL=scai-310"
set "TIMEOUT=-1"

REM === Run notebooks in a fixed order ===
for %%F in (
  "4_2_2_Temporal_Features_Baseline.ipynb"
  "5_1_Baseline_Code.ipynb"
  "5_2_Ablation Study on Hybrid DL-RL Model Components (1).ipynb"
  "5_3_McNemar_Test (1).ipynb"
  "5_4_ROC_Curve.ipynb"
  "5_5_Confusion_Matrix.ipynb"
  "5_6_Training_Dynamics.ipynb"
  "6_1_SP500_Validation.ipynb"
  "6_2_Kfold_Validation.ipynb"
  "6_3_Validation_DataCo.ipynb"
  "6_4_Contextual Bandit.ipynb"
  "6_5_Mixture of Experts.ipynb"
  "8_1_PPO_Only.ipynb"
  "8_2_1_PPO_Timesteps_Graphs.ipynb"
  "8_2_Sensitivity_Timesteps.ipynb"
  "8_3_epoch_sensitivity.ipynb"
  "8_4_Testsize_Sensitivity.ipynb"
  "8_5_Reward_Sensitivity.ipynb"
) do (
  echo === Running %%~F ===
  "%~dp0..\venv\Scripts\python.exe" -m jupyter nbconvert --to notebook --execute "%%~F" ^
    --output "%%~nF_out.ipynb" ^
    --output-dir "%OUTDIR%" ^
    --ExecutePreprocessor.timeout=%TIMEOUT% ^
    --ExecutePreprocessor.kernel_name=%KERNEL%
  if errorlevel 1 (
    echo *** FAILED: %%~F
    pause
    exit /b 1
  )
)

echo.
echo Done. Outputs saved to: "%OUTDIR%"
pause
