# Code Review

- /code-review for quality, /security-review for security-sensitive changes. Checklists and severity criteria live in the skills — don't duplicate them here.
- Run /security-review when changing: auth/authorization, user input handling, database queries, file system operations, external API calls, cryptography, payment/financial code.
- Review before committing to shared branches or merging PRs.
- Language-specific standards (rules/golang, rules/typescript) load automatically when matching files are in context.
