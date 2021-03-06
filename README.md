# WindowingHotKeys

A simple zero-dependency window manager for macOS.

## Usage

Move and resize windows with global hot keys.

| Hot Key                                    | Description          |
| ------------------------------------------ | -------------------- |
| <kbd>⌃</kbd> + <kbd>⌥</kbd> + <kbd>↑</kbd> | Top half             |
| <kbd>⌃</kbd> + <kbd>⌥</kbd> + <kbd>↓</kbd> | Bottom half          |
| <kbd>⌃</kbd> + <kbd>⌥</kbd> + <kbd>→</kbd> | Right half           |
| <kbd>⌃</kbd> + <kbd>⌥</kbd> + <kbd>←</kbd> | Left half            |
| <kbd>⌃</kbd> + <kbd>⌥</kbd> + <kbd>U</kbd> | Top Left Quarter     |
| <kbd>⌃</kbd> + <kbd>⌥</kbd> + <kbd>I</kbd> | Top Right Quarter    |
| <kbd>⌃</kbd> + <kbd>⌥</kbd> + <kbd>J</kbd> | Bottom Left Quarter  |
| <kbd>⌃</kbd> + <kbd>⌥</kbd> + <kbd>K</kbd> | Bottom Right Quarter |
| <kbd>⌃</kbd> + <kbd>⌥</kbd> + <kbd>⏎</kbd> | Maximize             |
| <kbd>⌃</kbd> + <kbd>⌥</kbd> + <kbd>C</kbd> | Center               |
| <kbd>⌃</kbd> + <kbd>⌥</kbd> + <kbd>⌫</kbd> | Restore              |

### How to quit the app after hiding the status bar item

Open the Terminal, type `kill $(pgrep WindowingHotKeys)` and hit enter. The
application will then terminate, and can be launched again with the status bar
item appearing as usual.
