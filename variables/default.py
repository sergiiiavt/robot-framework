import os


def _as_bool(value: str) -> bool:
    return value.strip().lower() in {"1", "true", "yes", "on"}


BASE_URL = os.getenv("BASE_URL", "https://gimme-job.com").rstrip("/")
BROWSER = os.getenv("BROWSER", "chromium")
HEADLESS = _as_bool(os.getenv("HEADLESS", "true"))
DEFAULT_TIMEOUT = os.getenv("DEFAULT_TIMEOUT", "10s")

__all__ = ["BASE_URL", "BROWSER", "HEADLESS", "DEFAULT_TIMEOUT"]
