# Contributing to Whitepaper Generator

Thank you for your interest in contributing! This document provides guidelines for contributing to the project.

## How to Contribute

### Reporting Bugs

If you find a bug, please create an issue with:
- Clear description of the problem
- Steps to reproduce
- Expected vs. actual behavior
- Your environment (OS, software versions)
- Sample markdown file (if applicable)

### Suggesting Enhancements

Enhancement suggestions are welcome! Please include:
- Clear description of the feature
- Use case and motivation
- Proposed implementation (if applicable)

### Pull Requests

1. **Fork the repository**
   ```bash
   git clone https://github.com/yourusername/whitepaper-generator.git
   cd whitepaper-generator
   ```

2. **Create a feature branch**
   ```bash
   git checkout -b feature/amazing-feature
   ```

3. **Make your changes**
   - Follow existing code style
   - Add comments for complex logic
   - Test thoroughly

4. **Commit your changes**
   ```bash
   git commit -m 'Add amazing feature'
   ```

5. **Push to your fork**
   ```bash
   git push origin feature/amazing-feature
   ```

6. **Open a Pull Request**
   - Describe your changes clearly
   - Reference any related issues
   - Include example outputs if applicable

## Development Guidelines

### Code Style

**Bash Scripts:**
- Use 4-space indentation
- Add comments for non-obvious logic
- Use meaningful variable names
- Follow ShellCheck recommendations

**Python Scripts:**
- Follow PEP 8 style guide
- Use type hints where applicable
- Add docstrings for functions
- Keep functions focused and small

**LaTeX Templates:**
- Comment complex formatting
- Maintain consistent spacing
- Use semantic naming for colors/styles

### Testing

Before submitting:

1. **Test with examples**
   ```bash
   ./build_whitepaper.sh examples/minimal_example.md
   ./build_whitepaper.sh examples/corporate_report.md
   ./build_whitepaper.sh examples/technical_whitepaper.md
   ```

2. **Test edge cases**
   - Empty frontmatter
   - No mermaid diagrams
   - Large documents (100+ pages)
   - Special characters in titles

3. **Verify cleanup**
   - Check that auxiliary files are removed
   - Ensure no leftover temp files

### Documentation

- Update README.md for new features
- Add examples for significant changes
- Keep comments up-to-date
- Document any new dependencies

## Project Structure

```
whitepaper-generator/
├── build_whitepaper.sh      # Main build script
├── process_mermaid.py        # Mermaid pre-processor
├── whitepaper_template.tex   # LaTeX template
├── examples/                 # Example documents
├── README.md                 # Main documentation
├── CONTRIBUTING.md           # This file
└── LICENSE                   # MIT License
```

## Feature Priorities

### High Priority
- [ ] Additional output formats (HTML, EPUB)
- [ ] Custom CSS for HTML output
- [ ] Bibliography/citation support
- [ ] Multi-language support

### Medium Priority
- [ ] Custom font selection
- [ ] Advanced table styling
- [ ] Image optimization
- [ ] Batch processing

### Low Priority
- [ ] GUI wrapper
- [ ] Cloud rendering service
- [ ] Template marketplace

## Questions?

- 📧 Email: support@paice.work
- 💬 Discussions: [GitHub Discussions](https://github.com/yourusername/whitepaper-generator/discussions)
- 🐛 Issues: [GitHub Issues](https://github.com/yourusername/whitepaper-generator/issues)

## Code of Conduct

### Our Pledge

We are committed to providing a welcoming and inclusive environment for all contributors.

### Our Standards

**Positive behavior includes:**
- Using welcoming and inclusive language
- Being respectful of differing viewpoints
- Gracefully accepting constructive criticism
- Focusing on what's best for the community

**Unacceptable behavior includes:**
- Trolling, insulting/derogatory comments, and personal attacks
- Public or private harassment
- Publishing others' private information without permission
- Other conduct which could reasonably be considered inappropriate

### Enforcement

Instances of unacceptable behavior may be reported to support@paice.work. All complaints will be reviewed and investigated promptly and fairly.

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

**Thank you for contributing!** 🎉
