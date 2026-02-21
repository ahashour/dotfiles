#!/usr/bin/env python3
"""
JSON menu for iTerm2: parse JSON from selection and offer Copy Parsed / Copy Raw / Format.
Replicates urxvt Perl behavior: https://gist.github.com/recht/593934ec7acc9fa4fa70659de000c916

Reads input from stdin, or from pbpaste (macOS) when no stdin, or from first argument.
"""

import json
import re
import subprocess
import sys
from pathlib import Path


def get_input() -> str:
    """Get text from stdin, pbpaste, or first argument."""
    if not sys.stdin.isatty():
        return sys.stdin.read()
    if len(sys.argv) > 1:
        return sys.argv[1]
    # macOS: use clipboard (caller should copy selection before running, e.g. via key binding)
    try:
        r = subprocess.run(
            ["pbpaste"],
            capture_output=True,
            text=True,
            timeout=2,
        )
        if r.returncode == 0 and r.stdout:
            return r.stdout
    except (FileNotFoundError, subprocess.TimeoutExpired):
        pass
    return ""


def extract_json(text: str) -> str | None:
    """Extract first JSON object from text (from first { to matching })."""
    text = text.strip()
    start = text.find("{")
    if start == -1:
        return None
    depth = 0
    in_string = False
    escape = False
    quote = None
    for i in range(start, len(text)):
        c = text[i]
        if escape:
            escape = False
            continue
        if c == "\\" and in_string:
            escape = True
            continue
        if not in_string:
            if c == "{":
                depth += 1
            elif c == "}":
                depth -= 1
                if depth == 0:
                    return text[start : i + 1]
            elif c in ('"', "'"):
                in_string = True
                quote = c
        elif c == quote:
            in_string = False
    return None


def main() -> None:
    raw = get_input()
    if not raw:
        print("No input: pipe JSON, pass as argument, or copy selection then run.", file=sys.stderr)
        sys.exit(1)

    json_str = extract_json(raw)
    if not json_str:
        print("No JSON object found in input.", file=sys.stderr)
        sys.exit(1)

    try:
        parsed = json.loads(json_str)
        pretty = json.dumps(parsed, indent=2)
    except json.JSONDecodeError as e:
        print(f"Invalid JSON: {e}", file=sys.stderr)
        sys.exit(1)

    # macOS: show dialog with three options
    script = '''
    set choice to choose from list {"Copy parsed (pretty)", "Copy raw", "Format (copy pretty + notify)"} \
        with title "JSON" with prompt "Choose action" default items {"Copy parsed (pretty)"} \
        without empty selection allowed
    if choice is false then return "cancel"
    return item 1 of choice
    '''
    r = subprocess.run(
        ["osascript", "-e", script],
        capture_output=True,
        text=True,
        timeout=60,
    )
    if r.returncode != 0 or not r.stdout:
        sys.exit(0)
    choice = r.stdout.strip()
    if choice == "cancel":
        sys.exit(0)

    if choice == "Copy parsed (pretty)":
        subprocess.run(["pbcopy"], input=pretty, text=True, check=True)
    elif choice == "Copy raw":
        subprocess.run(["pbcopy"], input=json_str, text=True, check=True)
    elif choice == "Format (copy pretty + notify)":
        subprocess.run(["pbcopy"], input=pretty, text=True, check=True)
        subprocess.run(
            ["osascript", "-e", 'display notification "Formatted JSON copied to clipboard" with title "JSON"'],
            check=True,
        )
    else:
        print("Unknown choice", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
