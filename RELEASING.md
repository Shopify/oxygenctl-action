1.  Push to main

2.  Release an appropriate Semver tag.

    ```
    tag=v1.X.X
    git tag $tag
    git push origin $tag
    ```

3.  Rerelease the `v1` tag so that users of `shopify/oxygenctl-action@v1` can benefit from the newest changes without making code changes.

    ```
    tag=v1
    git push --delete origin $tag
    git tag --delete $tag
    git tag $tag
    git push origin $tag
    ```
