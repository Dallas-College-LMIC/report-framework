# Development Commands

## Running Python Code
```bash
# Run any Python script
uv run path/to/script.py

# Run Python modules
uv run -m module_name

# Run with specific Python version
uv run --python 3.13 script.py
```

## Code Quality
```bash
# Format code with ruff
uv run ruff format .

# Lint code with ruff
uv run ruff check --fix .

# Type check with mypy
uv run mypy .

# Run all pre-commit hooks
pre-commit run --all-files
```

## Dependency Management
```bash
# Add a runtime dependency
uv add package-name

# Add a development dependency
uv add --dev package-name

# Install all dependencies
uv sync

# Update dependencies
uv lock --upgrade

# Show installed packages
uv pip list

# Remove a dependency
uv remove package-name
```
