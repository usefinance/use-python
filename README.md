# USE Python — setup guide

This folder contains the shared Python environment for both courses you take in parallel:

- **USEMFDA** — Financial Data Analytics
- **USEMEE** — Empirical Economics

The setup installs Python and all required packages automatically. After the one-time setup, you can start JupyterLab or open the course folder in Visual Studio Code.

No existing Python installation is required.

## 1. Store this folder somewhere permanent

Unzip the downloaded `use-python` folder and move it to a permanent location, such as your **Documents** folder.

Do not work directly inside the Downloads folder or inside the open ZIP file. Move and unzip the folder first to make sure that your work is stored permanently.

## 2. Start JupyterLab

### Windows

Double-click:

`start-jupyterlab.bat`

The launcher checks whether `uv` is installed. If necessary, it installs `uv` automatically.

It then prepares the Python environment and starts JupyterLab.

The **first start** downloads Python and all required packages. This can take several minutes, so please be patient and do not close the black window.

JupyterLab will open automatically in your web browser.

**Keep the black window open while you are working.**

To stop JupyterLab, return to the black window and press:

`Ctrl+C`

You can then close the window.

### macOS

Double-click:

`start-jupyterlab.command`

The launcher checks whether `uv` is installed. If necessary, it installs `uv` automatically.

It then prepares the Python environment and starts JupyterLab.

The first time you open the launcher, macOS may prevent it from running. In that case:

1. Right-click (or Control-click) `start-jupyterlab.command`.
2. Choose **Open**.
3. In the confirmation window, click **Open**.

If macOS instead says that it “cannot check `start-jupyterlab.command` for malicious software”, with the options **Done** and **Move to Bin**:

1. If you downloaded this folder from the official course link, click **Done** — do not click **Move to Bin**.
2. Open **System Settings**.
3. Choose **Privacy & Security**.
4. Scroll down to the **Security** section.
5. Click **Open Anyway** next to the message about `start-jupyterlab.command`.
6. In the confirmation window, click **Open**.

You only need to do this once. Afterwards, double-click `start-jupyterlab.command` normally.

The **first start** downloads Python and all required packages. This can take several minutes, so please be patient and do not close the Terminal window.

JupyterLab will open automatically in your web browser.

**Keep the Terminal window open while you are working.**

To stop JupyterLab, return to the Terminal window and press:

`Ctrl+C`

You can then close the window.

## 3. Start Visual Studio Code (optional)

Visual Studio Code (VS Code) is an alternative way to work with the course files.

### Windows

Double-click:

`start-vscode.bat`

If VS Code is already installed, it opens the `use-python` folder immediately. If it is not installed, the launcher asks whether you want to install it. Choose `Y` only if you want to download and run the official VS Code user installer. No administrator rights are normally required.

### macOS

Double-click:

`start-vscode.command`

If VS Code is already installed, it opens the `use-python` folder immediately. If it is not installed, the launcher asks whether you want to open the official VS Code download page. After installing VS Code and moving it to the Applications folder, run the launcher again.

macOS may ask you to approve `start-vscode.command` the first time you run it. Follow the same right-click **Open** and **Open Anyway** guidance above.

To work with Python notebooks in VS Code, install the Microsoft **Python** and **Jupyter** extensions from the Extensions panel.

## 4. Working folders

The folders for the two courses are located inside the `use-python` folder.

Put your notebooks and course-specific data files inside the appropriate course folder:

```text
use-python/
│
├── USEMFDA/
│   └── notebooks/    Financial Data Analytics notebooks
│
├── USEMEE/
│   └── notebooks/    Empirical Economics notebooks
│
├── README.md
├── pyproject.toml
├── start-jupyterlab.bat
├── start-jupyterlab.command
├── start-vscode.bat
└── start-vscode.command
```

This allows both courses to use the same Python installation and packages while keeping your course files separate.

## 5. Python environment

The environment is managed using `uv`.

You do **not** need to install Python yourself. The required Python version is downloaded automatically when the environment is created for the first time.

The shared environment requires:

```text
Python >= 3.12
```

The package configuration is stored in:

`pyproject.toml`

Do not modify this file unless instructed to do so.

## 6. Included packages

The environment contains the packages required for both courses.

### Data analysis

- `pandas`
- `polars`
- `numpy`
- `pyarrow`
- `openpyxl`

For example:

```python
import pandas as pd
import polars as pl
import numpy as np
```

### Data access

- `requests`
- `yfinance`
- `wrds`
- `openassetpricing`
- `tidyfinance`

These packages can be used to retrieve data from APIs and financial databases.

### Statistics, econometrics, and machine learning

- `scipy`
- `statsmodels`
- `linearmodels`
- `pyfixest`
- `scikit-learn`

These packages provide statistical, econometric, and machine-learning methods.

### SQL and databases

- `duckdb`

DuckDB allows you to work with SQL directly from Python and can also query pandas and Polars data.

### Data visualization

- `matplotlib`
- `seaborn`
- `plotly`

These packages can be used to create static and interactive visualizations.

### Dashboards and interactivity

- `ipywidgets`
- `panel`

These packages allow you to create interactive controls and dashboards from JupyterLab.

### AI and large language models

- `openai`
- `ollama`

These packages provide Python interfaces for working with OpenAI models and locally hosted models through Ollama.

> **Note:** The Python package `ollama` is included, but running local models also requires the Ollama application and the relevant model to be installed separately.

### Parallel computing and performance

- `joblib`
- `dask`
- `numba`

`joblib` provides a simple way to parallelize independent computations.

`dask` provides parallel and larger-than-memory data processing.

`numba` can substantially speed up numerical Python functions by compiling suitable Python and NumPy code at runtime.

### JupyterLab

- `jupyterlab`

JupyterLab is the main working environment used in the courses.

## 7. Do not install packages inside notebooks

Please do **not** install packages yourself from inside a Jupyter notebook.

In particular, do not use commands such as:

```python
!pip install package_name
```

or:

```python
%pip install package_name
```

The purpose of the shared environment is to make sure that everybody works with the same packages and package versions.

If you need a package that is not available, ask the instructor to add it to the shared configuration.

## 8. Starting applications later

After the initial setup, starting your Python environment is simple.

### Windows

Double-click:

`start-jupyterlab.bat`

### macOS

Double-click:

`start-jupyterlab.command`

The environment does not need to be installed again. `uv` will check the environment and JupyterLab should normally start within a few seconds.

### Visual Studio Code

Double-click `start-vscode.bat` on Windows or `start-vscode.command` on macOS. Once VS Code is installed, the launcher simply opens this folder in VS Code.

## 9. If something goes wrong

If the launcher reports an error:

1. Do not repeatedly reinstall Python or individual packages.
2. Take a screenshot of the complete error message shown in the black/Terminal window.
3. Send the screenshot to the instructor.

This makes it much easier to identify and fix the problem.
