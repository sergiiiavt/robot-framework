from __future__ import annotations

from typing import Any

from robot.api.deco import keyword, library


@library(scope="GLOBAL", auto_keywords=False)
class ProjectLibrary:
    """Small technical keyword library used by the reference Robot project."""

    @keyword("Build URL")
    def build_url(self, base_url: str, path: str) -> str:
        """Join a base URL and path without introducing duplicate slashes."""
        return f"{base_url.rstrip('/')}/{path.lstrip('/')}"

    @keyword("Response Should Be Healthy")
    def response_should_be_healthy(self, response: Any) -> None:
        """Assert the GimmeJob health response contract."""
        status_code = getattr(response, "status_code", None)
        if status_code != 200:
            raise AssertionError(f"Expected HTTP 200, got {status_code!r}")

        try:
            payload = response.json()
        except Exception as exc:  # noqa: BLE001 - convert third-party response errors into test evidence
            raise AssertionError("Health response did not contain valid JSON") from exc

        if not isinstance(payload, dict):
            raise AssertionError(f"Expected a JSON object, got {type(payload).__name__}")
        if payload.get("ok") is not True:
            raise AssertionError(f"Expected health payload ok=true, got {payload!r}")
