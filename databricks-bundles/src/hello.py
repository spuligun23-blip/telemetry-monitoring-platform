# Databricks notebook source
print("Hello from Databricks!")
print(f"Workspace: {spark.conf.get('spark.databricks.workspaceId')}")
print("✅ Deployment successful via GitHub Actions + DABs! Lets check it out")