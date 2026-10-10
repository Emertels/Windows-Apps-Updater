# Changelog

## 1.0.0 — 2026-10-09

- Sets the CMD palette to `07` for light text on black without high-intensity output.

- Removes the global CMD color override to keep the default console style without emphasized text.

- Organizes the docs into a PT-BR primary README and a separate English version, with guidance tailored to this project’s options and workflow.

- Updates the run instructions to point directly to the correct project entry point.

- Fixes accented text and progress-bar display in CMD by setting console output encoding without using CHCP.

- Consolidates the updater into one Batch file without `chcp 65001`.
- Clarifies that winget upgrades apps, not hardware drivers.

- Upgrades available winget packages and reports the exit code.
- Adds a ten-language interface and session banner.
- Keeps one-click launch through the BAT file.
- Documents that this utility does not install hardware drivers.


- Corrects accents and cedilla in interface text and documentation, aligns session headers, and updates agent instructions.

- Usage, dependency, and required-file documentation was reviewed to match current project behavior.

- Aligns the author, projects, and official communities section with the Antigravity reference repository.

- Packages the Batch release with CRLF line endings so CMD does not misread or close the script.

- Restores the original dark-green console color to avoid the bold-looking text appearance.

- Sets normal (400) font weight in classic CMD and restores the dark-green palette.

- Sets console input and output to UTF-8 through the console APIs, preserving accents without CHCP; keeps normal font weight and dark green.
