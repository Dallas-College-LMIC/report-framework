# Python Guidelines & Code Quality

Remember the following software engineering principles:

KISS - Keep it Simple, Stupid
DRY - Don't Repeat Yourself
YAGNI - You Aren't Gonna Need It


## Python Standards
- Python 3.13+ required
- Follow PEP 8 (enforced by ruff)
- Use type hints for all function signatures and public APIs
- Maximum line length: 88 characters (Black/ruff default)
- Keep functions short and focused on a single task

## Error Handling
- Use specific exception types rather than generic `Exception`
- Log errors effectively with context
- Handle errors gracefully with proper cleanup

## Security
- Always validate and sanitize user input
- Be mindful of potential injection vulnerabilities
- Never expose sensitive data in logs or error messages
