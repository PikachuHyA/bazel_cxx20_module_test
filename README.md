# bazel_cxx20_module_test

This repo hosts extra tests for Bazel support C++20 Modules.

Clang 17 or higher is required.

run unit_test

```
bazel build --action_env=CC=/usr/bin/clang-17 unit_test/...
```

run integration_test

```
cd integration_test
bash test_all.sh
```

a GitHub Action is added. see https://github.com/PikachuHyA/bazel_cxx20_module_test/actions/workflows/ci.yml
