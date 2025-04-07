# Contributing Guidelines

Thank you for your interest in contributing to this project! We welcome contributions from everyone, regardless of experience level.

## How to Contribute

1.  **Fork the repository:** Click the "Fork" button at the top right of the repository page. This will create a copy of the repository in your GitHub account.
2.  **Clone your fork:** Clone your forked repository to your local machine using `git clone https://github.com/cavrilionis/noteguessr.git`.
3.  **Create a branch:** Create a new branch for your contribution using `git checkout -b feature/your-feature-name` or `git checkout -b fix/your-fix-name`. Choose a descriptive branch name.
4.  **Make your changes:** Make your changes to the codebase.
5.  **Commit your changes:** Commit your changes with clear and concise commit messages using `git commit -m "Add your commit message here"`. Follow our [commit message guidelines](#commit-message-guidelines).
6.  **Push your changes:** Push your changes to your forked repository using `git push origin feature/your-feature-name`.
7.  **Create a pull request (PR):** Go to the original repository on GitHub and click the "New Pull Request" button. Fill out the pull request template with a clear description of your changes.

## Pull Request Guidelines

* **One pull request per feature or fix:** Keep pull requests focused on a single feature or bug fix.
* **Clear and descriptive title and description:** Use a clear and descriptive title and description for your pull request.
* **Include relevant issue numbers:** If your pull request addresses an existing issue, include the issue number in the description (e.g., "Fixes #123").
* **Update documentation:** If your changes affect the documentation, update it accordingly.
* **Add tests:** If your changes affect the code, add relevant tests.
* **Follow code style:** Follow the existing code style and conventions.
* **Be patient:** Maintainers will review your pull request as soon as possible. Be patient and responsive to feedback.

## Commit Message Guidelines

We follow the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specification.

* **Structure:**
    ```
    <type>(<scope>): <description>

    [optional body]

    [optional footer(s)]
    ```
* **Type:**
    * `feat`: A new feature
    * `fix`: A bug fix
    * `docs`: Documentation only changes
    * `style`: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
    * `refactor`: A code change that neither fixes a bug nor adds a feature
    * `perf`: A code change that improves performance
    * `test`: Adding missing tests or correcting existing tests
    * `build`: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
    * `ci`: Changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
    * `chore`: Other changes that don't modify src or test files
    * `revert`: Reverts a previous commit
* **Scope:** The scope is optional and provides additional context for the change (e.g., `feat(ui):`).
* **Description:** Use a concise description of the changes.
* **Body:** The body is optional and provides more detailed information about the changes.
* **Footer:** The footer is optional and can be used for things like breaking changes or issue references.

**Example Commit Messages:**

* `fix: resolve issue with button click`
* `feat(api): add new endpoint for user data`
* `docs: update installation instructions`

## Reporting Issues

If you find a bug or have a feature request, please open an issue on GitHub. Provide as much detail as possible, including:

* A clear and descriptive title
* Steps to reproduce the issue (if applicable)
* Expected behavior
* Actual behavior
* Screenshots (if applicable)

## Code Style

For R code, we adhere to the following style guidelines:

* **Linters:** We use `lintr` to enforce consistent code style. Please ensure your R code passes `lintr` checks before submitting a pull request.
    * Install `lintr`: `install.packages("lintr")`
    * Run `lintr` on your code: `lintr::lint_package()` or `lintr::lint("your_file.R")`
    * We prefer the tidyverse style guide as implemented by lintr's default settings, but if any deviations are necessary, please add a `.lintr` file to the root of the repository to specify any exceptions.
* **General Style:**
    * Use consistent indentation (4 spaces).
    * Use descriptive variable and function names.
    * Add comments to explain complex code.
    * Follow the tidyverse style guide for general formatting.
    * Use `snake_case` for variable and function names.
* **File Structure:**
    * Place R scripts within the `R/` directory.
    * Place test scripts within the `tests/testthat/` directory.

## License

By contributing to this project, you agree that your contributions will be licensed under the project's [LICENSE](LICENSE) file.

## Getting Help

If you have any questions or need help, please open an issue or reach out to us at avrilionis@gmail.com

Thank you for contributing!
