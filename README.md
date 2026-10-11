# TPD matcher

## A. What the program does

TPD matcher assigns trainees (doctors) to hospitals from their ranked choices. It uses a doctor-proposing, capacity-constrained matching process based on Gale–Shapley.

The director selects a ranking spreadsheet, supplies each hospital's number of full-time places and jobshare policy, and can pre-allocate particular trainees. The program produces an assignment spreadsheet with one column per hospital.

- A full-time trainee uses one full-time place.
- At a hospital where **Allows Jobshares** is set to Yes, each part-time trainee uses half a place; two part-time trainees therefore share one full-time job.
- At hospitals where jobshares are not allowed, a part-time trainee uses one full-time place.
- Pre-allocations are assigned before the remaining matching takes place.
- If a trainee cannot receive any ranked hospital, the result can still be saved with that trainee in an `UNALLOCATED` column.
- The supplied data has no hospital preference ranking. When places are contested, spreadsheet row order is the deterministic tie-break.

### Ranking spreadsheet format

Input may be a `.csv` or `.xlsx` spreadsheet. The first row should contain headings; every later row represents one trainee.

| Column | Contents |
| --- | --- |
| A, B | ignored |
| C | trainee name; must be unique |
| D | `full-time` or `part-time` (FT/PT are also accepted) |
| E | ignored notes/free text |
| F onward | hospitals in preference order |

## B. Run the Windows application

No Python, Tkinter, or terminal is needed to use the pre-built Windows application.

1. Download [tpd_matcher_windows.zip](tpd_matcher_windows.zip) from this project's main directory.
2. Extract the entire ZIP file. Do not extract only `TPDMatcher.exe`; it needs the accompanying `_internal` folder.
3. Open `dist\TPDMatcher\TPDMatcher.exe` from the extracted files.
4. Follow the on-screen instructions: select the ranking spreadsheet, enter hospital settings and any pre-allocations, then choose where to save the result as CSV or XLSX.

Windows may show a SmartScreen warning for this unsigned, privately distributed executable. This is a Windows trust warning, not a missing dependency.

## C. Build from source

Build each platform on that platform. The resulting application is self-contained for its recipients.

### Linux

Install Python 3.10+ with Tkinter support. On Debian/Ubuntu using the system Python:

```bash
sudo apt install python3-tk python3-venv
```

If Python was installed with pyenv, install `tk-dev` before building/rebuilding that Python version, then verify this succeeds:

```bash
python3 -c "import tkinter; print(tkinter.TkVersion)"
```

From the project root, run:

```bash
cd tpd_matcher_linux
bash build_linux.sh
```

The distributable application is `tpd_matcher_linux/dist/TPDMatcher/`. Send that whole folder to another Linux machine; recipients open `TPDMatcher` and do not need Python or a terminal.

### Windows

Copy the entire project folder to a Windows machine: the builder needs `matcher.py` and `requirements.txt` from the project root as well as `tpd_matcher_win/`.

1. Install a current Python from [python.org](https://www.python.org/downloads/windows/).
2. Open the copied project folder and double-click `tpd_matcher_win\build_windows.bat`.
3. The completed app is in `tpd_matcher_win\dist\TPDMatcher\`.

Distribute that complete `TPDMatcher` folder. Recipients double-click `TPDMatcher.exe` and need no other setup.

## D. Run from the command line

Install the spreadsheet dependency once:

```bash
python -m pip install -r requirements.txt
```

Launch the graphical workflow from the project root:

```bash
python matcher.py
```

The program asks for an input spreadsheet, director settings, and an output location. Output may be `.csv` or `.xlsx`.

For scripted/repeatable runs, pass the input, output, and a JSON director configuration:

```bash
python matcher.py assignments.xlsx --rankings rankings.xlsx --config director_config.json
```

Use a `.csv` output filename to create CSV instead. Add `--no-header` only when the ranking spreadsheet has no heading row.

### Director configuration JSON

```json
{
  "hospitals": {
    "North Hospital": {"full_time_places": 3, "allows_jobshares": true},
    "South Hospital": {"full_time_places": 2, "allows_jobshares": false}
  },
  "preallocations": {
    "Dr Ada Example": "North Hospital"
  }
}
```

`preallocations` may be an empty object (`{}`). A pre-allocation need not appear in that trainee's ranking, but it must fit within the hospital's capacity.
