# Pipeline Notes

## Real-World Enhancements

- Use semantic image tags such as Git commit SHA or release tag.
- Add Trivy or Docker Scout scanning before pushing images.
- Use separate deploy credentials for dev, stage, and prod.
- Add manual approval before production deployment.
- Capture deployment events in Slack or email notifications.

## Rollback Command

```bash
kubectl rollout undo deployment/webapp-webapp -n devops-demo
kubectl rollout status deployment/webapp-webapp -n devops-demo
```
