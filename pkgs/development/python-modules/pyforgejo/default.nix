{
  lib,
  buildPythonPackage,
  fetchPypi,
  poetry-core,
  httpx,
  pydantic,
  pydantic-core,
  python-dotenv,
  nix-update-script,
}:
buildPythonPackage (finalAttrs: {
  pname = "pyforgejo";
  version = "2.0.7";
  pyproject = true;
  __structuredAttrs = true;

  src = fetchPypi {
    inherit (finalAttrs) pname version;
    hash = "sha256-gFHXul8ANHfv/3pzrgKGo4wy4+CB2v9NgblCb8B6Cz8=";
  };

  build-system = [
    poetry-core
  ];

  dependencies = [
    httpx
    pydantic
    pydantic-core
    python-dotenv
  ];

  pythonImportsCheck = [
    "pyforgejo"
  ];

  passthru.updateScript = nix-update-script {
    extraArgs = ["--flake"];
  };

  meta = {
    description = "A Python client library for accessing the Forgejo API";
    homepage = "https://pypi.org/project/pyforgejo";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [rein];
  };
})
