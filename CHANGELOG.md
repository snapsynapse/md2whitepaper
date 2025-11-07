# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2025-11-06

### Added
- **Mermaid diagram support** via pre-processing pipeline
- Python-based `process_mermaid.py` for diagram rendering
- Dynamic LaTeX template with YAML frontmatter variables
- Custom color support (primary and secondary colors)
- Full-width table formatting with `tabularx`
- Comprehensive examples (corporate report, technical whitepaper, minimal)
- Detailed README with usage instructions
- Contributing guidelines
- MIT License
- Command validation in build script

### Changed
- **Breaking:** Removed pandoc filter dependency (now uses pre-processing)
- Improved build script with validation and error handling
- Enhanced table formatting with `ltablex` package
- Refactored template to use conditional rendering
- Updated documentation structure

### Fixed
- Narrow table column rendering
- Mermaid diagram rendering failures
- Section numbering inconsistencies
- Missing blank lines causing parsing errors

## [1.0.0] - 2025-11-05

### Added
- Initial release
- Basic markdown to PDF conversion
- Static LaTeX template
- Simple build script
- PAICE whitepaper example

### Known Issues
- Hardcoded values in template
- No mermaid support
- Tables render too narrow
- Requires manual filter installation

---

## Upgrade Guide

### From v1.0 to v2.0

1. **Install new dependencies:**
   ```bash
   npm install -g @mermaid-js/mermaid-cli
   sudo tlmgr install tabularx ltablex
   ```

2. **Update your markdown files:**
   - No changes required! v2.0 is backward compatible
   - Optionally add new YAML frontmatter variables:
     ```yaml
     primary-color: "003366"
     secondary-color: "555555"
     header-left: "Custom Header"
     ```

3. **Replace your files:**
   - `build_whitepaper.sh` → New version with validation
   - `whitepaper_template.tex` → Dynamic version
   - Add `process_mermaid.py` to your directory

4. **Test the build:**
   ```bash
   ./build_whitepaper.sh
   ```

---

## Future Roadmap

### v2.1.0 (Planned - Q1 2026)
- [ ] HTML output format
- [ ] Custom CSS for HTML
- [ ] Bibliography support (BibTeX integration)
- [ ] Cross-reference automation

### v2.2.0 (Planned - Q2 2026)
- [ ] EPUB output format
- [ ] Multi-language support
- [ ] Advanced table styling
- [ ] Image optimization

### v3.0.0 (Planned - Q3 2026)
- [ ] GUI wrapper
- [ ] Template marketplace
- [ ] Cloud rendering service
- [ ] Batch processing

---

## Release Notes Format

Each release will include:
- **Added:** New features
- **Changed:** Changes to existing functionality
- **Deprecated:** Features to be removed
- **Removed:** Removed features
- **Fixed:** Bug fixes
- **Security:** Security improvements
