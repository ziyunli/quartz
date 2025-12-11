---
created: 2025-11-24
---

## Worker Versioning

> The `BuildID`/`UseBuildIDForVersioning` API is deprecated [^3]. The current approach uses **Worker Deployments** (Public Preview, GA expected Q4 2025 [^5]). Minimum Go SDK version: v1.35.0+.

### Core Concepts [^1]

- **Worker Deployment**: A service across multiple versions
- **Worker Deployment Version**: A specific version identified by Deployment Name + Build ID
- **Pinned Workflows**: Execute entirely on their original version; no patching needed
- **Auto-Upgrade Workflows**: Automatically move to newer versions; require patching for replay-safety

Version states: `Inactive` → `Active` → `Draining` → `Drained`

### Worker Setup (Go SDK) [^1] [^4]

```go
buildID := os.Getenv("MY_BUILD_ID")
w := worker.New(c, "my-task-queue", worker.Options{
    DeploymentOptions: worker.DeploymentOptions{
        UseVersioning: true,
        Version: worker.WorkerDeploymentVersion{
            DeploymentName: "my-service",
            BuildId:        buildID,
        },
    },
})
```

### Register Workflow as Pinned [^1] [^4]

```go
w.RegisterWorkflowWithOptions(MyWorkflow, workflow.RegisterOptions{
    VersioningBehavior: workflow.VersioningBehaviorPinned,
})
```

### Starting a Workflow with Version Override [^1] [^4]

```go
opts := client.StartWorkflowOptions{
    ID:        "my-workflow-id",
    TaskQueue: "my-task-queue",
    VersioningOverride: &client.PinnedVersioningOverride{
        Version: worker.WorkerDeploymentVersion{
            DeploymentName: "my-service",
            BuildId:        "1.0",
        },
    },
}
we, err := c.ExecuteWorkflow(ctx, opts, MyWorkflow, input)
```

### CLI Commands [^1]

```bash
# Check deployment versions
temporal worker deployment describe --name="my-service"

# Set current version (100% traffic)
temporal worker deployment set-current-version \
    --deployment-name "my-service" \
    --build-id "2.0"

# Ramp traffic to new version (gradual rollout)
temporal worker deployment set-ramping-version \
    --deployment-name "my-service" \
    --build-id "2.0" \
    --percentage=10

# Move a pinned workflow to a different version
temporal workflow update-options \
    --workflow-id "my-workflow-id" \
    --versioning-override-behavior pinned \
    --versioning-override-deployment-name "my-service" \
    --versioning-override-build-id "2.0"
```

### Choosing a Strategy [^1]

| Strategy         | Use Case                                                                  |
| ---------------- | ------------------------------------------------------------------------- |
| **Pinned**       | Rainbow deployments; workflows stay on original version until completion  |
| **Auto-Upgrade** | Blue-green deployments; workflows move to new version (requires patching) |

[^1]: [Worker Versioning | Temporal Docs](https://docs.temporal.io/production-deployment/worker-deployments/worker-versioning) - Official docs for the new Deployments-based versioning

[^2]: [Versioning - Go SDK | Temporal Docs](https://docs.temporal.io/develop/go/versioning) - Go SDK versioning guide (patching + worker versioning)

[^3]: [Worker Versioning (Legacy) | Temporal Docs](https://docs.temporal.io/encyclopedia/worker-versioning-legacy) - Deprecated BuildID API reference

[^4]: [worker package | Go Packages](https://pkg.go.dev/go.temporal.io/sdk/worker) - Go SDK worker package API reference

[^5]: [Replay 2025 Product Announcements | Temporal Blog](https://temporal.io/blog/replay-2025-product-announcements) - Latest feature announcements including Worker Versioning updates
