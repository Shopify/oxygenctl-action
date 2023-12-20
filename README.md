# Shopify/oxygenctl-action

This action allows Shopify merchants to deploy their Hydrogen applications to the Oxygen hosting platform from GitHub Actions.

## Usage

This action is utilized by a workflow file that Shopify adds to the Github repository when a storefront is created from the Hydrogen channel or Hydrogen CLI. The workflow then calls this action on the "push" event. This allows merchants to deploy to Oxygen automatically whenever they push changes to their repository.

It is also possible to call this action on the "workflow_dispatch" event for manually triggered deployments, however this is unsupported.

### Inputs

This action accepts the following inputs:

- `build_command`: The command to execute to build the project. The environment variable `OXYGEN_ASSET_BASE_URL` is available as a reference to the location where assets will be available for the deployment on the Shopify CDN. This is a required input.
- `commit_message`: The message of the commit. Defaults to the message of the triggering commit, or "No commit message" when none is provided.
- `commit_timestamp`: The timestamp of the commit. Defaults to the timestamp of the triggering commit.
- `oxygen_deployment_token`: The Oxygen deployment token issued by Shopify. This is a required input.
- `oxygen_worker_dir`: The name of the directory containing the worker file. Defaults to `dist/worker`.
- `oxygen_client_dir`: The name of the directory with compiled asset files to be uploaded to the CDN. Defaults to `dist/client`.
- `oxygen_deployment_verification`: Verifies successful deployment of the worker to Oxygen. Accepts `true` or `false`. Defaults to `true`. Note: This verification checks the status of the deployment, not the health of the application. If set to `true`, the workflow will only be marked as successful if the worker deployment to Oxygen has been verified to be routable. Also note that the workflow status and the status of the deployment in the Hydrogen storefronts channel may differ if the verification check fails.
- `oxygen_deployment_verification_max_duration`: The maximum duration in seconds to wait for the health check to pass. Defaults to `180`.
- `path`: The root path of the project to deploy.

### Output

-  `preview_url`: When the deployment is successful, this is the unique url where the deployment can be accessed.

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md) for details on how to contribute.

## License

This project is licensed under the terms of the [MIT license](./LICENSE.md).
