---
applyTo: "**/*.{tf,tfvars,hcl}"
---

# Terraform / IaC Standards

## Naming and Structure

- Use meaningful, descriptive names for resources, variables, outputs, and modules.
- Organize code into logical modules (`modules/`) and reuse across environments.
- Structure root module files consistently: `main.tf`, `variables.tf`, `outputs.tf`, `providers.tf`, `backend.tf`.

## Variables and Configuration

- Use variables for all configurable values; hardcoding is forbidden.
- Provide `description` and `type` for every variable; add `default` only for optional values.
- Use `locals` for derived values and to avoid repetition.
- Use `outputs` to expose necessary information for other modules or users.
- Use corresponding prefix in naming convention (e.g., `v_` for variable, `r_` for resource, `m_` for module, `o_` for output, `_l` for local) to easily identify the type of entity.
- Use `tfvars` files per environment (e.g., `dev.tfvars`, `prod.tfvars`); never commit `*.auto.tfvars` with secrets.
- Use variable for environment and common prefix for resource names (e.g., `v_solution_slug = xyz-`) to maintain consistency across resources. Example name is `${v_solution_slug}-${v_environment}-raw-data`.

## Quality Gates

- Format all code with `terraform fmt` before committing.
- Validate with `terraform validate` and scan with `tflint` or `checkov` in CI.
- Pin provider and module versions with explicit constraints (e.g., `~> 5.0`).
- Use `terraform plan` output in PR reviews before applying changes.

## State Management

- Store state remotely (e.g., GCS, S3, Azure Blob) with state locking enabled.
- Never commit `terraform.tfstate` or `*.tfstate.backup` to version control.
- Use workspaces or directory-per-environment pattern for multi-environment management.

## Security

- Mark sensitive variables with `sensitive = true`.
- Use IAM roles and service accounts with least-privilege permissions.
- Never store secrets in Terraform files; use a secret manager (e.g., Vault, GCP Secret Manager).

## References

- Follow [coding standards](coding.standard.instructions.md) for universal coding rules.
- Follow [devops](devops.instructions.md) for CI/CD and deployment practices.
