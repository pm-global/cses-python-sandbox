# cses-python-sandbox
This sandbox enables on-demand local testing of CSES solutions in Python (pypy) against their provided tests.
The test suite can be run from the command palette, and solutions can be submitted without modification for scoring.

[CSES Problem Sets](https://cses.fi/problemset)

## Setup / Installation
- Confirm you have Zed and pypy
- Replicate this folder for each problem
- Download the test suite for the problem, unzip should default into the /tests/ subfolder

## Usage
- Write your solution using input() and print()
- Open the Command Palette (Ctrl+Shift+P)
- Select 'task:spawn'
- From the task menu, select "Run CSES problem tests"
- Once all your tests pass, solution.py can be submitted for scoring without changes

After running the test once, `alt+t` will run it again.

- ✓ is shown when solution output matches the test exactly
- ✗ is otherwise, and a diff follows: it shows the difference in line count and bytes, plus a comparison of the real and expected output.
```shell
✓ 1
✓ 2
✓ 3
✗ 4
  Expected: 1 lines, 9 bytes
  Got:      1 lines, 8 bytes
  Got: 2 4 1 3
  Exp: 2 4 1 3
✗ 5
  Expected: 1 lines, 11 bytes
  Got:      1 lines, 10 bytes
  Got: 2 4 1 3 5
  Exp: 2 4 1 3 5
```
***CSES tests assume " \n" at the end of output, so Got and Exp can match but the answer is still 'wrong'***

## Project Structure
**solution.py** - write your solution here with the same input() and print() functions expected by the CSES grader

**run_tests.sh** - the script that runs your solution against each test and shows the diff

**/tests/** - not included here, but required. downloaded tests create this on unzip

**/.zed/tasks.json** - task runner so it appears in the Command Palette (in Zed, at least)

## Requirements
capability to run BASH scripts, pypy, Zed, and the tests from a CSES problem unzipped into the /tests/ subfolder
