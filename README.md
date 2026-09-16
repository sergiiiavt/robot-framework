# Robot Framework reference project

A real, runnable Robot Framework test-automation project. It uses the public GimmeJob production site as the system under test and demonstrates a maintainable split between tests, reusable domain keywords, configuration, and Python extension code.

## What is covered

- Robot Framework 7.5
- Browser Library 20.4.0 for Playwright-backed UI tests
- RequestsLibrary 0.9.7 for HTTP API tests
- a typed custom Python keyword library
- environment-driven configuration
- smoke/core/API/UI tags
- GitHub Actions execution with Robot reports preserved as artifacts

## Project structure

```text
.
├── .github/workflows/robot.yml
├── libraries/
│   └── ProjectLibrary.py
├── resources/
│   ├── api.resource
│   └── web.resource
├── tests/
│   ├── api/health.robot
│   ├── core/framework_contract.robot
│   └── ui/public_site.robot
├── variables/
│   └── default.py
├── requirements.txt
└── README.md
```

The dependency direction is intentionally simple:

```text
tests -> resources -> external Robot libraries / custom Python library
                     -> variables
```

Tests describe behavior. Resource files hide repeated protocol/UI mechanics. Python is used only for technical behavior that is clearer there than in Robot syntax.

## Local setup

Python 3.13 and Node.js 22 are the reference runtime versions used in CI.

### Windows PowerShell

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
rfbrowser init
python -m robot --outputdir results tests
```

### Linux / macOS

```bash
python -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
rfbrowser init
python -m robot --outputdir results tests
```

Expected output is written to `results/`:

- `output.xml` — canonical Robot result data
- `log.html` — detailed execution log
- `report.html` — high-level report

## Useful commands

Run smoke tests only:

```bash
python -m robot --include smoke --outputdir results tests
```

Run API tests:

```bash
python -m robot --include api --outputdir results tests
```

Run UI tests:

```bash
python -m robot --include ui --outputdir results tests
```

Run deterministic framework/core checks without external HTTP/browser traffic:

```bash
python -m robot --include core --outputdir results tests
```

Validate suite structure without executing test keywords:

```bash
python -m robot --dryrun --output NONE --log NONE --report NONE tests
```

## Configuration

The defaults target `https://gimme-job.com` and run Chromium headlessly. Override them with environment variables:

| Variable | Default | Purpose |
| --- | --- | --- |
| `BASE_URL` | `https://gimme-job.com` | system under test |
| `BROWSER` | `chromium` | Browser Library browser engine |
| `HEADLESS` | `true` | headless/headed browser execution |
| `DEFAULT_TIMEOUT` | `10s` | shared UI assertion timeout |

Example:

```bash
BASE_URL=https://staging.example.com HEADLESS=false python -m robot --include ui tests
```

PowerShell:

```powershell
$env:BASE_URL = "https://gimme-job.com"
$env:HEADLESS = "false"
python -m robot --include ui tests
```

## Why the tests are structured this way

`tests/core/framework_contract.robot` proves the custom Python keyword contract without relying on external systems. `tests/api/health.robot` verifies the real production health endpoint through RequestsLibrary. `tests/ui/public_site.robot` opens the real site through Browser Library and checks stable user-visible behavior.

The UI suite uses state-based Browser assertions instead of sleeps. The API suite keeps the HTTP call in a reusable resource keyword and sends the response object to a Python assertion helper. This makes the test read at the behavior level while leaving implementation details one layer below.

## CI

`.github/workflows/robot.yml` installs the pinned dependencies, initializes Browser Library, performs a Robot dry run, executes the full test suite, and uploads `results/` even when a test fails. This means a failed CI run still retains `output.xml`, `log.html`, and `report.html` for debugging.

The suite intentionally exercises the public production site, so API/UI jobs require outbound internet access. The `core` tests remain deterministic and can run independently when external access is unavailable.
