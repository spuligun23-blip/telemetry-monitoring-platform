# Telemetry Monitoring Platform

## CI/CD Flow
- **Pull Request** → Deploys to DEV workspace
- **Merge to main** → Deploys to PROD workspace

## Infrastructure
- **Terraform**: Creates 2 Databricks workspaces (dev/prod)
- **Service Principal**: Authenticates deployments
- **DABs**: Manages notebook + scheduled job

## Orchestration
- Job runs daily at 9 AM (configured in databricks.yml)
- Deployed via GitHub Actions using Service Principal