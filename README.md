# astroville/homebrew-tap

Homebrew tap for astroville tools.

```sh
brew tap astroville/tap
brew install candy
```

## Formulae

- `candy` — single-binary distributed software load balancer. Builds from
  source. The [`candy`](https://github.com/astroville/candy) repo is currently
  private, so `brew install candy` needs a GitHub token with access:

  ```sh
  export HOMEBREW_GITHUB_API_TOKEN=$(gh auth token)
  brew install candy
  ```

Formulae here are copies kept in sync with each tool's source repo on release
(canonical source for candy: `deploy/homebrew/candy.rb` in the candy repo).
