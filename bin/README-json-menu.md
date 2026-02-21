# JSON menu (urxvt-style in iTerm2)

`json_menu.py` replicates the [urxvt JSON popup](https://gist.github.com/recht/593934ec7acc9fa4fa70659de000c916): parse JSON from the current selection and choose **Copy parsed** (pretty), **Copy raw**, or **Format** (copy pretty + notification).

Requires: macOS (uses `osascript`, `pbcopy`, `pbpaste`), Python 3.

## Setup in iTerm2

### Option A: Key binding (recommended)

1. **Preferences → Profiles → [Your Profile] → Keys → Key Mappings**
2. Click **+**, press **Cmd+Shift+J** (or another shortcut).
3. Set **Action** to **Run Command…**.
4. Command (replace `~` with your home path if needed):

   ```bash
   osascript -e 'tell application "System Events" to keystroke "c" using command down' && sleep 0.2 && ~/bin/json_menu.py
   ```

5. This copies the current selection, then runs the script; the script reads from the clipboard.

**Usage:** Select the line or blob containing JSON, press **Cmd+Shift+J**, pick an action in the dialog.

### Option B: Smart Selection + right-click

1. **Preferences → Profiles → [Your Profile] → Advanced → Smart Selection → Edit…**
2. Add a rule:
   - **Regular expression:** `(\{[^{}]*(?:\{[^{}]*\}[^{}]*)*\})`  
     (or a simpler `(\{.*\})` if your JSON is single-line and doesn’t contain `}` in strings)
   - **Precision:** Normal or High
3. In **Actions** for that rule, add **Run Command** with parameter:

   ```bash
   ~/bin/json_menu.py '\0'
   ```

   (`\0` = full match; use **Use interpolated strings** off for legacy `\0`.)

4. **Right-click** on JSON to get the context menu; the script runs with the matched text.

**Note:** Passing the selection as an argument can break if the JSON contains single quotes or complex escaping. Option A (key binding + clipboard) is more reliable.

## Install

Ensure `~/bin` is on your `PATH` (this repo’s `dot_profile.d/home_path` adds it). After `chezmoi apply`, `~/bin/json_menu.py` will exist; or symlink/copy `bin/json_menu.py` from this repo into `~/bin`.
